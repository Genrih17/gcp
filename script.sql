CREATE TABLE USERS (
    ID int,
    Name varchar(255),
    Email varchar(255),
    Position varchar(255),
    Department_ID int
);
CREATE TABLE DEPARTMENTS (
    ID int,
    Department_Name varchar(255)
);
INSERT INTO USERS VALUES (1,'Rachel','rachel@emap.com','manager',1);
INSERT INTO USERS VALUES (2,'Monica','monica@emap.com','HR',2);
INSERT INTO USERS VALUES (3,'Phoebe','phoebe@emap.com','devops',3);
INSERT INTO USERS VALUES (4,'Joey','joey@emap.com','support',4);
INSERT INTO USERS VALUES (5,'Chandler','chandler@emap.com','devops',3);
INSERT INTO USERS VALUES (6,'Ross','ross@emap.com','programmer',5);
INSERT INTO DEPARTMENTS VALUES (1,'Sale');
INSERT INTO DEPARTMENTS VALUES (2,'HR');
INSERT INTO DEPARTMENTS VALUES (3,'DevOps');
INSERT INTO DEPARTMENTS VALUES (4,'Support');
INSERT INTO DEPARTMENTS VALUES (5,'Java_dev');
