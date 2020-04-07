import requests
import googlemaps
from datetime import datetime
import polyline
import json
import pandas as pd

from config import MAP_QUEST_KEY
from config import GMAPS_KEY


def LiveStats(routes):
    l = []
    a = polyline.decode(routes[0]['overview_polyline']['points'])

    for j in range(len(a)):
        l.append(a[j][0])
        l.append(a[j][1])

    r = requests.get("http://open.mapquestapi.com/elevation/v1/profile?key=" + MAP_QUEST_KEY + "&shapeFormat=raw&latLngCollection=" + str(l)[1:-1])
    elevation = pd.DataFrame((json.loads(r.content))['elevationProfile'])
    
    roc = [0]
    for i in range(len(elevation)-1):
        roc.append((elevation["height"][i+1] - elevation["height"][i]) / (elevation["distance"][i+1] - elevation["distance"][i]))
    elevation["roc"] = roc
    asc = 0
    desc = 0
    ascList = []
    descList = []
    distList = []
    for i in range(len(elevation)):
        if (elevation["roc"][i]<0):
            desc += (elevation["distance"][i] - elevation["distance"][i-1])
            ascList.append(asc)
            descList.append(desc)
            distList.append(elevation["distance"][i])
        elif (elevation["roc"][i]>0):
            asc += (elevation["distance"][i] - elevation["distance"][i-1])
            ascList.append(asc)
            descList.append(desc)
            distList.append(elevation["distance"][i])

    df = pd.DataFrame()
    df["Distance"] = distList
    df["Ascent"] = ascList
    df["Descent"] = descList
    df["Flat"] = df["Distance"] - df["Ascent"] - df["Descent"]
    df['index'] = df.index

    return df
