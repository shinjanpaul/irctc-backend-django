from pymongo import MongoClient
from django.conf import settings

client = MongoClient(settings.MONGO_URI)
db = client['irctc_logs']
search_logs = db['train_search_logs']
