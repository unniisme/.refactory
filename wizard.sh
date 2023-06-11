#!/bin/bash

# Run this to install or uninstall the prompt on the machine.
# Mayn't always work

BASHRC="$HOME/.bashrc"
VIMRC="$HOME/.vimrc"
GITCONFIG="$HOME/.gitconfig"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

while getopts "B:V:G:" opt; do
  case ${opt} in
    B) BASHRC="$OPTARG"
    ;;
    V) VIMRC="$OPTARG"
    ;;
    G) GITCONFIG="$OPTARG"
    ;;
  esac
done
shift $((OPTIND-1))

if [ "$#" -eq 0 ]; then
  echo "Please enter an option. Type 'help' for a list of available options."
  exit 1
fi

case "$1" in
  "help")
    echo "Usage: wizard.sh [-B bashrc_path] [-V vimrc_path] [-G gitconfig_path] option"
    echo ""
    echo "Available options:"
    echo "  help      - Display this help message"
    echo "  install   - Install .refactory customizations"
    echo "  uninstall - Uninstall .refactory customizations"
    ;;
  "install")
    echo "Installing refactory"
    read -p "Warning: This will override .gitconfig and .vimrc. Do you wish to continue? (Y/n) " answer
    if [[ $answer == n ]]; then
        echo "Aborting.."
        exit
    fi
    echo "Continuing.."

    # Add a line in bashrc to source refactory, if line is not already present.
    if grep -q "\:.refactory:$" "$BASHRC"; then
        echo "bashrc already sourced"
    else
        echo "source $DIR/prompt #:.refactory:" >> "$BASHRC"
        echo "bashrc sourced"
    fi

    echo "Adding path to bashrc"
    if grep -q "\:.refactory-path:$" "$BASHRC"; then
        echo "path already added"
    else
        echo "export PATH=\"\$PATH:$DIR/bin\" #:.refactory-path:" >> "$BASHRC"
        echo "path added"
    fi


    echo "Overriding .vimrc"
    cp -f "$DIR/.vimrc" "$VIMRC"

    echo "Overriding .gitconfig"
    cp -f "$DIR/.gitconfig" "$GITCONFIG"

    echo "Installation completed"
    ;;

  "uninstall")
    echo "Uninstalling refactory for Mac"

    # Find and delete the line that ends with ":.refactory:" in the file $BASHRC
    sed -i '' -e '/\:.refactory:$/d' "$BASHRC"
    # Similarly find and delete the path line
    sed -i '' -e '/\:.refactory-path:$/d' "$BASHRC"


    echo "Deleting .vimrc"
    rm -f "$VIMRC"

    echo "Deleting .gitconfig"
    rm -f "$GITCONFIG"
    
    echo "Uninstallation completed"
    ;;
  *)
    echo "Invalid option. Type 'help' for a list of available options."
    exit 1
esac
