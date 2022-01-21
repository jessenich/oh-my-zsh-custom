# shellcheck shell=bash
# shellcheck disable=SC1090,SC1091
# shellcheck enable=quote-safe-variables,check-unassigned-uppercase

# sourceall() {
#     if [ "$#" -eq 1 ]; then exit 0; fi

#     _sa_test_path=false;
#     if [ "$1" = "-t" ] || [ "$1" = "--test" ]; then
#         _sa_test_path=true;
#         shift;
#     fi

#     if [ "$1" = "-v" ] || [ "$1" = "--verbose" ]; then
#         _sa_verbose=true;
#         shift;
#     fi

#     while [ "$#" -gt 0 ]; do
#         if [ "$_sa_verbose" = true ]; then echo "Sourcing file $1"; fi

#         if "$_sa_test_path"; then
#             if [ -r "$1" ]; then
#                 source "$1";
#             fi
#         else
#             source "$1";
#         fi
#         shift;
#     done
#     unset test_path;
# }

# dotenv() {
#     local env_file="$1";
#     shift;
#     while [ "$#" -gt 0 ]; do
#         case "$1" in
#             -s | --source-only)
#                 local source_only=true;
#             shift;;
#         esac
#     done

#     if [ -n "$source_only" ];
#     then
#         source "$env_file";
#     else
#         set -x;
#         eval "$(cat "$env_file")";
#         set +x;
#     fi
# }

mkdir -p "$HOME/.secrets" 2>&1 >/dev/null;
touch "$HOME/.secrets/.gitkeep" 2>&1 >/dev/null;

secret() {
  _gs_show_usage() {
    echo "Usage: secret <name> [ <value> ]";
    echo "   secret github_token ghp_abcdef0123456789abcdef01234567";
    echo "";
    echo "Example:""
    echo "   $ secret GITHUB_TOKEN";
    echo "   > ghp_abcdef0123456789abcdef01234567";
    echo ""
    echo "   $ secret GITHUB_TOKEN ghp_abcdef0123456789abcdef01234567";";
    exit 1;
  }

  while [[ "$#" -gt 0 ]]; do
    case "$1" in
      -h | --help)
        _gs_show_usage;
        return "$?";;

      *)
        if [ -z "$var_value" ]; then
          local -r var_name="$1";
        else
          local -r var_value="$1";
        fi
        shift;;
    esac
  done

  if [ ! -e "$HOME/.secrets/$var_name" ]; then
    _gs_show_usage;
    return $?;
  elif [[ -n "$var_value" ]]; then
    echo "$var_value" > "$HOME/.secrets/$var_name";
  elif [[ -n "$var_name" ]]; then
    cat "$HOME/.secrets/$var_name";
  else
    _gs_show_usage;
    return $?;
  fi

  return 0;
}
