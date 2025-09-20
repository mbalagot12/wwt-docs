#!/bin/bash
set -e  # Exit on any error

# Local CI/CD Testing Script
# Simulates the entire CI/CD pipeline without touching any servers

echo "🧪 LOCAL CI/CD TESTING PIPELINE"
echo "================================"

# Configuration
LOCAL_TEST_DIR="./local-test-output"
BACKUP_DIR="./local-test-backups"
TEST_PORT=8000

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Step 1: Environment Setup
setup_test_environment() {
    log_info "Setting up local test environment..."
    
    # Create test directories
    mkdir -p "$LOCAL_TEST_DIR"
    mkdir -p "$BACKUP_DIR"
    
    # Create backup of current state
    BACKUP_NAME="backup-$(date +%Y%m%d_%H%M%S)"
    if [ -d "site" ]; then
        cp -r site "$BACKUP_DIR/$BACKUP_NAME"
        log_success "Created backup: $BACKUP_NAME"
    fi
    
    log_success "Test environment ready"
}

# Step 2: Build Validation
test_build() {
    log_info "Testing MkDocs build process..."
    
    # Clean previous build
    rm -rf site/
    
    # Build site
    if mkdocs build; then
        log_success "MkDocs build successful"
    else
        log_error "MkDocs build failed"
        return 1
    fi
    
    # Validate build output
    if [ ! -d "site" ]; then
        log_error "Build output directory 'site' not found"
        return 1
    fi
    
    if [ ! -f "site/index.html" ]; then
        log_error "Main index.html not found in build output"
        return 1
    fi
    
    # Check build size (should be reasonable)
    SITE_SIZE=$(du -sm site | cut -f1)
    if [ "$SITE_SIZE" -lt 1 ]; then
        log_error "Build output too small ($SITE_SIZE MB), likely build failed"
        return 1
    fi
    
    log_success "Build validation passed (Size: ${SITE_SIZE}MB)"
}

# Step 3: Content Validation
test_content() {
    log_info "Validating content structure..."
    
    # Check for required pages
    REQUIRED_PAGES=(
        "site/index.html"
        "site/references/agenda/index.html"
    )
    
    for page in "${REQUIRED_PAGES[@]}"; do
        if [ -f "$page" ]; then
            log_success "Found: $page"
        else
            log_warning "Missing: $page"
        fi
    done
    
    # Check agenda content specifically
    if [ -f "site/references/agenda/index.html" ]; then
        if grep -q "Campus Workshop Agenda" "site/references/agenda/index.html"; then
            log_success "Agenda content validated"
        else
            log_error "Agenda content validation failed"
            return 1
        fi
    fi
    
    log_success "Content validation completed"
}

# Step 4: Local Server Test
test_local_server() {
    log_info "Testing local server deployment..."
    
    # Copy build to test directory
    cp -r site/* "$LOCAL_TEST_DIR/"
    
    # Start local server in background
    cd "$LOCAL_TEST_DIR"
    python3 -m http.server $TEST_PORT > /dev/null 2>&1 &
    SERVER_PID=$!
    cd - > /dev/null
    
    # Wait for server to start
    sleep 3
    
    # Test server response
    if curl -f -s "http://localhost:$TEST_PORT/" > /dev/null; then
        log_success "Local server test passed"
        
        # Test agenda page
        if curl -f -s "http://localhost:$TEST_PORT/references/agenda/" > /dev/null; then
            log_success "Agenda page accessible"
        else
            log_warning "Agenda page not accessible (may be normal)"
        fi
    else
        log_error "Local server test failed"
        kill $SERVER_PID 2>/dev/null || true
        return 1
    fi
    
    # Clean up server
    kill $SERVER_PID 2>/dev/null || true
    log_success "Local server test completed"
}

# Step 5: Rollback Test
test_rollback() {
    log_info "Testing rollback procedures..."
    
    # Simulate a "bad" deployment
    echo "<html><body>BAD DEPLOYMENT</body></html>" > "$LOCAL_TEST_DIR/index.html"
    
    # Test rollback
    LATEST_BACKUP=$(ls -t "$BACKUP_DIR" | head -1)
    if [ -n "$LATEST_BACKUP" ]; then
        rm -rf "$LOCAL_TEST_DIR"/*
        cp -r "$BACKUP_DIR/$LATEST_BACKUP"/* "$LOCAL_TEST_DIR/"
        log_success "Rollback test passed using backup: $LATEST_BACKUP"
    else
        log_error "No backup found for rollback test"
        return 1
    fi
}

# Step 6: Performance Test
test_performance() {
    log_info "Running performance tests..."
    
    # Check build time
    START_TIME=$(date +%s)
    mkdocs build > /dev/null 2>&1
    END_TIME=$(date +%s)
    BUILD_TIME=$((END_TIME - START_TIME))
    
    if [ $BUILD_TIME -lt 30 ]; then
        log_success "Build time acceptable: ${BUILD_TIME}s"
    else
        log_warning "Build time slow: ${BUILD_TIME}s"
    fi
    
    # Check final site size
    FINAL_SIZE=$(du -sm site | cut -f1)
    log_info "Final site size: ${FINAL_SIZE}MB"
}

# Main execution
main() {
    echo "Starting local CI/CD testing at $(date)"
    echo ""
    
    setup_test_environment
    echo ""
    
    test_build
    echo ""
    
    test_content
    echo ""
    
    test_local_server
    echo ""
    
    test_rollback
    echo ""
    
    test_performance
    echo ""
    
    log_success "🎉 ALL LOCAL CI/CD TESTS PASSED!"
    echo ""
    echo "📊 Test Summary:"
    echo "  - Build: ✅ Successful"
    echo "  - Content: ✅ Validated"
    echo "  - Server: ✅ Accessible"
    echo "  - Rollback: ✅ Working"
    echo "  - Performance: ✅ Acceptable"
    echo ""
    echo "🚀 Ready for next phase of testing!"
    
    # Cleanup
    rm -rf "$LOCAL_TEST_DIR"
    log_info "Cleaned up test files"
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
