import RPi.GPIO as GPIO
from flask import Flask, render_template

app = Flask(__name__)
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
led = 25
ledSts = GPIO.LOW

GPIO.setup(led, GPIO.IN)

@app.route('/')
def index():
    ledSts = GPIO.input(led)
    template_data = {
        'title' : 'GPIO input status',
        'led' : ledSts
        }
    return render_template('index.html', **templateData)

if __name__ == "__main__":
    app.run(host = '0.0.0.0', port = 80, debug = True)
