FROM ubuntu:20.04

RUN apt-get update && apt-get install -y lib32gcc-s1 wget && rm -rf /var/lib/apt/lists/*

WORKDIR /samp

RUN wget https://cdn.sa-mp.com/samp040/samp03svr_R3-1-0.tar.gz && \
    tar -xvzf samp03svr_R3-1-0.tar.gz && \
    rm samp03svr_R3-1-0.tar.gz

RUN chmod +x ./samp03svr

EXPOSE 7777/udp

CMD ["./samp03svr"]
