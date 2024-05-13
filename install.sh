#!/usr/bin/bash
# parrot-os gui on termux-x11
printf "\n\a\a\e[32;1m
▛▀▖            ▐    ▞▀▖   
▙▄▘▝▀▖▙▀▖▙▀▖▞▀▖▜▀▄▄▖▌ ▌▞▀▘
▌  ▞▀▌▌  ▌  ▌ ▌▐ ▖  ▌ ▌▝▀▖
▘  ▝▀▘▘  ▘  ▝▀  ▀   ▝▀ ▀▀ On Termux\e[0m\n"

if [[ -z $PREFIX/etc/apt/sources.list.d/alienkrishn.list ]]; then
echo adding alienkrishn repo in your termux 
curl -sL https://github.com/Anon4You/alienkrishn/raw/main/addrepo | bash
fi

if [[ -d $PREFIX/var/lib/proot-distro/installed-rootfs/prrt ]]; then
  echo parrot os is already installed 
else
  echo installing parrot-os; sleep 1 
  echo this may take some time 
  dpnd=(termux-x11-nightly dbus xwayland parrot-os) 
  for p in "${dpnd[@]}"; do 
    if ! hash ${p} > /dev/null 2>&1; then
      echo -e "\e[32m${p} is not found installing....\e[0m"
      apt install ${p} -y > /dev/null 2>&1 
    fi 
  done 
fi
CHROOT=$PREFIX/var/lib/proot-distro/installed-rootfs/prrt 
mv $CHROOT/root/.bashrc $CHROOT/root/.bashrcx 
echo italling desktop 

cat > $CHROOT/root/.bashrc <<- EOF
apt-get update && apt-get upgrade -y 
apt install xfce4 xfce4-terminal xfce4-goodies xwayland dbus-x11 -y
curl -sL https://raw.githubusercontent.com/Anon4You/kalilinux/main/xstart 
mv xstart /usr/bin && chmod +x /usr/bin/xstart
rm .bashrc 
mv .bashrcx .bashrc 
exit
EOF
parrot-os
echo parrot os deaktop install successfully
