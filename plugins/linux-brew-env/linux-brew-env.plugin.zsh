
case "$(uname -s)" in
  Linux)
    # Import brews shell env
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
    export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar";
    export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew";
    export HOMEBREW_SHELLENV_PREFIX="/home/linuxbrew/.linuxbrew";
    export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH:+":$PATH"}";
    # export MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH:+":$MANPATH"}";
    # export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:+":$INFOPATH"}";

    # Disable telemetry from homebrew
    export HOMEBREW_NO_ANALYTICS=1
    ;;
esac


