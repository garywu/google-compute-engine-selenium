# SeleniumBase Debian Linux Dependency Installation
# (Installs all required dependencies on Linux)
# Initial version copied from:
# https://github.com/seleniumbase/SeleniumBase/blob/3f60c2e0fd78807528661aff36120700d4ff1ed6/integrations/linux/Linuxfile.sh

# Make sure this script is only run on Linux
value="$(uname)"
if [ "$value" = "Linux" ]
then
  echo "Initializing Requirements Setup..."
else
  echo "Not on a Linux machine. Exiting..."
  exit
fi

# Go home
cd ~

# Configure apt-get resources
sudo sh -c "echo \"deb http://packages.linuxmint.com debian import\" >> /etc/apt/sources.list"
sudo sh -c "echo \"deb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main\" >> /etc/apt/sources.list"

# Update aptitude
sudo apt-get update

# Install core dependencies
sudo apt-get install -y --force-yes unzip
sudo apt-get install -y --force-yes xserver-xorg-core
sudo apt-get install -y --force-yes x11-xkb-utils

# Install Xvfb (headless display system)
sudo apt-get install -y --force-yes xvfb

# Install fonts for web browsers
sudo apt-get install -y --force-yes xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic

# Install Python core dependencies
sudo apt-get update
sudo apt-get install -y --force-yes python-setuptools

# Install Firefox
sudo gpg --keyserver pgp.mit.edu --recv-keys 3EE67F3D0FF405B2
sudo gpg --export 3EE67F3D0FF405B2 > 3EE67F3D0FF405B2.gpg
sudo apt-key add ./3EE67F3D0FF405B2.gpg
sudo rm ./3EE67F3D0FF405B2.gpg
sudo apt-get -qy --no-install-recommends install -y --force-yes firefox
sudo apt-get -qy --no-install-recommends install -y --force-yes $(apt-cache depends firefox | grep Depends | sed "s/.*ends:\ //" | tr '\n' ' ')
sudo wget --no-check-certificate -O firefox-esr.tar.bz2 'https://download.mozilla.org/?product=firefox-esr-latest&os=linux32&lang=en-US'
sudo tar -xjf firefox-esr.tar.bz2 -C /opt/
sudo rm -rf /usr/bin/firefox
sudo ln -s /opt/firefox/firefox /usr/bin/firefox
sudo rm -f /tmp/firefox-esr.tar.bz2
sudo apt-get -f install -y --force-yes firefox

# Install more dependencies
sudo apt-get update
sudo apt-get install -y --force-yes xvfb
sudo apt-get install -y --force-yes build-essential chrpath libssl-dev libxft-dev
sudo apt-get install -y --force-yes libfreetype6 libfreetype6-dev
sudo apt-get install -y --force-yes libfontconfig1 libfontconfig1-dev
sudo apt-get install -y --force-yes python-dev

# Install Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get -f install -y --force-yes
sudo dpkg -i google-chrome-stable_current_amd64.deb

# Install Chromedriver
wget -N http://chromedriver.storage.googleapis.com/2.36/chromedriver_linux64.zip
unzip -o chromedriver_linux64.zip
chmod +x chromedriver
sudo rm -f /usr/local/share/chromedriver
sudo rm -f /usr/local/bin/chromedriver
sudo rm -f /usr/bin/chromedriver
sudo mv -f chromedriver /usr/local/share/chromedriver
sudo ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
sudo ln -s /usr/local/share/chromedriver /usr/bin/chromedriver

#============
# GeckoDriver
#============
GECKODRIVER_VERSION=latest
GK_VERSION=$(if [ ${GECKODRIVER_VERSION:-latest} = "latest" ]; then echo $(wget -qO- "https://api.github.com/repos/mozilla/geckodriver/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([0-9.]+)".*/\1/'); else echo $GECKODRIVER_VERSION; fi)
echo "Using GeckoDriver version: "$GK_VERSION
wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GK_VERSION/geckodriver-v$GK_VERSION-linux64.tar.gz
sudo rm -rf /opt/geckodriver
sudo tar -C /opt -zxf /tmp/geckodriver.tar.gz
rm /tmp/geckodriver.tar.gz
sudo mv /opt/geckodriver /opt/geckodriver-$GK_VERSION
sudo chmod 755 /opt/geckodriver-$GK_VERSION
sudo ln -fs /opt/geckodriver-$GK_VERSION /usr/bin/geckodriver

# Finalize apt-get dependancies
sudo apt-get -f install -y --force-yes

# Get pip
sudo easy_install pip

# get python dependency
wget -O requirements.txt https://raw.githubusercontent.com/garywu/gae-selenium/master/requirements.txt
sudo pip install -r requirements.txt
wget -O demo.py https://raw.githubusercontent.com/garywu/gae-selenium/master/demo.py
chmod +x demo.py
wget -O start_headless.sh https://raw.githubusercontent.com/garywu/gae-selenium/master/start_headless.sh
chmod +x start_headless.sh
