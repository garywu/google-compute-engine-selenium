#!/usr/bin/env python

from pyvirtualdisplay import Display
from selenium import webdriver

display = Display(visible=0, size=(800, 600))
display.start()

print 'browsing with firefox'
browser = webdriver.Firefox()
browser.get('http://www.python.org')
print browser.title
browser.quit()

print 'browsing with chrome'
browser = webdriver.Chrome()
browser.get('http://www.python.org')
print browser.title
browser.quit()

display.stop()
