FROM ubuntu:latest
WORKDIR /pong_game


RUN apt-get update && apt-get install -y openssh-server   
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Now add umpire
RUN useradd -ms /bin/bash umpire;
RUN echo 'umpire:qwerty2000' | chpasswd
RUN chown -R umpire:umpire /pong_game;

COPY make_points.sh /pong_game
COPY make_points.py /pong_game
COPY calculate_points.py /pong_game

COPY keys /home/umpire/.ssh/
RUN chown -R umpire:umpire /home/umpire/.ssh
#RUN ssh-add /home/umpire/.ssh/keys

# install python3
RUN apt-get update && apt-get install -y python3-full python3-pip
RUN pip3 install python-lorem --break-system-packages



ENTRYPOINT  service ssh start && /bin/bash /pong_game/make_points.sh