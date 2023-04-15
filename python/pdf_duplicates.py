#!/usr/bin/env python3 
""" Find all pdf files in a directory and eliminate duplicates based on file
Name. Using regex. Also create a folder in which duplicates will be moved, to
restore them in case sth went wrong. This folder has to be deleted manually
after the program ran. Also among all instances of one file, the one with the
biggest size will be kept """

import os, time
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
basenamepattern = re.compile(r'(\s\(\d+\))$')
for file in files:
    if pattern.search(file):
        pdf_files.append(file)          #appending pdf file to list
print("""PDF-Files:--------------------------------------------------------------------------------------------------------------------------
        -----------------------------------------------------------------------------""")
pdf_files = list([str(i) for i in pdf_files])
[print(i) for i in pdf_files]
# declare a dict for pdf 
print("-------------------SORTIEREN---------------------------------------------------------------------------------")
pdf_dict = {}
basenames= []
#pattern_dups = re.compile(r'((.+)(\s\(\d+\))$', re.IGNORECASE)
for file in pdf_files:
    basename, ext = os.path.splitext(file)
    basenames.append(basename) 
    match = pattern.search(file)
    if match:
        # online save filename without duplicate counter
        original_basename = re.sub(basenamepattern,'',basename)
        print(original_basename)
        #time.sleep(5)
        # if filename is already existent in our dictionary add it to key:list
        # (the full duplicate file name)
        if original_basename in pdf_dict:
            pdf_dict[original_basename].append(file)
            print(f"{original_basename} appended to {file}")
        else:
            pdf_dict[original_basename] = [file]

[print(i) for i in basenames]
#pdf_files.sort()
print("KEY VALUE PAARE -----------------------------------------------------------------------------------------------")
for key,value in pdf_dict.items():
    print(f"{key} -----> {len(value)}")
# Create duplicate Directory or check if already existing
duplicate_path = os.path.join(destination, "Duplikate_pdfs")
if not os.path.exists(duplicate_path):
    os.makedirs(duplicate_path)
# TODO: ordner mit duplikaten erstellen oder zu send2trash senden <12-04-23,ernie> #

# Iterate over pdf_dict
for key in pdf_dict.keys():
    if len(pdf_dict[key]) > 1:
        # determining largest file of lists
        largest_file = max(pdf_dict[key], key=lambda x: os.path.getsize(x))
        print(f"der größte ist: {largest_file}")
        # moving the smaller files to dup folder
        for smaller in pdf_dict[key]:
            if not largest_file:
                #shutil.move(smaller, os.path.join(duplicate_path, smaller))
                print(f"Es wurde File {smaller} verschoben") 

print(f"Duplicate pdf files moved to : {duplicate_path}")
#TODO: fix last errors
# funktioniert bis jetzt so 