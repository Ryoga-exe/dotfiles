#!/usr/bin/env sh

set -e

WORKSPACE_DIR="${WORKSPACE_DIR:-$HOME/workspace}"
DOTFILES_DIR="${DOTFILES_DIR:-$WORKSPACE_DIR/repos/dotfiles}"

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
    mkdir -p "${WORKSPACE_DIR}"
    mkdir -p "${WORKSPACE_DIR}/repos"
    mkdir -p "${WORKSPACE_DIR}/research"
    mkdir -p "${WORKSPACE_DIR}/sandbox"
    mkdir -p "${WORKSPACE_DIR}/cp"
}

clone_dotfiles() {
    if [ -d "${DOTFILES_DIR}" ]; then
        if [ -n "${DRY_RUN}" ]; then
            printf "\033[1;37;45m SKIPPED (dry run) \033[m Updating dotfiles...\n"
        else
            echo "Updating dotfiles..."
            git -C "${DOTFILES_DIR}" pull
        fi
    else
        if [ -n "${DRY_RUN}" ]; then
            printf "\033[1;37;45m SKIPPED (dry run) \033[m Installing dotfiles...\n"
        else
            echo "Installing dotfiles..."
            git clone https://github.com/Ryoga-exe/dotfiles "${DOTFILES_DIR}"
        fi
    fi
}

main() {
    parse_args "$@"
    create_xdg_base_directories
    create_workspace_directories
    clone_dotfiles
}

main "$@"
