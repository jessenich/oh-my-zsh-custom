if [ "$TILIX_ID" ] || [ "$VTE_VERSION" ]; then
    if [ -e /etc/profile.d/vte.sh ]; then
      source /etc/profile.d/vte.sh
    else
      echo "Detected Tilix terminal environment, but no file found at /etc/profile.d/vte.sh" >&2;
      echo "A symlink may be needed from the numbered version to 'vte.sh'" >&2;
      echo "Run this command and reload your environment:" >&2;
      echo "    ln -sf /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh" >&2;
    fi
fi
