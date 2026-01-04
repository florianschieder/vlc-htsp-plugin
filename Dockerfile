FROM gcc:15-trixie

RUN apt-get update
RUN apt-get install -y \
    libvlc-dev \
    vlc-plugin-base \
    libvlccore-dev

ENTRYPOINT ["make", "libhtsp_plugin.so"]
