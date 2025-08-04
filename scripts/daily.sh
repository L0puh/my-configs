#!/bin/bash

NOTES_DIR="$HOME/storage/daily"

mkdir -p "$NOTES_DIR"
DATE=$(date +"%Y-%m-%d")
FILENAME="$NOTES_DIR/daily_$DATE.md"

if [ ! -f "$FILENAME" ]; then
    touch "$FILENAME"
fi

st -e vim --cmd "cd $NOTES_DIR" "${NOTES_DIR}/$FILENAME"  &> /dev/null &
