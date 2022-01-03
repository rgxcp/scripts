#!/bin/bash

ARG=$1

main () {
    if [[ $(git log -1 --pretty=format:"%an") == "Rommy Gustiawan" ]]
    then
        git commit-as-someone-else -s -m "${ARG}"
    else
        git commit -s -m "${ARG}"
    fi
}

main
