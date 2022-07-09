# [Choice] Debian version (use bullseye on local arm64/Apple Silicon): bullseye, buster
ARG VARIANT="bullseye"
FROM buildpack-deps:${VARIANT}-curl

ARG INSTALL_ZSH="true"
ARG UPGRADE_PACKAGES="true"
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY library-scripts/common-debian.sh /tmp/library-scripts/
RUN bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/

ARG INSTALL_GITLFS="true"
COPY library-scripts/install_gitlfs.sh /tmp/library-scripts/
RUN bash /tmp/library-scripts/install_gitlfs.sh "${INSTALL_GITLFS}"

ARG USER_LANG=en_GB.UTF-8
COPY library-scripts/set_locale.sh /tmp/library-scripts/
RUN bash /tmp/library-scripts/set_locale.sh "${USER_LANG}"

ENV QUARTO_VERSION=latest
COPY library-scripts/install_quarto.sh /tmp/library-scripts/
RUN bash /tmp/library-scripts/install_quarto.sh "${QUARTO_VERSION}"

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends \
#         <your-package-list-here> \
#     && apt-get clean -y && rm -rf /var/lib/apt/lists/*

ENV RIG_VERSION=latest
COPY library-scripts/install_rig.sh /tmp/library-scripts/
RUN bash /tmp/library-scripts/install_rig.sh "${RIG_VERSION}"
USER "${USERNAME}"
ARG R_VERSION="release"
RUN rig add ${R_VERSION} && Rscript -e "pak::pkg_install('renv')"
