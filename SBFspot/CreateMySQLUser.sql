#DROP USER 'SBFspotUser'@'%';
CREATE USER 'SBFspotUser'@'%' IDENTIFIED BY 'SBFspotPassword';
GRANT DELETE,INSERT,SELECT,UPDATE ON SBFspot.* TO 'SBFspotUser'@'%';
FLUSH PRIVILEGES;