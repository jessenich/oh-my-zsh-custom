#!/usr/bin/env zsh

# Path prefix additions
typeset -agx PATH_PREFIXES;
typeset -agx PATH_SUFFIXES;
typeset -agx PACKAGE_CONFIG_PATHS;

PATH_PREFIXES=(
    "/usr/local/opt/ruby/bin"
    "/usr/local/opt/gnu-getopt/bin"
    "/usr/local/opt/make/libexec/gnubin"
    "/usr/local/opt/bison/bin"
    "/usr/local/opt/util-linux/bin"
    "/usr/local/opt/util-linux/sbin"
    "/usr/local/opt/unzip/bin"
    "$HOME/.dotnet/tools"
)

# Path suffix additions
PATH_SUFFIXES=( );

PACKAGE_CONFIG_PATHS=(
    "/usr/local/opt/ruby/lib/pkgconfig"
    "/usr/local/lib/pkgconfig"
    "/usr/local/opt/openssl/lib/pkgconfig"
);

join-array() {
    if [ "$#" -eq 1 ]; then exit 0; fi
    local delimiter;
    if [ "$1" = "-d" ] || [ "$1" = "--delimiter" ]; then
        delimiter="$2";
        shift 2;
    else
        delimiter="$IFS";
    fi
    local cpa_paths;
    while [ "$#" -gt 0 ]; do
        cpa_paths="${cpa_paths}${delimiter}$1";
        shift;
    done

    echo "${cpa_paths[@]}";
}


test "${#PATH_PREFIXES[@]}" -gt 0 && \
PATH="$(join-array -d ':' "${PATH_PREFIXES[@]}"):$PATH" && \
export PATH;

test "${#PATH_SUFFIXES[@]}" -gt 0 && \
PATH="$PATH:$(join-array -d ':' "${PATH_SUFFIXES[@]}")" && \
export PATH;

test "${#PACKAGE_CONFIG_PATHS[@]}" -gt 0 && \
PKG_CONFIG_PATH="$(join-array -d ':' "${PACKAGE_CONFIG_PATHS[@]}"):$PKG_CONFIG_PATH" &&
export PKG_CONFIG_PATH;

# Colorize with chroma if installed
if builtin command -v chroma >/dev/null; then
    export ZSH_COLORIZE_TOOL=chroma;
    export ZSH_COLORIZE_STYLE="colorful";
    export ZSH_COLORIZE_CHROMA_FORMATTER=terminal256;
else
    echo "Chroma not installed. Skipping colorization setup." >> "$ZSH_STARTUP_LOG";
fi

# NVM Home
test command -v nvm >/dev/null 2>&1 && \
    export NVM_DIR="${NVM_DIR:-"$HOME/.nvm"}"

# DotNet Configs

export DEVELOPMENT_PATH=${DEVELOPMENT_PATH:-"$HOME/Development"};
export WORKSPACES_PATH=${WORKSPACES_PATH:-"$DEVELOPMENT_PATH/workspaces"};
export GITHUB_PATH=${GITHUB_PATH:-"$DEVELOPMENT_PATH/repos/github"};

test -d "$WORKSPACES_PATH" || mkdir -p "$WORKSPACES_PATH";
test -d "$GITHUB_PATH" || mkdir -p "$GITHUB_PATH";

if [ -z "$VISUAL" ] || [ $VISUAL = '' ]; then
    alias VISUAL="code -n";
fi
