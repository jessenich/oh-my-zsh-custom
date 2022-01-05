# Enable to turn on debug logging within plugins

export NULL_TERM="$(printf '\0')";
export NULL_TERM_LEN="${#NULL_TERM}";

# Set up extended file system variables
export EXTFS="${EXTFS:-/mnt/extfs}"
export CACHESFS="${CACHESFS:-/tmp/Caches}"

# Move NuGet Caches and Dotnet Stores to extended fs
export NUGET_PACKAGES="$CACHESFS/NuGet"
export DOTNET_SHARED_STORE="$CACHESFS/DotNetSharedStore"

# Colorize with chroma if installed
if builtin command -v chroma >/dev/null; then
    export ZSH_COLORIZE_TOOL=chroma;
    export ZSH_COLORIZE_STYLE="colorful";
    export ZSH_COLORIZE_CHROMA_FORMATTER=terminal256;
else
    echo "Chroma not installed. Skipping colorization setup." >> "$ZSH_STARTUP_LOG";
fi

# NVM Home
NVM_DIR="${NVM_DIR:-"$HOME/.nvm"}"

# DotNet Configs
if builtin command -v dotnet $NUL; then
DOTNET_NO_LOGO=${DOTNET_NO_LOGO:-1}
DOTNET_CLI_TELEMETRY_OPTOUT=${DOTNET_CLI_TELEMETRY_OPTOUT:-1}
DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT=${DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT:-1}

# Git Options
GIT_CLI_OPTS="--no-pager -c user.name='$GIT_USER'"

export DEVELOPMENT_PATH=${DEVELOPMENT_PATH:-"$HOME/Development"};
export WORKSPACES_PATH=${WORKSPACES_PATH:-"$DEVELOPMENT_PATH/workspaces"};
export GITHUB_PATH=${GITHUB_PATH:-"$DEVELOPMENT_PATH/repos/github"};

if [ -z "$VISUAL" ] || [ $VISUAL = '' ]; then
    alias VISUAL="code -n";
fi
