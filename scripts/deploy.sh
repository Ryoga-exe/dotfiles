#!/usr/bin/env sh

cd `dirname $0`
cd ..
set -e

usage() {
    cat << EOF
Deploy Ryoga.exe's dotfiles.

Usage:
    install.sh [OPTIONS]

Options:
    --dry-run          Dry run
    -h, --help         Print help
EOF
}

parse_args() {
    while [ -n "$1" ]; do
        case "$1" in
            --dry-run)
                DRY_RUN='1'
                ;;
            --help | -h)
                usage
                exit
                ;;
            *)
                printf "\033[1;37;41m ERROR \033[m unexpected option '\033[33m%s\033[m'\n\n" "$1" >&2
                usage >&2
                exit 1
                ;;
        esac

    shift
    done
}

create_symbolic_link() {
    if [ -n "${DRY_RUN}" ]; then
        printf "\033[1;37;45m SKIPPED (dry run) \033[m $1 -> $2\n"
    else
        mkdir -p "${HOME}/$(dirname $to)"
        ln -fns "$1" "$2"
        printf "$1 -> $2"
    fi
}

main() {
    parse_args "$@"
    currentDir=`pwd`
    length=${#currentDir}
    length=$((length + 1))
    for file in `\find ./.config -maxdepth 30 -type f`; do
        from=$(cd $(dirname $file); pwd)/$(basename $file)
        to=`echo ${from} | sed -e "s/^.\{${length}\}//"`
        create_symbolic_link "${from}" "${HOME}/${to}"
    done
}

main "$@"
