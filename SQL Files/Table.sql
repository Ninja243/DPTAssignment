-- Table.sql
-- Defines the tables used in our database
-- TODO, foreign key constraints are weird

-- Create the database if it does not already exist
CREATE DATABASE ScholarshipHelperDB;
Go
USE ScholarshipHelperDB;


-- Skip above if DB exists

create table Person

(

    IDNumber numeric(11) primary key not null,

    Firstname varchar(20) not null,

    Lastname varchar(20) not null,

    DateOfBirth date not null

);

create table PersonAudit (
	AuditID integer Identity (1,1) primary key, 
	IDNumber numeric (11),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);

create table Student

(

    StudentNumber numeric(9) primary key not null,

    IDNumber numeric(11) not null,

    constraint StID foreign key (IDNumber) references Person(IDNumber) ON DELETE CASCADE

);

create table StudentAudit (
	AuditID integer Identity (1,1) primary key, 
	StudentNumber numeric(9),
	IDNumber numeric (11),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);

create table Lecturer

(

    StaffNumber numeric(9) primary key not null,

    IDNumber numeric(11) not null,

    constraint LeID foreign key (IDNumber) references Person(IDNumber) ON DELETE CASCADE

);

create table LecturerAudit (
	AuditID integer Identity (1,1) primary key, 
	StaffNumber numeric(9),
	IDNumber numeric (11),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
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

create table EmailAudit (
	AuditID integer Identity (1,1) primary key, 
	EmailID numeric(4),
	EmailSubject nvarchar(60),
	EmailText ntext,
	Sender varchar(20),
	Receiver varchar(20),
	IDNumber numeric (11),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);

create table Registrar

(

    RegistrarID numeric(9) primary key not null,

    StaffNumber numeric(9) not null,

    constraint RID foreign key (StaffNumber) references Lecturer(StaffNumber) ON DELETE CASCADE

);

create table RegistrarAudit (
	AuditID integer Identity (1,1) primary key, 
	RegistrarID numeric (9),
	StaffNumber numeric (9),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);


create table Institution

(

    InstitutionID numeric(4) not null primary key,

    InstitutionName varchar(50) not null,

    Acronym varchar(8)

);

create table InstitutionAudit (
	AuditID integer Identity (1,1) primary key,
	InstitutionID numeric (4),
	InstitutionName varchar(50),
	Acronym varchar(8),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);


create table Coordinator

(

    CoordinatorID numeric(9) not null primary key,

    InstitutionID numeric(4) not null,

    StaffNumber Numeric(9) not null,

    constraint InsID foreign key (InstitutionID) references Institution(InstitutionID) ON DELETE CASCADE,

    constraint ScID foreign key (StaffNumber) references Lecturer(StaffNumber) ON DELETE CASCADE

);

create table CoordinatorAudit (
	AuditID integer Identity (1,1) primary key, 
	CoordinatorID numeric(9),
	InstitutionID numeric(4),
	StaffNumber Numeric(9),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);

create table RawFile

(

    FileID int not null primary key,

    RawFileData varbinary not null,

    RawFileName varchar(20) not null

);

create table RawAudit (
	AuditID integer Identity (1,1) primary key, 
	FileID int,
	RawFileData varbinary,
	RawFileName varchar(20),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);

create table Document

(

    DocumentID nvarchar(11) not null primary key,

    DocumentDescription text null,
	FileID int not null,
    constraint Did foreign key (FileID) references RawFile(FileID) ON DELETE CASCADE

);

create table DocumentAudit (
	AuditID integer Identity (1,1) primary key, 
	DocumentID nvarchar(11),
	DocumentDescription text,
	FileID int,
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);

create table Passport

(

    PassportNumber int not null primary key,

    DocumentID nvarchar(11) not null,

    constraint PaID foreign key (DocumentID) references Document(DocumentID) ON DELETE CASCADE

);

create table PassportAudit (
	AuditID integer Identity (1,1) primary key, 
	PassportNumber int,
	DocumentID nvarchar(11),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);

create table PoliceClearance

(

    ClearanceID int not null primary key,

    ExpiryDate datetime not null,

    CreationDate datetime not null,

    DocumentID nvarchar(11) not null,

    constraint PoID foreign key (DocumentID) references Document(DocumentID) ON DELETE CASCADE

);

create table PoliceClearanceAudit (
	AuditID integer Identity (1,1) primary key, 
	ClearanceID int,
	CreationDate datetime,
	DocumentID nvarchar(11),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);

create table Applicant

(

    ApplicationID nvarchar(9) not null primary key,

    StudentNumber numeric(9) not null,

    constraint AaID foreign key (StudentNumber) references Student(StudentNumber) ON DELETE CASCADE

);

create table ApplicantAudit (
	AuditID integer Identity (1,1) primary key, 
	ApplicationID nvarchar(9),
	StudentNumber numeric (9),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);

create table CoverLetter

(

    CLID int not null primary key,

    StudentNumber numeric(9) not null,

    DocumentID nvarchar(11) not null,

    constraint CleID foreign key (StudentNumber) references Student(StudentNumber) ON DELETE CASCADE,

    constraint CID foreign key (DocumentID) references Document(DocumentID) ON DELETE CASCADE

);

create table CoverLetterAudit (
	AuditID integer Identity (1,1) primary key, 
	CLID int,
	StudentNumber numeric (9),
	DocumentID nvarchar(11),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);

create table Department

(

    DepartmentID nvarchar(4) not null primary key,

    DepartmentName varchar(20) not null

);

create table DepartmentAudit (
	AuditID integer Identity (1,1) primary key, 
	DepartmentID nvarchar(4),
	DepartmentName varchar(20),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);

create table Course

(

    CourseCode nvarchar(6) not null primary key,

    DescriptionText text not null,

    NQL int not null,

    DepartmentID nvarchar(4),

    constraint DaID foreign key (DepartmentID) references Department(DepartmentID) ON DELETE CASCADE

);

create table CourseAudit (
	AuditID integer Identity (1,1) primary key, 
	CourseCode nvarchar(6),
	DescriptionText text,
	NQL int,
	DepartmentID nvarchar (4),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
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

create table SemesterMarkAudit (
	AuditID integer Identity (1,1) primary key, 
	MarkID int,
	SemesterNumber int,
	CourseID nvarchar (6),
	PercentageMark numeric (3),
	DocumentID nvarchar(11),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);





create table AdmittanceLetter

(

    AdmID nvarchar(4) not null primary key,

    creation datetime not null,

    DocumentID nvarchar(11) not null,

    constraint AmintD foreign key (DocumentID) references Document(DocumentID) ON DELETE CASCADE

);

create table AdmittanceLetterAudit (
	AuditID integer Identity (1,1) primary key, 
	AdmID nvarchar(4),
	creation datetime,
	DocumentID nvarchar(11),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
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


create table ApplicationFormAudit (
	AuditID integer Identity (1,1) primary key, 
	AppID nvarchar(6),
	ApplicationID nvarchar(9),
	ClearanceID int,
	PassportNumber int,
	CLID int,
	AdmID nvarchar(4),
	MarkID int,
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
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

create table HeadOfDepartmentAudit (
	AuditID integer Identity (1,1) primary key, 
	HoDID nvarchar(6),
	StaffNumber numeric (9),
	CourseCode nvarchar (6),
	DepartmentID nvarchar (4),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);


-- Need explanation

Create table PhysicalLocation

(

    LocationID varchar(13) not null primary key,

    LDescription text,

    Longitude decimal,

    Latitude decimal,

    Erf int not null,

    Street varchar(20) not null,

    Suburb varchar(20) not null,

    City varchar(20) not null,

    Region varchar(20) not null,

    Country varchar(20) not null

);

create table PhysicalLocationAudit (
	AuditID integer Identity (1,1) primary key, 
	LocationID varchar(13),
	LDescription text,
	Longitude decimal,
	Latitude decimal,
	Erf int,
	Street varchar (20),
	Suburb varchar (20),
	City varchar (20),
	Region varchar(20),
	Country varchar(20),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);

create table Office

(

    OfficeNumber int not null primary key,

    OfficePhoneNumber nvarchar(11) not null,

    EmailAddress varchar(20) not null,

    LocationID varchar(13) not null,

    constraint LocOffice foreign key (LocationID) references PhysicalLocation(LocationID) ON DELETE CASCADE

);

create table OfficeAudit (
	AuditID integer Identity (1,1) primary key, 
	OfficeNumber int,
	OfficePhoneNumber nvarchar(11),
	EmailAddress varchar(20),
	LocationID varchar(13),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);

Create table InstituitionOffice

(

    OfficeNumber int not null,

    InstitutionID numeric(4) not null,

    constraint InstK Foreign key (InstitutionID) references Institution(InstitutionID) ON DELETE CASCADE,

    constraint OfficeK foreign key (OfficeNumber) references Office(OfficeNumber) ON DELETE CASCADE

);

create table InstitutionAudit (
	AuditID integer Identity (1,1) primary key, 
	OfficeNumber int,
	InstitutionID numeric(4),
	UpdatedBy nvarchar(128),
	UpdatedOn datetime
);