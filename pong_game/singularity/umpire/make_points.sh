#!/bin/bash

# if user is root then switch to umpire
if [ "$EUID" -eq 0 ]; then
    su umpire
fi

touch /pong_game/team1/rules.txt
touch /pong_game/team2/rules.txt

echo "Welcome to the game" > /pong_game/team1/rules.txt -y
echo "Welcome to the game" > /pong_game/team2/rules.txt -y


scp /pong_game/team1/* team1:/pong_game/
scp /pong_game/team2/* team2:/pong_game/

# Start up the ssh agent
eval "$(ssh-agent -s)"
ssh-add /home/umpire/.ssh/keys

# Bash script that does things for 10 mins then exits
echo "Starting make_points.sh"

# Loop for 10 mins sending files to team1:/pong_game/ and team2:/pong_game/
mkdir -p /pong_game/team1
mkdir -p /pong_game/team2

for _ in {1..2000}; do
    # run python to make random points
    python3 /pong_game/make_points.py
    # team 1
    scp /pong_game/team1/* team1:/pong_game/
    rm /pong_game/team1/*
    # Now team 2
    scp /pong_game/team2/* team2:/pong_game/
    rm /pong_game/team2/*
    sleep 0.3
done

rm /pong_game/team1/*
rm /pong_game/team2/*

# copy all points files to the umpire's home directory
scp -r team1:/pong_game/* /pong_game/team1/
scp -r team2:/pong_game/* /pong_game/team2/

# Run the calculate_points.py script
python3 /pong_game/calculate_points.py

# Sleep for 10 mins
sleep 600


