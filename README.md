gae-selenium
============

1.	Go to [your cloud console compute engine](https://console.cloud.google.com/compute/instances)
2.	create a new instance of VM, keep everything default. this should be a Debian image
3.	ssh into your instance after it's been setup
4.	issue the following commands:

```
sudo apt-get install git
cd /
sudo git clone https://github.com/garywu/gae-selenium.git
cd gae-selenium
./start_headless.sh
./test.py
```
