FROM ubuntu:18.04

ADD https://raw.githubusercontent.com/fullincome/scripts/master/nginx-gost/install-nginx.sh /

RUN chmod +x install-nginx.sh

COPY linux-amd64_deb.tgz /

RUN apt-get update && apt-get install -y wget git gcc g++ make

RUN ["./install-nginx.sh", "--csp=./linux-amd64_deb.tgz"]

RUN useradd --no-create-home nginx

ADD https://raw.githubusercontent.com/fullincome/scripts/master/nginx-gost/install-certs.sh /

RUN chmod +x install-certs.sh

RUN ./install-certs.sh

EXPOSE 80 443

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]


