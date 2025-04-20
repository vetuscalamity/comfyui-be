FROM python:3.10-slim

# Gerekli sistem kütüphaneleri
RUN apt update && apt install -y git wget curl libgl1 libglib2.0-0 ffmpeg libsm6 libxext6 && \
    apt clean

# Çalışma dizini
WORKDIR /app

# ComfyUI klonla
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .

# Flux modelini indir
RUN mkdir -p /app/models/checkpoints && \
    curl -L -o /app/models/checkpoints/flux.safetensors https://huggingface.co/SimianLuo/Flux-V3/resolve/main/flux-v3.safetensors

# Python bağımlılıklarını yükle
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# 📌 start.sh’ı çalıştırılabilir yap
RUN chmod +x start.sh

# Portu aç
EXPOSE 8188

# Başlat
CMD ["bash", "start.sh"]
