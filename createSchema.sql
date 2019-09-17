Create table Office(
OfficeCode varchar(5) Primary Key,
PhoneNumber int(10),
EmailAddress varchar(30),
LocationID varchar(13) Foerign Key,
)

Create table PhysicalLocation(
Desription text,
Latitude decimal,
Longitude decimal,
HouseNumber int,
StreetName varchar(30),
Suburb varcahar(30),
City varchar(30),
RegionName varchar(30),
Country varchar(30),
)

Create table InstitutionAndOffice(
InstitutionID varchar(30),
OfficeCode varchar(30) Foreign Key,
)

Create table Institution(
InstitutionID varchar(13) Primary Key,
Name varchar(30),
Arconym varchar(30),
)

Create table Coordinator(
CoordinatorID varchar(13) Primary Key,
InstitutionID  varchar(13),
StaffNumber int(15),
)

Create table Person(
IDNumber int(11) Primary Key,
Firstname varchar(20),
Lastname varchar(30),
DateofBirth datetime,
EmailAddress varchar(30),
)

Create table Email(
EmailID varchar(30) Primary Key ,
Subject varchar(30),
Text text ,
Sender varchar(30),
IDNumber int(30) Foreign Key,
DocumentID varchar(40) Foreign Key,
)

Create table Document(
Document Text,
FileID varchar(20) foreign key,
)

Create table Lecturer(
StaffNumber int(20) Primary Key,
IDNumber int(20) foreign key,
)

Create table RawFile(
FileID varchar(20) Primary key,
Data varbinary,
FileName varchar(20),
)

Create table Registrar(
RegistrarID varchar(10) Primary Key,
StaffNumber int(15) Foreign key,
)

Create table HeadofDepartment(
HeadofDepartmentID varchar(7) Primary key,
StaffNuber int(9) foreign key,
CourseDepartmentID varchar(25) foreign key,
)

Create table BirthCertificate(
BirthNumber int(15) Primary key,
DocumentID varchar(18),
)

Create table PoliceClearance(
ClearanceID varchar(17) Primary key,
ExpiryDate datetime,
CreationDate datetime,
DocumentID varchar(18),
)

Craete table Passport(
PassportNumber varchar(15) Primary key,
DocumentID varchar(25) foreign key,
)

Create table Application9
ApplicationID varchar(13) Primary key,
ApplicantID varchar(15) foreign key,
ClearanceID varchar(17) foreign key,
PassportNumber varchar(15) foreign key,
CoverLetterID varchar918) foreign key,
AdmittanceID varchar(17) foreign key,
MarkID varchar(18) foreign key,
)

Create table Department(
CourseDepartmentID varchar980 Primary key,
SubjectCode varchar(8) foreign key,
)

Craete table SemesterMarks(
MarkID varchar(13) Primary key,
SemesterNumber int(100,
SubjectCode varchar(10) foreign key,
PercentageMark numeric,
DocumentID varchar(19) foreign key,
)

Create table Course(
SubjectCode varchar(7) Primary key,
NQFLevel int(7),
)

Create table AdmittanceLetter(
AdmittanceID varchar(20) Primary key,
ApplicantID varchar(23) foreign key,
DocumentID varchar(18) foreign key,
)

Create table Applicant(
ApplicantID varchar(20) Primary key,
StudentNumber int(12) foreign key,
)

Create table CoverLetter(
CoverLetterID varchar(18) Primary key,
Text text,
DocumentID varchar(19) foreign key,
StudentNumber int(15) foreign key,
)

Create table Student(
StudentNumber int(18) Primary key,
IDNumber int(20) foreign key,
)

