# 02: Installing Windows Server 2025

## Steps
1. Booted DC01 from the Windows Server 2025 evaluation ISO.
2. Kept default language, time, and keyboard settings.
3. Chose **Install Windows Server** and selected **I don't have a product key** (evaluation edition).
4. Selected **Windows Server 2025 Standard Evaluation (Desktop Experience)**. Without Desktop Experience the server installs as Server Core (command line only).
5. Installed to the unallocated 50 GB virtual disk.
6. After the first reboot, ejected the ISO so the VM would boot from the hard disk (see troubleshooting).
7. Set the local Administrator password.
8. Logged in using **Input → Keyboard → Insert Ctrl-Alt-Del** (or Right Ctrl + Delete), since the host captures a real Ctrl+Alt+Del.
9. Took a snapshot named **"Fresh install"** as a clean rollback point.

## Notes
- The evaluation edition must activate over the internet within 10 days, which happens automatically through the NAT Network.
- The evaluation lasts 180 days.

## Next
- Rename the server to `DC01`
- Assign static IP `10.10.10.10/24`, gateway `10.10.10.1`, DNS `127.0.0.1`
- Install AD DS and create the `lab.local` forest
