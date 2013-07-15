from os import environ as env
from random import choice

from flask import Flask, jsonify
from tornado.wsgi import WSGIContainer
from tornado.httpserver import HTTPServer
from tornado.ioloop import IOLoop
import requests

app = Flask(__name__)

@app.route("/")
def hello():
    random_service_status = choice(requests.get('https://zapier.com/status/json/').json()['objects'])
    return jsonify(service=random_service_status)

if __name__ == "__main__":
    http_server = HTTPServer(WSGIContainer(app))
    http_server.listen(env.get('app.port', 5000))
    IOLoop.instance().start()
