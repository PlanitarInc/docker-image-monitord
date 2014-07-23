FROM planitar/base

RUN apt-get install -y collectd-core && apt-get clean

ADD collectd.conf /etc/collectd/

CMD collectd -f
