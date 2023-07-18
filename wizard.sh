#!/bin/bash

# Run this to install or uninstall the prompt on the machine.
# Mayn't always work


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source $DIR/wizard_options.sh

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
    echo "  vimPack   - git clone all required vim packs"
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


    echo "Backing up .vimrc"
    mv -f "$VIMRC" "$DIR/bckup/"
    ln -s "$DIR/.vimrc" "$VIMRC"
    mkdir -p "$VIMPACK/refactory"
    ln -s "$DIR/vimPack/start/" "$VIMPACK/refactory/start"

    echo "Backing up .gitconfig"
    mv -f "$GITCONFIG" "$DIR/bckup/"
    ln -s "$DIR/.gitconfig" "$GITCONFIG"

    echo "Installation completed"
    ;;

  "uninstall")
    echo "Uninstalling refactory"

    # Find and delete the line that ends with ":.refactory:" in the file $BASHRC
    sed -i '' -e '/\:.refactory:$/d' "$BASHRC"


    echo "Replacing .vimrc"
    mv -f "$DIR/bckup/.vimrc" "$VIMRC" 
    rm -r "$VIMPACK/refactory"

    echo "Replacing .gitconfig"
    mv -f "$DIR/bckup/.gitconfig" "$GITCONFIG" 
    
    echo "Uninstallation completed"
    ;;

  "vimPack")
    echo "cloning vim packs"
    cd "$DIR/vimPack/start"

    for package in "${PACKAGES[@]}"
    do
      git clone "https://github.com/$package"
    done
    ;;

  *)
    echo "Invalid option. Type 'help' for a list of available options."
    exit 1
esac
