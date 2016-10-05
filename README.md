gae-selenium
============

1.	Go to [your cloud console compute engine](https://console.cloud.google.com/compute/instances)
2.	create a new instance of VM, you can simply use default settings. this should be a Debian image
3.	ssh into your instance after it's been setup
4.	issue the following commands:

```
wget https://raw.githubusercontent.com/garywu/gae-selenium/master/install.sh
sudo chmod +x install.sh
sudo ./install.sh
./start_headless.sh
./demo.py
```
