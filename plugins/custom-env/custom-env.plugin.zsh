# shellcheck shell=bash
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

export ZSH_2000_DISABLE_RVM=true;

# Preferred editor for local and remote sessions
export CUSTOM_FUNCTIONS_PATH="$HOME/.zsh/custom-functions";
export CUSTOM_ENV_PATH="$HOME/.zsh/custom-env";

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
  export VISUAL=$EDITOR
else
  export EDITOR='code'
  export VISUAL=$EDITOR
fi

# Docker Env additions
export DOCKER_BUILDKIT=1;

# Disable telemetry from homebrew
export HOMEBREW_NO_ANALYTICS=1

# Local machine metadata
export PLATFORM=$(uname)
export FULL_PALTFORM_STRING=$(uname -a);
export LOCAL_HOSTNAME=$(hostname);
