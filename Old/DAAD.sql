create table Person (IDNumber numeric(11) primary key not null,
Firstname varchar(20),
Lastname varchar(20), 
DateOFBirth date);


GO
Create Procedure SpPerson
@Firstname varchar(20),
@Lastname varchar(20), 
@DateOFBirth date
AS
BEGIN

SET NOCOUNT ON;
INSERT INTO  Person (Firstname,Lastname,DateOFBirth)
VALUES (@Firstname,@Lastname,@DateOFBirth)
END 
GO



create table Student( 
StudentNumber numeric(9) primary key not null,
IDNumber numeric(11) null 
constraint StID foreign key (IDNumber) references Person(IDnumber));

CREATE TRIGGER STUD
ON Student
AFTER INSERT  
AS
BEGIN 
INSERT INTO Student_BACKUP
SELECT * FROM INSERTED
END
GO

GO
Create Procedure SpStud
@StudentNumber numeric(9),
@IDNumber numeric(11)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO  Stud (StudentNumber,IDNumber)
VALUES (@StudentNumber,@IDNumber)
END 
GO


create table Lecturer( 
SaffNumber numeric(9) primary key not null,
IDNumber numeric(11) null 
constraint LeID foreign key (IDNumber) references Person(IDnumber));

GO
Create Procedure Splect
@SaffNumber numeric(9),
@IDNumber numeric(11)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO  lect (SaffNumber,IDNumber)
VALUES (@SaffNumber,@IDNumber)
END 
GO

create table Email(EmailID numeric(4) primary key not null,
EmailSubject nvarchar(60) null,
EmaillText ntext not null,
Sender varchar(20) not null,
Receiver varchar(20) not null,
IDNumber numeric(11)
constraint EID foreign key (IDNumber) references Person(IDNumber))



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
INSERT INTO  Mail (EmailID,EmailSubject,Sender,Receiver,IDNumber)
VALUES (@EmailID,@EmailSubject,@Sender,@Receiver,@IDNumber)
END 
GO
--
create table Registrar (
RegistrarID numeric(9) primary key not null, 
StaffNumber numeric(9) not null
constraint RID foreign key (StaffNumber) references Lecturer(SaffNumber))

GO
Create Procedure SpReg
@RegistrarID numeric(9),
@StaffNumber numeric(9)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO  Reg (RegistrarID,StaffNumber)
VALUES (@RegistrarID,@StaffNumber)
END 
GO

create table Institution (
InstitutionID numeric(4) not null primary key,
Name varchar(50) not null,
Acronym varchar(8)) 

GO
Create Procedure SpInsti
@InstitutionID numeric(4),
@Name varchar(50),
@Acronym varchar(8)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO  Insti (InstitutionID,Name,Acronym)
VALUES (@InstitutionID,@Name,@Acronym)
END 
GO
create table Coordinator (
CoordinatorID numeric(9) not null primary key,
InstitutionID numeric(4) not null,
StaffNumber Numeric(9) not null
constraint InsID foreign key (InstitutionID) references Institution(InstitutionID),
constraint ScID foreign key (StaffNumber) references Lecturer(SaffNumber))

GO
Create Procedure SpCoor
@CoordinatorID numeric(9),
@InstitutionID numeric(4),
@StaffNumber Numeric(9)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO  Coor (CoordinatorID,InstitutionID,StaffNumber)
VALUES (@CoordinatorID,@InstitutionID,@StaffNumber)
END 
GO
create table Document (DocumentID nvarchar(11) not null primary key,
Description text null)

GO
Create Procedure SpDocu
@DocumentID nvarchar(11),
@Description text
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO  Docu (DocumentID,Description)
VALUES (@DocumentID,@Description)
END 
GO
create table BirthCertificate ( BCNumber int not null primary key,
DocumentID nvarchar(11) not null
constraint BCID foreign key (DocumentID) references Document(DocumentID))

GO
Create Procedure SpBirth
@BCNumber numeric(30),
@DocumentID nvarchar(11)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO  Birth (BCNumber,DocumentID)
VALUES (@BCNumber,@DocumentID)
END 
GO
create table Passport ( PassportNumber int not null primary key,
DocumentID nvarchar(11) not null
constraint PaID foreign key (DocumentID) references Document(DocumentID))

GO
Create Procedure SpPass
@PassportNumber int,
@DocumentID nvarchar(11)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO  Pass (PassportNumber,DocumentID)
VALUES (@PassportNumber,@DocumentID)
END 
GO
create table PoliceClearance( CllearanceID int not null primary key,
ExpiryDate datetime not null,
CreationDate datetime,
DocumentID nvarchar(11) not null
constraint PoID foreign key (DocumentID) references Document(DocumentID))

GO
Create Procedure SpPolice
@CllearanceID int,
@ExpiryDate datetime,
@DocumentID nvarchar(11)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO  Police (CllearanceID,ExpiryDate,DocumentID)
VALUES (@CllearanceID,@ExpiryDate,@DocumentID)
END 
GO
create table RawFile ( FileID int not null primary key,
Data varbinary not null,
FileName varchar(20))
GO
Create Procedure SpRaw
@FileID int,
@Data varbinary,
@FileName varchar(20)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO  Raw (FileID,Data,FileName)
VALUES (@FileID,@Data,@FileName)
END 
GO
alter table document add constraint Did foreign key (FileID) references rawfile(fileid)

create table Applicant (ApplicationID nvarchar(9) not null primary key,
StudentNumber numeric(9) not null
constraint AaID foreign key (StudentNumber) references Student(StudentNumber))
GO
Create Procedure SpAppl
@ApplicationID nvarchar(9),
@StudentNumber numeric(9)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO  Appl (ApplicationID,StudentNumber)
VALUES (@ApplicationID,@StudentNumber)
END 
GO
create table CoverLetter (CLID int not null primary key,
StudentNumber numeric(9) not null,
DocumentID nvarchar(11) not null
constraint CleID foreign key (StudentNumber) references Student(StudentNumber),
constraint CID foreign key (DocumentID) references Document(DocumentID))
GO
Create Procedure SpCover
@CLID int,
@StudentNumber numeric(9),
@DocumentID nvarchar(11)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO  Cover (CLID,StudentNumber,DocumentID)
VALUES (@CLID,@StudentNumber,@DocumentID)
END 
GO
create table Department (DepaartmentID nvarchar(4) not null primary key,
DepartmentName varchar(20))
GO
Create Procedure SpDept
@DepaartmentID nvarchar(4),
@DepartmentName varchar(20)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO  Dept (DepaartmentID,DepartmentName)
VALUES (@DepaartmentID,@DepartmentName)
END 
GO
create table Course(CourseCode nvarchar(6) not null primary key,
DescriptionText text not null,
NQL int,
DepartmentID nvarchar(4)
constraint DaID foreign key (DepartmentID) references Department(DepaartmentID))
GO
Create Procedure SpCos
@CourseCode nvarchar(6),
@Description Text ,
@NQL int,
@DepartmentID nvarchar(4)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO Cos (CourseCode,DescriptionText,NQL,DepartmentID)
VALUES (@CourseCode,@Description,@NQL,@DepartmentID)
END 
GO
create table SemesterMark(MarkID int not null primary key,
SemesterNumber int not null,
CourseID nvarchar(6) not null,
PercentageMark numeric(3),
DocumentID nvarchar(11)
constraint CourID foreign key (CourseID) references Course(CourseCode),
constraint CdD foreign key (DocumentID) references Document(DocumentID))

CREATE TRIGGER MARKS
ON SemesterMark
AFTER INSERT  
AS 
BEGIN 
INSERT INTO SemesterMark_BACKUP
SELECT * FROM INSERTED
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
SELECT * FROM SemesterMark where PercentageMark = @PercentageMark
END
ELSE
BEGIN
Print 'NOT ELIGIBLE TO BE AWARDED THE DAAD SCHOLARSHIP'
END
SET NOCOUNT ON;
INSERT INTO Mark (MarkID,SemesterNumber,PercentageMark,DocumentID)
VALUES (@MarkID,@SemesterNumber,@CourseID,@PercentageMark,@DocumentID)
END 
GO

create table ApplicationForm(
AppID nvarchar(6) not null primary key,
ApplicationID nvarchar(9) not null,
CllearanceID int not null,
PassportNumber int not null,
CLID int not null,
AdmID nvarchar(4) not null,
MarkID int not null

constraint Adiml foreign key (AdmID) references AdimittanceLetter(AdmID),
constraint clearID foreign key (CllearanceID) references PoliceClearance(CllearanceID),
constraint pasid foreign key (PassportNumber) references Passport(PassportNumber),
constraint mark foreign key (MarkID) references SemesterMark(MarkID),
constraint Appid foreign key (ApplicationID) references Applicant(ApplicationID),
constraint cccid foreign key (CLID) references CoverLetter(CLID)
)
CREATE TRIGGER APPFORM
ON ApplicationForm
AFTER INSERT  
AS
BEGIN 
INSERT INTO ApplicationForm_BACKUP
SELECT * FROM INSERTED
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
INSERT INTO form (AppID,ApplicationID,CllearanceID,PassportNumber,CLID,AdmID,MarkID)
VALUES (@AppID,@ApplicationID,@CllearanceID,@PassportNumber,@CLID,@AdmID,@MarkID)
END 
GO


create table AdimittanceLetter (
AdmID nvarchar(4) not null primary key,
creation datetime not null,
DocumentID nvarchar(11) not null
constraint AmintD foreign key (DocumentID) references Document(DocumentID))

CREATE TRIGGER PROOF_LETTER
ON AdimittanceLetter
AFTER INSERT  
AS 
BEGIN 
INSERT INTO AdimittanceLetter_BACKUP
SELECT * FROM INSERTED
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
INSERT INTO Adm (AdmID,creation,DocumentID)
VALUES (@AdmID,@creation,@DocumentID)
END 
GO
create table HeadOfDepartment (HoDID nvarchar(6) not null primary key,
StaffNumber numeric(9) not null,
CourseCode nvarchar(6) not null, 
DepartmentID nvarchar(4)not null

constraint hodiD foreign key (CourseCode) references Course(CourseCode),
constraint hodiDD foreign key (StaffNumber) references Lecturer(SaffNumber),
constraint hodSID foreign key (DepartmentID) references Department(DepaartmentID))
GO
Create Procedure SpHod
@HoDID nvarchar(6),
@StaffNumber numeric(9),
@CourseCode nvarchar(6),
@DepartmentID nvarchar(4)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO Hod (HoDID,StaffNumber,CourseCode,DepartmentID)
VALUES (@HoDID,@StaffNumber,@CourseCode,@DepartmentID)
END 
GO
create table Office (OfficeNumber int not null primary key,
OfficePhoneNumber nvarchar(11) not null,
EmailAddress varchar(20));
GO
Create Procedure SpFicer
@OfficeNumber int,
@OfficePhoneNumber nvarchar(11),
@EmailAddress varchar(20)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO Office (OfficeNumber,OfficePhoneNumber,EmailAddress)
VALUES (@OfficeNumber,@OfficePhoneNumber,@EmailAddress)
END 
GO
Create table PhysicalLocation (LocationID varchar(13) not null primary key,
LDescription text,
Logitude decimal,
Latitude decimal,
Erf int not null,
Street varchar(20) not null,
Suburb varchar(20) not null,
City varchar(20),
Region varchar(20),
Country varchar(20))

Create table InstituitionOffice (OfficeNumber int not null,
InstitutionID numeric(4) not null
Constraint InstK Foreign key (InstitutionID) references Institution(InstitutionID),
Constraint OfficeK foreign key (OfficeNumber) references Office(OfficeNumber))

alter table Office add LocationID varchar(13) not null
constraint LocOffice foreign key (LocationID) references PhysicalLocation(LocationID) 

alter table Email alter column IDnumber numeric(11) not null

alter table person alter column dateofbirth date not null

alter table person alter column firstname varchar(20) not null

alter table person alter column lastname varchar(20) not null

alter table Student alter column IDnumber numeric(11) not null

alter table Lecturer alter column IDnumber numeric(11) not null

alter table Department alter column DepartmentName varchar(20) not null

alter table policeClearance alter column creationdate datetime not null

alter table rawfile alter column filename varchar(20) not null

alter table course alter column nql int not null
                                                                
alter table semestermark alter column PercentageMark numeric(3)not null
                                                                
alter table semestermark alter column DocumentID nvarchar(11) not null
                                                                
alter table office alter column EmailAddress varchar(20) not null
