FROM debian:latest
RUN apt update -y
RUN apt upgrade -y
RUN apt install python3-pip -y
RUN apt install git -y
RUN pip install dbt-bigquery
RUN pip install numpy
RUN pip install google-cloud-storage
RUN pip install google-cloud-bigquery