SELECT * FROM time_slot

ALTER TABLE time_slot ADD COLUMN break INT


UPDATE   time_slot SET break = 0 WHERE slotid !=16 

SELECT * FROM time_slot WHERE active=1 ORDER BY label ASC

SELECT * FROM time_table (slotid,classid,teacherid,teachername,subjectid,subjectname,dayid,daylabel)


SELECT * FROM time_table


SELECT * FROM time_table

TRUNCATE TABLE time_table
SELECT tbl.slotid,
       tbl.classid,
       tbl.teacherid,
       tbl.teachername ,
       tbl.subjectid,
       tbl.subjectname,
       tbl.dayid,
       tbl.daylabel,
       tbl1.label  FROM   time_slot  tbl1 LEFT JOIN  time_table  tbl ON tbl.slotid = tbl1.slotid  AND tbl.classid = 1 ORDER BY tbl.slotid ASC
       
       
       
       
       
       
       
 
SELECT tbl.slotid,
       tbl.classid,
       tbl.teacherid,
       tbl.teachername ,
       tbl.subjectid,
       tbl.subjectname,
       tbl.dayid,
       tbl.daylabel,
       tbl1.label  FROM   time_slot  tbl1 LEFT JOIN  time_table  tbl ON tbl.slotid = tbl1.slotid    AND tbl.classid =2   ORDER BY label ASC 