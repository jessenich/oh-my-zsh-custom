DEVELOPMENT_PATH=${DEVELOPMENT_PATH:-"$HOME/Development"};
WORKSPACES_PATH=${WORKSPACES_PATH:-"$DEVELOPMENT_PATH/workspaces"};
GITHUB_PATH=${GITHUB_PATH:-"$DEVELOPMENT_PATH/repos/github"};
JN_GITHUB_PATH=${JN_GITHUB_PATH:-"$GITHUB_PATH/jessenich"};

if [ -z "$VISUAL" ] || [ $VISUAL = '' ]; then alias VISUAL="code -n"; fi

gitrepo_scriptable="$JN_GITHUB_PATH/Scriptable";
gitrepo_scriptablejs="$JN_GITHUB_PATH/Scriptable.JS";
gitrepo_dockerweb="$JN_GITHUB_PATH/DockerWeb";
codews_docker_projects="$WORKSPACES_PATH/docker-projects.code-workspace";
codews_shell_projects="$WORKSPACES_PATH/shell-projects.code-workspace";
