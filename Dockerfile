FROM ubuntu:20.04

RUN apt-get update && apt-get install -y wget unzip lib32gcc1 && apt-get clean

RUN wget https://files.sa-mp.com/samp03svr_R2-1.tar.gz

RUN tar -xvzf samp03svr_R2-1.tar.gz && rm samp03svr_R2-1.tar.gz

COPY gamemodes ./samp03svr/gamemodes
COPY filterscripts ./samp03svr/filterscripts
COPY server.cfg ./samp03svr/server.cfg

WORKDIR /samp03svr

RUN chmod +x samp03svr

EXPOSE 7777/udp

CMD ["./samp03svr"]
