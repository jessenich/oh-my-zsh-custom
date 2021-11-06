# shellcheck shell=bash

jetbrains_jediterm_terminal_fix() {
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

tilix_terminal_fix() {
  if [ -n "$TILIX_ID" ] || [ -n "$VTE_VERSION" ]; then
    if [ ! -e /etc/profile.d/vte.sh ]; then
      if [ -e /etc/profile.d/vte-2.91.sh ]; then
        ln -sf /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
      elif [ -e /etc/profile.d/vte.csh ]; then
        ln -sf /etc/profile.d/vte.csh /etc/profile.d/vte.sh
      elif [ -e /etc/profile.d/vte-2.91.csh ]; then
        ln -sf /etc/profile.d/vte-2.91.csh /etc/profile.d/vte.sh
      elif [[ -e /etc/profile.d/vte** ]]; then
        ln -sf /etc/profile.d/vte** /etc/profile.d/vte.sh
      else
        echo "No VTE profile found"
        return 1;
      fi

      source /etc/profile.d/vte.sh
      return 0;
    # else
    #   echo "Detected Tilix terminal environment, but no file found at /etc/profile.d/vte.sh" >&2;
    #   echo "A symlink may be needed from the numbered version to 'vte.sh'" >&2;
    #   echo "Run this command and reload your environment:" >&2;
    #   echo "    ln -sf /etc/profile.d/vte-*.**.sh /etc/profile.d/vte.sh" >&2;
    # fi
  fi
}

jetbrains_jediterm_terminal_fix;
tilix_terminal_fix;
