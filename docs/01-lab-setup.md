# 01: Lab Setup (VirtualBox and Network)

## Goal
Prepare an isolated virtual network and a VM for the domain controller without affecting the host computer or home network.

## Host Preparation
- Installed Oracle VirtualBox with default options.
- Left Hyper-V off. The host runs Windows 11 Home, which doesn't include Hyper-V, and VirtualBox does the same job.
- Created a local folder, `C:\VMs`, as the default machine folder. **Kept VMs out of OneDrive** so large, constantly changing virtual disks don't sync to the cloud.

## Downloads
Both from the Microsoft Evaluation Center (free):
- Windows Server 2025 evaluation ISO (180-day trial)
- Windows 11 Enterprise evaluation ISO (90-day trial)

## Lab Network
Created a VirtualBox **NAT Network**:

| Setting | Value |
|---|---|
| Name | `ADLab` |
| IPv4 prefix | `10.10.10.0/24` |
| VirtualBox DHCP | **Disabled** |

**Why NAT Network instead of Bridged?** The domain controller will run its own DHCP server. On a bridged adapter it could hand out addresses to real devices on my home network. A NAT Network gives the VMs internet access while keeping them isolated. VirtualBox's built-in DHCP is disabled so it doesn't compete with the server's DHCP.

## DC01 Virtual Machine

| Setting | Value |
|---|---|
| Name | `DC01` |
| OS type | Windows Server 2025 (64-bit) |
| Memory | 3072 MB |
| CPUs | 2 |
| Disk | 50 GB VDI, dynamically allocated |
| Firmware | Legacy BIOS (UEFI disabled, see troubleshooting) |
| Boot order | Optical, then Hard Disk |
| Video | VMSVGA, 128 MB |
| Network | Adapter 1: NAT Network `ADLab` |
| Unattended install | Disabled, so the edition can be chosen manually |

RAM is sized so both the server and the future Windows 11 client (3 GB each) can run at once on a 12 GB host.
