import pandas as pd
import os

files = os.listdir('./citibike/data_files/')

# Concatenate csv files into one pandas dataframe object
combined = pd.concat([pd.read_csv(f'./citibike/data_files/{f}') for f in files])


df = combined.rename(columns={'tripduration':'tripduration_sec',
                    'starttime':'start_time',
                    'stoptime':'stop_time',
                    'start station id':'start_station_id',
                    'start station name':'start_station_name',
                    'start station latitude':'start_latitude',
                    'start station longitude':'start_longitude',
                    'end station id':'end_station_id',
                    'end station name':'end_station_name',
                    'end station latitude':'end_latitude',
                    'end station longitude':'end_longitude',
                    'birth year':'birth_year'},index=None)

# Fill NA values as 0 so we can drop them later
df_fill= df.fillna(0)
df_fill.isnull().sum().sum()

df_fill.to_csv('./citibike/data_files/2019_tripdata.csv',index=False)
