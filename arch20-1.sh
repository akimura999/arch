#!/bin/bash
read -p "Введите имя компьютера: " ArchY-20
read -p "Введите имя пользователя: " maximus

echo 'Прописываем имя компьютера'
echo $hostname > /etc/hostname
ln -svf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

echo '3.4 Добавляем русскую локаль системы'
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen 

echo 'Обновим текущую локаль системы'
locale-gen

echo 'Указываем язык системы'
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf
export LANG=ru_RU.UTF-8

echo 'Вписываем KEYMAP=ru FONT=cyr-sun16'
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf

echo 'Настраиваем hosts'
echo '127.0.0.1     localhost' >> /etc/hosts
echo '::1           localhost' >> /etc/hosts
echo '127.0.1.1     hostname.localdomain   hostname' >> /etc/hosts

echo 'Создадим загрузочный RAM диск'
mkinitcpio -p linux

echo '3.5 Устанавливаем загрузчик'
pacman -Syy
pacman -S  efibootmgr --noconfirm 
bootctl install

echo 'Настраиваем менеджер загрузки'
rm /boot/loader/loader.conf
echo 'default arch' >> /boot/loader/loader.conf
echo 'timeout 0' >> /boot/loader/loader.conf
echo 'editor 0' >> /boot/loader/loader.conf

echo 'Создаём файлы конфигурации'
echo 'title Arch Linux' >> /boot/loader/entries/arch.conf
echo 'linux /vmlinuz-linux' >> /boot/loader/entries/arch.conf
echo 'initrd /intel-ucode.img' >> /boot/loader/entries/arch.conf
echo 'initrd /initramfs-linux.img' >> /boot/loader/entries/arch.conf
echo 'options root=/dev/sda2 rw nvidia-drm.modeset=1' >> /boot/loader/entries/arch.conf

echo 'Ставим программу для Wi-fi'
pacman -S dialog wpa_supplicant --noconfirm 

echo 'Добавляем пользователя'
useradd -m -g users -G wheel -s /bin/bash $username

echo 'Создаем root пароль ROOTa'
passwd

echo 'Устанавливаем пароль пользователя'
passwd $username

echo 'Устанавливаем SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

echo 'Раскомментируем репозиторий multilib Для работы 32-битных приложений в 64-битной системе.'
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
pacman -Syy

echo "Куда устанавливем Arch Linux на виртуальную машину?"
read -p "1 - Да, 0 - Нет: " vm_setting
if [[ $vm_setting == 0 ]]; then
  gui_install="xorg-server xorg-drivers xorg-xinit xorg-apps mesa-libgl nvidia nvidia-utils nvidia-settings lib32-nvidia-utils xf86-video-intel sakura"
elif [[ $vm_setting == 1 ]]; then
  gui_install="xorg-server xorg-drivers xorg-xinit virtualbox-guest-utils sddm xf86-video-intel xf86-video-vesa sakura"
fi

echo 'Ставим иксы и драйвера'
pacman -S $gui_install

echo "Ставим Cinnamon"
pacman -S cinnamon cinnamon-translations --noconfirm

echo 'Cтавим DM'
pacman -S sddm --noconfirm
systemctl enable sddm

echo 'Ставим шрифты'
pacman -S ttf-liberation ttf-dejavu opendesktop-fonts ttf-bitream-vera ttf-arphic-ukai ttf-arphic-uming ttf-hanazono --noconfirm 


echo 'Подключаем автозагрузку менеджера входа и интернет'
systemctl enable NetworkManager

echo 'Установка завершена! Перезагрузите систему.'

