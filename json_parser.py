# -*- coding: utf-8 -*-
"""
Created on Sat Feb 14 12:51:36 2016

@author: FloM
"""
import json
import pandas as pd
from timeit import default_timer
start = default_timer()

#Create a list to store the data from the json file (by line)
data = []
# Read the data line by line 
with open('data_json.json.stream','r') as f:
    for line in f:
        data.append(json.loads(line))
            
#Create empty lists
mylist = []

#Set the 'original' dataframe containing the json data 
df_before = pd.DataFrame(data)
#Set sub dataframe containing only the records
df_sub=df_before['records']

# Create a list of data frames, where in each list, one row equals one track section
for i in range(df_sub.size):
     print(i)
     mylist.append(pd.DataFrame(df_sub[i]))
     mylist[i]['id']=df_before['id'][i]
     mylist[i]['start']=df_before['start'][i]
     mylist[i]['end']=df_before['end'][i]
     #First element contains the label and destination
     mylist[i]['label']=mylist[i]['label'][0]
     mylist[i]['dest']=mylist[i]['dest'][0]

#Concatenate the list
df_final = pd.concat(mylist)
     
#Reset index
df_final = df_final.reset_index()

#Order of columns -> id, label,dest,delay,direction, lat, lon, nid,nname,ntime,pid,pname,ptime,start , end, timestamp
cols = df_final.columns.tolist()
cols_re = cols[3:5]+cols[1:2]+cols[0:1]+cols[2:3]+ cols[5:7] +cols[7:13]+cols[-2:]+ cols[-1:-2] + cols[-3:-2]
df_final = df_final[cols_re]

#Save to csv
df_final.to_csv('df_out.csv',sep=';')

#Show processing time
duration = default_timer() - start
print (duration)
