#!/usr/bin/env python

import argparse
import csv
import datetime
import os
import subprocess
from jinja2 import Template

VERSION_FILE = 'doc/inc/versions.csv'
OUTPUT_FILE = 'doc/inc/versions.w'


class Version(object):

    def __init__(self):
        key         = None
        short_key   = None
        author      = None
        date        = None
        description = None

    def __str__(self):
        return "%s (%s) %s %s: %s" % (
            v.key, v.short_key, v.author, v.date, v.description
        )


def is_in_versions(haystack, needle, needle_attr="key"):
    for hay in haystack:
        val = getattr(hay, needle_attr)
        if val == needle:
            return True

    return False


def write_version_to_csv(version):
    with open(VERSION_FILE, 'a') as vfh:
        vfh.write("\n{version};{short};{author};{date};{description}".format(
            version=version.key, short=version.short_key,
            author=version.author,
            date=version.date,
            description=version.description
        ))


def write_versions_to_output(versions):
    t_str = """
% -*- mode: latex; coding: utf-8 -*-

% Versions:
% -----------------------------------------------

\chapter*{}
\label{chap:versions}

\\begin{versionhistory}
    {% for v in versions %}\\vhEntry{ {{v.short_key}} }{ {{v.date}} }{ {{v.author}} }{ {{v.description}} }
    {% endfor %}
\end{versionhistory}"""
    t = Template(t_str)
    output = t.render(versions=versions)
    with open(OUTPUT_FILE, 'w') as wfh:
        wfh.truncate()
        wfh.write(output)
    print("Wrote version output")

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

write_parser = subparsers.add_parser('write', help="Writes the version file")

args = vars(parser.parse_args())
current_mode = args['command']

# Do a sanity check first: If file does not exist, create it
if not os.path.exists(VERSION_FILE):
    open(VERSION_FILE, 'a').close()

# Get current versions
versions = []
with open(VERSION_FILE, 'r') as vfh:
    version_reader = csv.reader(vfh, delimiter=';')
    for row in version_reader:
        if len(row) > 0:
            v             = Version()
            v.key         = row[0]
            v.short_key   = row[1]
            v.author      = row[2]
            v.date        = row[3]
            v.description = row[4]
            versions.append(v)

if current_mode == 'list':
    for v in versions:
        print(v)
elif current_mode == 'add':
    author          = args['author'][0]
    description     = args['description'][0]
    write_to_output = args['force'] or False

    git_cmd           = "git rev-parse HEAD"
    git_version       = subprocess.getoutput(git_cmd)
    git_short_cmd     = "git rev-parse --short HEAD"
    git_short_version = subprocess.getoutput(git_short_cmd)
    date_string       = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Write current version to versions file if necessary
    if not is_in_versions(versions, git_version):
        v = Version()
        v.key         = git_version
        v.short_key   = git_short_version
        v.author      = author
        v.date        = date_string
        v.description = description
        versions.append(v)

        write_version_to_csv(v)
        print("Wrote version %s to versions file" % git_version)

        write_to_output = True

    if write_to_output:
        write_versions_to_output(versions)
    else:
        print("Version already known, not writing output")
elif current_mode == 'write':
        write_versions_to_output(versions)
elif current_mode is not None:
    raise KeyError("The given mode '%s' is not known." % (current_mode))
else:
    parser.print_help()
