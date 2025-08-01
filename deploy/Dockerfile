# Dockerfile for Robot Framework Test Automation
FROM python:3.10-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV DISPLAY=:99
ENV ROBOT_REPORTS_DIR=/app/results
ENV ROBOT_TESTS_DIR=/app/test

# Install system dependencies
RUN apt-get update && apt-get install -y \
    # Chrome dependencies
    wget \
    gnupg \
    unzip \
    curl \
    xvfb \
    # Additional dependencies for Chrome
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libxss1 \
    libxtst6 \
    lsb-release \
    xdg-utils \
    # Clean up
    && rm -rf /var/lib/apt/lists/*

# Install Google Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Install ChromeDriver using the new Chrome for Testing API
RUN CHROME_VERSION=$(google-chrome --version | cut -d " " -f3) \
    && echo "Chrome version: $CHROME_VERSION" \
    && CHROMEDRIVER_URL="https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json" \
    && CHROMEDRIVER_VERSION=$(curl -s $CHROMEDRIVER_URL | grep -o '"version":"[^"]*' | head -1 | cut -d'"' -f4) \
    && echo "ChromeDriver version: $CHROMEDRIVER_VERSION" \
    && wget -O /tmp/chromedriver.zip "https://storage.googleapis.com/chrome-for-testing-public/${CHROMEDRIVER_VERSION}/linux64/chromedriver-linux64.zip" \
    && unzip /tmp/chromedriver.zip -d /tmp/ \
    && mv /tmp/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver \
    && chmod +x /usr/local/bin/chromedriver \
    && rm -rf /tmp/chromedriver.zip /tmp/chromedriver-linux64

# Set working directory
WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir robotframework

# Copy application code
COPY . .

# Create results directory
RUN mkdir -p /app/results

# Create a script to start Xvfb and run tests
RUN echo '#!/bin/bash\n\
# Start Xvfb in background\n\
Xvfb :99 -screen 0 1920x1080x24 &\n\
export DISPLAY=:99\n\
\n\
# Wait a moment for Xvfb to start\n\
sleep 2\n\
\n\
# Execute the command passed to the container\n\
exec "$@"' > /app/start.sh \
    && chmod +x /app/start.sh

# Expose port (if needed for any web interface)
EXPOSE 8080

# Set the entrypoint
ENTRYPOINT ["/app/start.sh"]

# Default command to run tests
CMD ["python", "run_tests.py"]
