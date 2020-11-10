DROP TABLE ExamResult;

CREATE TABLE ExamResult
(StudentName VARCHAR(70), 
 Subject     VARCHAR(20), 
 Marks       INT
);
INSERT INTO ExamResult
VALUES
('Lily', 
 'Maths', 
 65
);
INSERT INTO ExamResult
VALUES
('Lily', 
 'Science', 
 80
);
INSERT INTO ExamResult
VALUES
('Lily', 
 'english', 
 70
);
INSERT INTO ExamResult
VALUES
('Isabella', 
 'Maths', 
 50
);
INSERT INTO ExamResult
VALUES
('Isabella', 
 'Science', 
 70
);
INSERT INTO ExamResult
VALUES
('Isabella', 
 'english', 
 50
);
INSERT INTO ExamResult
VALUES
('Olivia', 
 'Maths', 
 55
);
INSERT INTO ExamResult
VALUES
('Olivia', 
 'Science', 
 60
);
INSERT INTO ExamResult
VALUES
('Olivia', 
 'english', 
 89
);
INSERT INTO ExamResult
VALUES
('Lily', 
 'French', 
 73
);
INSERT INTO ExamResult
VALUES
('Lily', 
 'German', 
 80
);
INSERT INTO ExamResult
VALUES
('Lily', 
 'Spanish', 
 64
);
INSERT INTO ExamResult
VALUES
('Isabella', 
 'French', 
 90
);
INSERT INTO ExamResult
VALUES
('Isabella', 
 'German', 
 45
);
INSERT INTO ExamResult
VALUES
('Isabella', 
 'Spanish', 
 71
);
INSERT INTO ExamResult
VALUES
('Olivia', 
 'French', 
 75
);
INSERT INTO ExamResult
VALUES
('Olivia', 
 'German', 
 80
);
INSERT INTO ExamResult
VALUES
('Olivia', 
 'Spanish', 
 77
);



####

#A : use Row_Number() function get a row number for students and subjects as per their marks- highest to lowest 


SELECT Studentname, 
       Subject, 
       Marks, 
       ROW_NUMBER() OVER(ORDER BY Marks desc) RowNumber
FROM ExamResult;


#B : Use RANK() function to specify rank for each row in the result set. We have student results for  multiple subjects. We want to rank the result for each student as per their marks in the subjects. For example, student Isabella got her highest marks in French and her lowest marks in German 


SELECT Studentname, 
       Subject, 
       Marks, 
       RANK() OVER(PARTITION BY Studentname ORDER BY Marks desc) as Ranking
FROM ExamResult
ORDER BY Studentname;


#C : Use RANK() function to specify rank for each row in the result set by the marks alone. sort by the rank column 

SELECT Studentname, 
       Subject, 
       Marks, 
       RANK() OVER(ORDER BY Marks DESC) as Ranking1
FROM ExamResult
ORDER BY Ranking1;


#D : Use DENSE_RANK() function to specify rank for each row in the result set by the marks alone - so that no rank numbers are skipped in the resulting column. sort by the rank column  

SELECT Studentname, 
       Subject, 
       Marks, 
       DENSE_RANK() OVER(ORDER BY Marks DESC) as Ranking2
FROM ExamResult
ORDER BY Ranking2;


#E : Use DENSE_RANK() function to specify the rank each student has achieved in each subject versus the other students, eg Isabella came first in French, 2nd in German, Science etc 
         
SELECT Studentname, 
       Subject, 
       Marks, 
       DENSE_RANK() OVER(PARTITION BY Subject ORDER BY Marks DESC) as Ranking3
FROM ExamResult
ORDER BY Studentname, 
         Ranking3;    
         
#Use Row_Number() and a subquery to return the top position 1-3 students, a) first overall by grades, and then b) for just the european languages
         
WITH StudentRanks AS
(
  SELECT *, ROW_NUMBER() OVER( ORDER BY Marks DESC) AS Ranks
  FROM ExamResult
  where Subject not in ('Science', 'english')
)
 
SELECT StudentName , Marks, Subject 
FROM StudentRanks
WHERE Ranks >= 1 and Ranks <=3
ORDER BY Ranks ;
         
         