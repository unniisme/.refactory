#!/bin/bash

export _CDshowgit=true
export _CDpromptoverride=true

# cd overrides
function CD() { 
	# cdls
	cd "$@" && ls --color=auto;

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