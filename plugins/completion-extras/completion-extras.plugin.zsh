# shellcheck shell=bash
export fpath=($ZSH_CUSTOM/plugins/completion-extras $fpath);
source <(kubeadm completion zsh)
source <(kubectl completion zsh)
source <(minikube completion zsh)
source <(helm completion zsh)
source <(gh completion zsh)
source <(node --completion-bash)
source <(dotnet suggest script bash)
