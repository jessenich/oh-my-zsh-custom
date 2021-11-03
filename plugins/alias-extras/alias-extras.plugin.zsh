alias nano='nano -l';
alias reload='exec $SHELL -l';
alias gpg-long='gpg --list-secret-keys --keyid-format=long';
alias k='kubectl'

gitrepo_scriptable="$GITHUB_HOME/jessenich/Scriptable";
gitrepo_scriptable_js="$GITHUB_HOME/jessenich/Scriptable.JS";
gitrepo_dockerweb="$GITHUB_HOME/jessenich/dockerweb";
gitrepo_docker_projects="$HOME/Development/workspaces/docker-projects.code-workspace";

alias edit-scriptable="$EDITOR $gitrepo_scriptable";
alias vedit-scriptable="$VISUAL $gitrepo_scriptable";
alias edit-scriptable_js="$EDITOR $gitrepo_scriptablejs";
alias vedit-scriptable_js="$VISUAL $gitrepo_scriptablejs";
alias edit-dockerweb="$EDITOR $gitrepo_dockerweb";
alias vedit-dockerweb="$VISUAL $gitrepo_dockerweb";
alias edit-docker-project="$EDITOR $codews_docker_projects";
alias vedit-docker-project="$VISUAL $codews_docker_projects";
