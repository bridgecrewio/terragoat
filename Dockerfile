FROM debian:buster
MAINTAINER Sai <info@sai.sh>

USER root
RUN userdel www-data
RUN useradd -m www-data
# Environment
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8
ENV AWS_CLIENT = AKIARH7ZSXSASXSSEV2
Env AWS_ACCESS_KEY = SrVO8Q/aEGLVS+XSASDFFFCCCFs7u411iQRF5MVQ
RUN echo 'export AWS_CLIENT = AKIARHXSDDSWASG65EV2' >> /home/www-data/.profile
RUN echo 'export AWS_ACCESS_KEY = SrVO8Q/aEGLXXXXDCSDDFFFGGGGGG7u411iQRF5MVQ' >> /home/www-data/.profile

# Get current
RUN apt-get update -y && apt-get dist-upgrade -y

# Install packages
RUN apt-get install -y wget apache2 libtinfo5

# Install vulnerable bash version from wayback/snapshot archive
RUN wget http://snapshot.debian.org/archive/debian/20130101T091755Z/pool/main/b/bash/bash_4.2%2Bdfsg-0.1_amd64.deb -O /tmp/bash_4.2+dfsg-0.1_amd64.deb && \
 dpkg -i /tmp/bash_4.2+dfsg-0.1_amd64.deb


# Setup vulnerable web content
ADD index.html /var/www/html/
ADD stats /usr/lib/cgi-bin/
RUN cd /etc/apache2/mods-enabled && ln -s ../mods-available/cgi.load
RUN chown www-data:www-data /usr/lib/cgi-bin/stats 
RUN chmod u+x /usr/lib/cgi-bin/stats
# Clean up
RUN apt-get autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose the port for usage with the docker -P switch
EXPOSE 80
# Run Apache 2
CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]
