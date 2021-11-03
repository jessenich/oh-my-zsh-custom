command-exists() {
  command -v "$@" >/dev/null 2>&1
}

current-epoch() {
  zmodload zsh/datetime
  echo $(( EPOCHSECONDS / 60 / 60 / 24 ))
}

source-all() {
    if [ "$#" -eq 1 ]; then exit 0; fi

    _sa_test_path=false;
    if [ "$1" = "-t" ] || [ "$1" = "--test" ]; then
        _sa_test_path=true;
        shift;
    fi

    if [ "$1" = "-v" ] || [ "$1" = "--verbose" ]; then
        _sa_verbose=true;
        shift;
    fi

    while [ "$#" -gt 0 ]; do
        if [ "$_sa_verbose" = true ]; then echo "Sourcing file $1"; fi

        if "$_sa_test_path"; then
            if [ -r "$1" ]; then
                source "$1";
            fi
        else
            source "$1";
        fi
        shift;
    done
    unset test_path;
}

import-dotenv() {
    local env_file="$1";
    shift;
    while [ "$#" -gt 0 ]; do
        case "$1" in
            -s | --source-only)
                local source_only=true;$PATH
                shift;;
        esac
    done

    if [ -n "$source_only" ];
    then
        source "$env_file";
    else
        set -x;
        eval "$(cat "$env_file")";
        set +x;
    fi
}

get-local-file-secret() {
    _gs_show_usage() {
        echo "Usage: " >&2;
        echo "   get-secret SECRET_NAME" >&2;
        echo "Example: get-secret GITHUB_TOKEN" >&2;
        exit 1;
    }

    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -h | --help)
                _gs_show_usage;
                return "$?";;

            *)
                if [ -n "$var_value" ]; then
                    _gs_show_usage;
                    return $?;
                else
                    local var_value="$1";
                fi
                shift;;
        esac
    done

    if [ -e "$HOME/.secrets/$var_value" ]; then
        cat "$HOME/.secrets/$var_value";
    elif [ -e "$HOME/Development/.secrets/$var_value" ]; then
        cat "$HOME/Development/.secrets/$var_value";
    elif [ -e "$ZSH_DOTFILES/.secrets/$var_value" ]; then
        cat "$ZSH_DOTFILES/.secrets/$var_value";
    else
        echo "Secret $var_value not found";
        return 1;
    fi
}
