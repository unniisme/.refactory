#!/bin/bash

# Run this to install or uninstall the prompt on the machine.
# Mayn't always work

BASHRC="$HOME/.bash_profile"


if [ "$#" -eq 0 ]; then
  echo "Please enter an option. Type 'help' for a list of available options."
  exit 1
fi

while getopts "B:" opt; do
  case ${opt} in
    B) BASHRC="$OPTARG"
    ;;
  esac
done
shift $((OPTIND-1))

case "$1" in
  "help")
    echo "Usage: wizard.sh [-B bashrc_path] option"
    echo ""
    echo "Available options:"
    echo "  help      - Display this help message"
    echo "  install   - Install .refactory customizations"
    echo "  uninstall - Uninstall .refactory customizations"
    ;;
  "install")
    echo "Installing refactory for Mac"
    # Add a line in bashrc to source refactory, if line is not already present.
    if grep -q "^: .refactory *" "$BASHRC"; then
        echo "Already sourced"
    else
        DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
        echo ": .refactory & source $DIR/prompt #refactory prompt" >> "$BASHRC"
    fi
    echo "Installation completed"
    ;;
  "uninstall")
    echo "Uninstalling refactory for Mac"
    # Find and delete the line that starts with ": .refactory" in the file $BASHRC
    sed -i '' -e '/^: \.refactory/d' "$BASHRC"
    echo "Uninstallation completed"
    ;;
  *)
    echo "Invalid option. Type 'help' for a list of available options."
    exit 1
esac
