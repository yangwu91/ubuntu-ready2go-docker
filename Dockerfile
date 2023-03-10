FROM ubuntu:jammy

MAINTAINER wuyang@drwu.ga

COPY bfsu.* /tmp/

ENV PATH="/opt/miniconda3/bin:$PATH"
ENV TZ="Asia/Hong_Kong"
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt update -yy && \
    apt upgrade -yy && \
    apt install -qyy wget vim curl zip unzip iputils-ping build-essential dnsutils ack antlr3 aria2 asciidoc autoconf automake autopoint binutils bison build-essential bzip2 ccache cmake cpio device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libreadline-dev libssl-dev libtool lrzsz mkisofs msmtp nano ninja-build p7zip p7zip-full patch pkgconf python3 python3-pip libpython3-dev qemu-utils rsync scons squashfs-tools subversion swig texinfo uglifyjs upx-ucl xmlto xxd zlib1g-dev sed && \
    wget -qO /tmp/miniconda3.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash /tmp/miniconda3.sh -bfp /opt/miniconda3 && \
    timedatectl set-timezone "$TZ" && \
    cp /tmp/bfsu.condarc ${HOME}/.condarc && \
    conda update -y --all && \
    conda install -y requests beautifulsoup4 biopython matplotlib tqdm && \
    apt autoremove -yy && \
    apt autoclean -yy && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/cache/apt/* && \
    conda clean -ayq && \
    mv -f /tmp/bfsu.jammy.source.list /etc/apt/sources.list && \

ENTRYPOINT ["/bin/bash"]
