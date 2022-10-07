import psycopg2
from db_cred import key

def create_tbl():

    try:
        connection = psycopg2.connect(dbname="citi_tripdata",user="postgres",
                                            password=key)
        cursor= connection.cursor()

        create_table= '''CREATE TABLE bike_trips(
                                    tripduration_sec INT,
                                    start_time TIMESTAMP,
                                    stop_time TIMESTAMP,
                                    start_station_id FLOAT4,
                                    start_station_name VARCHAR,
                                    start_latitude FLOAT8,
                                    start_longitude FLOAT8,
                                    end_station_id FLOAT4,
                                    end_station_name VARCHAR,
                                    end_latitude FLOAT8,
                                    end_longitude FLOAT8,
                                    bikeid INT,
                                    usertype VARCHAR,
                                    birth_year INT,
                                    gender INT); '''

        cursor.execute(create_table)
        connection.commit()
        print('Successfully')

    except psycopg2.Error as error:
        pass

    finally:
         if(connection):
                cursor.close()
                connection.close()
                print("Closed")

def update_tbl():
    try:
        connection = psycopg2.connect(dbname="citi_tripdata",user="postgres",
                                            password=key)
        cur = connection.cursor()

        with open('./citibike/data_files/2019_tripdata.csv','r') as f:
            next(f)
            cur.copy_from(f, "bike_trips", sep=',')

            connection.commit()

    except psycopg2.Error as error:
        pass

    finally:
         if(connection):
                cur.close()
                connection.close()
                print("PostgreSQL connection is closed")
if __name__ == '__main__':
    create_tbl()
    update_tbl()
