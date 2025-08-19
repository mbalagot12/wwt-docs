# Arista Campus Workshop Docs

This project uses [MkDocs](https://www.mkdocs.org/) to build and serve documentation for the Arista Campus Workshop.

## 🚀 Quick Start

### 1. Clone the Repository

```sh
git clone https://github.com/mbalagot12/campus-workshop.git
cd your-repo
```

### 2. Install Python (if needed)

- **MacOS/Linux:**  
  Python 3.8+ is usually pre-installed. Check with:
  ```sh
  python3 --version
  ```
- **Windows 11:**  
  Download and install Python from [python.org](https://www.python.org/downloads/windows/).

### 3. Create a Virtual Environment

#### Option 1: Using `venv` (Standard Python)

```sh
python3 -m venv venv
source venv/bin/activate      # MacOS/Linux
venv\Scripts\activate         # Windows
```

#### Option 2: Using [`uv`](https://github.com/astral-sh/uv) (Fast Python package manager)

1. Install `uv` (if not already installed):

    - **MacOS/Linux:**
      ```sh
      curl -Ls https://astral.sh/uv/install.sh | sh
      ```
    - **Windows (PowerShell):**
      ```powershell
      irm https://astral.sh/uv/install.ps1 | iex
      ```

2. Create and activate a virtual environment with `uv`:

    ```sh
    uv venv .venv
    source .venv/bin/activate      # MacOS/Linux
    .venv\Scripts\activate         # Windows
    ```

### 4. Install MkDocs and Required Plugins

```sh
pip install mkdocs mkdocs-material
```

> Add any additional plugins your project uses (e.g., `pip install mkdocs-table-reader-plugin`).

### 5. Serve the Documentation Locally

```sh
mkdocs serve
```

Open [http://127.0.0.1:8000](http://127.0.0.1:8000) in your browser to view the docs.

### 6. Build the Static Site

```sh
mkdocs build
```

The static site will be generated in the `site/` directory.

---

## 🛠️ Troubleshooting

- If you encounter permission errors, try running commands with `python3` instead of `python`.
- For Windows, always use the Command Prompt or PowerShell, not WSL unless you have Python set up there.

---

## Running Server

To run mkdocs behind an nginx server

1. [Install nginx](https://getnoc.com/blog/2023-hosting-a-mkdocs-generated-site-using-nginx/)
2. Build the mkdocs site
3. Navigate to the server IP

   If you are unable to navigate to the local IP address, you may have to open `System Preferences`.

## 📚 Resources

- [MkDocs Documentation](https://www.mkdocs.org/)
- [MkDocs Material Theme](https://squidfunk.github.io/mkdocs-material/)

### References

- https://www.pulleycloud.com/mkdocs-nginx-aws-ec2/part-2/
-

## Original Maintainers

- Kyle Bush ([kbush@arista.com](mailto:kbush@arista.com))
- Larry Gomez ([larry@arista.com](mailto:larry@arista.com))

## Edited For Channel Partners by
- Miguel Balagot ([mbalagot@arista.com](mailto:mbalagot@arista.com))
