#!/bin/bash

MEMO_FILE="$HOME/.mymemo.txt"

touch "$MEMO_FILE"

function show_menu() {
    echo "===================="
    echo "Simple Notepad"
    echo "1) Add Memo"
    echo "2) List Memos"
    echo "3) Search Memo"
    echo "4) Delete Memo"
    echo "5) Exit"
    echo "===================="
    echo -n "Choose >> "
}

function add_memo() {
    echo -n "Enter memo: "
    read memo
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $memo" >> "$MEMO_FILE"
    echo "Memo saved."
}

function list_memos() {
    if [[ ! -s "$MEMO_FILE" ]]; then
        echo "No memos saved."
        return
    fi
    nl -w2 -s") " "$MEMO_FILE"
}

function search_memo() {
    echo -n "Enter keyword to search: "
    read keyword
    grep --color=always "$keyword" "$MEMO_FILE" || echo "No memos found with that keyword."
}

function delete_memo() {
    list_memos
    echo -n "Enter memo number to delete: "
    read num
    sed -i "${num}d" "$MEMO_FILE"
    echo "Memo deleted."
}

while true; do
    show_menu
    read choice
    case $choice in
        1) add_memo ;;
        2) list_memos ;;
        3) search_memo ;;
        4) delete_memo ;;
        5) echo "Exiting."; exit 0 ;;
        *) echo "Invalid input." ;;
    esac
    echo ""
done
