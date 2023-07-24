#!/bin/bash

# copy-paste
function copyf {
  _copypastefiles=("$@")
  _copypastesrc="$PWD"
  _copypastemode=copy
}

function cutf {
  _copypastefiles=("$@")
  _copypastesrc="$PWD"
  _copypastemode=cut
}

function pastef {
  for f in "${_copypastefiles[@]}"
  do
    cp "${_copypastesrc}/$f" .
    if [[ ${_copypastemode} = "cut" ]]
    then
      rm "${_copypastesrc}/$f"
    fi
  done
}