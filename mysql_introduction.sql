# Exercises for https://ds.codeup.com/sql/mysql-introduction/

# * means all columns from a database table
SELECT * FROM mysql.user;

# only showing the "user" column and the "host" columns
SELECT user, host FROM mysql.user;

# All the rows because we use * from the help_topic table of the mysql database
SELECT * FROM mysql.help_topic;

# Selecting only the help_topic_id, help_category_id, and url columns from the help_topic table.
SELECT help_topic_id, help_category_id, url FROM mysql.help_topic;