FROM ubuntu:jammy

MAINTAINER wuyang@drwu.ga

COPY bfsu.* /tmp/

ENV PATH="/opt/miniconda3/bin:$PATH"
ENV TZ="Asia/Hong_Kong"
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt update -yy && \
    apt upgrade -yy && \
    apt install -qyy wget vim curl zip unzip iputils-ping build-essential dnsutils binutils bzip2 git sed  libcurl4-openssl-dev && \
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
