FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

ADD linux-amd64_deb.tgz /

RUN apt-get update && apt-get install -y nginx lsb-core

RUN /linux-amd64_deb/install.sh

RUN /opt/cprocsp/sbin/amd64/cpconfig -hardware reader -add HDIMAGE store

ADD https://raw.githubusercontent.com/fullincome/scripts/master/nginx-gost/install-certs.sh /

RUN chmod +x install-certs.sh

RUN mkdir -p /tmp/db1/kis_1
RUN mkdir -p /tmp/db2/kis_1
RUN mkdir -p /var/opt/cprocsp/dsrf/db1/kis_1
RUN mkdir -p /var/opt/cprocsp/dsrf/db2/kis_1
RUN /opt/cprocsp/sbin/amd64/cpconfig -hardware rndm -add cpsd -name 'cpsd rng' -level 3
RUN /opt/cprocsp/sbin/amd64/cpconfig -hardware rndm -configure cpsd -add string /db1/kis_1 /var/opt/cprocsp/dsrf/db1/kis_1
RUN /opt/cprocsp/sbin/amd64/cpconfig -hardware rndm -configure cpsd -add string /db2/kis_1 /var/opt/cprocsp/dsrf/db2/kis_1
RUN ls /tmp/db1/kis_1
RUN ls /var/opt/cprocsp/dsrf/db1/kis_1
RUN cp -r /tmp/db1/kis_1 /var/opt/cprocsp/dsrf/db1/kis_1
RUN cp -r /tmp/db2/kis_1 /var/opt/cprocsp/dsrf/db2/kis_1

RUN ./install-certs.sh

EXPOSE 80 443

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
