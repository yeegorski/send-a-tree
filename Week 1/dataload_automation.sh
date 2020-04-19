#automating data load
#the data for the new day appears on the server 10 minutes after midnight daily
#below I automate the data load to be performed at 00:15 every night

#creating a script
mcedit automation.sh

#in mcedit

#!/usr/bin/env bash
cd raw_data
#finding the last day_* file in the raw_data folder
yesterday=$(ls -v | grep "day_*" | tail -1 | cut -d'_' -f2) 
today=$((yesterday+1))
#downloading from the server
wget 0.0.0.0/folder/day_$today
#sorting in the respective folders
grep "registration" /home/dataguy/raw_data/day_$today > /home/dataguy/registration/day_$today
grep "sent_a_free_tree" /home/dataguy/raw_data/day_$today > /home/dataguy/free_tree/day_$today
grep "sent_a_super_tree" /home/dataguy/raw_data/day_$today > /home/dataguy/super_tree/day_$today

#making the script executable
chmod 777 automation.sh

#I perform the automation in crontab
crontab -e

#m h dom mon dow command
15 0 * * * /home/dataguy/automation.sh
