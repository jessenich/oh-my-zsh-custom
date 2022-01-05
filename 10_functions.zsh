# shellcheck shell=bash
# shellcheck disable=SC1090,SC1091
# shellcheck enable=quote-safe-variables,check-unassigned-uppercase

command-exists() {
    builtin command -v "$1" >/dev/null 2>&1 || return 1;
}

join-array() {
    if [ "$#" -eq 1 ]; then exit 0; fi

    local -r delimiter;
    if [ "$1" = "-d" ] || [ "$1" = "--delimiter" ]; then
        delimiter="$2";
        shift 2;
    else
        delimiter="${#1}";
        shift;
    fi
    local -r cpa_paths;
    while [ "$#" -gt 0 ]; do
        cpa_paths="${cpa_paths}${delimiter}${1}";
        shift;
    done

    echo "${cpa_paths[@]}";
}


sourceall() {
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

dotenv() {
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

secret() {
    _gs_show_usage() {
        echo "Usage: " >&2;
        echo "   getsecret SECRET_NAME" >&2;
        echo "Example: get-secret GITHUB_TOKEN" >&2;
        exit 1;
    }

    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -h | --help)
                _gs_show_usage;
                return "$?";;

            *)
                if [ -z "$var_value" ]; then
                    _gs_show_usage;
                    return $?;
                else
                    local -r var_value="$1";
                fi
                shift;;
        esac
    done

    if [ ! -e "$HOME/.secrets/$var_value" ]; then
        _gs_show_usage;
        return $?;
    fi

    cat "$HOME/.secrets/$var_value";
    return 0;
}

omp-theme() {
    echo "$1" | sed -e 's/\.omp\.json//g' | tee "$HOME/.zsh/zsh-omp-theme" >/dev/null
}

