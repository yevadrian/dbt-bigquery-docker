#!/usr/bin/python3

from google.cloud import storage
from urllib.request import urlopen
import numpy as np

try:
    client = storage.Client()
    print('Connection to Google Cloud Storage Success')
except:
    print('Connection to Google Cloud Storage Failed')

client.create_bucket('yellow_tripdata')
bucket = client.get_bucket('yellow_tripdata')

for x in ["%.2d" % i for i in np.arange(1,13)]:
    file = urlopen(f'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2019-{x}.parquet')
    blob = bucket.blob(f'yellow_tripdata_2019-{x}.parquet')
    blob.upload_from_string(file.read())
    print(f'[{x}/12] File Loaded to Google Cloud Storage')