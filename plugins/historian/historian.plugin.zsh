#!/usr/bin/env zsh

VERSION="1.0.0"
HISTORIAN_SRC=${HISTORIAN_SRC:-"$HOME/.zsh_history"}
HISTORIAN_DB=${HISTORIAN_DB:-"$ZSHRC_DIR/zsh.historian.db"}
HISTORIAN_SQLITE3=${HISTORIAN_SQLITE3:-"$(builtin command -v sqlite3)"}

usage() {
    echo "Usage: hist <subcommand>" >&2
    echo "subcommands:" >&2
    echo "  config           show config" >&2
    echo "  count            count items in history" >&2
    echo "  import           import to db" >&2
    echo "  shell            launch sqlite3 shell with db" >&2
    echo "  search <term>    search for <term>" >&2
    echo "    /term          search for <term>" >&2
    echo "  version          show the version" >&2
}

preflight_check() {
    if [ -z "$HOME" ]; then
        echo "need \$HOME" >&2
        exit 1
    fi

    if [ -z "${HISTORIAN_SQLITE3}" ]; then
        echo "need sqlite3" >&2
        exit 1
    fi
}

ensure_db_exists() {
    ( cat <<SQL
        CREATE TABLE IF NOT EXISTS history (
            id INTEGER PRIMARY KEY ASC,
            command TEXT NOT NULL,
            timestamp INTEGER
        );
        CREATE UNIQUE INDEX IF NOT EXISTS
            history_command_timestamp ON history(command);
        CREATE VIRTUAL TABLE IF NOT EXISTS
            history_search USING fts4(id, history, command);
SQL
    ) | "${HISTORIAN_SQLITE3}" "${HISTORIAN_DB}";
}

fail_unless_db_exists() {
    if [ ! -f "${HISTORIAN_DB}" ]; then
        echo "db (${HISTORIAN_DB}) doesn't exist. Aborting";
        exit 1;
    fi
}

cmd_config() {
    echo "version:        ${VERSION}"
    echo "source_history: ${HISTORIAN_SRC}"
    echo "db:             ${HISTORIAN_DB}"
    echo "sqlite3:        ${HISTORIAN_SQLITE3}"
}

cmd_count() {
    local args=$@
    preflight_check;
    ensure_db_exists;

    ( cat <<SQL
        SELECT COUNT(*) FROM history;
SQL
    ) | "${HISTORIAN_SQLITE3}" "${HISTORIAN_DB}";
}

cmd_import() {
    local args=$@
    preflight_check;
    ensure_db_exists;

    ( cat <<SQL
        CREATE TEMPORARY TABLE variables
            (key TEXT, value INTEGER);
        INSERT INTO variables(key, value)
            SELECT 'items', COUNT(*) FROM history;
        CREATE TEMPORARY TABLE history_import (line TEXT);
.separator $(echo -e "\x01")
.import ${HISTORIAN_SRC} history_import
        INSERT OR IGNORE INTO history(command, timestamp)
            SELECT line, NULL FROM history_import;
        UPDATE variables
            SET value = -1 * value + (SELECT COUNT(*) FROM history); -- lol subtraction
        SELECT 'Imported ' || value || ' item(s).' FROM variables WHERE key = 'items';
SQL
    ) | "${HISTORIAN_SQLITE3}" "${HISTORIAN_DB}";
}

cmd_log() {
    local args=$@
    preflight_check;
    fail_unless_db_exists;

    ( cat <<SQL
.separator "\\n\\t"
        SELECT id, command FROM history ORDER BY id DESC;
SQL
    ) | "${HISTORIAN_SQLITE3}" "${HISTORIAN_DB}" | less;
}

cmd_search() {
    preflight_check;
    ensure_db_exists;

    local args=$@
    _search "$args"
}

cmd_search_slash() {
    preflight_check;
    ensure_db_exists;

    local args=$@
    term="$(echo "$args" | sed -e 's/^.//g')";
    _search "$term"
}

_search() {
    local args=$@
    ( cat <<SQL
.separator "\\n\\t"
        SELECT id, command
        FROM history
        WHERE command LIKE '%${args}%'
        ORDER BY id DESC;
SQL
    ) | "${HISTORIAN_SQLITE3}" "${HISTORIAN_DB}";
}

cmd_shell() {
    local args=$@
    preflight_check;
    fail_unless_db_exists;

    echo "${HISTORIAN_SQLITE3}" "${HISTORIAN_DB}" >&2
    "${HISTORIAN_SQLITE3}" "${HISTORIAN_DB}";
}

cmd_version() {
    echo "historian version: ${VERSION}"
}

main() {
    local cmd=$1
    shift
    case $cmd in
    config)
        cmd_config $@
        ;;
    count)
        cmd_count $@
        ;;
    import)
        cmd_import $@
        ;;
    log)
        cmd_log $@
        ;;
    search)
        cmd_search $@
        ;;
    shell)
        cmd_shell $@
        ;;
    version)
        cmd_version $@
        ;;
    "")
        usage
        ;;
    *)
        if [ -n "$(echo "$cmd" | grep -E '^/')" ]; then
            cmd_search_slash $cmd $@
        else
            usage
            exit 1
        fi
        ;;
    esac
}

main $@
