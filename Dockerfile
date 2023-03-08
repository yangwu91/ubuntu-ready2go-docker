FROM ubuntu:latest

MAINTAINER wuyang@drwu.ga

COPY bfsu.* /tmp/

ENV PATH="/opt/miniconda3/bin:$PATH"

RUN apt update -yy && \
    apt upgrade -yy && \
    apt install -qyy wget vim curl zip iputils-ping build-essential dnsutils && \
    wget -qO /tmp/miniconda3.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash /tmp/miniconda3.sh -bfp /opt/miniconda3 && \
    cp /tmp/bfsu.condarc ${HOME}/.condarc && \
    conda update -y --all && \
    conda install -y requests beautifulsoap4 biopython matplotlib tqdm && \
    apt autoremove -yy && \
    apt autoclean -yy && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/cache/apt/* && \
    conda clean -ayq

ENTRYPOINT ["/bin/bash"]
