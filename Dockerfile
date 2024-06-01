# Use the official Python image from the Docker Hub
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Install build dependencies
RUN apt-get update && \
    apt-get install -y gcc libsqlite3-dev && \
    rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY Pipfile Pipfile.lock /app/

# Set the Python version for pipenv
ENV PIPENV_PYTHON /usr/local/bin/python3.8

# Install pipenv and project dependencies
RUN pip install --upgrade pip && \
    pip install pipenv && \
    pipenv install --deploy

# Copy the entire project into the container
COPY . /app

# Set the environment variables
ENV FLASK_APP=main.py
ENV FLASK_RUN_HOST=0.0.0.0

# Expose port 80 to the outside world
EXPOSE 80

# Add a health check (optional but recommended)
HEALTHCHECK CMD ["curl", "--fail", "http://localhost:80"] || exit 1

# Run the application
CMD ["pipenv", "run", "flask", "run", "--host=0.0.0.0", "--port=80"]
