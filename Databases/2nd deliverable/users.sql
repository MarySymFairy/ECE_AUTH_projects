# Create the admin of the DB
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin_password';
CREATE USER 'admin'@'%' IDENTIFIED BY 'admin_password';
GRANT ALL PRIVILEGES ON neurosync_db.* TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON neurosync_db.* TO 'admin'@'%';

# Create the researcher user of the DB
CREATE USER 'researcher'@'localhost' IDENTIFIED BY 'researcher_password';
CREATE USER 'researcher'@'%' IDENTIFIED BY 'researcher_password';
GRANT SELECT, INSERT, UPDATE ON neurosync_db.* TO 'researcher'@'localhost';
GRANT SELECT, INSERT, UPDATE ON neurosync_db.* TO 'researcher'@'%';

# Data Analyst User uses the DB to extract conclusions
CREATE USER 'analyst'@'localhost' IDENTIFIED BY 'analyst_password';
CREATE USER 'analyst'@'%' IDENTIFIED BY 'analyst_password';
GRANT SELECT ON neurosync_db.* TO 'analyst'@'localhost';
GRANT SELECT ON neurosync_db.* TO 'analyst'@'%';

 # Student User uses the DB to study
CREATE USER 'student'@'localhost' IDENTIFIED BY 'student_password';
CREATE USER 'student'@'%' IDENTIFIED BY 'student_password';
GRANT SELECT ON neurosync_db.* TO 'student'@'localhost';
GRANT SELECT ON neurosync_db.* TO 'student'@'%';
