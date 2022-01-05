case "$(uname -s)" in
  Linux)
    if [[ -e /etc/lsb-release ]]; then
      source /etc/lsb-release;
      export DISTRIB_ID;
      export DISTRIB_RELEASE;
      export DISTRIB_CODENAME;
      export DISTRIB_DESCRIPTION;
    fi
  ;;
esac
