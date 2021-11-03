case "$(uname -s)" in
  Linux)
    eval "$(cat /etc/lsb-release)"
    export DISTRIB_ID;
    export DISTRIB_RELEASE;
    export DISTRIB_CODENAME;
    export DISTRIB_DESCRIPTION;
  ;;
esac
