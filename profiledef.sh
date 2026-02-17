#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="aiarch"
iso_label="AIARCH_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="AI Arch <https://archlinux.org>"
iso_application="AI Arch Automated Installer"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux'
           'uefi.systemd-boot')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/sudoers.d"]="0:0:750"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/root/install.sh"]="0:0:755"
  ["/root/ArchScripts/setup.sh"]="0:0:755"
  ["/usr/local/bin/reversessh.sh"]="0:0:755"
  ["/usr/local/bin/setup-hwid.sh"]="0:0:755"
  ["/usr/local/bin/first-boot.sh"]="0:0:755"
)
