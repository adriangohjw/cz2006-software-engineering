import requests
import googlemaps
from datetime import datetime
import polyline
import json
import pandas as pd
import numpy as np
import geopandas
import re
import random

from config import MAP_QUEST_KEY
from config import GMAPS_KEY


def RouteStatsCalc(routes):
    res=[]

    for i in range(len(routes)):        
        l=[]
        a=polyline.decode(routes[i]['overview_polyline']['points'])
        
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
        for i in range(len(elevation)):
            if (elevation["roc"][i] < 0):
                desc += (elevation["distance"][i] - elevation["distance"][i-1])
            elif (elevation["roc"][i] > 0):
                asc += (elevation["distance"][i] - elevation["distance"][i-1])
        flat = elevation['distance'][len(elevation)-1] - asc -desc
        total_dist = elevation['distance'][len(elevation)-1]
        res.append([asc,desc,flat, total_dist])

    return res

def liveStats(routes):
    l=[]
    a=polyline.decode(routes['overview_polyline']['points'])
    for j in range(len(a)):
        l.append(a[j][0])
        l.append(a[j][1])
    r = requests.get("http://open.mapquestapi.com/elevation/v1/profile?key="+MAP_QUEST_KEY+"&shapeFormat=raw&latLngCollection="+str(l)[1:-1])
    elevation = pd.DataFrame((json.loads(r.content))['elevationProfile'])
    roc = [0]
    for i in range(len(elevation)-1):
        roc.append((elevation["height"][i+1] - elevation["height"][i])/(elevation["distance"][i+1] - elevation["distance"][i]))
    elevation["roc"]=roc
    asc=0
    desc=0
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
    return df.values.tolist()

def PopularRoutes(weight):
    df2 = geopandas.read_file("cycling-path-network/cycling-path-network-geojson.geojson")
    for i in range(len(df2)):     
        df2["Description"][i] = df2["Description"][i][re.search("\s<td>", df2["Description"][i]).span()[1]:re.search("</td>", df2["Description"][i]).span()[0]]
        a = list(df2["Description"].value_counts().keys())
        res = []
    rem=[]
    for i in range(len(a)):
        if (len(df2[df2["Description"] == a[i]]) < 22):
            rem.append(a[i])
    a=[x for x in a if x not in rem]
    np.random.shuffle(a)
    
    for i in range(7):
        b = []
        for j in df2[df2["Description"] == a[i]].geometry:
            try:
                for i in (j.coords):
                    b.append([i[1],i[0]])
            except NotImplementedError:
                continue
        gmaps = googlemaps.Client(key=GMAPS_KEY)
        now = datetime.now()
        directions_result = gmaps.directions(b[random.randrange(0,len(b))], b[random.randrange(0,len(b))],mode="driving",departure_time=now, waypoints = b[0:[25 if (len(b)>=25) else len(b)][0]], optimize_waypoints = True)
        res.extend(directions_result)
    routestats = RouteStatsCalc(res)
    df = pd.DataFrame([])
    df["Route"] = res
    df["Ascent"] = [i[0] for i in routestats]
    df["Descent"] = [i[1] for i in routestats]
    df["Flat"] = [i[2] for i in routestats]
    df["Total Distance"] = [i[3] for i in routestats]
    df["DiffRat"] = abs((df["Ascent"] - df["Descent"])/df["Total Distance"])
    l = list(np.zeros(len(df)))
    for i in range(len(df)):
        if (df["DiffRat"][i] < 0.05):
            l[i] = 3
        elif (df["Ascent"][i] < df["Descent"][i]):
            if (df["Ascent"][i] < df["Flat"][i]):
                l[i]= 1
            else:
                l[i] = 2
        else:
            if (df["Ascent"][i] < df["Flat"][i]):
                l[i]= 4
            else:
                l[i] = 5
    
    df["FitLevel"] = l
    weightkg = weight
    MET = [4.9,6.8,8,11,15.8]
    speed = [8,11,13,16.25,22]
    calories = []
    tim = []
    
    for i in range(len(df)):
        calpm = (MET[df["FitLevel"][i]-1] * weightkg * 3.5) / 200
        distkm = df["Total Distance"][i]
        distmile = distkm * 0.621371
        time = (distmile / speed[df["FitLevel"][i]-1]) * 60
        tim.append(time)
        calories.append(calpm * time)

    df["Time"] = tim
    df["Calories"] = calories
    df.index = np.arange(len(df))
    polyline = []
    for i in range(len(df)):
        polyline.append(df['Route'][i]['overview_polyline']['points'])
    df['polyline']=polyline
    AscDesc = []
    for i in range(len(df)):
        AscDesc.append(liveStats(df["Route"][i]))
    df['AscDesc']=AscDesc
    return df
