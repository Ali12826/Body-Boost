import re
from transformers import AutoTokenizer, AutoModelForSequenceClassification
from scipy.special import softmax


user_tweet = input("Enter a tweet: ")


def preprocess_tweet(tweet):

    processed_tweet = re.sub(r'[@#]\S+|http\S+|[^\w\s]', '', tweet)
    return processed_tweet

processed_tweet = preprocess_tweet(user_tweet)


if 5 <= len(processed_tweet) < 50 and '@user' not in processed_tweet and 'http' not in processed_tweet:

    roberta = "cardiffnlp/twitter-roberta-base-sentiment"
    model = AutoModelForSequenceClassification.from_pretrained(roberta)
    tokenizer = AutoTokenizer.from_pretrained(roberta)


    encoded_tweet = tokenizer(processed_tweet, return_tensors='pt')
    output = model(**encoded_tweet)


    labels = ['Negative', 'Neutral', 'Positive']
    scores = output.logits[0].detach().numpy()
    softmax_scores = softmax(scores)

    for i in range(len(labels)):
        sentiment = labels[i]
        percentage = softmax_scores[i] * 100
        print(f"{sentiment} Percentage: {percentage:.2f}%")
else:
    print("Invalid input. Please enter a tweet meeting the specified criteria.")