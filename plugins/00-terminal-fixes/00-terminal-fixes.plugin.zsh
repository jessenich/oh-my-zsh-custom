# shellcheck shell=bash

function jetbrains_jediterm_terminal_fix() {
  if ! type 'get-omp-theme' 2>/dev/null | grep -q 'function'; then
    return 0;
  else
    OMP_THEME="$(get-omp-theme)"
  fi

  # JetBrains-JediTerm || jediterm
  if [[ "$TERMINAL_EMULATOR" =~ [Jj]edi[Tt]erm ]] && [[ -n "$OMP_THEME" ]]; then
    export TERMINAL_EMULATOR="jediterm"
    export TERM_PROGRAM="jediterm"
    export TERM_PROGRAM_VERSION="1.0"
    export TERM_PROGRAM_NAME="jediterm"

    if [ -e "$ZSH_CUSTOM"/themes/powerlevel10k ]; then
      export ZSH_THEME="powerlevel10k/powerlevel10k";
    else
      export ZSH_THEME=agnoster;
    fi
  fi
}


function tilix_vte_symlink_fix() {
  # Tilix only available on Linux. Don't apply to MacOS.
  if [[ "$(uname)" =~ Linux* ]] && [ -n "$TILIX_ID" ] || [ -n "$VTE_VERSION" ]; then
    if [ ! -e /etc/profile.d/vte.sh ]; then
      if [ -e /etc/profile.d/vte-2.91.sh ]; then
        ln -sf /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh;
      elif [ -e /etc/profile.d/vte.csh ]; then
        ln -sf /etc/profile.d/vte.csh /etc/profile.d/vte.sh;
      elif [ -e /etc/profile.d/vte-2.91.csh ]; then
        ln -sf /etc/profile.d/vte-2.91.csh /etc/profile.d/vte.sh;
      else
        echo "No VTE profile found"
        exit 1;
      fi
    fi

    source /etc/profile.d/vte.sh
  fi
}

jetbrains_jediterm_terminal_fix;
tilix_vte_symlink_fix;
