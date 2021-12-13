# shellcheck shell=bash

__load-completions() {
  local plugin_path="$ZSH_CUSTOM/plugins/completion-extras";
  declare -A comp_exes;
  local comp_exes=(
    [kubeadm]="source <(kubeadm completion zsh)"
    [minikube]="source <(minikube completion zsh); source <(minikube kubectl completion zsh);"
    [helm]="source <(helm completion zsh)"
    [kubectl]="source <(kubectl completion zsh)"
    [microk8s]="source <(microk8s kubectl completion zsh); source <(microk8s helm completion zsh); source <(microk8s helm3 completion zsh);"
    [gh]="source <(gh completion -s zsh)"
    [kind]="source <(kind completion zsh)"
  )

  for exe cmd in "${(@kv)comp_exes}"; do
    if command -v "$exe" >/dev/null; then
      if [ "$OHMYZSH_DEBUG_SHELL" = "true" ]; then
        echo "Loading $exe completion for $cmd"
      fi

      eval "$cmd"

      if [ "$OHMYZSH_DEBUG_SHELL" = "true" ]; then
        echo "Loaded $exe completion for $cmd"
      fi
    fi
  done
}

__load-completions "$@";
