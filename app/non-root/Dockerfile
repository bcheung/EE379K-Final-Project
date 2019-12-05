FROM debian:stretch

COPY secrets.txt /root/secrets.txt

EXPOSE 80

RUN  groupadd -g 1000 appuser && \
  useradd -r -u 1000 -g appuser -ms /bin/bash appuser

RUN echo "root:password" | chpasswd
RUN echo "appuser:password" | chpasswd

USER appuser

CMD tail -f /dev/null