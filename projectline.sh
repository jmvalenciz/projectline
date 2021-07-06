#!/usr/bin/bash

# helpers
bold=$(tput bold)
red="\e[31m"
yellow="\e[33m"
green="\e[32m"
normal=$(tput sgr0)

# Default variables
base_path=~/projects
config_file=~/.config/projectline/config.sh
usage="${green}projectline${normal}: program to set the environment for a project

${yellow}USAGE:${normal}
    projectline [OPTIONS]

${yellow}OPTIONS:${normal}
    ${green}-h       ${normal}    Print this help message
    ${green}-c <FILE>${normal}    Set config file (default: ~/.config/projectilne/config.sh)
    ${green}-p <PATH>${normal}    Set projects path (default: ~/projects)"

while getopts ':h:c:p:' option; do
    case "${option}" in
        h)  echo -e "$usage"
            exit 0
            ;;
        c)  config_file=$OPTARG
            ;;
        :)  echo -e "${bold}${red}ERROR:${normal} missing argument for -${OPTARG}" >&2
            exit 1
            ;;
        p)  base_path=$OPTARG
            ;;
        :)  echo -e "${bold}${red}ERROR:${normal} missing argument for -${OPTARG}" >&2
            exit 1
            ;;
        \?) echo -e "${bold}${red}ERROR:${normal} illegal option: -${OPTARG}" >&2
            exit 1
            ;;
    esac
done

if test -f "${config_file}" ; then
    source "${config_file}"
else
    echo -e "${bold}${yellow}WARNING:${normal} config file doesn't exists. Loading defaults"
fi

if [ "${base_path: -1}" != "/" ]; then
    base_path+="/"
fi

[ ! -d "$base_path" ] && echo -e "${bold}${red}ERROR:${normal} '$base_path' doesn't exists." && exit 1

cd $base_path

project_path=$base_path
project_path+=$(fd -H -t d '\.git$' --prune | sed 's#/.git##' | fzf )
project_name=$(basename $project_path)

cd $project_path

if [ $(type -t onReady) ]; then
    onReady
    exit 0
else
    tmux new -d -s $project_name -n editor
    tmux a -t $project_name
fi