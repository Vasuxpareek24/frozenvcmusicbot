FROM python:3.10-slim

# Install ffmpeg + dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg ffmpeg-doc libsm6 libxext6 git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080
CMD ["python", "main.py"]
