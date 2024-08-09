FROM ghcr.io/fekad/north-desktop-base:main

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

RUN apt update \
 && apt-get install -y \
        unzip \
 && rm -rf /var/lib/apt/lists/*


# Switch back to jovyan to avoid accidental container runs as root
USER ${NB_UID}
WORKDIR "${HOME}"

RUN wget https://downloads.imagej.net/fiji/archive/20240614-2117/fiji-linux64.zip \
 && unzip fiji-linux64.zip \
 && rm -f fiji-linux64.zip

COPY --chown=${NB_UID}:${NB_GID} config/rc.xml ${HOME}/.config/openbox/rc.xml
COPY --chown=${NB_UID}:${NB_GID} config/menu.xml ${HOME}/.config/openbox/menu.xml
COPY --chown=${NB_UID}:${NB_GID} config/autostart ${HOME}/.config/openbox/autostart

