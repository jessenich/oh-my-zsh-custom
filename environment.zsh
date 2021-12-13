# Enable to turn on debug logging within plugins
export OHMYZSH_DEBUG_SHELL="false";

# Set up extended file system variables
EXTFS=$(test -d "/Volumes/SEAGATE4TB" && echo "/Volumes/SEAGATE4TB")
CACHESFS=$(test -d "$EXTFS/Caches" && echo "$EXTFS/Caches" || echo "/tmp/Caches")

# Move NuGet Caches and Dotnet Stores to extended fs
NUGET_PACKAGES="$CACHESFS/NuGet"
DOTNET_SHARED_STORE="$CACHESFS/DotNetSharedStore"

# NVM Home
NVM_DIR="$HOME/.nvm"

# Dotnet Configs
DOTNET_NO_LOGO='true'
DOTNET_CLI_TELEMETRY_OPTOUT='true'
