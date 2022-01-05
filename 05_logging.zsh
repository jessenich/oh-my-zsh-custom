OHMYZSH_DEBUG_SHELL="false";
LOGGER_INDENT_COUNT=${LOG_INDENTATION_LEVEL:-0}

_calc_printf_indent_val() {
    if [ "$LOGGER_INDENT_COUNT" -gt 0 ]; then
        printf "%${LOGGER_INDENT_COUNT}s" " ";
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
        printf "%s" "$(printf -- "%09s" "$@")";
    fi
}
