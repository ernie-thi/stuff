#!/usr/bin/env python3 
""" Find all pdf files in a directory and eliminate duplicates based on file Name. Using regex"""

import os, shutil
from pathlib import Path
p = Path.home()

print(p)
print(type(p))