rm -rf /boot/grub/themes/pepefrog
cp -r pepefrog /boot/grub/themes/

#remove old theme
sudo sed -i '/^GRUB_THEME=/d' /etc/default/grub

#new line
echo | sudo tee -a /etc/default/grub

#add theme
echo "GRUB_THEME=/boot/grub/themes/pepefrog/theme.txt" | sudo tee -a /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg
