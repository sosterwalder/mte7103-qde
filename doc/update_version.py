#!/usr/bin/env python

import argparse
import csv
import datetime
import os
import subprocess
from jinja2 import Template

VERSION_FILE = 'doc/inc/versions.csv'
OUTPUT_FILE = 'doc/inc/versions.w'


# Top level parser
parser = argparse.ArgumentParser(description=(
    "List and update documentation version. "
    "Sets the version and the date for the document to the current git "
    "revision and the current date."
))
subparsers = parser.add_subparsers(help='help for subcommand', dest='command')

# Parser for list command
list_parser = subparsers.add_parser('list', help='List all known versions')

# Parser for adding a new entry
add_parser = subparsers.add_parser('add', help='Add a new version')
add_parser.add_argument('author',
              type=str,
              nargs=1,
              help="Short name of the author")
add_parser.add_argument('description',
              type=str,
              nargs=1,
              help="Description of the current version")
add_parser.add_argument('-f', '--force',
                         action='store_true',
                         help="Re-write the version, even if known")

args = vars(parser.parse_args())
current_mode = args['command']

# Do a sanity check first: If file does not exist, create it
if not os.path.exists(VERSION_FILE):
    open(VERSION_FILE, 'a').close()

# Get current versions
versions = {}
with open(VERSION_FILE, 'r') as vfh:
    version_reader = csv.reader(vfh, delimiter=';')
    for row in version_reader:
        if len(row) > 0:
            # row[0]: Key == version as full SHA hash
            # row[1]: Short version
            # row[2]: Date of entry
            versions[row[0]] = (row[1],row[2])

if current_mode == 'list':
    for version, (short_version, date) in versions.items():
        print("%s (%s): %s" % (version, short_version, date))

elif current_mode == 'add':
    author = args['author'][0]
    description = args['description'][0]
    do_write = args['force'] or False

    git_cmd = "git rev-parse HEAD"
    git_version = subprocess.getoutput(git_cmd)
    git_short_cmd = "git rev-parse --short HEAD"
    git_short_version = subprocess.getoutput(git_short_cmd)
    date_string = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Write current version to versions file if necessary
    if git_version not in versions:
        versions[git_short_version] = date_string
        with open(VERSION_FILE, 'w') as vfh:
            vfh.write("\n{version};{date}".format(version=git_version, date=date_string))
        do_write = True
        print("Wrote version %s to versions file" % git_version)

    if do_write:
        t_str = """
% -*- mode: latex; coding: utf-8 -*-

% Versions:
% -----------------------------------------------

\chapter*{}
\label{chap:versions}

\\begin{versionhistory}
    {% for rev, (short, date) in versions.items() %}\\vhEntry{ {{ short }} }{ {{ date }} }{ {{author}} }{ {{description}} }{% endfor %}
\end{versionhistory}"""
        t = Template(t_str)
        output = t.render(versions=versions, author=author, description=description)
        with open(OUTPUT_FILE, 'w') as wfh:
            wfh.truncate()
            wfh.write(output)
        print("Wrote version output")
    else:
        print("Version already known, not writing output")
elif current_mode is not None:
    raise KeyError("The given mode '%s' is not known." % (current_mode))
else:
    parser.print_help()
