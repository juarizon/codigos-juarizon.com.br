#!/bin/bash
for i in “$@”; do
lame -b 64 -m j -h “${i}”
mv “${i}”.mp3 “${i}”
done
