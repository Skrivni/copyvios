#! /usr/bin/env python
# -*- coding: utf-8  -*-

from __future__ import print_function
from os import path, walk, version_info #Per PEP20
from subprocess import run, check_output #Per PEP20, +faster pre-processing

def process(*args):
    #Handler function for check_output run command
    #Input: string arguments
    #Output: encoded byte flow
    print(*args)
    if version_info.major >= 3 and version_info.minor >=5:
        content = run(args) #since PY3.5 subprocess.run is preferred
    else:
        content = check_outputs(args) #back-compatibility with PY<3.5

def main():
    root = path.join(path.dirname(__file__), "static")
    for dirpath, dirnames, filenames in walk(root):
        for filename in filenames:
            name = path.relpath(path.join(dirpath, filename))
            if filename.endswith(".js") and ".min." not in filename:
                process("uglifyjs", "--compress", "-o", name.replace(".js", ".min.js"), "--", name)
            if filename.endswith(".css") and ".min." not in filename:
                process("postcss", "-u", "cssnano", "--no-map", name, "-o",
                        name.replace(".css", ".min.css"))

if __name__ == "__main__":
    main()
