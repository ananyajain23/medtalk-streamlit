# A Dockerfile is a text file that contains a set of instructions for Docker to build a Docker image.

# base image
FROM python:3.11

# Install system tools/dependencies
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    libtesseract-dev \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

RUN tesseract --version

# Set working directory
WORKDIR /app

# Copy project files (Copies your code into the image)
COPY . /app

# Remove known incompatible packages before install as they are windows specific only (removed to avoid install errors on Linux.)
RUN sed -i '/pywin32/d' requirements.txt && \
    sed -i '/pyreadline3/d' requirements.txt

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose Streamlit port
EXPOSE 8501

# Start app (below is command to run app)
CMD ["streamlit", "run", "MedTalk_Chatbot_withAgenticAI_Streamlit_v5.py", "--server.port=8501", "--server.address=0.0.0.0"]

