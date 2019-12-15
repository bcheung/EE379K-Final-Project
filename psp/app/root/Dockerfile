FROM debian:stretch

COPY secrets.txt /root/secrets.txt

EXPOSE 80

RUN echo "root:password" | chpasswd

CMD tail -f /dev/null