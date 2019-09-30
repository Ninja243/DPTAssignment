-- Procedures.sql
-- Contains procedure creation text ro be called by interface

-- TODO Comment/doc

--insert into Person values (12345678123, 'Mweya', 'Ruider', GETDATE());



-- Add someone to the person table
create Procedure spAddPerson
@PersonIDNumber numeric(11),
@PersonFirstname varchar,
@PersonLastname varchar,
@PersonDoB datetime
AS 
Begin
	insert into Person (IDNumber, Firstname, Lastname, DateOfBirth) Values (@PersonIDNumber, @PersonFirstname, @PersonLastname, @PersonDoB);
END
GO

-- Promote person to student
create Procedure spMakeStudentFromPerson
@IDNumber numeric(11),
@StudentNumber numeric(9)
AS
BEGIN
	insert into Student(StudentNumber, IDNumber) Values (@StudentNumber, @IDNumber);
END
GO

-- Find a person in the DB by searching for their ID number
create PROCEDURE spFindPersonFromID
    @ID varchar(11)
AS
BEGIN
    SELECT *
    FROM Person
    WHERE IDnumber = cast(@ID as numeric(11);
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
    WHERE Firstname = @Firstname AND LastName = @Lastname;
END
GO

-- Get all First names in DB
create Procedure spGetAllFirstNames
AS
BEGIN
    SELECT Firstname
    FROM Person;
END
Go

-- Search for Person's first name
create Procedure spSearchPersonFirstName
    @SearchString varchar
AS
BEGIN
	if (@SearchString is not null) 
    SELECT Firstname, Lastname, IDNumber
    from Person
    where Firstname like '%'+@SearchString+'%';
	else 
	exec spGetAllFirstNames
END
Go

-- Search for Person's last name
create Procedure spSearchPersonLastName
    @SearchString varchar
AS
BEGIN
    SELECT Firstname, Lastname, IDNumber
    from Person
    where Lastname like '%'+@SearchString+'%';
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



    -- Find Student with specific Student Number
    create PROCEDURE spFindStudentStudentNumber
        @StudentNumber numeric(9)
    AS
    BEGIN
        SELECT *
        From Student
        WHERE StudentNumber = '%'+@StudentNumber+'%';
    END
GO

-- Find Student with specific ID Number
create PROCEDURE spFindStudentIDNumber
    @IDNumber numeric(11)
AS
BEGIN
    SELECT *
    FROM Student
    WHERE IDNumber = '%'+@IDNumber+'%';
END
GO

-- Search handler
create procedure spSearch
@SearchString varchar
AS
Begin
 IF Len(@SearchString) = 11
 BEGIN
	SELECT 'Not done yet'
 END
 ELSE
 BEGIN
	Exec spSearchPersonFirstName @SearchString
 END
End
Go






















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
Create Procedure spInsertStudent
    @StudentNumber numeric(9),
    @IDNumber numeric(11)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Student
        (StudentNumber,IDNumber)
    VALUES
        (@StudentNumber, @IDNumber)
END 
GO

GO
Create Procedure spInsertLecturer
    @StaffNumber numeric(9),
    @IDNumber numeric(11)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Lecturer
        (StaffNumber,IDNumber)
    VALUES
        (@StaffNumber, @IDNumber)
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
    INSERT INTO  Email
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
    INSERT INTO  Registrar
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
    INSERT INTO  Institution
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
    INSERT INTO  Coordinator
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
    INSERT INTO  Document
        (DocumentID,Description)
    VALUES
        (@DocumentID, @Description)
END 
GO

Create Procedure SpPass
    @PassportNumber int,
    @DocumentID nvarchar(11)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO  Passport
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
    INSERT INTO  PoliceClearance
        (ClearanceID,ExpiryDate,DocumentID)
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
    INSERT INTO  RawFile
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
    INSERT INTO  Applicant
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
    INSERT INTO  CoverLetter
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
    INSERT INTO  Department
        (DepartmentID,DepartmentName)
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
    INSERT INTO Course
        (CourseCode,DescriptionText,NQL,DepartmentID)
    VALUES
        (@CourseCode, @Description, @NQL, @DepartmentID)
END 
GO

GO
/*Create Procedure SpMark
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
*/
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
    INSERT INTO ApplicationForm
        (AppID,ApplicationID,ClearanceID,PassportNumber,CLID,AdmID,MarkID)
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
    INSERT INTO AdmittanceLetter
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
    INSERT INTO HeadOfDepartment
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

Create Procedure createTables
AS
BEGIN
create table Person

(

    IDNumber numeric(11) primary key not null,

    Firstname varchar(20) not null,

    Lastname varchar(20) not null,

    DateOfBirth date not null

);



create table Student

(

    StudentNumber numeric(9) primary key not null,

    IDNumber numeric(11) not null,

    constraint StID foreign key (IDNumber) references Person(IDNumber) ON DELETE CASCADE

);



create table Lecturer

(

    StaffNumber numeric(9) primary key not null,

    IDNumber numeric(11) not null,

    constraint LeID foreign key (IDNumber) references Person(IDNumber) ON DELETE CASCADE

);



create table Email

(

    EmailID numeric(4) primary key not null,

    EmailSubject nvarchar(60) null,

    EmailText ntext not null,

    Sender varchar(20) not null,

    Receiver varchar(20) not null,

    IDNumber numeric(11) not null,

    constraint EID foreign key (IDNumber) references Person(IDNumber) ON DELETE CASCADE

);



create table Registrar

(

    RegistrarID numeric(9) primary key not null,

    StaffNumber numeric(9) not null,

    constraint RID foreign key (StaffNumber) references Lecturer(StaffNumber) ON DELETE CASCADE

);



create table Institution

(

    InstitutionID numeric(4) not null primary key,

    Name varchar(50) not null,

    Acronym varchar(8)

);



create table Coordinator

(

    CoordinatorID numeric(9) not null primary key,

    InstitutionID numeric(4) not null,

    StaffNumber Numeric(9) not null,

    constraint InsID foreign key (InstitutionID) references Institution(InstitutionID) ON DELETE CASCADE,

    constraint ScID foreign key (StaffNumber) references Lecturer(StaffNumber) ON DELETE CASCADE

);

create table RawFile

(

    FileID int not null primary key,

    Data varbinary not null,

    FileName varchar(20) not null

);

create table Document

(

    DocumentID nvarchar(11) not null primary key,

    Description text null,
	FIleID int not null,
    constraint Did foreign key (FileID) references RawFile(FileID) ON DELETE CASCADE

);

create table Passport

(

    PassportNumber int not null primary key,

    DocumentID nvarchar(11) not null,

    constraint PaID foreign key (DocumentID) references Document(DocumentID) ON DELETE CASCADE

);



create table PoliceClearance

(

    ClearanceID int not null primary key,

    ExpiryDate datetime not null,

    CreationDate datetime not null,

    DocumentID nvarchar(11) not null,

    constraint PoID foreign key (DocumentID) references Document(DocumentID) ON DELETE CASCADE

);

create table Applicant

(

    ApplicationID nvarchar(9) not null primary key,

    StudentNumber numeric(9) not null,

    constraint AaID foreign key (StudentNumber) references Student(StudentNumber) ON DELETE CASCADE

);



create table CoverLetter

(

    CLID int not null primary key,

    StudentNumber numeric(9) not null,

    DocumentID nvarchar(11) not null,

    constraint CleID foreign key (StudentNumber) references Student(StudentNumber) ON DELETE CASCADE,

    constraint CID foreign key (DocumentID) references Document(DocumentID) ON DELETE CASCADE

);



create table Department

(

    DepartmentID nvarchar(4) not null primary key,

    DepartmentName varchar(20) not null

);



create table Course

(

    CourseCode nvarchar(6) not null primary key,

    DescriptionText text not null,

    NQL int not null,

    DepartmentID nvarchar(4),

    constraint DaID foreign key (DepartmentID) references Department(DepartmentID) ON DELETE CASCADE

);



create table SemesterMark

(

    MarkID int not null primary key,

    SemesterNumber int not null,

    CourseID nvarchar(6) not null,

    PercentageMark numeric(3) not null,

    DocumentID nvarchar(11) not null,

    constraint CourID foreign key (CourseID) references Course(CourseCode) ON DELETE CASCADE,

    constraint CdD foreign key (DocumentID) references Document(DocumentID) ON DELETE CASCADE

);







create table AdmittanceLetter

(

    AdmID nvarchar(4) not null primary key,

    creation datetime not null,

    DocumentID nvarchar(11) not null,

    constraint AmintD foreign key (DocumentID) references Document(DocumentID) ON DELETE CASCADE

);

create table ApplicationForm

(

    AppID nvarchar(6) not null primary key,

    ApplicationID nvarchar(9) not null,

    ClearanceID int not null,

    PassportNumber int not null,

    CLID int not null,

    AdmID nvarchar(4) not null,

    MarkID int not null,

    constraint Adiml foreign key (AdmID) references AdmittanceLetter(AdmID) ON DELETE CASCADE,

	-- Prevent a cascade cascade
    constraint clearID foreign key (ClearanceID) references PoliceClearance(ClearanceID) ON DELETE NO ACTION,

    constraint pasid foreign key (PassportNumber) references Passport(PassportNumber) ON DELETE NO ACTION,

    constraint mark foreign key (MarkID) references SemesterMark(MarkID) ON DELETE NO ACTION,

    constraint Appid foreign key (ApplicationID) references Applicant(ApplicationID) ON DELETE CASCADE,

    constraint cccid foreign key (CLID) references CoverLetter(CLID) ON DELETE No Action

);


create table HeadOfDepartment

(

    HoDID nvarchar(6) not null primary key,

    StaffNumber numeric(9) not null,

    CourseCode nvarchar(6) not null,

    DepartmentID nvarchar(4)not null,

    constraint hodiD foreign key (CourseCode) references Course(CourseCode) ON DELETE No action,

    constraint hodiDD foreign key (StaffNumber) references Lecturer(StaffNumber) ON DELETE CASCADE,

    constraint hodSID foreign key (DepartmentID) references Department(DepartmentID) ON DELETE CASCADE

);



-- Need explanation

Create table PhysicalLocation

(

    LocationID varchar(13) not null primary key,

    LDescription text,

    Logitude decimal,

    Latitude decimal,

    Erf int not null,

    Street varchar(20) not null,

    Suburb varchar(20) not null,

    City varchar(20) not null,

    Region varchar(20) not null,

    Country varchar(20) not null

);

create table Office

(

    OfficeNumber int not null primary key,

    OfficePhoneNumber nvarchar(11) not null,

    EmailAddress varchar(20) not null,

    LocationID varchar(13) not null,

    constraint LocOffice foreign key (LocationID) references PhysicalLocation(LocationID) ON DELETE CASCADE

);

Create table InstituitionOffice

(

    OfficeNumber int not null,

    InstitutionID numeric(4) not null,

    constraint InstK Foreign key (InstitutionID) references Institution(InstitutionID) ON DELETE CASCADE,

    constraint OfficeK foreign key (OfficeNumber) references Office(OfficeNumber) ON DELETE CASCADE

);
END
GO
