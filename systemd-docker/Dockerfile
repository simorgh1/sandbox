ARG BASE="centos:8"

FROM $BASE
LABEL Author="Bahram Maravandi"

# Installing httpd service with a default page
RUN yum install -y httpd && \
    echo "<html><body>Hello World</body></html>" > /var/www/html/index.html && \
    systemctl enable httpd

# configured httpd listen port: /etc/httpd/conf/httpd.conf
EXPOSE 80

# Adding health check
HEALTHCHECK --interval=35s --timeout=4s CMD curl -f http://localhost/ || exit 1

CMD ["/sbin/init"]
