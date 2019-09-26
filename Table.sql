-- Table.sql
-- Defines the tables used in our database

-- TODO, foreign key constraints are weird
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
    constraint StID foreign key (IDNumber) references Person(IDNumber)
);

create table Lecturer
(
    StaffNumber numeric(9) primary key not null,
    IDNumber numeric(11) not null,
    constraint LeID foreign key (IDNumber) references Person(IDNumber)
);

create table Email
(
    EmailID numeric(4) primary key not null,
    EmailSubject nvarchar(60) null,
    EmailText ntext not null,
    Sender varchar(20) not null,
    Receiver varchar(20) not null,
    IDNumber numeric(11) not null,
    constraint EID foreign key (IDNumber) references Person(IDNumber)
);

create table Registrar
(
    RegistrarID numeric(9) primary key not null,
    StaffNumber numeric(9) not null,
    constraint RID foreign key (StaffNumber) references Lecturer(StaffNumber)
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
    constraint InsID foreign key (InstitutionID) references Institution(InstitutionID),
    constraint ScID foreign key (StaffNumber) references Lecturer(StaffNumber)
);

-- TODO
create table Document
(
    DocumentID nvarchar(11) not null primary key,
    Description text null,
    constraint Did foreign key (FileID) references rawfile(FileID)
);

create table Passport
(
    PassportNumber int not null primary key,
    DocumentID nvarchar(11) not null,
    constraint PaID foreign key (DocumentID) references Document(DocumentID)
);

create table PoliceClearance
(
    ClearanceID int not null primary key,
    ExpiryDate datetime not null,
    CreationDate datetime not null,
    DocumentID nvarchar(11) not null,
    constraint PoID foreign key (DocumentID) references Document(DocumentID)
);

create table RawFile
(
    FileID int not null primary key,
    Data varbinary not null,
    FileName varchar(20) not null
);

create table Applicant
(
    ApplicationID nvarchar(9) not null primary key,
    StudentNumber numeric(9) not null,
    constraint AaID foreign key (StudentNumber) references Student(StudentNumber)
);

create table CoverLetter
(
    CLID int not null primary key,
    StudentNumber numeric(9) not null,
    DocumentID nvarchar(11) not null,
    constraint CleID foreign key (StudentNumber) references Student(StudentNumber),
    constraint CID foreign key (DocumentID) references Document(DocumentID)
);

create table Department
(
    DepaartmentID nvarchar(4) not null primary key,
    DepartmentName varchar(20) not null
);

create table Course
(
    CourseCode nvarchar(6) not null primary key,
    DescriptionText text not null,
    NQL int not null,
    DepartmentID nvarchar(4),
    constraint DaID foreign key (DepartmentID) references Department(DepartmentID)
);

create table SemesterMark
(
    MarkID int not null primary key,
    SemesterNumber int not null,
    CourseID nvarchar(6) not null,
    PercentageMark numeric(3) not null,
    DocumentID nvarchar(11) not null,
    constraint CourID foreign key (CourseID) references Course(CourseCode),
    constraint CdD foreign key (DocumentID) references Document(DocumentID)
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
    constraint Adiml foreign key (AdmID) references AdmittanceLetter(AdmID),
    constraint clearID foreign key (CllearanceID) references PoliceClearance(CllearanceID),
    constraint pasid foreign key (PassportNumber) references Passport(PassportNumber),
    constraint mark foreign key (MarkID) references SemesterMark(MarkID),
    constraint Appid foreign key (ApplicationID) references Applicant(ApplicationID),
    constraint cccid foreign key (CLID) references CoverLetter(CLID)
);

create table AdmittanceLetter
(
    AdmID nvarchar(4) not null primary key,
    creation datetime not null,
    DocumentID nvarchar(11) not null,
    constraint AmintD foreign key (DocumentID) references Document(DocumentID)
);

create table HeadOfDepartment
(
    HoDID nvarchar(6) not null primary key,
    StaffNumber numeric(9) not null,
    CourseCode nvarchar(6) not null,
    DepartmentID nvarchar(4)not null,
    constraint hodiD foreign key (CourseCode) references Course(CourseCode),
    constraint hodiDD foreign key (StaffNumber) references Lecturer(StaffNumber),
    constraint hodSID foreign key (DepartmentID) references Department(DepartmentID)
);

-- Need explanation
create table Office
(
    OfficeNumber int not null primary key,
    OfficePhoneNumber nvarchar(11) not null,
    EmailAddress varchar(20) not null,
    LocationID varchar(13) not null,
    constraint LocOffice foreign key (LocationID) references PhysicalLocation(LocationID)
);

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

Create table InstituitionOffice
(
    OfficeNumber int not null,
    InstitutionID numeric(4) not null,
    constraint InstK Foreign key (InstitutionID) references Institution(InstitutionID),
    constraint OfficeK foreign key (OfficeNumber) references Office(OfficeNumber)
);
