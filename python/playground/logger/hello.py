from flask import Flask
from logging.config import dictConfig

dictConfig({
    'version': 1,
    'formatters': {'default': {
        'format': '[%(asctime)s] %(levelname)s in %(module)s: %(message)s',
    }},
    'handlers': {'wsgi': {
        'class': 'logging.StreamHandler',
        'stream': 'ext://flask.logging.wsgi_errors_stream',
        'formatter': 'default'
    }},
    'root': {
        'level': 'INFO',
        'handlers': ['wsgi']
    }
})

app = Flask(__name__)
app.logger.info("app init")

@app.route("/")
def hello_world():
    app.logger.info("hello_world route")
    return (
        "<html><head><title>Test</title></head><body><p>Hello, World!</p></body></html>"
    )
