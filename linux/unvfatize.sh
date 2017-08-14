#!/bin/bash
#este script, corrije permissões de arquivos vindo de partições VFAT/NTFS
#Compatível com nomes de diretório contendo espaços (tm)
 
dir="$@"
if [ -z "$dir" ]; then
        echo No directory name given, using actual directory in 5 seconds, press ctrl-c to cancel...
        sec=5
        while [ $sec -ge 0 ]; do
                sleep 1
                echo -n "$sec "
                sec=$((sec-1))
        done
        dir=.
fi
echo -n "Analyzing directory infra-structure..."
mb=$(du -sm "${dir}"|awk '{print $1}')
echo "Will fix $mb MB of data"
echo Fixing Directory permissions...
find "${dir}" -type d -exec chmod 0755 \{} \;
echo Fixing File permissions...
find "${dir}" -type f -exec chmod 0644 \{} \;
echo Done.
