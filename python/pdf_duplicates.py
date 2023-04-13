#!/usr/bin/env python3 
""" Find all pdf files in a directory and eliminate duplicates based on file Name. Using regex"""

import os 
import shutil 
import sys
import re
from pathlib import Path

home = Path.home()
destination = input('Input destination Folder to search for pdf duplicates, like $HOME/your/path: ')
#if len(sys.argv) == 1:
#    sys.exit("Include path to folder which contains pdf files as first argument passed when calling")
#destination = str(sys.argv[1])
if not destination:
    sys.exit("No Path inserted, Program terminated.")
os.chdir(destination)
files = os.listdir()
print("files: ------------")
[print(i) for i in files]

pdf_files = []
pattern = re.compile(r'([A-Za-z0-9]+.+)\.pdf$')
for file in files:
    #if re.search(r'\.pdf$', file) and :
    if pattern.search(file) and pattern.sub(r'\1',file):
        pdf_files.append(file)

print("""PDF-Files:--------------------------------------------------------------------------------------------------------------------------
        -----------------------------------------------------------------------------""")
secondPdfs = []
[ print(i) for i in pdf_files ]
print(len(pdf_files))
# TODO: pdf files filtern  <12-04-23,ernie> #
# TODO: pdf files auf duplikate pruefen <12-04-23,ernie> #
# TODO: dann nur noch die betroffenen files an send2trash senden <12-04-23,ernie> #
# TODO: und die nicht betroffenen in ein zip packen <12-04-23,ernie> #