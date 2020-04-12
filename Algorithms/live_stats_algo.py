def LiveStats(a,distance):
    length=len(a)
    for i in range(length) :
        if(a[i][0]<distance<a[i+1][0]):
            b=i+1
            ascent=a[b][1]
            descent=a[b][2]
            flat=distance-(ascent+descent)
            break
        else:
            ascent=0
            descent=0
            flat=distance
    listofdetails=[ascent,descent,flat]
    return listofdetails
