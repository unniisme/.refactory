#!/bin/bash

export _CDshowgit=true
export _CDpromptoverride=true

# Initialize a stack to store directory history
declare -a DIRECTORY_STACK=()

# cd overrides
function CD() { 
    # Backstack
    local option=$1

    # If --back option is provided
    if [ "$option" = "-b" ]; then
        # Pop the last directory from the stack
        if [ ${#DIRECTORY_STACK[@]} -gt 0 ]; then
            local popped_dir="${DIRECTORY_STACK[${#DIRECTORY_STACK[@]}-1]}"
            DIRECTORY_STACK=("${DIRECTORY_STACK[@]:0:${#DIRECTORY_STACK[@]}-1}")
            builtin cd "$popped_dir"
            echo "cd $(pwd)"
            return
        else
            echo "No directory to go back to."
        fi
    else
        # Save the current directory in the stack
        DIRECTORY_STACK+=("$PWD")

        # If stack size exceeds 10, remove the oldest entry (the first one)
        if [ ${#DIRECTORY_STACK[@]} -gt 10 ]; then
            DIRECTORY_STACK=("${DIRECTORY_STACK[@]:1}")
        fi
    fi

	# cdls
	builtin cd "$@" && ls --color=auto;

	# Show git
    if $_CDshowgit; then
        if [ -d ".git" ]; then
            git status
	    fi
    fi

	## Prompt override
	#Potentially dangerous
    if $_CDpromptoverride; then
        PROMPT_FILE=$(ls *.refactory 2>/dev/null)
        if [ -n "$PROMPT_FILE" ]; then
            source "$PROMPT_FILE"
        fi
    fi
}

alias c="CD"
alias Cd="CD"
alias cD="CD"
#alias cd="CD" #Not recommended
