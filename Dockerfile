FROM python:3.6.8

COPY . /app/

WORKDIR /app

RUN pip3 install -r requirements.txt

ENTRYPOINT ["python3", "piGPIO.py"]
