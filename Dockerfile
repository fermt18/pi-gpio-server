FROM python:3.6.8

COPY piGPIO.py /app/

ENTRYPOINT ["python3", "/app/piGPIO.py"]
