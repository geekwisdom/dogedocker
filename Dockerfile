FROM debian:stable-slim

LABEL org.opencontainers.image.authors="Brad Detchevery <braddet@gmail.com>"

WORKDIR /home/dogecoin

RUN useradd -ms /bin/bash dogecoin \
  && apt-get update -y \
  && apt-get install -y curl gnupg gosu grep sed wget nano procps \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

COPY ./getlatest.sh .

RUN mkdir /home/dogecoin/data
RUN chown -R dogecoin /home/dogecoin/data
RUN chgrp -R dogecoin /home/dogecoin/data

COPY ./data .

COPY ./data/* ./data/

RUN chown -R dogecoin /home/dogecoin

RUN chgrp -R dogecoin /home/dogecoin

RUN rm /home/dogecoin/dogecoin.conf

RUN ln /home/dogecoin/data/dogecoin.conf /home/dogecoin/dogecoin.conf

EXPOSE 22556

EXPOSE 18332

ENTRYPOINT ["./getlatest.sh"]
