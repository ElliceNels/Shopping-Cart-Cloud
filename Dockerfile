# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY Pipfile Pipfile.lock /app/

# Install pipenv and project dependencies
RUN pip install pipenv && pipenv install --deploy --ignore-pipfile

# Copy the entire project into the container
COPY . /app

# Set the environment variables
ENV FLASK_APP=main.py
ENV FLASK_RUN_HOST=0.0.0.0

# Expose port 80 to the outside world
EXPOSE 80

# Run the application
CMD ["pipenv", "run", "flask", "run", "--host=0.0.0.0", "--port=80"]