#shellcheck shell=bash



jetbrains_terminal_fix() {
  if ! type 'get-omp-theme' 2>/dev/null | grep -q 'function'; then
    exit 0;
  else
    OMP_THEME="$(get-omp-theme)"
  fi

  # JetBrains-JediTerm || jediterm
  if [[ "$TERMINAL_EMULATOR" = *edi*erm* ]] && [ -n "$OMP_THEME" ]; then
    export TERMINAL_EMULATOR="jediterm"
    export TERM_PROGRAM="jediterm"
    export TERM_PROGRAM_VERSION="1.0"
    export TERM_PROGRAM_NAME="jediterm"
    export OMP_THEME="$OMP_THEME"
    export SHIMMED_THEME="powerlevel10k/powerlevel10k";

    if [ -e "$ZSH_CUSTOM"/themes/powerlevel10k ]; then
      export ZSH_THEME="$SHIMMED_THEME";
      source "$ZSH_CUSTOM"/themes/powerlevel10k/powerlevel10k.zsh-theme;
    else
      export ZSH_THEME=agnoster
    fi

  fi

}
