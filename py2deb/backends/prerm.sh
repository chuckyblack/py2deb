#!/bin/sh -e

# Generic pre-removal script for Debian binary packages that cleans up *.pyc
# files left around by Debian packages containing Python modules. This isn't
# necessary for packages built using py_support or dh_python2, however those
# are not always an option...

SCRIPT_NAME="$0"
PACKAGE_NAME="`basename "$SCRIPT_NAME" .prerm`"
if [ -z "$PACKAGE_NAME" ]; then
  echo "Warning: Failed to determine name of package! (py2deb prerm script)" >&2
else
  dpkg -L $PACKAGE_NAME | grep '\.py$' | while read filename; do
    echo "${filename}c"
    echo "${filename}o"
  done | xargs --delimiter '\n' --no-run-if-empty rm --force
fi
