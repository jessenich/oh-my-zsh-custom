LOCAL_ENV_DIR="${LOCAL_ENV_DIR:-"$ZSHRC_DIR/env"}"

set -o allexport
find "$LOCAL_ENV_DIR" -type f -name "**.env.zsh" -print0 | while IFS= read -r -d '' file; do
    source "$file"
done
set +o allexport
