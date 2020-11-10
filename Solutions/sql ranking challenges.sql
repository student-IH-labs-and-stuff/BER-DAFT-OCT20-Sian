DROP TABLE if exists ExamResult;

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


#A : use Row_Number() function get a row number for students and subjects as per their marks- highest to lowest 




#B : Use RANK() function to specify rank for each row in the result set. We have student results for  multiple subjects. We want to rank the result for each student as per their marks in the subjects. For example, student Isabella got her highest marks in French and her lowest marks in German 





#C : Use RANK() function to specify rank for each row in the result set, considering marks alone. sort by the rank column 




#D : Use DENSE_RANK() function to specify rank for each row in the result set by the marks alone - so that no rank numbers are skipped in the resulting column. sort by the rank column  




#E : Use DENSE_RANK() function to specify the rank each student has achieved with their grade in each subject versus the other students, eg Isabella came first in French, 2nd in German and Science etc 
         
   
   
         
#F : Use Row_Number() and a subquery to return the top position 1-3 students,a) first overall by grades, and then b) for just the european languages
         

         
         