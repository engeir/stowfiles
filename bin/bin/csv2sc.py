#!/usr/bin/env python3

# Converts from CSV to spreadsheet calculator. Whatever that is.

import sys
import string

if len(sys.argv) < 2:
    print(f"Usage: {sys.argv[0]} infile [outfile] [delimiter_char]")
    sys.exit(1)

filename_in = sys.argv[1]

if len(sys.argv) > 2:
    outfile = open(sys.argv[2], "w")
else:
    outfile = sys.stdout

delimiter = ":"
if len(sys.argv) == 4:
    delimiter = sys.argv[3][0]
    print(f"using delimiter {delimiter!r}")

letters = string.ascii_uppercase
text = ["# Produced by convert_csv_to_sc.py"]

with open(filename_in, "r") as infile:
    for row, line in enumerate(infile):
        allp = line.rstrip().split(delimiter)
        if len(allp) > 26:
            print("too many columns (max 26)")
            sys.exit(2)
        for column, p in enumerate(allp):
            if not p:
                continue
            col = letters[column]
            try:
                n = int(p)
                text.append(f"let {col}{row} = {n}")
            except ValueError:
                if p[0] == '"':
                    text.append(f"label {col}{row} = {p}")
                else:
                    text.append(f'label {col}{row} = "{p}"')

outfile.write("\n".join(text) + "\n")
if outfile is not sys.stdout:
    outfile.close()
