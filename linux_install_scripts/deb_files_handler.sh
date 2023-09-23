#!/bin/bash

destination_folder="./deb_packages"

download_and_install_deb_packages(){
    # Check if the specified directory exists
    if [ ! -d "$destination_folder" ]; then
        echo "Directory '$destination_folder' does not exist."
        mkdir -p $destination_folder
        echo "Directory '$destination_folder' has been created"
    fi
    
    echo "Downloading relevant .deb packages"
    cat deb_packages.list | xargs wget -P $destination_folder 

    # Get a list of .deb files in the specified directory
    deb_files=("$deb_directory"/*.deb)

    # Check if there are any .deb files to install
    if [ ${#deb_files[@]} -eq 0 ]; then
        echo "No .deb files found in '$deb_directory'."
        exit 1
    fi

    # Install each .deb file, continuing if installation fails
    for deb_file in "${deb_files[@]}"; do
        echo "Installing $deb_file..."
        if sudo apt install -y "$deb_file"; then
            echo "Installed $deb_file."
        else
            echo "Failed to install $deb_file."
        fi
    done
}

download_and_install_deb_packages