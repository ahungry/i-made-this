#!/bin/bash

#  i made this - A joke
#  Copyright (C) 2015 Matthew Carter <m@ahungry.com>
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Affero General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Affero General Public License for more details.
#
#  You should have received a copy of the GNU Affero General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Find a project with a repurposable license, and repurpose to your own

while getopts ":g::o::d::n::a::y::h" opt; do
    case $opt in
        g)
            GIT="${OPTARG}"
            echo "Remote repository: ${GIT}" >&2
            ;;
        o)
            NAME="${OPTARG}"
            echo "Original project name: ${NAME}" >&2
            ;;
        d)
            CLONE="${OPTARG}"
            echo "Clone directory: ${CLONE}" >&2
            ;;
        n)
            NEW_NAME="${OPTARG}"
            echo "New project name: ${NEW_NAME}" >&2
            ;;
        a)
            AUTHOR="${OPTARG}"
            echo "Original author name: ${AUTHOR}" >&2
            ;;
        y)
            YOU="${OPTARG}"
            echo "New author name: ${YOU}" >&2
            ;;
        h)
            cat <<EOF
Point to a free to re-license project (MIT/BSD) and make it your own.

WARNING: This is extremely alpha quality, and should be used at your own risk!

At this time, do *NOT* use anything but alphanumerics (and spaces) for
any of the option parameters other than '-g'.

  -g  The git remote/clone URL
  -o  Original project name
  -d  Clone directory (where to place the remote files and your new ones)
  -n  New project name
  -a  Original author name
  -y  Your name

Sample call:

./i-made-this.sh -g 'https://github.com/ahungry/i-made-this.git' -o 'i made this' -d 'clone-dir' -n 'my project' -a 'Matthew Carter' -y 'Your Name'

EOF
            exit 0;
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

if [ -z "${GIT}" ]; then
    echo "Error: Missing git remote."
    exit 1
fi

if [ -z "${NAME}" ]; then
    echo "Error: Missing project name."
    exit 1
fi

if [ -z "${CLONE}" ]; then
    echo "Error: Missing clone directory."
    exit 1
fi

if [ -z "${NEW_NAME}" ]; then
    echo "Error: Missing new project name."
    exit 1
fi

if [ -z "${AUTHOR}" ]; then
    echo "Error: Missing original author."
    exit 1
fi

if [ -z "${YOU}" ]; then
    echo "Error: Missing your name."
    exit 1
fi

git clone "${GIT}" "./${CLONE}" || (echo "Failed to clone repository, aborting." && exit 1)
cd "${CLONE}"
find -maxdepth 9 -type f -exec sed -i.imtbak -e "s/${NAME}/${NEW_NAME}/gi" {} \;
find -maxdepth 9 -type f -name 'LICENSE*' -exec cp {} "${NEW_NAME}_LICENSE.md" \;
[ -f "${NEW_NAME}_LICENSE.md" ] || cp ../LICENSE.md "${NEW_NAME}_LICENSE.md"
sed -i.imtbak -e "s/${AUTHOR}/${YOU}/gi" "${NEW_NAME}_LICENSE.md"
find -maxdepth 9 -type f -exec sed -i.imtbak -e "s/${AUTHOR}/${AUTHOR} (modifications copyright ${YOU})/gi" {} \;

find -maxdepth 9 -type f -name 'README.md' -exec echo "See ${NEW_NAME}_LICENSE.md for additional copyright/license information" >> README.md \;
find -maxdepth 9 -type f -name 'README.txt' -exec echo "See ${NEW_NAME}_LICENSE.md for additional copyright/license information" >> README.txt \;
find -maxdepth 9 -type f -name 'README' -exec echo "See ${NEW_NAME}_LICENSE.md for additional copyright/license information" >> README \;

echo "If all looks well, remove the backup sed files with:"
echo ""
echo "find -name '*.imtbak' -delete"
