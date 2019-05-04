#!/bin/bash
echo 'Установка AUR (aurman)'
sudo pacman -Syy
sudo pacman -S git --noconfirm

#Ставим зависимость expac-git
git clone https://aur.archlinux.org/expac-git.git
cd expac-git
makepkg -si --noconfirm
cd ..
rm -rf expac-git

#Ставим aurman
git clone https://aur.archlinux.org/aurman.git
cd aurman
makepkg -si --noconfirm --skippgpcheck
cd ..
rm -rf aurman
aurman -S pamac-aur google-chrome yandex-browser-beta korla-ikon-theme caffeine-ng docky timeshift

echo 'Установка программ'
sudo pacman -S ufw libreoffice libreoffice-fresh-ru audacious audacious-plugins vlc deluge alsa-lib alsa-utils p7zip unrar gvfs aspell-ru pulseaudio --noconfirm acetoneiso2 bleachbit brasero  epdfview leafpad playonlinux redshift remmina sakura steam  wine winetricks xarchiver blueman catfish gufw gnome-system-monitor  gpicview pcmanfm gnome-screenshot mate-calc cantarell-fonts bbswitch hdparm intel-ucode pepper-flash reflector gameconqueror
 
echo 'Установка тем'
aurman -S osx-arc-shadow breeze-obsidian-cursor-theme papirus-maia-icon-theme-git --noconfirm windows10-icons korla-icon-theme

echo 'Создаем нужные директории'
sudo pacman -S xdg-user-dirs

echo 'Включаем сетевой экран'
sudo ufw enable

echo 'Качаем и устанавливаем настройки Cinnamon'
cd ~/Загрузки
wget https://getfile.dokpub.com/yandex/get/https://yadi.sk/d/1sp-18Hio3QjqA  -O cinnamon.tar.gz
#rm -rf ~/
tar -xzf cinnamon.tar.gz -C /

echo 'Ставим лого ArchLinux в меню'
wget ordanax.ru/arch/archlinux_logo.png
sudo mv -f ~/Загрузки/archlinux_logo.png /usr/share/pixmaps/archlinux_logo.png

mkdir ~/Изображения
mkdir ~/Документы
mkdir ~/Загрузки
mkdir ~/Музыка
mkdir ~/Видео

echo 'Ставим обои на рабочий стол'
wget https://getfile.dokpub.com/yandex/get/https://yadi.sk/i/azK7wgu51mGeuA -O peyzazh-81.jpg
sudo mv -f ~/Загрузки/peyzazh-81.jpg ~/Изображения/peyzazh-81.jpg
rm -rf ~/Загрузки/*

echo 'Включаем сетевой экран'
sudo ufw enable

echo 'Установка завершена!'
rm -rf ~/arch3.sh
