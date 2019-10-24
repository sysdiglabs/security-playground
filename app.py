#!/bin/env python

import subprocess
from flask import Flask, request

app = Flask(__name__)


@app.route('/<path:file_to_read>', methods=['GET'])
def read(file_to_read):
    with open('/' + file_to_read, 'r') as f:
        return f.read()


@app.route('/<path:file_to_write>', methods=['POST'])
def write(file_to_write):
    content = request.values['content']
    with open('/' + file_to_write, 'w') as f:
        f.write(content)

    return content


@app.route('/exec', methods=['POST'])
def exec():
    command = [request.values['command']]

    process = subprocess.run(command, shell=True, capture_output=True)

    return process.stdout


@app.route('/health', methods=['GET'])
def health():
    return 'OK'
