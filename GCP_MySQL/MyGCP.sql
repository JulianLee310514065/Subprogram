SHOW databases;
-- CREATE DATABASE Telegonosis;
USE Telegonosis;

CREATE TABLE Persons (
    id int NOT NULL AUTO_INCREMENT,
    Title varchar(3000) NOT NULL,
    Trans_Title varchar(3000),
    Content varchar(5000),
    Time datetime,
    Source varchar(500),
    Link varchar(3000),
    Want int,
    PRIMARY KEY (id)
)CHARACTER SET utf8mb4;
