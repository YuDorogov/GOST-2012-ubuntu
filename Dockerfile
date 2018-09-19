FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

ADD linux-amd64_deb.tgz /

RUN apt-get update && apt-get install -y nginx

RUN cd /linux-amd64_deb && dpkg -i ./cprocsp-compat-debian_1.0.0-1_all.deb \
./cprocsp-cpopenssl-64_4.0.9944-5_amd64.deb \
./cprocsp-cpopenssl-base_4.0.9944-5_all.deb \
./cprocsp-cpopenssl-devel_4.0.9944-5_all.deb \
./cprocsp-cpopenssl-gost-64_4.0.9944-5_amd64.deb \
./cprocsp-curl-64_4.0.9944-5_amd64.deb \
./lsb-cprocsp-base_4.0.9944-5_all.deb \
./lsb-cprocsp-capilite-64_4.0.9944-5_amd64.deb \
./lsb-cprocsp-kc1-64_4.0.9944-5_amd64.deb \
./lsb-cprocsp-kc2-64_4.0.9944-5_amd64.deb \
./lsb-cprocsp-rdr-64_4.0.9944-5_amd64.deb

ADD https://raw.githubusercontent.com/fullincome/scripts/master/nginx-gost/install-certs.sh /

RUN chmod +x install-certs.sh

RUN ./install-certs.sh

EXPOSE 80 443

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

