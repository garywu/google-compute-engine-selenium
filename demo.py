#!/usr/bin/env python

from pyvirtualdisplay import Display
from selenium import webdriver

display = Display(visible=0, size=(800, 600))
display.start()

url = 'http://www.python.org'

print 'browsing with firefox, ', url
try:
  browser = webdriver.Firefox()
  browser.get(url)
  print browser.title
  browser.quit()
except Exception as e:
  print e

print 'browsing with chrome, ', url
try:
  browser = webdriver.Chrome()
  browser.get(url)
  print browser.title
  browser.quit()
except Exception as e:
  print e

display.stop()
