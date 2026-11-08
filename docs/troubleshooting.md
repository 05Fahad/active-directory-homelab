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

---

## 3. Windows 11 client stuck on a black screen (UEFI required)

**Symptom:** CLIENT01 started to a blank black window. Resetting the VM and pressing keys had no effect.

**Constraints:** The DC01 fix (switching to legacy BIOS) wasn't an option here, because Windows 11 requires UEFI, Secure Boot, and TPM 2.0.

**Causes:**
- The VM had been closed with **Save the machine state**, so each start resumed the same stuck screen instead of booting fresh (indicated by the **Discard** button in VirtualBox Manager).
- The UEFI "Press any key to boot from CD or DVD" prompt appears only briefly and was being missed.

**Fix:**
1. Powered off CLIENT01 and clicked **Discard** to clear the saved state.
2. Confirmed the Windows 11 ISO was attached under **Storage**.
3. Adjusted **Display** settings: 128 MB video memory, VMSVGA graphics controller, 3D acceleration off.
4. Started the VM and pressed **Esc** immediately to open the UEFI firmware menu, then chose **Boot Manager → UEFI VBOX CD-ROM** and pressed a key right away. The Windows 11 installer loaded.

**Lesson:** A **Discard** button means the VM is resuming a saved state, not booting. During OS installs, shut VMs down instead of saving state. The firmware Boot Manager is a reliable way to force booting from install media.

---

## 4. Domain join credential prompt rejected the username

**Symptom:** The `Add-Computer` credential dialog showed an "Examples" tooltip and wouldn't accept the username.

**Cause:** The username was typed as `LAB/Administrator` (forward slash).

**Fix:** Entered `LAB\Administrator` (backslash). The UPN format `administrator@lab.local` also works.

**Lesson:** Windows domain logons use `DOMAIN\username` (down-level logon name) or `username@domain` (UPN). Small format errors are a common help desk issue.
