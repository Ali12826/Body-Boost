# -*- coding: utf-8 -*-
"""Untitled22.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1qQrfwO6woObeLCx4fq0pUew-HrheIWGZ
"""

import os
from flask import Flask, request, jsonify
from transformers import AutoTokenizer, AutoModelForSequenceClassification
from scipy.special import softmax

app = Flask(__name__)

# Load tokenizer and model
tokenizer = AutoTokenizer.from_pretrained("cardiffnlp/twitter-roberta-base-sentiment")
model = AutoModelForSequenceClassification.from_pretrained("cardiffnlp/twitter-roberta-base-sentiment")

@app.route('/predict', methods=['POST'])
def predict_sentiment():
    data = request.get_json()
    user_tweet = data['tweet']

    # Tokenize input
    encoded_tweet = tokenizer(user_tweet, return_tensors='pt')

    # Predict sentiment
    output = model(**encoded_tweet)

    # Get probabilities
    scores = output.logits.detach().numpy()
    softmax_scores = softmax(scores, axis=1)[0]

    # Format results
    labels = ['Negative', 'Neutral', 'Positive']
    results = {label: score.item() for label, score in zip(labels, softmax_scores)}

    return jsonify(results)

if __name__ == '__main__':
    os.environ['FLASK_ENV'] = 'production'
    app.run(host='0.0.0.0', debug=False)