export OHMYZSH_DEBUG_SHELL="false";
LOGGER_INDENT_COUNT=${LOG_INDENTATION_LEVEL:-0}

set_debug_log_indentation() {
  local -r arg0="$1";
  if [[ "$arg0" -le 0 ]]; then
    export LOGGER_INDENT_COUNT=0;
  else
    export LOGGER_INDENT_COUNT=$arg0;
  fi
}

_calc_printf_indent_val() {
    if [[ -z $LOGGER_INDENT_COUNT ]] || [[ $LOGGER_INDENT_COUNT -le 0 ]]; then
        echo -n 5;
        return 0;
    fi

    echo -n "$((5 + LOGGER_INDENT_COUNT));"
}

_debug_log() {
    if [ "$OHMYZSH_DEBUG_SHELL" = "true" ]; then
        printf "$@";
    fi
}

_debug_log_line() {
    if [ "$OHMYZSH_DEBUG_SHELL" = "true" ]; then
        printf "%s" "$@";
    fi
}

_debug_log_line_indent() {
    if [ "$OHMYZSH_DEBUG_SHELL" = "true" ]; then
        printf "%s" "$(printf -- "%$(_calc_printf_indent_val)s" "$@")";
    fi
}

alias enable_debug_logging='export OHMYZSH_DEBUG_SHELL="true";'
alias disable_debug_logging='export OHMYZSH_DEBUG_SHELL="false";'
alias indent_debug_log='export LOG_INDENTATION_LEVEL="$((LOG_INDENTATION_LEVEL + 1))";'
alias debuglog="_debug_log";
