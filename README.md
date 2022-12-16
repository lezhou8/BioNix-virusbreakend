# BioNix-VIRUSBreakend

Writing [VIRUSBreakend](https://github.com/PapenfussLab/gridss/blob/master/VIRUSBreakend_Readme.md) as a [BioNix](https://github.com/PapenfussLab/bionix) pipeline. VIRUSBreakend is a high-speed tool that detects viral DNA integration using single breakends.


## Installation

BioNix is a library built on top of [Nix](http://nixos.org/nix), which can be installed by:
```{sh}
curl -L https://nixos.org/nix/install | sh
```
Or follow the Nix official site: https://nixos.org/download.html

###### Notes for Windows Users
To use Nix on a Windows machine, Windows Subsystem for Linux 2 (WSL2) is required.
Installing WSL2 requires the following prerequisites:
- If you are running **Windows 10 version 2004 (20H1) or higher** (with **Build 19041 or higher**), or **Windows 11**, you can follow this installation [guide](https://learn.microsoft.com/en-us/windows/wsl/install).
- If you are running on earlier versions of Windows, the minimum requirement to install (or update to) WSL2 is:
  - For x64 systems: **Version 1903** or higher, with **Build 18362** or higher.
  - For ARM64 systems: **Version 2004** or higher, with **Build 19041** or higher.
  - This [guide](https://learn.microsoft.com/en-us/windows/wsl/install-manual) includes the instructions to manually install WSL2 on the above Windows versions. (Linux distributions can also be downloaded and installed manually using the links provided in this guide.)

Here is also a useful guide on setting up Nix: https://github.com/victorwkb/BioNix-Doc

## Run

Run with:
```{sh}
nix build
```
