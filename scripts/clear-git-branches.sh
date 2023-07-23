#!/usr/bin/env bash

read -p ">>> Continue clear-git-branches? (y/n): " answer

to_remove_branches=()
if [ "$answer" == "y" ]; then
    HEADER="Select-to-EXCLUDE::[Single-Select:<Enter>||Multi-Select:<TAB>]"
    branches=$(git branch | sed 's/\*/ /g')
    exclude_branches="$(git branch | sed 's/\*/ /g' | fzf --header=${HEADER} --header-first --multi)"

    # Switch branch to first excluded branch
    for exclude_branch in $exclude_branches
    do
        git switch $exclude_branch --quiet
        echo -e "\n  * >>> Branch Switched to << $exclude_branch >> \n"
        break
    done

    # Append not excluded branches to (to_remove_branches)
    for branch in $branches
    do
        is_excluded=false
        for exclude_branch in $exclude_branches
        do
            if [[ $exclude_branch == $branch ]]; then
                is_excluded=true
                break
            fi
        done

        if [[ $is_excluded == false ]]; then
            to_remove_branches+="${branch} "
        fi
    done

    # Delete branches of to_remove_branches
    for to_remove_branch in $to_remove_branches
    do
        git branch -D $to_remove_branch
    done

else
    echo -e "\n>>> Cancelled clear-git-branches \n"
fi
