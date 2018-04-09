FROM ubuntu:xenial

# install required packages
RUN apt-get clean
RUN apt-get update \
    && apt-get install -y  git \
    net-tools \
    aptitude \
    build-essential \
    python-setuptools \
    python-dev \
    python-pip \
    software-properties-common \
    ansible \
    curl \
    iptables \
    iputils-ping \
    sudo
RUN curl https://get.docker.com | sh
RUN service docker start
RUN pip install pytest
RUN pip install docker

# install containernet (using its Ansible playbook)
RUN git clone https://github.com/containernet/containernet
RUN git clone https://github.com/prashplus/containernet-docker
RUN bash containernet/util/install.sh
RUN cd containernet
WORKDIR /containernet
RUN sudo make develop

# tell containernet that it runs in a container
ENV CONTAINERNET_NESTED 1

# Important: This entrypoint is required to start the OVS service
# ENTRYPOINT ["util/docker/entrypoint.sh"]
ENTRYPOINT ["sudo bash /containernet-docker/script/entrypoint.sh"]

CMD ["python", "examples/containernet_example.py"]