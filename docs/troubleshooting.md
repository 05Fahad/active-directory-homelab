# Troubleshooting Log

Problems hit while building the lab and how they were fixed.

---

## 1. VM showed a black screen and would not boot the installer

**Symptom:** After starting DC01, the window stayed black. Pressing keys to "boot from CD/DVD" did nothing.

**Cause:** The VM was set to UEFI firmware, and it was not booting from the attached ISO.

**Fix:**
1. Powered off the VM and discarded its saved state.
2. **Settings → Storage:** confirmed the Server ISO was attached to the optical drive.
3. **Settings → System → Motherboard:** unchecked **UEFI** (switched to legacy BIOS), unchecked Floppy, and kept **Optical** above **Hard Disk** in the boot order.
4. **Settings → Display:** set Video Memory to 128 MB with the VMSVGA graphics controller.
5. Started the VM again, and the Windows Server installer loaded.

**Lesson:** When a VM won't boot, check firmware mode, boot order, and whether the install media is actually attached.

---

## 2. Setup asked about an "upgrade" after the first reboot

**Symptom:** Partway through installation, the VM rebooted into Windows Setup again and showed: *"It looks like you started an upgrade and booted from installation media."*

**Cause:** The ISO was still first in the boot order, so the VM booted from the installer instead of the newly installed system on the hard disk.

**Fix:**
1. In the VM window: **Devices → Optical Drives → Remove disk from virtual drive** (Force Unmount).
2. Clicked **Yes** to continue. The VM booted from the hard disk and finished setup.

**Lesson:** Clicking **No** would have restarted the installation from scratch. Once Windows is copied to disk, remove the install media.
