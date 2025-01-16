#!/bin/bash

add_user() {
    local username="$1"
    local add_to_sudo="$2"
    if id "$username" &>/dev/null; then
        echo "User '$username' already exists."
    else
        sudo useradd -m "$username"
        echo "User '$username' has been added."
        echo "Setting password for '$username':"
        sudo passwd "$username"
        mkdir -p /home/"$username"/{Documents,Downloads,Music,Pictures,Videos}
        sudo chown -R "$username":"$username" /home/"$username"
        if [ "$add_to_sudo" == "yes" ]; then
            sudo usermod -aG sudo "$username"
            echo "User '$username' added to sudo group."
        fi
    fi
}

remove_user() {
    local username="$1"
    if id "$username" &>/dev/null; then
        sudo deluser --remove-home "$username"
        echo "User '$username' has been removed."
    else
        echo "User '$username' does not exist."
    fi
}

echo "Do you want to add or remove a user? (add/remove)"
read -r action
if [ "$action" == "add" ]; then
    echo "Enter the username to add:"
    read -r username
    echo "Should the user have sudo privileges? (yes/no)"
    read -r sudo_option
    add_user "$username" "$sudo_option"
elif [ "$action" == "remove" ]; then
    echo "Enter the username to remove:"
    read -r username
    remove_user "$username"
else
    echo "Invalid action. Please choose 'add' or 'remove'."
fi
