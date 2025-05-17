FROM ubuntu:20.04

RUN apt-get update && apt-get install -y lib32gcc-s1 && rm -rf /var/lib/apt/lists/*

WORKDIR /samp

COPY . /samp

EXPOSE 7777/udp

CMD ["./samp03svr"]
