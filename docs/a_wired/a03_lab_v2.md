# A-03 | Switch Onboarding with Inventory Studio

## Overview

In this lab, you will learn how to onboard switches using CloudVision's Inventory Studio. This streamlined approach provides a visual and intuitive way to add new devices to your network infrastructure.

--8<--
docs/snippets/topology.md
docs/snippets/login_cv.md
docs/snippets/workspace.md
--8<--

## Video Walkthrough

Before we begin the hands-on portion, watch this demonstration video that shows the complete switch onboarding process using Inventory Studio:

!!! warning "Video Setup Required"
    **If the video doesn't play**, please check:
    
    1. **File exists**: Ensure `01_inventory_studio.mp4` is in your `docs/demos/` folder
    2. **File path**: Verify the relative path matches your MkDocs structure
    3. **File format**: MP4 with H.264 codec works best across all browsers

<div class="video-container" id="main-video-container">
  <video 
    id="demo-video"
    width="100%" 
    controls 
    controlslist="nodownload"
    preload="metadata"
    aria-label="CloudVision Inventory Studio Walkthrough"
    onloadeddata="videoLoaded()"
    onerror="videoError()"
  >
    <!-- MkDocs standard paths for docs/demos/ folder -->
    <source src="demos/01_inventory_studio.mp4" type="video/mp4">
    <source src="./demos/01_inventory_studio.mp4" type="video/mp4">
    <source src="../demos/01_inventory_studio.mp4" type="video/mp4">
    <!-- Absolute path from site root -->
    <source src="/demos/01_inventory_studio.mp4" type="video/mp4">
    
    <!-- Fallback content -->
    <div class="video-fallback">
      <p><strong>⚠️ Video cannot be loaded</strong></p>
      <p>This might be due to:</p>
      <ul style="text-align: left; display: inline-block;">
        <li>Missing video file in the demos folder</li>
        <li>Incorrect file path</li>
        <li>Browser compatibility issues</li>
      </ul>
      <p>
        <button onclick="retryVideo()" class="retry-btn">🔄 Retry Loading</button>
      </p>
    </div>
  </video>
  
  <!-- Loading indicator -->
  <div id="video-loading" class="video-loading" style="display: none;">
    <p>📺 Loading video...</p>
  </div>
  
  <!-- Error message -->
  <div id="video-error" class="video-error" style="display: none;">
    <p><strong>❌ Video failed to load</strong></p>
    <details>
      <summary>🔧 Troubleshooting Options</summary>
      <div class="troubleshooting">
        <h4>Try these solutions:</h4>
        <ol>
          <li><strong>Check file location:</strong> Ensure video file is at <code>docs/demos/01_inventory_studio.mp4</code></li>
          <li><strong>Test direct access:</strong> 
            <a href="demos/01_inventory_studio.mp4" target="_blank">Test Path 1</a> |
            <a href="./demos/01_inventory_studio.mp4" target="_blank">Test Path 2</a> |
            <a href="../demos/01_inventory_studio.mp4" target="_blank">Test Path 3</a> |
            <a href="/demos/01_inventory_studio.mp4" target="_blank">Test Path 4</a>
          </li>
          <li><strong>Use external hosting:</strong> Upload to YouTube, Vimeo, or cloud storage</li>
        </ol>
      </div>
    </details>
  </div>
  
  <!-- Video info -->
  <div class="video-controls-info">
    <small>
      💡 <strong>Tip:</strong> Use spacebar to play/pause, arrow keys to skip forward/back
    </small>
  </div>
</div>

<!-- Alternative hosting options -->
<details>
<summary>🎬 Alternative Video Options</summary>

If the embedded video doesn't work, try these alternatives:

### Option 1: Direct Download
<a href="demos/01_inventory_studio.mp4" download class="download-btn">
  📥 Download Video (MP4)
</a>

### Option 2: External Player
If you've uploaded the video to a cloud service, replace this with your URL:

```html
<!-- YouTube example -->
<iframe width="100%" height="400" 
  src="https://www.youtube.com/embed/YOUR_VIDEO_ID" 
  frameborder="0" allowfullscreen>
</iframe>

<!-- Vimeo example -->
<iframe width="100%" height="400"
  src="https://player.vimeo.com/video/YOUR_VIDEO_ID"
  frameborder="0" allowfullscreen>
</iframe>
```

### Option 3: Self-Hosted with Absolute Path
If using MkDocs serve locally, try:
```html
<video controls width="100%">
  <source src="http://localhost:8000/demos/01_inventory_studio.mp4" type="video/mp4">
</video>
```

</details>

!!! tip "Video Overview"
    This video demonstrates:
    
    - **Accessing CloudVision Inventory Studio** (0:00-1:30)
    - **Identifying available devices for onboarding** (1:30-3:00)
    - **Configuring device settings and roles** (3:00-5:30)
    - **Applying network configurations** (5:30-7:00)
    - **Verifying successful device integration** (7:00-8:30)

!!! note "Video Accessibility"
    - **Captions**: Click the CC button for subtitles
    - **Speed Control**: Right-click video → Playback speed
    - **Full Screen**: Click the expand icon or press F key
    - **Keyboard Navigation**: Spacebar (play/pause), ← → (skip), ↑ ↓ (volume)

## Onboarding Your Switch

Now that you've seen the process, let's onboard your assigned switch using the same workflow demonstrated in the video.

!!! danger "Single Workspace"
    You and your fellow student will work together to onboard your switch pair in a **single workspace**.

### Step 1: Access Inventory Studio

1. Navigate to `Studios` from the main CloudVision menu
2. Locate and click on `Inventory Studio`
3. Create a new workspace or use an existing one

### Step 2: Identify Your Device

1. In the Inventory Studio interface, look for devices in the "Available Devices" section
2. Identify your assigned switch using the serial number from your lab assignment
3. Your device should appear with a hostname like `sw-X.X.X.X` indicating it's in ZTP mode

### Step 3: Configure Device Settings

Following the video demonstration:

1. Select your device from the available devices list
2. Configure the following settings:
   - **Hostname**: `pod##-leaf1X` (where ## is your pod number and X is A or B)
   - **Role**: Select `Leaf`
   - **Location**: Choose `Workshop > Home Office > IDF1`

### Step 4: Apply Network Configuration

1. Configure the management network settings:
   - **Management Subnet**: `10.1.##.0/24` (where ## is your pod number)
   - **Management VLAN**: `1##` (where ## is your pod number)

2. Review all settings before proceeding

### Step 5: Deploy Configuration

1. Click `Review Workspace` to see all proposed changes
2. Verify the configuration matches your requirements
3. Click `Submit Workspace` to generate the Change Control
4. Review and approve the Change Control
5. Execute the changes

## Verification

After the onboarding process completes:

1. Navigate to `Devices` > `Inventory` to verify your switch appears with the correct hostname
2. Check that the device status shows as `Active` and `Streaming`
3. Verify the device appears in the correct location within your campus hierarchy

## Troubleshooting

### Video Playback Issues

If you're experiencing video playback problems:

- **Chrome/Edge**: Should support MP4 natively
- **Firefox**: Try refreshing the page or use the alternative player
- **Safari**: MP4 should work, check if hardware acceleration is enabled
- **Mobile browsers**: Video should be responsive and touch-friendly

### Switch Onboarding Issues

If you encounter issues during onboarding:

- Ensure your device is properly connected to the network
- Verify the device is receiving DHCP and can reach CloudVision
- Check that ZTP is enabled on the device
- Confirm the device serial number matches your lab assignment

!!! tip "🎉 CONGRATS! You have completed this lab! 🎉"

    Your switch is now successfully onboarded and ready for further configuration.

    [:material-login: LET'S GO TO THE NEXT LAB!](./a04_lab.md){ .md-button .md-button--primary }

--8<-- "includes/abbreviations.md"

<!-- Custom CSS and JavaScript for enhanced video experience -->
<style>
.video-container {
  position: relative;
  margin: 1.5em 0;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  background: #f8f9fa;
}

.video-container video {
  border-radius: 8px;
  background: #000;
  display: block;
}

.video-loading, .video-error {
  padding: 2em;
  text-align: center;
  background: #f8f9fa;
  border-radius: 8px;
}

.video-error {
  background: #fff3cd;
  border: 1px solid #ffeaa7;
}

.video-controls-info {
  background: #f8f9fa;
  padding: 8px 12px;
  text-align: center;
  border-top: 1px solid #e9ecef;
  font-size: 0.9em;
}

.video-fallback {
  background: #fff3cd;
  padding: 2em;
  text-align: center;
  border-radius: 8px;
  border: 2px dashed #ffeaa7;
  margin: 1em;
}

.troubleshooting {
  text-align: left;
  background: #f8f9fa;
  padding: 1em;
  border-radius: 4px;
  margin-top: 1em;
}

.troubleshooting h4 {
  margin-top: 0;
  color: #495057;
}

.troubleshooting code {
  background: #e9ecef;
  padding: 2px 4px;
  border-radius: 2px;
  font-size: 0.9em;
}

.retry-btn, .download-btn {
  background: #007bff;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  text-decoration: none;
  display: inline-block;
  margin: 0.5em;
}

.retry-btn:hover, .download-btn:hover {
  background: #0056b3;
  text-decoration: none;
  color: white;
}

/* Responsive video */
@media (max-width: 768px) {
  .video-container {
    margin: 1em 0;
  }
  
  .video-controls-info {
    font-size: 0.8em;
    padding: 6px 10px;
  }
  
  .video-loading, .video-error, .video-fallback {
    padding: 1em;
  }
}

/* Dark mode support */
@media (prefers-color-scheme: dark) {
  .video-container {
    background: #2d3748;
  }
  
  .video-controls-info {
    background: #2d3748;
    border-color: #4a5568;
    color: #e2e8f0;
  }
  
  .video-loading {
    background: #2d3748;
    color: #e2e8f0;
  }
  
  .video-error, .video-fallback {
    background: #744210;
    border-color: #d69e2e;
    color: #fef5e7;
  }
  
  .troubleshooting {
    background: #2d3748;
    color: #e2e8f0;
  }
  
  .troubleshooting code {
    background: #4a5568;
    color: #e2e8f0;
  }
}
</style>

<script>
function videoLoaded() {
  console.log('Video loaded successfully');
  document.getElementById('video-loading').style.display = 'none';
  document.getElementById('video-error').style.display = 'none';
}

function videoError() {
  console.error('Video failed to load');
  document.getElementById('video-loading').style.display = 'none';
  document.getElementById('video-error').style.display = 'block';
}

function retryVideo() {
  const video = document.getElementById('demo-video');
  document.getElementById('video-loading').style.display = 'block';
  document.getElementById('video-error').style.display = 'none';
  
  // Try to reload the video
  video.load();
  
  setTimeout(() => {
    if (video.readyState === 0) {
      videoError();
    }
  }, 5000);
}

// Check if video loads on page load
document.addEventListener('DOMContentLoaded', function() {
  const video = document.getElementById('demo-video');
  
  // Show loading indicator
  document.getElementById('video-loading').style.display = 'block';
  
  // Set a timeout to show error if video doesn't load
  setTimeout(() => {
    if (video.readyState === 0) {
      videoError();
    }
  }, 10000);
});
</script>