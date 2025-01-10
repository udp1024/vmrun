# Function to display the menu
# Check the operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Running on macOS"
    export VMWARETYPE="fusion"
else
    echo "Linux-Like operating system"
    export VMWARETYPE="ws"
fi

echo "Detected operating system is $OSTYPE."

display_menu() {
    echo "Please choose VMware Type:"
    echo "1. Workstation on Linux"
    echo "2. Fusion on mac OS"
    echo "3. Player"
}

# Function to handle the user's choice
handle_choice() {
    case $1 in
        1)
            echo "You chose Workstation"
            export VMWARETYPE="ws" 
            ;;
        2)
            echo "You chose Fusion"
            export VMWARETYPE="fusion"
            ;;
        3)
            echo "You chose Player"
            export VMWARETYPE="Player"
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
}

# Main script loop
while true; do
    display_menu
    read -p "Enter your choice [Default: $VMWARETYPE]: " choice
    choice=${choice:-$VMWARETYPE}
    handle_choice $choice
done

# Check if VMWARETYPE is set
if [ -z "$VMWARETYPE" ]; then
    echo "VMWARETYPE is not set."
    exit 1
fi

# Check if VMWARETYPE has one of the allowed values
case "$VMWARETYPE" in
    ws|fusion|Player)
        echo "VMWARETYPE is set to: $VMWARETYPE"
        ;;
    *)
        echo "VMWARETYPE is set to an invalid value: $VMWARETYPE"
        exit 1
        ;;
esac


