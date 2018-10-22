# Pull base image from authorized source
FROM centos:7

ARG OPENLDAP_VERSION=2.4.44

LABEL description="OpenLDAP Proxy" \
      maintainer="Brian Rimek <brian.rimek@tu-dresden.de>" \
      version="${OPENLDAP_VERSION}"

# Install the necessary packages for LDAP Proxy server
RUN yum install -y \
        openldap-${OPENLDAP_VERSION}* \
        openldap-clients-${OPENLDAP_VERSION}* \
        openldap-servers-${OPENLDAP_VERSION}*

# Make necessary directories
RUN mkdir -p /root/openldap_proxy && \
    mkdir -p /root/openldap_proxy/tmp && \
    mkdir -p /root/openldap_proxy/data && \
    mkdir -p /root/openldap_proxy/certs

# Remove unneeded directories
RUN rm -rf /etc/openldap/slapd.d && \
    rm /etc/openldap/sldap.conf

# Copy files to container
COPY ./docker-entrypoint.sh /root/openldap_proxy/docker-entrypoint.sh

# Add execution permission
RUN chmod 755 /root
RUN chmod +x /root/openldap_proxy/docker-entrypoint.sh

# Entry point
ENTRYPOINT ["/root/openldap_proxy/docker-entrypoint.sh"]