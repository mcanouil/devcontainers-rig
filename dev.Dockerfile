FROM debian:bullseye

LABEL org.opencontainers.image.licenses="GPL-3.0" \
      org.opencontainers.image.source="https://github.com/mcanouil/docker-rig" \
      org.opencontainers.image.authors="Mickaël Canouil <https://mickael.canouil.fr/>"

ENV LANG=en_GB.UTF-8
ENV RIG_VERSION=0.4.1

COPY assets /docker_scripts

RUN chmod --recursive +x /docker_scripts
RUN /docker_scripts/install_lang.sh
RUN /docker_scripts/install_rig.sh

CMD ["R"]
