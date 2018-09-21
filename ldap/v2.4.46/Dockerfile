FROM marcosoliveirasoares94/ubuntu:latest

MAINTAINER Marcos Oliveira Soares <marcos.soares@foton.la>

LABEL name="marcosoliveirasoares94/ldap" \
     maintainer="Marcos Oliveira Soares <marcos.soares@foton.la>" \
     summary="Default image for initializing an LDAP" \
     description="Default image for initializing an LDAP"

ENV DEBIAN_FRONTEND=noninteractive

#
# BASE image installation.
#
RUN apt update -y && \
	apt install -y \
    slapd \
    ldap-utils \
    gcc \
    make \
    libdb-dev

COPY resources/files_to_install/openldap-2.4.46.tgz /root/openldap-2.4.46.tgz
RUN cd /root && \
	tar -zxvf openldap-2.4.46.tgz &&  \
	cd openldap-2.4.46 && ./configure && \
	make depend

COPY resources/files_to_install/cracklib-2.9.6.tar.gz /root/cracklib-2.9.6.tar.gz
RUN cd /root && gunzip cracklib-2.9.6.tar.gz && tar -xvf cracklib-2.9.6.tar && \
	cd cracklib-2.9.6 && ./configure --prefix=/usr --disable-static  --with-default-dict=/lib/cracklib/pw_dict && \
	make && make install

COPY resources/files_to_install/cracklib-words-2.9.6.gz cracklib-words-2.9.6.gz
RUN install -v -m644 -D /root/cracklib-words-2.9.6.gz /usr/share/dict/cracklib-words.gz && \
	gunzip -v /usr/share/dict/cracklib-words.gz && \
	ln -v -sf cracklib-words /usr/share/dict/words && install -v -m755 -d /lib/cracklib &&\
    create-cracklib-dict /usr/share/dict/cracklib-words

COPY resources/files_to_install/check_password.conf /etc/ldap/check_password.conf
COPY resources/files_to_install/openldap-ppolicy-check-password-1.1.tar.gz /root/openldap-ppolicy-check-password-1.1.tar.gz
RUN cd /root && gunzip openldap-ppolicy-check-password-1.1.tar.gz && tar -xvf openldap-ppolicy-check-password-1.1.tar && \
	cd openldap-ppolicy-check-password-1.1 && \
	make install  CONFIG="/etc/ldap/check_password.conf" LDAP_INC="-I/root/openldap-2.4.46/include/ -I/root/openldap-2.4.46/servers/slapd" \
	CRACKLIB="/lib/cracklib/" CRACKLIB_LIB="/usr/lib/libcrack.so.2" LIBDIR="/usr/lib/ldap/"

#
# Removing outdated software.
#
RUN apt remove -y \
	gcc \
	libdb-dev \
	make && \
	rm -rf /root/*

ENV \
	SLAPD_PASSWORD=Passw0rd@123 \
	SLAPD_DOMAIN=ldap.example.com \
	SLAPD_ORGANIZATION=ldap.example.com \
	SLAPD_FULL_DOMAIN=dc=ldap,dc=example,dc=com \
	SLAPD_LDIF_BASE=/var/tmp/ldifs \
	SLAPD_LOAD_LDIFS=

COPY resources/*.sh /usr/local/bin/
COPY resources/supervisord.conf /etc/supervisord.conf

RUN chmod u+x /usr/local/bin/*.sh

EXPOSE 20 21 22 389 636

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]