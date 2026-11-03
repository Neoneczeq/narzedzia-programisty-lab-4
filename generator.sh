my_function() {
    RANDOM_STRING=$(tr -dc 'a-zA-Z0-9' </dev/urandom | head -c 16)
    echo "$RANDOM_STRING"
}

my_function
