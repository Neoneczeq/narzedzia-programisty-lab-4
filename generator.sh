
#!/bin/bash

LENGTH=16
COUNT=1
VERBOSE=false
OUTPUT=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --length)
            if [[ -z "$2" || ! "$2" =~ ^[0-9]+$ || "$2" -lt 1 ]]; then
                echo "Błąd: --length wymaga liczby większej od 0"
                exit 1
            fi
            LENGTH="$2"
            shift 2
            ;;
        --count)
            if [[ -z "$2" || ! "$2" =~ ^[0-9]+$ || "$2" -lt 1 ]]; then
                echo "Błąd: --count wymaga liczby większej od 0"
                exit 1
            fi
            COUNT="$2"
            shift 2
            ;;
        --verbose)
            VERBOSE=true
            shift
            ;;
        --output)
            if [[ -z "$2" || "$2" == -* ]]; then
                echo "Błąd: --output wymaga nazwy pliku"
                exit 1
            fi
            OUTPUT="$2"
            shift 2
            ;;
        --help)
            echo "Użycie: $0 [--length N] [--count N] [--verbose] [--output PLIK]"
            exit 0
            ;;
        *)
            echo "Nieznana flaga: $1"
            exit 1
            ;;
    esac
done

if [[ "$VERBOSE" == true ]]; then
    echo "Długość hasła: $LENGTH"
    echo "Liczba haseł: $COUNT"
    echo "Plik wyjściowy: ${OUTPUT:-brak}"
fi

if [[ -n "$OUTPUT" ]]; then
    : > "$OUTPUT" || exit 1
fi

for ((i=1; i<=COUNT; i++)); do
    PASSWORD=$(LC_ALL=C tr -dc 'a-zA-Z0-9' </dev/urandom | head -c "$LENGTH")

    if [[ -n "$OUTPUT" ]]; then
        echo "$PASSWORD" >> "$OUTPUT"
    else
        echo "$PASSWORD"
    fi

    if [[ "$VERBOSE" == true ]]; then
        echo "Wygenerowano hasło $i/$COUNT" >&2
    fi
done

if [[ "$VERBOSE" == true && -n "$OUTPUT" ]]; then
    echo "Hasła zapisano w pliku: $OUTPUT" >&2
fi

