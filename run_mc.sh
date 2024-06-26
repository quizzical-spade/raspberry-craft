#!/bin/bash
if screen -ls | grep -q mc_server; then
    if [ "$1" = "q" ]; then
        screen -S mc_server -p 3 -X stuff "stop^M"
        for ((i = 0; i < 10; i++)); do
            echo -n "."  # Print the dot without a newline
            sleep 1      # Wait for 1 second
        done
        if pgrep java; then
            echo "ERRROR: Java process still found after 10 seconds."
            exit 1
        else
            echo "Server stopped."
            screen -S mc_server -X quit
            screen -ls
            exit 0
        fi
    fi
echo "Server already running. Use screen -r to reconnect."
else
	ssh -fN -R 0.0.0.0:25565:localhost:25565 vis@45.26.195.236 -p 22022
       
    case $1 in
        1)
            echo "starting working_Hannah_tuned"
            sleep 1
            pass="~/mc/working_Hannah_tuned"
            ;;
        2) 
            echo "starting stresstest"
            sleep 1
            pass="~/mc/stresstest"
            ;;
        *)
            echo "starting nothing, no CLA"
            pass=""
            ;;
    esac
    
    if [ -z "$pass" ]; then
        echo "Passing nothing"
    else
        echo "Passing: $pass to setup"
        ~/setup_mc_screen.sh $pass &
        screen -S mc_server
    fi
fi
#-----other script detaches from mc_server------



