#!/usr/bin/env python

from pyvirtualdisplay import Display
from selenium import webdriver

display = Display(visible=0)
display.start()

url = 'http://www.python.org'

print 'browsing with firefox, ', url
browser = webdriver.Firefox()
browser.get(url)
print browser.title
browser.quit()

print 'browsing with chrome, ', url
browser = webdriver.Chrome()
browser.get(url)
print browser.title
browser.quit()

display.stop()
