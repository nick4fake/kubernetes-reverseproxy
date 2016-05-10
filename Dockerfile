FROM ubuntu:latest
MAINTAINER bogdan@yurov.me

ENV DEBIAN_FRONTEND noninteractive

# Prepare requirements 
RUN apt-get update -qy && \
    apt-get install --no-install-recommends -qy software-properties-common

# Add Nginx
RUN add-apt-repository -y ppa:nginx/stable && \
    apt-get update -q
# Install Nginx
RUN apt-get install --no-install-recommends -qy nginx && \
    chown -R www-data:www-data /var/lib/nginx && \
    rm -f /etc/nginx/sites-available/default

# setup confd
#ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /usr/local/bin/confd
ADD ./confd /usr/local/bin/confd
RUN chmod u+x /usr/local/bin/confd && \
	mkdir -p /etc/confd/conf.d && \
	mkdir -p /etc/confd/templates

ADD ./src/confd /etc/confd
ADD ./src/boot.sh /opt/boot.sh
RUN chmod +x /opt/boot.sh

EXPOSE 80 443

# Run the boot script
CMD /opt/boot.sh
