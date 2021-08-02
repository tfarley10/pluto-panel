FROM python:3.8-slim-buster

WORKDIR /usr/src/app

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt
RUN apt-get update
RUN apt-get install wget -y
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

ENV PYTHONPATH=$PYTHONPATH:/usr/src/app
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

COPY . .

CMD ["python3"]