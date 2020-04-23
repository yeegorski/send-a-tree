#an update for the automation script: adding automatic sql tables update

#the old part
#!/usr/bin/env bash
cd raw_data
yesterday=$(ls -v | grep "day_*" | tail -1 | cut -d'_' -f2)
today=$((yesterday+1))
wget 46.101.230.157/jds_february_2020/day_$today
grep "registration" /home/dataguy/raw_data/day_$today > /home/dataguy/registration/day_$today
grep "sent_a_free_tree" /home/dataguy/raw_data/day_$today > /home/dataguy/free_tree/day_$today
grep "sent_a_super_tree" /home/dataguy/raw_data/day_$today > /home/dataguy/super_tree/day_$today

#the new part
psql -U dataguy -d postgres -c "COPY registration FROM '/home/dataguy/registration/day_$today' DELIMITER ' ';"
psql -U dataguy -d postgres -c "COPY free_tree FROM '/home/dataguy/free_tree/day_$today' DELIMITER ' ';"
psql -U dataguy -d postgres -c "COPY super_tree FROM '/home/dataguy/super_tree/day_$today' DELIMITER ' ';"
