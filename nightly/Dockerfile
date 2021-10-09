FROM camilstaps/clean:base
MAINTAINER Camil Staps <info@camilstaps.nl>

COPY install_clean.sh /opt/install_clean.sh
COPY install_clean_nightly.sh /opt/install_clean_nightly.sh
COPY uninstall_clean.sh /opt/uninstall_clean.sh

ENV PATH /opt:$PATH

CMD ["clm"]
