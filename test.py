#!/usr/bin/python2.7

import cgitb
cgitb.enable()

print("Content-type: text/plain\n\n")


import pygame
import subprocess

result = subprocess.check_output(["ls", "/usr/lib/python2.5/site-packages"])
print(result)

print( "done!")
