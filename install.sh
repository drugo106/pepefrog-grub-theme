#! /bin/bash

rm -rf /boot/grub/themes/pepefrog
cp -r pepefrog /boot/grub/themes/

BOOT_MODE='legacy'
UPDATE_GRUB=''

if [[ -d /boot/efi && -d /sys/firmware/efi ]]; then
	BOOT_MODE='UEFI'
fi

echo "Boot mode: ${BOOT_MODE}"

if [[ -e /etc/os-release ]]; then
	source /etc/os-release
	echo "distro: ${ID}"

	if [[ "$ID" =~ (debian|ubuntu|solus|void) || \
		"$ID_LIKE" =~ (debian|ubuntu|solus|void) ]]; then
		UPDATE_GRUB='update-grub'

	elif [[ "$ID" =~ (arch|gentoo) || \
		"$ID_LIKE" =~ (archlinux|gentoo) ]]; then
		UPDATE_GRUB='grub-mkconfig -o /boot/grub/grub.cfg'
	fi
fi

echo 'Creating GRUB themes dir and copy theme'
sudo mkdir -p /boot/grub/themes/pepefrog
sudo cp -r * /boot/grub/themes/pepefrog

echo 'Remove old theme'
sudo sed -i '/^GRUB_THEME=/d' /etc/default/grub

#new line
echo | sudo tee -a /etc/default/grub

echo 'Set GRUB uses graphical output'
sudo sed -i 's/^\(GRUB_TERMINAL\w*=.*\)/#\1/' /etc/default/grub

echo 'Install theme'
echo "GRUB_THEME=/boot/grub/themes/pepefrog/theme.txt" | sudo tee -a /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg
