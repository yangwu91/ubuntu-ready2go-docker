FROM ubuntu:jammy

MAINTAINER wuyang@drwu.ga

COPY mirrors/* /tmp/
COPY entrypoint.sh /entrypoint.sh

ENV PATH="/opt/miniconda3/bin:$PATH"
ENV TZ="Asia/Hong_Kong"
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt update -qyy && \
    apt upgrade -qyy && \
    apt install -qyy wget vim curl libcurl4-openssl-dev zip unzip iputils-ping libgl1-mesa-dev build-essential dnsutils bzip2 sed grep gawk tzdata && \
    wget -qO /tmp/miniconda3.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash /tmp/miniconda3.sh -bfp /opt/miniconda3 && \
    conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda update -y --all && \
    conda install -qy python=3.11 requests beautifulsoup4 tqdm && \
    apt autoremove -qyy && \
    apt autoclean -qyy && \
    rm -rf /tmp/miniconda3.sh /var/lib/apt/lists/* /var/cache/apt/* && \
    conda clean -ayq && \
    mv /tmp/bfsu.source.list /etc/apt/sources.list && \
    mv /tmp/bfsu.condarc /root/.condarc && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
