FROM python:3.10-slim

# Sistem bağımlılıkları
RUN apt update && apt install -y git wget curl libgl1 libglib2.0-0 ffmpeg libsm6 libxext6 && apt clean

WORKDIR /app

# 1. Orijinal ComfyUI klonla
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .

# 2. Flux modelini indir
RUN mkdir -p /app/models/checkpoints && \
    curl -L -o /app/models/checkpoints/flux.safetensors https://huggingface.co/SimianLuo/Flux-V3/resolve/main/flux-v3.safetensors

# 3. Bağımlılıkları yükle
RUN pip install --upgrade pip && pip install -r requirements.txt

# 4. CUDA'yı Bypass eden patch dosyasını kopyala
COPY cpu_patch.py cpu_patch.py
RUN python3 cpu_patch.py

# 5. start.sh dosyasını kopyala
COPY start.sh start.sh
RUN chmod +x start.sh

EXPOSE 8188

CMD ["bash", "start.sh"]
