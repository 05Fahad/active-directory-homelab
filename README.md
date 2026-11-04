# Active Directory Home Lab

A Windows Server 2025 Active Directory environment built from scratch in VirtualBox to practice real-world IT administration: user and group management, Group Policy, DNS/DHCP, help desk workflows, and PowerShell automation.

> **Status:** In progress. DC01 is promoted to a domain controller for `lab.local` with AD-integrated DNS. Next up: DHCP and joining a Windows 11 client.

---

## Lab Overview

| Component | Details |
|---|---|
| Hypervisor | Oracle VirtualBox |
| Host | Dell Inspiron 15 3501 (Intel CPU, 12 GB RAM, SSD, Windows 11 Home) |
| Lab network | VirtualBox NAT Network `ADLab`, `10.10.10.0/24`, VirtualBox DHCP disabled |
| Domain | `lab.local` (forest functional level Windows2025Domain) |
| Domain controller | `DC01`, Windows Server 2025 Standard Evaluation (Desktop Experience) |
| Client | Windows 11 Enterprise Evaluation (planned) |

### Network Plan

```
            Internet
               |
     VirtualBox NAT gateway (10.10.10.1)
               |
      ADLab NAT Network 10.10.10.0/24
        |                          |
  DC01 (10.10.10.10)         CLIENT01 (DHCP 10.10.10.100-200)
  AD DS, DNS, DHCP           Windows 11, joined to lab.local
```

The lab runs on an isolated NAT Network so the domain controller's DHCP server can never hand out addresses on my home network.

---

## Progress

- [x] Created isolated NAT Network (`ADLab`) with VirtualBox DHCP disabled
- [x] Built DC01 VM (2 vCPU, 3 GB RAM, 50 GB dynamic disk)
- [x] Installed Windows Server 2025 (Desktop Experience)
- [x] Took baseline snapshot ("Fresh install")
- [x] Renamed server to DC01 and set static IP `10.10.10.10`
- [x] Installed AD DS and promoted to domain controller (`lab.local`) with integrated DNS
- [ ] Configure DHCP scope
- [ ] Build Windows 11 client and join it to the domain
- [ ] Create OU structure, users, and security groups
- [ ] Bulk-create users with PowerShell
- [ ] Help desk tasks: password resets, account lockouts, disable/delete, AD Recycle Bin restore
- [ ] Group Policy: password/lockout policy, USB block, drive mapping
- [ ] Onboarding/offboarding scripts
- [ ] Ticketing workflow with Jira Service Management

---

## Documentation

1. [Lab Setup: VirtualBox and Network](docs/01-lab-setup.md)
2. [Installing Windows Server 2025](docs/02-windows-server-install.md)
3. [Naming, Static IP, and Promoting the Domain Controller](docs/03-static-ip-and-ad-ds.md)
4. [Troubleshooting Log](docs/troubleshooting.md)

---

## Skills Demonstrated

- Virtualization and lab design (VirtualBox, NAT networking, snapshots)
- Windows Server installation and configuration
- Boot troubleshooting (UEFI vs. BIOS, boot order, install media)
- Static IP addressing and layered connectivity testing
- Active Directory Domain Services: new forest and domain controller promotion
- DNS: AD-integrated zones, name resolution testing
- PowerShell for server configuration
- *Coming as the lab progresses:* DHCP, Group Policy, user lifecycle management, ITSM ticketing

---

## Repository Structure

```
active-directory-homelab/
├── README.md
├── docs/           Step-by-step write-ups for each phase
├── scripts/        PowerShell scripts (user provisioning, offboarding)
└── screenshots/    Screenshots for each milestone
```
