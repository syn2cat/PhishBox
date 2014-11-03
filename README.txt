howtoinstall

sudo vi /etc/xdg/lxsession/LXDE/autostart
remove screensaver
sudo apt-get install unclutter xdotool git-core screen apache2
git clone git://git.drogon.net/wiringPi
cd wiringPi
./build

mkdir website
cd website
wget https://raw.github.com/HubSpot/odometer/v0.4.6/odometer.js
wget https://raw.github.com/HubSpot/odometer/master/themes/odometer-theme-car.css
cd ..
mkdir -p /home/pi/.config/lxsession/LXDE/
cat > /home/pi/.config/lxsession/LXDE/autostart <<"EOF"
@xset s off
@xset -dpms
@xset s noblank
@sed -i 's/"exited_cleanly": false/"exited_cleanly": true/' ~/.config/chromium/Default/Preferences
@unclutter -display :0 -noevents -grab
@screen -dm ./buttonscanner.sh 
@firefox http://localhost/ 
@sleep 60s
@xdotool key F11
EOF

wget http://code.jquery.com/jquery-1.11.1.min.js
