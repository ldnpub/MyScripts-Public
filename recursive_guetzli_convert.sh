#!/bin/bash
for d in */; do # only match directories
	( cd "$d" && (for i in * ; do echo $i && date && guetzli --verbose "$i" "$i" ; done) ) # Use a subshell to avoid having to cd back to the root each time.
done
exit 0
