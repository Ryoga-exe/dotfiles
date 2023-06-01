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
        printf "  \x1b[35mSkipped (dry run):\x1b[39m \x1b[36m%s\x1b[39m -> \x1b[36m%s\x1b[39m\n" "$1" "$2"
    else
        ln -fns "$1" "$2"
        printf "  \x1b[32mCreated:\x1b[39m \x1b[36m%s\x1b[39m -> \x1b[36m%s\x1b[39m\n" "$1" "$2"
    fi
}

main() {
    parse_args "$@"
    currentDir=`pwd`
    length=${#currentDir}
    for file in `\find ./.config -maxdepth 5 -type f`; do
        from=$(cd $(dirname $file); pwd)/$(basename $file)
        length=${#current}
        length=$((length + 1))
        to=`echo ${from} | sed -e "s/^.\{${length}\}//"`
        create_symbolic_link "${from}" "${to}"
	done
}

main "$@"
