import requests

payload = { 'api_key': 'e02f82dccc8fb3a588369852d07ee2cc', 'url': 'https://twitter.com/' } 
r = requests.get('https://api.scraperapi.com/', params=payload)
print(r.text)
