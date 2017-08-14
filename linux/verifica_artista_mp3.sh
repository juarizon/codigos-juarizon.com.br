#!/bin/bash
TXT_BLD=$(tput bold)
TXT_RED=$(tput setaf 1)
TXT_GREEN=$(tput setaf 2)
TXT_YLW=$(tput setaf 3)
TXT_BLUE=$(tput setaf 4)
TXT_PURPLE=$(tput setaf 5)
TXT_CYAN=$(tput setaf 6)
TXT_WHITE=$(tput setaf 7)
TXT_RESET=$(tput sgr0)
 
if [ "x$1" = "x-h" ]; then
        echo "Uso: ${0##*/} [-h] [nome_artista] [nome_arq_log|-show]"
        echo "    Procura a partir do diretório atual por arquivos mp3, analizando da tag 'Artist'"
        echo "    Caso seja divergente da string [nome_artista], mostra o número da linha em que apareceu"
        echo "    e a string divergente. O argumento opcional [nome_arq_log] especifica o arquivo de log"
        echo "    que será sobrescrito com arquivos mp3 sem tag definida e demais erros do sistema."
        echo "    Caso o segundo argumento seja '-show' simplesmente mostra uma listagem com linha numeradas"
        echo "    dos mp3 juntamente com suas tags."
        exit 0
fi
ARTIST="${1}"
if [ "x${ARTIST}" = "x" ]; then
        echo -n "Preencha nome exato artista:"
        read ARTIST
fi
if [ "x${ARTIST}" = "x" ]; then
        echo "Nome de artista em branco" >&2
        exit 1
fi
LOG=${2}
if [ "x${LOG}" = "x" ]; then
        LOG=~/verifica_artista_mp3.log
fi
if [ "x$LOG" = "xshow" ]; then
        find . -name "*.mp3" -print0|xargs -0 mp3info  -p "Artist: %a\t kB: %k '%F'\n" |nl|more
else
        echo "${TXT_BLD}${TXT_GREEN}* * * * Verificando conteúdos das tags das MP3 ($PWD) * * * * ${TXT_RESET}"
        find . -name "*.mp3" -print0|xargs -0 mp3info -p " ${TXT_PURPLE}Artist: %a${TXT_RESET}\t kB: %k nnxn ${TXT_BLD}${TXT_RED}'%F'${TXT_RESET} nnxs\n" 2>$LOG|nl|grep -vi "Artist: ${ARTIST}" |sed -e 's,nnxn,\n,' -e 's,nnxs,\\,'
        if [ $(cat "${LOG}" |wc -l) = 0 ]; then
                echo -e "mp3info analisou todos os arquivos mp3 dentro de\n'${PWD}'\ncom sucesso!"
                rm "${LOG}"
        else
                echo -e "Erros encontrados, consulte\n${LOG}\n($(cat "${LOG}" |wc -l) linhas)"
        fi
        echo -e "Para consertar algum, utilizar\n${TXT_BLD}${TXT_RED}mp3info -a '${ARTIST}'${TXT_RESET} \\"
        echo "adicionando as linhas acima referentes aos arquivos a serem corrigidos."
fi
