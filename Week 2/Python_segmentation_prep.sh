#To perform some segmentation analysis in Python, we have to prepare the data accordingly
#First, I collect all the data for registrations, free tree sends, and super tree sends in three separate csv files

#in every respective folder:

cat * > registration.csv
cat * > free_tree.csv
cat * > super_tree.csv

#updating the automation script, so the csv files are updated daily:

cat /home/dataguy/registration/day_$today >> /home/dataguy/registration/registration.csv
cat /home/dataguy/free_tree/day_$today >> /home/dataguy/free_tree/free_tree.csv
cat /home/dataguy/super_tree/day_$today >> /home/dataguy/super_tree/super_tree.csv
