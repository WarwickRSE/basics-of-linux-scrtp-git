FROM ubuntu:latest
WORKDIR /pong_game


RUN apt-get update && apt-get install -y openssh-server   
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config


COPY create_users.sh /pong_game
# loop to add 20 players in team 1&2 and umpire
RUN bash create_users.sh
RUN rm /pong_game/create_users.sh

# add umpires public key to authorized_keys
RUN mkdir /home/umpire/.ssh && touch /home/umpire/.ssh/authorized_keys
COPY keys.pub /home/umpire/.ssh/
RUN cat /home/umpire/.ssh/keys.pub >> /home/umpire/.ssh/authorized_keys
RUN rm /home/umpire/.ssh/keys.pub
RUN chmod 700 /home/umpire/.ssh && chmod 600 /home/umpire/.ssh/authorized_keys
RUN chown -R umpire:umpire /home/umpire/.ssh



ENTRYPOINT service ssh start && /bin/bash