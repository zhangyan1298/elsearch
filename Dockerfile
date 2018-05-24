From ingensi/oracle-jdk 
COPY elasticsearch-5.6.9.tar.gz /usr/local
RUN yum -y install tar
RUN tar xzvf /usr/local/elasticsearch-5.6.9.tar.gz
RUN echo   "elsearch soft nofile 65536" >>/etc/security/limits.conf
RUN echo   "elsearch hard nofile 131072" >>/etc/security/limits.conf

RUN echo   "elsearch soft nproc 2048" >> /etc/security/limits.conf
 
RUN echo   "elsearch hard nproc 4096"  >>/etc/security/limits.conf
RUN groupadd elsearch
RUN useradd elsearch -g elsearch
RUN sed -i s/2g/256m/g elasticsearch-5.6.9/config/jvm.options
RUN mv elasticsearch-5.6.9 /usr/local/
RUN chown elsearch:elsearch /usr/local/elasticsearch-5.6.9
RUN usermod elsearch -G root
RUN mkdir -p /da/es/data
RUN mkdir -p /da/es/logs
RUN mkdir -p /usr/local/elasticsearch-5.6.9/config/scripts
RUN chown -R elsearch:elsearch  /da/es
COPY elasticsearch.yml  /usr/local/elasticsearch-5.6.9/config/
USER elsearch
WORKDIR /usr/local/elasticsearch-5.6.9/bin
CMD [ "sh", "-x", "elasticsearch" ]