#downloading the data log files from a server
#on the server every file is named day_x, day_1 being September 13, 2019
#as of the day the code was written (April 19, 2020), there were 219 data log files (219 days) on the server 

#creating a folder for the data log files
mkdir raw_data

#entering the folder
cd raw_data

#in the folder raw_data, the actual download
start=1
end=220
while [ $start -lt $end ]
do
wget 0.0.0.0/folder/day_$start
start=$((start+1))
done
