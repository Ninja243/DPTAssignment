-- Procedures.sql
-- Contains procedure creation text ro be called by interface

-- TODO Comment/doc

-- Find a person in the DB by searching for their ID number
create PROCEDURE spFindPersonFromID
    @ID numeric(11)
AS
BEGIN
    SELECT *
    FROM Person
    WHERE IDnumber = @ID;
END
GO

-- Find a person in the DB by searching for their First Name and Surname
create PROCEDURE spFindPersonFromFirstLastName
    @Firstname varchar(20),
    @Lastname varchar(20)
AS
BEGIN
    SELECT *
    FROM Person
    WHERE Firstname = @Firstname AND Lastname = LastName;
END
GO

-- Search for Person's first name
create Procedure spSearchPersonFirstName
    @SearchString varchar
AS
BEGIN
    SELECT Firstname, Lastname, IDNumber
    from Person
    where Firstname like @SearchString;
END
Go

-- Search for Person's last name
create Procedure spSearchPersonLastName
    @SearchString varchar
AS
BEGIN
    SELECT Firstname, Lastname, IDNumber
    from Person
    where Lastname like @SearchString;
END
Go

-- Get all First names in DB
create Procedure spGetAllFirstNames
AS
BEGIN
    SELECT Firstname
    FROM Person;
END
Go

-- Get all Last names in DB
create Procedure spGetAllLastNames
AS
BEGIN
    SELECT Lastname
    FROM Person;
END
GO

-- Get all ID Numbers in DB
create Procedure spGetAllIDNumbers
AS
BEGIN
    Select IDNumber
    from Person;
END
GO

-- Get all birthdays from DB
create Procedure spGetAllBirthdays
As
BEGIN
    Select DateOfBirth
    from Person;
END
Go

-- Get all information on people in db
create PROCEDURE spGetAllPeopleInfo
AS
BEGIN


    -- Find Student with specific Student Number
    create PROCEDURE spFindStudentStudentNumber
        @StudentNumber numeric(9)
    AS
    BEGIN
        SELECT *
        From Student
        WHERE StudentNumber = @StudentNumber;
    END
GO

-- Find Student with specific ID Number
create PROCEDURE spFindStudentIDNumber
    @IDNumber numeric(11)
AS
BEGIN
    SELECT *
    FROM Student
    WHERE IDNumber = @IDNumber;
END
GO

-- Find Lecturer with Specific






















-- Old procs here
GO
Create Procedure SpPerson
    @Firstname varchar(20),
    @Lastname varchar(20),
    @DateOFBirth date
AS
BEGIN

    SET NOCOUNT ON;
    INSERT INTO  Person
        (Firstname,Lastname,DateOFBirth)
    VALUES
        (@Firstname, @Lastname, @DateOFBirth)
END 
GO

GO
Create Procedure SpStud
    @StudentNumber numeric(9),
    @IDNumber numeric(11)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Stud
        (StudentNumber,IDNumber)
    VALUES
        (@StudentNumber, @IDNumber)
END 
GO

GO
Create Procedure Splect
    @SaffNumber numeric(9),
    @IDNumber numeric(11)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  lect
        (SaffNumber,IDNumber)
    VALUES
        (@SaffNumber, @IDNumber)
END 
GO

GO
Create Procedure SpMail
    @EmailID numeric(9),
    @EmailSubject nvarchar(60),
    @Sender varchar(20),
    @Receiver varchar(20),
    @IDNumber numeric(11)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Mail
        (EmailID,EmailSubject,Sender,Receiver,IDNumber)
    VALUES
        (@EmailID, @EmailSubject, @Sender, @Receiver, @IDNumber)
END 
GO

GO
Create Procedure SpReg
    @RegistrarID numeric(9),
    @StaffNumber numeric(9)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Reg
        (RegistrarID,StaffNumber)
    VALUES
        (@RegistrarID, @StaffNumber)
END 
GO


GO
Create Procedure SpInsti
    @InstitutionID numeric(4),
    @Name varchar(50),
    @Acronym varchar(8)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Insti
        (InstitutionID,Name,Acronym)
    VALUES
        (@InstitutionID, @Name, @Acronym)
END 
GO

GO
Create Procedure SpCoor
    @CoordinatorID numeric(9),
    @InstitutionID numeric(4),
    @StaffNumber Numeric(9)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Coor
        (CoordinatorID,InstitutionID,StaffNumber)
    VALUES
        (@CoordinatorID, @InstitutionID, @StaffNumber)
END 
GO

GO
Create Procedure SpDocu
    @DocumentID nvarchar(11),
    @Description text
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Docu
        (DocumentID,Description)
    VALUES
        (@DocumentID, @Description)
END 
GO

GO
Create Procedure SpBirth
    @BCNumber numeric(30),
    @DocumentID nvarchar(11)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Birth
        (BCNumber,DocumentID)
    VALUES
        (@BCNumber, @DocumentID)
END 
GO

GO
Create Procedure SpPass
    @PassportNumber int,
    @DocumentID nvarchar(11)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Pass
        (PassportNumber,DocumentID)
    VALUES
        (@PassportNumber, @DocumentID)
END 
GO

GO
Create Procedure SpPolice
    @CllearanceID int,
    @ExpiryDate datetime,
    @DocumentID nvarchar(11)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Police
        (CllearanceID,ExpiryDate,DocumentID)
    VALUES
        (@CllearanceID, @ExpiryDate, @DocumentID)
END 
GO

GO
Create Procedure SpRaw
    @FileID int,
    @Data varbinary,
    @FileName varchar(20)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Raw
        (FileID,Data,FileName)
    VALUES
        (@FileID, @Data, @FileName)
END 
GO

GO
Create Procedure SpAppl
    @ApplicationID nvarchar(9),
    @StudentNumber numeric(9)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Appl
        (ApplicationID,StudentNumber)
    VALUES
        (@ApplicationID, @StudentNumber)
END 
GO

GO
Create Procedure SpCover
    @CLID int,
    @StudentNumber numeric(9),
    @DocumentID nvarchar(11)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Cover
        (CLID,StudentNumber,DocumentID)
    VALUES
        (@CLID, @StudentNumber, @DocumentID)
END 
GO

GO
Create Procedure SpDept
    @DepaartmentID nvarchar(4),
    @DepartmentName varchar(20)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Dept
        (DepaartmentID,DepartmentName)
    VALUES
        (@DepaartmentID, @DepartmentName)
END 
GO

GO
Create Procedure SpCos
    @CourseCode nvarchar(6),
    @Description Text ,
    @NQL int,
    @DepartmentID nvarchar(4)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Cos
        (CourseCode,DescriptionText,NQL,DepartmentID)
    VALUES
        (@CourseCode, @Description, @NQL, @DepartmentID)
END 
GO

GO
ALTER Procedure SpMark
    @MarkID int,
    @SemesterNumber int ,
    @CourseID nvarchar(6) ,
    @PercentageMark numeric(3),
    @DocumentID nvarchar(11)
AS
BEGIN
    IF @PercentageMark > 60
BEGIN
        SELECT *
        FROM SemesterMark
        where PercentageMark = @PercentageMark
    END
ELSE
BEGIN
        Print 'NOT ELIGIBLE TO BE AWARDED THE DAAD SCHOLARSHIP'
    END
    SET NOCOUNT ON;
    INSERT INTO Mark
        (MarkID,SemesterNumber,PercentageMark,DocumentID)
    VALUES
        (@MarkID, @SemesterNumber, @CourseID, @PercentageMark, @DocumentID)
END 
GO

GO
Create Procedure Spform
    @AppID nvarchar(6),
    @ApplicationID nvarchar(9),
    @CllearanceID int,
    @PassportNumber int ,
    @CLID int ,
    @AdmID nvarchar(4) ,
    @MarkID int
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO form
        (AppID,ApplicationID,CllearanceID,PassportNumber,CLID,AdmID,MarkID)
    VALUES
        (@AppID, @ApplicationID, @CllearanceID, @PassportNumber, @CLID, @AdmID, @MarkID)
END 
GO

GO
Create Procedure SpAdm
    @AdmID nvarchar(4),
    @creation datetime,
    @DocumentID nvarchar(11)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Adm
        (AdmID,creation,DocumentID)
    VALUES
        (@AdmID, @creation, @DocumentID)
END 
GO

GO
Create Procedure SpHod
    @HoDID nvarchar(6),
    @StaffNumber numeric(9),
    @CourseCode nvarchar(6),
    @DepartmentID nvarchar(4)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Hod
        (HoDID,StaffNumber,CourseCode,DepartmentID)
    VALUES
        (@HoDID, @StaffNumber, @CourseCode, @DepartmentID)
END 
GO

GO
Create Procedure SpFicer
    @OfficeNumber int,
    @OfficePhoneNumber nvarchar(11),
    @EmailAddress varchar(20)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Office
        (OfficeNumber,OfficePhoneNumber,EmailAddress)
    VALUES
        (@OfficeNumber, @OfficePhoneNumber, @EmailAddress)
END 
GO