FROM python:3.10-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    libsm6 \
    libxext6 \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download static ffmpeg build (includes ffprobe)
RUN wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz && \
    tar -xvf ffmpeg-release-amd64-static.tar.xz && \
    cp ffmpeg-*-amd64-static/ffmpeg ffmpeg-*-amd64-static/ffprobe /usr/local/bin/ && \
    rm -rf ffmpeg-*-amd64-static* ffmpeg-release-amd64-static.tar.xz

WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy bot code
COPY . .

EXPOSE 8080
CMD ["python", "main.py"]
