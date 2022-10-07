import requests
from bs4 import BeautifulSoup
from time import sleep
import os
import zipfile
import os

url = 'https://s3.amazonaws.com/tripdata/'
trip_page = requests.get(url)
folder_name = 'citibike/data_files'

soup = BeautifulSoup(trip_page.text, 'xml')

# The zip files are tagged with "Key" allowing us to filter filenames into a list object
data = soup.find_all('Key')
files = []

for i in range(len(data)-1):
    # get_text removes <key> from the file list
    files.append(data[i].get_text())

# check if folder exists if not create it
if os.path.isdir(folder_name) == False:
    target = os.mkdir(folder_name)

# Uses list comprehension to filter out Jersey City files and years other than 2019
filter_list = [x for x in files if ('2019' in x and 'JC' not in x)]

for file_name in filter_list:
    file_url = url + file_name

    with open(os.path.join(folder_name,file_name), 'wb') as f:
        result = requests.get(file_url)
        sleep(5)
        f.write(result.content)

source = "./citibike/data_files/"

def unzip(directory):
'''Function to unzip files in specified directory'''

    for file in os.listdir(directory):
        if file.endswith('.zip'):
            names = source + file
            my_zip = zipfile.ZipFile(names)
            my_zip.extractall(source)
            my_zip.close()
            os.remove(names)

if __name__ =='__main__':
    unzip(source)
