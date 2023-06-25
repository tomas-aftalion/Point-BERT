ARG BASE_IMAGE=ubuntu:22.04
FROM ${BASE_IMAGE}

RUN apt update
RUN apt install -y python3 python3-pip
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN pip install torch==1.8
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y nvidia-cuda-toolkit git

COPY requirements.txt .
RUN pip install -r requirements.txt
RUN pip install "git+https://github.com/erikwijmans/Pointnet2_PyTorch.git#egg=pointnet2_ops&subdirectory=pointnet2_ops_lib"
RUN pip install --upgrade https://github.com/unlimblue/KNN_CUDA/releases/download/0.2/KNN_CUDA-0.2-py3-none-any.whl

COPY extensions /home/extensions
COPY install.sh /home
RUN chmod +x /home/install.sh 
WORKDIR /home
