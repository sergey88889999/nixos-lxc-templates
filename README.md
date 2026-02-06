# NixOS LXC Templates for Proxmox

[![Build](https://github.com/sergey88889999/nixos-lxc-templates/actions/workflows/build.yml/badge.svg)](https://github.com/sergey88889999/nixos-lxc-templates/actions/workflows/build.yml)
[![Release](https://img.shields.io/github/v/release/sergey88889999/nixos-lxc-templates)](https://github.com/sergey88889999/nixos-lxc-templates/releases)

Automated NixOS container images for Proxmox LXC with Infrastructure as Code approach.

## Features

- **Minimal NixOS** optimized for containers
- **SSH key-based** authentication only (root)
- **Network managed by Proxmox** (no conflicts)
- **Pre-configured timezone** (Europe/Berlin)
- **Essential tools** included: vim, git, curl, btop, mc

## Quick Start

### Download Latest Release
```bash
wget https://github.com/sergey88889999/nixos-lxc-templates/releases/latest/download/nixos-lxc-proxmox.tar.xz
```

### Deploy with OpenTofu/Terraform

See [deployment examples](./examples/) for automated container provisioning.

## Building Locally
```bash
nix-build '<nixpkgs/nixos>' \
  -A config.system.build.tarball \
  -I nixos-config=./mini-nixos.nix
```

## Configuration

### Included Packages
- vim-full
- git
- curl
- btop
- mc

### SSH Access
Add your public key to `ssh-keys/control-node.pub` before building.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.