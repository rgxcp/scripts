#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
WHITE="\e[0m"

ARG=$1

main () {
    if [[ $ARG == "--skip-unit-test" ]]
    then
        echo -e "${RED}[i] Skipping unit test.${WHITE}"
    else
        echo -e "${GREEN}[i] Running unit test.${WHITE}"
        echo -e "${GREEN}[i] Checking MariaDB service status.${WHITE}"
        if ! systemctl is-active --quiet mariadb
        then
            echo -e "${RED}[i] MariaDB service is inactive. Starting MariaDB service now.${WHITE}"
            sudo systemctl start mariadb
        fi
        echo -e "${GREEN}[i] MariaDB service is active.${WHITE}"
        bundle exec rspec -fd
        read -p "Press enter if the unit test passed without failure(s)."
    fi

    echo -e "\n${GREEN}[i] Building Docker image.${WHITE}"
    echo -e "${GREEN}[i] Checking Docker service status.${WHITE}"
    if ! systemctl is-active --quiet docker
    then
        echo -e "${RED}[i] Docker service is inactive. Starting Docker service now.${WHITE}"
        sudo systemctl start docker
    fi
    echo -e "${GREEN}[i] Docker service is active.${WHITE}"
    sudo docker build -t user/image:latest .

    echo -e "\n${GREEN}[i] Pushing Docker image to Docker Hub.${WHITE}"
    sudo docker push user/image:latest
}

main
