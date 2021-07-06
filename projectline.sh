#!/usr/bin/bash

# helpers
bold=$(tput bold)
red="\e[31m"
yellow="\e[33m"
green="\e[32m"
normal=$(tput sgr0)

# Default variables
projects_path=~/projects
config_file=~/.config/projectline/config.sh
usage="${green}projectline${normal}: program to set the environment for a project

${yellow}USAGE:${normal}
    projectline [OPTIONS]

${yellow}OPTIONS:${normal}
    ${green}-h       ${normal}    Print this help message
    ${green}-c <FILE>${normal}    Set config file (default: ~/.config/projectilne/config.sh)
    ${green}-p <PATH>${normal}    Set projects path (default: ~/projects)"

if test -f "${config_file}" ; then
    source "${config_file}"
else
    echo -e "${bold}${yellow}WARNING:${normal} config file doesn't exists. Loading defaults"
fi

while getopts ':hc:p:' option; do
    case "${option}" in
        h)  echo -e "$usage"
            exit 0
            ;;
        c)  config_file=$OPTARG
            ;;
        :)  echo -e "${bold}${red}ERROR:${normal} missing argument for -${OPTARG}" >&2
            exit 1
            ;;
        p)  projects_path=$OPTARG
            ;;
        :)  echo -e "${bold}${red}ERROR:${normal} missing argument for -${OPTARG}" >&2
            exit 1
            ;;
        \?) echo -e "${bold}${red}ERROR:${normal} illegal option: -${OPTARG}" >&2
            exit 1
            ;;
    esac
done

if [ "${projects_path: -1}" != "/" ]; then
    projects_path+="/"
fi

[ ! -d "$projects_path" ] && echo -e "${bold}${red}ERROR:${normal} '$projects_path' doesn't exists." && exit 1

cd $projects_path

project_path=$projects_path
project_relative_path=$(fd -H -t d '\.git$' --prune | sed 's#/.git##' | fzf )

if [ -z "$project_relative_path" ]; then
    exit 0
fi

project_path+=$project_relative_path

project_name=$(basename $project_path)

cd $project_path

if [ $(type -t onReady) ]; then
    onReady
else
    tmux new -d -s $project_name -n editor
    tmux a -t $project_name
fi
exit 0
