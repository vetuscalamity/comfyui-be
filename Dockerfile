FROM python:3.10-slim

RUN apt update && apt install -y git wget curl libgl1 libglib2.0-0 ffmpeg libsm6 libxext6 && \
    apt clean

WORKDIR /app

# ComfyUI CPU versiyonu
RUN git clone https://github.com/ltdrdata/ComfyUI-CPU.git .

# Flux modelini indir
RUN mkdir -p /app/models/checkpoints && \
    curl -L -o /app/models/checkpoints/flux.safetensors https://huggingface.co/SimianLuo/Flux-V3/resolve/main/flux-v3.safetensors

# Python bağımlılıkları
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# CPU moduna zorla
ENV PYTORCH_ENABLE_MPS_FALLBACK=1
ENV CUDA_VISIBLE_DEVICES=""

# start.sh dosyasını kopyala
COPY start.sh start.sh
RUN chmod +x start.sh

EXPOSE 8188

CMD ["bash", "start.sh"]
