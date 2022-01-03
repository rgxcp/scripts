#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
WHITE="\e[0m"

main () {
    echo -e "${GREEN}[i] Checking Docker service status.${WHITE}"
    if ! systemctl is-active --quiet docker
    then
        echo -e "${RED}[i] Docker service is inactive. Starting Docker service now.${WHITE}"
        sudo systemctl start docker
    fi
    echo -e "${GREEN}[i] Docker service is active.${WHITE}"

    echo -e "\n${GREEN}[i] Checking GitLab Runner service status.${WHITE}"
    if ! systemctl is-active --quiet gitlab-runner
    then
        echo -e "${RED}[i] GitLab Runner service is inactive. Starting GitLab Runner service now.${WHITE}"
        sudo systemctl start gitlab-runner
    fi
    if ! sudo gitlab-runner status
    then
        sudo gitlab-runner start
    fi
    echo -e "${GREEN}[i] GitLab Runner service is active.${WHITE}"

    echo -e "\n${GREEN}[i] Pulling the changes from remote repository.${WHITE}"
    git pull origin main

    echo -e "\n${GREEN}[i] Pushing the changes.${WHITE}"
    git push -u origin main

    echo -e "${GREEN}[i] It's pushed, Darling!${WHITE}"
    echo -e "${GREEN}[i] Now let's pray that the Pipeline will work.${WHITE}"
}

main
