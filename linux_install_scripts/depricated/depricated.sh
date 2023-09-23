# Function to read program list from a file
read_program_list() {
    local list_file="$1"
    local programs=()

    # Check if the program list file exists
    if [ ! -e "$list_file" ]; then
        echo "Program list file '$list_file' not found."
        return 1
    fi

    # Read the list of programs from the .list file and store them in an array
    while IFS= read -r program; do
        program=$(echo "$program" | tr -d '\r')  # Remove carriage return characters
        if [ -n "$program" ]; then
            programs+=("$program")
        fi
    done < "$list_file"

    # Output the program list
    echo "${programs[@]}"
}