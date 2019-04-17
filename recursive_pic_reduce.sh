#!/bin/bash
for d in */; do # only match directories
	( cd "$d" && (for file in * ; do convert "$file" -resize 2000x "$file" ; done) ) # Use a subshell to avoid having to cd back to the root each time.
done
exit 0
