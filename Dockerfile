FROM debian:bullseye

# تحديث الحزم وتثبيت المتطلبات
RUN apt-get update && apt-get install -y wget unzip lib32gcc-s1 && apt-get clean

# تحميل السيرفر من مصدر موثوق (أرشيف GitHub)
WORKDIR /samp
RUN wget https://github.com/Se8870/SAMP-File-Archive/releases/download/v1.0/samp03svr_R2-1.tar.gz

# فك الضغط وحذف الملف الأصلي
RUN tar -xvzf samp03svr_R2-1.tar.gz && rm samp03svr_R2-1.tar.gz

# نسخ ملفات السيرفر الخاصة بك (عدل هذا إذا عندك سكريبت)
COPY . /samp

# فتح المنفذ
EXPOSE 7777/udp

# أمر التشغيل
CMD ["./samp03/samp03svr"]
