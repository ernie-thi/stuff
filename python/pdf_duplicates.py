#!/usr/bin/env python3 
""" Find all pdf files in a directory and eliminate duplicates based on file Name. Using regex"""

import os, shutil, sys
from pathlib import Path
p = Path.home()

print(p)
print(type(p))
if sys.argv[1] == '':
    sys.exit("Include path to folder which contains pdf files as first argument passed when calling")

destination = str(sys.argv[1])
os.chdir(destination)
files = os.listdir()
print("files: ------------")
[print(i) for i in files]
# TODO: pdf files filtern  <12-04-23,ernie> #
# TODO: pdf files auf duplikate pruefen <12-04-23,ernie> #
# TODO: dann nur noch die betroffenen files an send2trash senden <12-04-23,ernie> #
# TODO: und die nicht betroffenen in ein zip packen <12-04-23,ernie> #
