if [ -z "$EDITOR" ] || [ "$EDITOR" = "" ]; then
  alias nano='nano -l';
  EDITOR=nano;
  if [[ -n "$SSH_CONNECTION" ]]; then
    VISUAL=$EDITOR;
  fi
fi

if [ -z "$VISUAL" ] || [ "$VISUAL" = "" ]; then
  VISUAL=code;
  if [[ -n "$SSH_CONNECTION" ]]; then
    EDITOR=$VISUAL;
  fi
fi

gitrepo_scriptable="$JN_GITHUB_PATH/Scriptable";
gitrepo_scriptable_js="$JN_GITHUB_PATH/Scriptable.JS";
gitrepo_dockerweb="$JN_GITHUB_PATH/DockerWeb"
codews_docker_projects="$HOME/Development/workspaces/docker-projects.code-workspace";

alias edit-scriptable="$EDITOR $gitrepo_scriptable";
alias vedit-scriptable="$VISUAL $gitrepo_scriptable";
alias edit-scriptable_js="$EDITOR $gitrepo_scriptablejs";
alias vedit-scriptable_js="$VISUAL $gitrepo_scriptablejs";
alias edit-dockerweb="$EDITOR $gitrepo_dockerweb";
alias vedit-dockerweb="$VISUAL $gitrepo_dockerweb";
alias edit-docker-project="$EDITOR $codews_docker_projects";
alias vedit-docker-project="$VISUAL $codews_docker_projects";
