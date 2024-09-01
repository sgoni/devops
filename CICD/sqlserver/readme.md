# Microsoft SQL Server

## Description

Docker compose file to deploy SQL Server 2022 for Ubuntu.

<hr>

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) 
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white)
<hr>

## Contents

- [Microsoft SQL Server](#microsoft-sql-server)
  - [Description](#description)
  - [Contents](#contents)
  - [Getting Started](#getting-started)
    - [Dependencies](#dependencies)
    - [Hardware Requirements:](#hardware-requirements)
      - [1. Operating System:](#1-operating-system)
      - [2. CPU:](#2-cpu)
      - [3. RAM:](#3-ram)
      - [4. Storage:](#4-storage)
    - [Software Requirements:](#software-requirements)
      - [For Windows:](#for-windows)
      - [For macOS:](#for-macos)
      - [For Linux:](#for-linux)
    - [System Configuration:](#system-configuration)
    - [Internet Access:](#internet-access)
    - [Recommended Additional Software:](#recommended-additional-software)
    - [System Resources:](#system-resources)
  - [Installing](#installing)
  - [Executing program](#executing-program)
  - [Help](#help)
  - [Authors](#authors)
  - [Version History](#version-history)
  - [License](#license)
  - [Acknowledgments](#acknowledgments)

## Getting Started

So how do you get this template to work for your project? It is easier than you think.

### Dependencies

### Hardware Requirements:
#### 1. Operating System:
- **Windows**: Windows 10 64-bit (Professional, Enterprise, or Education) or higher versions.
- **macOS**: macOS Catalina 10.15 or higher.
- **Linux**: A modern 64-bit Linux distribution, such as Ubuntu 20.04+, CentOS 7+, Debian 9+.

#### 2. CPU:
- 64-bit processor (x86_64 or ARM64) with virtualization support (VT-x or AMD-V).

#### 3. RAM:
- Minimum 4 GB of RAM, though at least 8 GB is recommended for smoother performance.

#### 4. Storage:
- Approximately 10 GB of free disk space for the initial installation and images.

### Software Requirements:
#### For Windows:
- **Docker Desktop for Windows**: Includes Docker Engine, Docker CLI, Docker Compose, and optional Kubernetes.
- **Windows Subsystem for Linux 2 (WSL 2)**: Recommended for better performance and compatibility.

#### For macOS:
- **Docker Desktop for macOS**: Includes Docker Engine, Docker CLI, Docker Compose, and optional Kubernetes.

#### For Linux:
- **Docker Engine**: Can be installed through your distribution’s package manager (e.g., apt, yum).
- **Docker Compose**: A separate tool that also needs to be installed (you can use pip or install from a package).

### System Configuration:
- **Virtualization Support**: Ensure that virtualization is enabled in your machine's BIOS/UEFI.
- **User Permissions**: On Linux, make sure your user belongs to the `docker` group to run Docker commands without needing `sudo`.
- **Networking**: Ensure there are no conflicts with ports that Docker might use (especially port 2375/2376 for the Docker daemon).

### Internet Access:
- You need an Internet connection to download Docker, updates, and the images you will use.

### Recommended Additional Software:
- **Git**: To clone repositories that contain Dockerfile or docker-compose.yml files.
- **Visual Studio Code**: Optional but recommended for its extensions like Docker and Remote - Containers, which facilitate container management.

### System Resources:
- **Windows/macOS**: Docker Desktop uses Hyper-V (Windows) or HyperKit (macOS) to run containers, meaning that performance may depend on how the virtual machine used by Docker is configured.
- **Linux**: Docker runs natively, so performance is generally better compared to Windows and macOS.

## Installing

1. docker compose up -d

2. Create a directory called `mssql-data`:

    ```bash
    sudo mkdir mssql-data
    ```

3. Change ownership of the `mssql-data` directory to the current user:

    ```bash
    sudo chown $USER /var/mssql-data
    ```

## Executing program

1. Run the following command to connect to Microsoft SQL Server:

    ```bash
    docker exec -it <container_id|container_name> /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P <your_password>
    ```

## Help


## Authors

ex. Steven Gon

## Version History

* 0.1
    * Initial Release
  
## License

## Acknowledgments

Inspiration, code snippets, etc.