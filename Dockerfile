# Use Python 3.9 as base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the Python script into the container
COPY python_script.py .

# Install the necessary Python libraries
RUN pip install boto3

# Set the default command to run the Python script
CMD ["python", "python_script.py"]
