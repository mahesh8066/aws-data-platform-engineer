import boto3
import logging
import sys

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger()

# Set up S3 client
s3 = boto3.client('s3')
bucket_name = 'unique-example-bucket-20258066'

def upload_file(file_name):
    try:
        s3.upload_file(file_name, bucket_name, file_name)
        logger.info(f"Successfully uploaded {file_name} to {bucket_name}.")
    except Exception as e:
        logger.error(f"Error uploading {file_name}: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        logger.error("Please provide the file name to upload.")
    else:
        upload_file(sys.argv[1])
