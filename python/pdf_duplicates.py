#!/usr/bin/env python3 
""" Find all pdf files in a directory and eliminate duplicates based on file Name. Using regex"""

import os 
import shutil 
import sys
import re
from pathlib import Path

# Grab home directory and directory from which filtering to be executed
home = Path.home()
destination = str(input('Input destination Folder to search for pdf duplicates, like $HOME/your/path: ') or "/home/raphael/Downloads/")
#if len(sys.argv) == 1:
#    sys.exit("Include path to folder which contains pdf files as first argument passed when calling")
#destination = str(sys.argv[1])
# In case no path given
if not destination:             
    sys.exit("No Path inserted, Program terminated.")
# change to destination directory and grab containing files
os.chdir(destination)
files = os.listdir()
print("files: ------------")
[print(i) for i in files]       # kontroll ausgabe

# declaring empty list for pdf files
pdf_files = []
pattern = re.compile(r'([A-Za-z0-9]+.+)(\s\(\d+\))*\.pdf$', re.IGNORECASE)
for file in files:
    if pattern.search(file):
        pdf_files.append(file)          #appending pdf file to list
print("""PDF-Files:--------------------------------------------------------------------------------------------------------------------------
        -----------------------------------------------------------------------------""")
pdf_files.sort()
[print(i) for i in pdf_files]
# declare a dict for pdf 
pdf_dict = {}
pattern_dups = re.compile(r'([A-Za-z0-9]+.+)(\s\(\d+\))$', re.IGNORECASE)
for file in pdf_files:
    basename, ext = os.path.splitext(file)
    if pattern_dups.match(basename):
        # online save filename without duplicate counter
        original_basename = pattern_dups.match(basename).groups()[0]
        # if filename is already existent in our dictionary add it to key:list
        # (the full duplicate file name)
        if original_basename in pdf_dict:
            pdf_dict[original_basename].append(file)
    else:
        # kein Duplikat, erste Instanz
        pdf_dict[basename] = [file]

for key,value in pdf_dict.items():
    print(f"{key} -----> {len(value)}")
# TODO: ordner mit duplikaten erstellen oder zu send2trash senden <12-04-23,ernie> #
