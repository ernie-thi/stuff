#!/usr/bin/env python3 
""" Find all pdf files in a directory and eliminate duplicates based on file
Name. Using regex. Also create a folder in which duplicates will be moved, to
restore them in case sth went wrong. This folder has to be deleted manually
after the program ran. Also among all instances of one file, the one with the
biggest size will be kept """

import os
import shutil 
import sys
import re
from pathlib import Path

# Grab home directory and directory from which filtering to be executed
home = Path.home()
destination = str(input('Input destination Folder to search for pdf duplicates, like $HOME/your/path: ') or "/home/raphael/Downloads/")
duplicate_exist = 0
move_duplicates = 0

# In case no path given
if not destination:             
    sys.exit("No Path inserted, Program terminated.")

# change to destination directory and grab containing files
os.chdir(destination)
files = os.listdir()
print("files: ------------")

# declaring empty list for pdf files and regex patterns
pdf_files = []
pattern = re.compile(r'([A-Za-z0-9]+.+)(\s\(\d+\))*\.pdf$', re.IGNORECASE)
basenamepattern = re.compile(r'(\s\(\d+\))$')

for file in files:
    if pattern.search(file):
        pdf_files.append(file)          #appending pdf file to list
print("""FOUND PDF-Files:---------------------------------------------------------------------------------------""")
[print(pdf) for pdf in pdf_files]

# declare a dict for pdf and sorting process
print("--------------------------------------SORTING--------------------------------------------------------------")
pdf_dict = {}
for file in pdf_files:
    basename, ext = os.path.splitext(file)
    match = pattern.search(file)
    if match:
        # save filename without duplicate counter
        original_basename = re.sub(basenamepattern,'',basename)
        # if filename is already existent in our dictionary add it to key:list
        if original_basename in pdf_dict:
            pdf_dict[original_basename].append(file)
        # when filename is not part of dict yet, add it as new entry
        else:
            pdf_dict[original_basename] = [file]

for key,value in pdf_dict.items():
    # To determine whether there were duplicates
    if len(value) > 1:
        duplicate_exist += 1
        if duplicate_exist == 1:
            print("KEY VALUE PAIRS: -----------------------------------------------------------------------------------------------")
        print(f"{key} ----------------------------------> {len(value)}")

#TODO: Maybe also print a statement to inform the user (in case) that no duplicate file was found at all
if not duplicate_exist:
    sys.exit("No duplicate PDF-Files, programm aborted")

# Create duplicate Directory or check if already existing
duplicate_path = os.path.join(destination, "Duplikate_pdfs")
if not os.path.exists(duplicate_path):
    os.makedirs(duplicate_path)

# Iterate over pdf_dict and ask user whether duplicate files should be moved then
move_duplicates = int(input("Do you want to move the duplicates to a seperate folder now? Insert 1 for YES and 0 for NO: "))
if move_duplicates == 1:
    for key in pdf_dict.keys():
        if len(pdf_dict[key]) > 1:
            # determining largest file of lists
            largest_file = max(pdf_dict[key], key=lambda x: os.path.getsize(x))
            print(f"der größte ist: {largest_file}")
            # moving the smaller files to dup folder
            for smaller in pdf_dict[key]:
                if smaller != largest_file:
                    shutil.move(smaller, os.path.join(duplicate_path, smaller))
                    print(f"Es wurde File {smaller} verschoben") 
    print(f"Duplicate pdf files moved to : {duplicate_path}")
else:
    print("Duplicate files NOT moved")
#TODO: Maybe add Date of creation to duplicate folder, or log file which tells when programm last ran
#TODO: Add Exception-Handling?
#TODO: Add logging logic