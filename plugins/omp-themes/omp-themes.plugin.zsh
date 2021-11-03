alias get-omp-theme='cat ~/.zsh/zsh-omp-theme';
alias list-omp-themes='for file in $HOME/.pwsh/themes/*.omp.json; do echo "$file\n"; oh-my-posh --config $file --shell universal; echo "\n"; done; echo; echo "OH MY POSH! THEMES DO NOT WORK WELL WITH JETBRAINS TERMINALS. HANDLE APPROPRIATE WITHIN RC FILE USING $TERMINAL_EMULATOR == "JetBrains-JediTerm";';

set-omp-theme() {
    echo "$1" | sed -e 's/\.omp\.json//g' | tee "$HOME/.zsh/zsh-omp-theme" >/dev/null
}
