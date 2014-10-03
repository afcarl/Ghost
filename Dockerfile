FROM dockerimages/docker-nave:latest
ADD . /ghost2
RUN git clone https://github.com/TryGhost/Ghost.git
WORKDIR /Ghost
RUN nave use stable npm install -g grunt-cli \
 && nave use stable npm install \
 && nave use stable grunt init 
 && nave use stable grunt prod
CMD nave use stable npm start
