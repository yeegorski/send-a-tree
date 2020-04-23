#loading historical data (from 223 days) into SQL tables using while loop in bash

start=1
end=224
while [ $start -lt $end ]
do
psql -U dataguy -d postgres -c "COPY registration FROM '/home/dataguy/registration/day_$start' DELIMITER ' ';"
start=$((start+1))
done 

start=1
while [ $start -lt $end ]
do
psql -U dataguy -d postgres -c "COPY free_tree FROM '/home/dataguy/free_tree/day_$start' DELIMITER ' ';"
start=$((start+1))
done

start=1
while [ $start -lt $end ]
do
psql -U dataguy -d postgres -c "COPY super_tree FROM '/home/dataguy/super_tree/day_$start' DELIMITER ' ';"
start=$((start+1))
done
