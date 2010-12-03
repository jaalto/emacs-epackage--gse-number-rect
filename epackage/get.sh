#!/bin/sh

set -e

pwd=$( cd $(dirname $0); pwd )
pkg=$( awk '/^Package:/  {print $2}' "$pwd/info" )
url=$( awk '/^Vcs-Url:/  {print $2}' "$pwd/info" )

agent="Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3) Gecko/20090913 Firefox/3.5.3";

wget --user-agent="$agent" --no-check-certificate --timestamping "$url"

# End of file
