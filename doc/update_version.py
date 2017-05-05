#!/usr/bin/env python

import argparse
import csv
import datetime
import os
import subprocess
from jinja2 import Template

VERSION_FILE = 'doc/inc/versions.csv'
OUTPUT_FILE = 'doc/inc/versions.w'


parser = argparse.ArgumentParser(description=(
    "Update documentation version. "
    "Sets the version and the date for the document to the current git "
    "revision and the current date."
))
parser.add_argument('author',
                    type=str,
                    nargs=1,
                    help="Short name of the author")
parser.add_argument('description',
                    type=str,
                    nargs=1,
                    help="Description of the current version")
parser.add_argument('-f', '--force',
                    action='store_true',
                    help="Re-write the version, even if known")
args = vars(parser.parse_args())
author = args['author'][0]
description = args['description'][0]
do_write = args['force'] or False

git_cmd = "git rev-parse HEAD"
git_version = subprocess.getoutput(git_cmd)
date_string = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

if not os.path.exists(VERSION_FILE):
    open(VERSION_FILE, 'a').close()

versions = {}
with open(VERSION_FILE, 'r') as vfh:
    version_reader = csv.reader(vfh, delimiter=';')
    for row in version_reader:
        if len(row) > 0:
            versions[row[0]] = row[1]

if git_version not in versions:
    versions[git_version] = date_string
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
        {% for rev, date in versions.items() %}{
            \\vhEntry{ {{ rev }} }{ {{ date }} }{ {{author}} }{ {{description}} }
        }{% endfor %}
    \end{versionhistory}"""
    t = Template(t_str)
    output = t.render(versions=versions, author=author, description=description)
    with open(OUTPUT_FILE, 'w') as wfh:
        wfh.truncate()
        wfh.write(output)
    print("Wrote version output")
else:
    print("Version already known, not writing output")
