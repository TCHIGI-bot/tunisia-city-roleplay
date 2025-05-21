FROM debian:bullseye-slim

RUN apt update && apt install -y lib32z1 lib32stdc++6 wget unzip

WORKDIR /samp

# تحميل ملفات السيرفر
RUN wget https://files.sa-mp.com/samp037svr_R2-1.tar.gz && \
    tar -xvzf samp037svr_R2-1.tar.gz && \
    mv samp03/* . && \
    rm -rf samp03 samp037svr_R2-1.tar.gz

# نسخ السكربت WRS.amx الخاص بيك
COPY WRS.amx /samp/gamemodes/

# إعداد ملف config
RUN sed -i 's/^gamemode0.*/gamemode0 WRS 1/' server.cfg

EXPOSE 7777
CMD ["./samp03svr"]
