FROM debian:bullseye-slim

WORKDIR /samp

RUN apt update && apt install -y lib32z1 lib32ncurses6 lib32stdc++6 tar

COPY samp03svr_R3-1-0.tar.gz .

RUN tar -xvzf samp03svr_R3-1-0.tar.gz && rm samp03svr_R3-1-0.tar.gz

COPY . .

EXPOSE 7777
CMD ["./samp03/samp03svr"]
