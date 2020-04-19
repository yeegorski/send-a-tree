#creating separate folders for registrations, free tree sends, and super tree sends

mkdir registration
mkdir free_tree
mkdir super_tree

#sort the raw_data into the respective folders

start=1
end=220
while [ $start -lt $end ]
do
grep "registration" /home/dataguy/raw_data/day_$start > /home/dataguy/registration/day_$start
grep "sent_a_free_tree" /home/dataguy/raw_data/day_$start > /home/dataguy/free_tree/day_$start
grep "sent_a_super_tree" /home/dataguy/raw_data/day_$start > /home/dataguy/super_tree/day_$start
start=$((start+1))
done
