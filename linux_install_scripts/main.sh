#!/bin/bash

#Function to display the menu and handle user input
installer() {
    echo "Linux Tools Installer"
    echo "1. Lightweight Install"
    echo "2. Custom Install"
    echo "3. Exit"
    read -rp "Enter your choice: " choice

    case "$choice" in
    1)
        echo "choice 1"
        sudo apt-get update -y
        cat minimal.list | xargs sudo apt-get install -y
        ;;
    2)
        echo "choice 2"
        sudo apt-get update -y
        cat custom.list | xargs sudo apt-get install -y
        source ./tools/docker.sh
        source ./deb_files_handler.sh
        sudo apt-get update -y
        ;;
    3)
        exit 0
        ;;
    *)
        echo "Invalid choice. Please select 1, 2, or 3."
        installer
        ;;
    esac
}

installer