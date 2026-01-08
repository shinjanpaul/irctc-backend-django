from rest_framework.views import APIView
from rest_framework.response import Response
from logs.mongo import search_logs


class TopRoutesView(APIView):
    def get(self, request):
        pipeline = [
            {
                "$group": {
                    "_id": {
                        "source": "$source",
                        "destination": "$destination"
                    },
                    "count": {"$sum": 1}
                }
            },
            {"$sort": {"count": -1}},
            {"$limit": 5}
        ]

        data = list(search_logs.aggregate(pipeline))

        response = [
            {
                "source": item["_id"]["source"],
                "destination": item["_id"]["destination"],
                "count": item["count"]
            }
            for item in data
        ]

        return Response(response)
