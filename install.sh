#!/usr/bin/env sh

set -e

WORKSPACE_DIR="${WORKSPACE_DIR:-$HOME/workspace}"
DOTFILES_DIR="${DOTFILES_DIR:-$workspaceDir/repos/dotfiles}"

usage() {
    cat << EOF
Install script for Ryoga.exe's dotfiles.

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

create_xdg_base_directories() {
    mkdir -p -m 700 "${HOME}/.config"
    mkdir -p -m 700 "${HOME}/.cache"
    mkdir -p -m 700 "${HOME}/.local"
    mkdir -p -m 700 "${HOME}/.local/share"
    mkdir -p -m 700 "${HOME}/.local/state"
    mkdir -p -m 700 "${HOME}/.local/bin"
}

create_workspace_directories() {
    mkdir -p $WORKSPACE_DIR
}

deploy() {
    # 
}

main() {
    parse_args "$@"
    create_xdg_base_directories

}

main "$@"
