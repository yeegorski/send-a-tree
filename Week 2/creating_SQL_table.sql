#creating three tables in SQL for the three activities: registrations, sending free trees, and sending super trees

CREATE TABLE registration
(
	day TEXT,
	date DATE,
	time TIME,
	used_id INTEGER,
	event TEXT,
	birth_year INTEGER,
	phone_type TEXT,
	country TEXT,
	source TEXT
);

CREATE TABLE free_tree
(
	day TEXT,
	date DATE,
	used_id INTEGER,
	event TEXT
);

CREATE TABLE super_tree
(
	day TEXT,
	date DATE,
	used_id INTEGER,
	event TEXT
);
