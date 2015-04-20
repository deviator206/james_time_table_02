CALL gs1(5);



 SELECT * FROM SUBJECT WHERE classid =  5;
 
 
 CALL test04(1);
 


SELECT * FROM SUBJECT WHERE classid = 5

SELECT * FROM days;

INSERT INTO  time_slot (label,active) VALUES 
('07.40 – 8-10',1);


INSERT INTO  time_slot (label,active) VALUES 
('08.10 – 8-40',1),
('08.40 – 9-10',1),
('09.10 – 9-40',1),
('09.40 - 10-10',1),
('10.10 – 10-30',1),

('10.30 – 11-00',1),
('11.00 – 11-30',1),
('11.30 – 12-00',1),
('12.00 – 12-30',1),
('12.30 –0 1-00',1);

INSERT INTO days (daylabel,isactive) VALUES
('MONDAY',1),
('TUESDAY',1),
('WEDNESDAY',1),
('THURSDAY',1),
('FRIDAY',1);

SELECT * FROM days

SELECT * FROM SUBJECT

INSERT INTO SUBJECT (NAME,classid,COUNT) VALUES 
("Maths",1,10),
("Games",1,1),
("Craft",1,2),
("PE",1,2),
("Marathi",1,6),
("English",1,10),
("GK",1,1),
("Art",1,2),
("CAP",1,1),
("MD",1,2),
("Computer",1,2);

SELECT * FROM SUBJECT WHERE subjectid =21

UPDATE SUBJECT SET successive = 1 WHERE subjectid = 21




INSERT INTO SUBJECT (NAME,classid,COUNT) VALUES 
("Marathi",2,8),
("Hindi",2,5),
("English",2,8),
("Mathis",2,8),
("Computer",2,2),
("Art",2,2),
("Craft",2,2),
("PE",2,2),
("V.ed",2,1),
("GK",2,1),
("CAP",2,1),
("MD",2,2)


SELECT * FROM SUBJECT WHERE classid  =2

INSERT INTO SUBJECT (NAME,classid,COUNT) VALUES 
("Marathi",3,5),
("Hindi",3,6),
("English",3,7),
("Science",3,5),
("Maths",3,8),
("Arts",3,2),
("S.S",3,6),
("Craft",3,2),
("P.E&M.D",3,4),
("Computer",3,2),
("V.ED",3,1),
("CAP & MD",3,1);



/* 4th std*/
INSERT INTO SUBJECT (NAME,classid,COUNT) VALUES 
("English",4,7),
("Marathi",4,5),
("Hindi",4,5),
("Maths",4,8),
("SC",4,5),
("SS",4,6),
("Art",4,2),
("Craft",4,2),
("Computer",4,2),
("Library",4,1),
("V.ED",4,1),
("GK",4,1),
("P.E",4,2),
("C.A.P",4,1),
("MD",4,2)





Marathi	5
Hindi	5
Maths	8
S.C	5
S.S
Arts	6
3
W.E	2
P.E
Comp	2
2
V.ED
G.K	1
1
C.A.P
M.D	1
5thstd
M.D	2

/* 5th std*/
INSERT INTO SUBJECT (NAME,classid,COUNT) VALUES 
("English",5,7),
("Marathi",5,5),
("Hindi",5,5),
("Maths",5,8),
("S.C",5,5),
("S.S",5,6),
("Arts",5,3),
("W.E",5,2),
("P.E",5,2),
("Comp",5,2),
("V.ED",5,1),
("GK",5,1),
("C.A.P",5,1),
("MD",5,3)


SELECT * FROM teacher


