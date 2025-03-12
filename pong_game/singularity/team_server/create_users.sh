#!/bin/bash

for i in {1..20}; do\
    # team 1
    useradd -ms /bin/bash  team_1_player_$i;\
    chown -R team_1_player_"$i":team_1_player_"$i" /pong_game;\
    echo team_1_player_"$i":team_1_player_"$i" | chpasswd;\
    # Now team 2
    useradd -ms /bin/bash  team_2_player_$i;\
    chown -R team_2_player_"$i":team_2_player_"$i" /pong_game;\
    echo team_2_player_"$i":team_2_player_"$i" | chpasswd;\
done

# Now add umpire
useradd -ms /bin/bash umpire;
echo umpire:qwerty2000 | chpasswd;
chown -R umpire:umpire /pong_game;