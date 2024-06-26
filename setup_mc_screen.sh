#!/bin/bash
SHORT_SLEEP=0.00001
WHICH_SERVER=$1
echo "Server: $WHICH_SERVER"

sleep $SHORT_SLEEP 
screen -S mc_server -X layout select tri_split
sleep $SHORT_SLEEP
#screen -S mc_server -X focus down
screen -S mc_server -p 3 -X stuff "cd $WHICH_SERVER^M./start.sh^M"
sleep $SHORT_SLEEP
screen -S mc_server -p 1 -X stuff "cd $WHICH_SERVER^M"
sleep $SHORT_SLEEP
screen -S mc_server -p 4 -X stuff 'top^M'
sleep 0.027 
screen -S mc_server -p 4 -X stuff '1^M'
sleep $SHORT_SLEEP
#screen -S mc_server -X select 4
#screen -S mc_server -p 4 -X focus down
#screen -S mc_server -p 4 -X focus left
#sleep 5
screen -S mc_server -d
