import requests
import googlemaps
from datetime import datetime
import polyline
import json
import pandas as pd
import numpy as np

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
            roc.append((elevation["height"][i+1] - elevation["height"][i])/(elevation["distance"][i+1] - elevation["distance"][i]))
        elevation["roc"] = roc
        asc = 0
        desc = 0
        for i in range(len(elevation)):
            if (elevation["roc"][i]<0):
                desc += (elevation["distance"][i] - elevation["distance"][i-1])
            elif (elevation["roc"][i]>0):
                asc += (elevation["distance"][i] - elevation["distance"][i-1])
        flat = elevation['distance'][len(elevation)-1] - asc -desc
        total_dist = elevation['distance'][len(elevation)-1]
        res.append([asc,desc,flat, total_dist])

    return res


def SearchResult(start, end, fit_level, weight, max_dist=None, cal=None):
    gmaps = googlemaps.Client(key=GMAPS_KEY)
    now = datetime.now()
    directions_result = gmaps.directions(
        start, end, mode="driving", departure_time=now, alternatives=True
    )
    routestats = RouteStatsCalc(directions_result)
    df = pd.DataFrame([])
    df["Route"] = directions_result
    df["Ascent"] = [i[0] for i in routestats]
    df["Descent"] = [i[1] for i in routestats]
    df["Flat"] = [i[2] for i in routestats]
    df["Total Distance"] = [i[3] for i in routestats]
    df["DiffRat"] = abs((df["Ascent"] - df["Descent"]) / df["Total Distance"])
    
    #Filtering results
    if (max_dist != None):
        drop = []
        for i in range(len(df)):
            if (df["Total Distance"][i] > max_dist):
                drop.append(i)
        df.drop(drop, inplace=True)
    df.index = np.arange(len(df))
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
    if(cal!=None):
        drop=[]
        for i in range(len(df)):
            if ((df["Calories"][i]<cal-150)or(df["Calories"][i]>cal+150)):
                drop.append(i)
        df.drop(drop, inplace=True)
    df.index = np.arange(len(df))
    polyline = []
    for i in range(len(df)):
        polyline.append(df['Route'][i]['overview_polyline']['points'])
    df['polyline']=polyline
    df1 = df[df["FitLevel"] == fit_level]

    if (df1.shape[0] == 0):
        df2 = df[df["FitLevel"]!=fit_level]
        df2.sort_values(by=['Total Distance'], inplace=True)
        return df2
    else:
        df1.sort_values(by=['Total Distance'], inplace=True)
        return df1
