-- Triggers.sql
-- Contains triggers that run when a certain action has been performed

create trigger TriggerAdminTableAudit
on AdminTable
after update,insert
as
begin
	insert into AdminTableAudit (
		AdminUsername, AdminPassword, UpdatedBy, UpdatedOn) select i.AdminUsername, i.AdminPassword, SUSER_SNAME(), GETDATE()
		From AdminTable t inner join inserted i on t.AdminUsername=i.AdminUsername;
end
go

create trigger TriggerPersonAudit
on Person 
after update,insert 
as 
begin 
	insert into PersonAudit (
	Firstname, 
	Lastname, 
	DateOfBirth,
	UpdatedBy,
	UpdatedOn) 
	select i.Firstname, i.Lastname, i.DateOfBirth, SUSER_SNAME(), getdate() 
	from Person t inner join inserted i on t.Firstname=i.Firstname;
end
go

create trigger TriggerAdmittanceLetterAudit
on AdmittanceLetter 
after update,insert 
as 
begin 
	insert into AdmittanceLetterAudit (
	AdmID, 
	creation, 
	DocumentID,
	UpdatedBy,
	UpdatedOn) 
	select i.AdmID, i.creation, i.DocumentID, SUSER_SNAME(), getdate() 
	from AdmittanceLetter t inner join inserted i on t.AdmID=i.AdmID;
end
go

create trigger TriggerApplicantAudit
on Applicant 
after update,insert 
as 
begin 
	insert into ApplicantAudit (
	ApplicationID, 
	StudentNumber, 
	UpdatedBy,
	UpdatedOn) 
	select i.ApplicationID, i.StudentNumber, SUSER_SNAME(), getdate() 
	from Applicant t inner join inserted i on t.ApplicationID=i.ApplicationID;
end
go

create trigger TriggerApplicationFormAudit
on ApplicationForm 
after update,insert 
as 
begin 
	insert into ApplicationFormAudit (
	AppID, 
	ApplicationID, 
	ClearanceID,
	PassportNumber,
	CLID,
	MarkID,
	AdmID,
	UpdatedBy,
	UpdatedOn) 
	select i.AppID, i.ApplicationID, i.ClearanceID, i.PassportNumber, i.CLID, i.MarkID, i.AdmID,  SUSER_SNAME(), getdate() 
	from ApplicationForm t inner join inserted i on t.AppID=i.AppID;
end
go

create trigger TriggerCoordinatorAudit
on Coordinator 
after update,insert 
as 
begin 
	insert into CoordinatorAudit (
	CoordinatorID, 
	InstitutionID, 
	StaffNumber,
	UpdatedBy,
	UpdatedOn) 
	select i.CoordinatorID, i.InstitutionID, i.StaffNumber, SUSER_SNAME(), getdate() 
	from Coordinator t inner join inserted i on t.CoordinatorID=i.CoordinatorID;
end
go

create trigger TriggerCourseAudit
on Course 
after update,insert 
as 
begin 
	insert into CourseAudit (
	CourseCode, 
	NQL,
	DepartmentID, 
	UpdatedBy,
	UpdatedOn) 
	select i.CourseCode, i.NQL, i.DepartmentID, SUSER_SNAME(), getdate() 
	from Course t inner join inserted i on t.CourseCode=i.CourseCode;
end
go

create trigger TriggerCoverLetterAudit
on CoverLetter 
after update,insert 
as 
begin 
	insert into CoverLetterAudit (
	CLID, 
	StudentNumber, 
	DocumentID,
	UpdatedBy,
	UpdatedOn) 
	select i.CLID, i.StudentNumber, i.DocumentID, SUSER_SNAME(), getdate() 
	from CoverLetter t inner join inserted i on t.CLID=i.CLID;
end
go

create trigger TriggerDepartmentAudit
on Department 
after update,insert 
as 
begin 
	insert into DepartmentAudit (
	DepartmentID, 
	DepartmentName, 
	UpdatedBy,
	UpdatedOn) 
	select i.DepartmentID, i.DepartmentName, SUSER_SNAME(), getdate() 
	from Department t inner join inserted i on t.DepartmentID=i.DepartmentID;
end
go

create trigger TriggerDocumentAudit
on Document 
after update,insert 
as 
begin 
	insert into DocumentAudit (
	DocumentID,  
	FileID,
	UpdatedBy,
	UpdatedOn) 
	select i.DocumentID, i.FileID, SUSER_SNAME(), getdate() 
	from Document t inner join inserted i on t.DocumentID=i.DocumentID;
end
go



create trigger TriggerEmailAudit
on Email 
after update,insert 
as 
begin 
	insert into EmailAudit (
	EmailID, 
	EmailSubject, 
	Sender,
	Receiver,
	IDNumber,
	UpdatedBy,
	UpdatedOn) 
	select i.EmailID, i.EmailSubject, i.Sender, i.Receiver, i.IDNumber, SUSER_SNAME(), getdate() 
	from Email t inner join inserted i on t.EmailID=i.EmailID;
end
go

create trigger TriggerHeadOfDepartmentAudit
on HeadOfDepartment 
after update,insert 
as 
begin 
	insert into HeadOfDepartmentAudit (
	HoDID, 
	StaffNumber, 
	CourseCode,
	DepartmentID,
	UpdatedBy,
	UpdatedOn) 
	select i.HoDID, i.StaffNumber, i.CourseCode, i.DepartmentID, SUSER_SNAME(), getdate() 
	from HeadOfDepartment t inner join inserted i on t.HoDID=i.HoDID;
end
go

create trigger TriggerInstitutionAudit
on Institution 
after update,insert 
as 
begin 
	insert into InstitutionAudit (
	InstitutionID, 
	InstitutionName, 
	Acronym,
	UpdatedBy,
	UpdatedOn) 
	select i.InstitutionID, i.InstitutionName, i.Acronym, SUSER_SNAME(), getdate() 
	from Institution t inner join inserted i on t.InstitutionID=i.InstitutionID;
end
go

create trigger TriggerLecturerAudit
on Lecturer 
after update,insert 
as 
begin 
	insert into LecturerAudit (
	StaffNumber, 
	IDNumber, 
	UpdatedBy,
	UpdatedOn) 
	select i.StaffNumber, i.IDNumber, SUSER_SNAME(), getdate() 
	from Lecturer t inner join inserted i on t.StaffNumber=i.StaffNumber;
end
go

create trigger TriggerOfficeAudit
on Office 
after update,insert 
as 
begin 
	insert into OfficeAudit (
	OfficeNumber, 
	OfficePhoneNumber, 
	EmailAddress,
	LocationID,
	UpdatedBy,
	UpdatedOn) 
	select i.OfficeNumber, i.OfficePhoneNumber, i.EmailAddress, i.LocationID, SUSER_SNAME(), getdate() 
	from Office t inner join inserted i on t.OfficeNumber=i.OfficeNumber;
end
go

create trigger TriggerPassportAudit
on Passport
after update,insert 
as 
begin 
	insert into PassportAudit (
	PassportNumber, 
	DocumentID, 
	UpdatedBy,
	UpdatedOn) 
	select i.PassportNumber, i.DocumentID, SUSER_SNAME(), getdate() 
	from Passport t inner join inserted i on t.PassportNumber=i.PassportNumber;
end
go

create trigger TriggerPhysicalLocationAudit
on PhysicalLocation 
after update,insert 
as 
begin 
	insert into PhysicalLocationAudit (
	LocationID, 
	Longitude,
	Latitude,
	Erf,
	Street,
	Suburb,
	City,
	Region,
	Country,
	UpdatedBy,
	UpdatedOn) 
	select i.LocationID, i.Longitude, i.Latitude, i.Erf, i.Street, i.Suburb, i.City, i.Region, i.Country, SUSER_SNAME(), getdate() 
	from PhysicalLocation t inner join inserted i on t.LocationID=i.LocationID;
end
go

create trigger TriggerPoliceClearanceAudit
on PoliceClearance 
after update,insert 
as 
begin 
	insert into PoliceClearanceAudit (
	ClearanceID, 
	ExpiryDate, 
	CreationDate,
	DocumentID,
	UpdatedBy,
	UpdatedOn) 
	select i.ClearanceID, i.ExpiryDate, i.CreationDate, i.DocumentID, SUSER_SNAME(), getdate() 
	from PoliceClearance t inner join inserted i on t.ClearanceID=i.ClearanceID;
end
go



create trigger TriggerRawFileAudit
on RawFile 
after update,insert 
as 
begin 
	insert into RawFileAudit (
	FileID, 
	RawFileData, 
	RawFileName,
	UpdatedBy,
	UpdatedOn) 
	select i.FileID, i.RawFileData, i.RawFileName, SUSER_SNAME(), getdate() 
	from RawFile t inner join inserted i on t.FileID=i.FileID;
end
go


create trigger TriggerRegistrarAudit
on Registrar 
after update,insert 
as 
begin 
	insert into RegistrarAudit (
	RegistrarID, 
	StaffNumber, 
	UpdatedBy,
	UpdatedOn) 
	select i.RegistrarID, i.StaffNumber, SUSER_SNAME(), getdate() 
	from Registrar t inner join inserted i on t.RegistrarID=i.RegistrarID;
end
go

create trigger TriggerSemesterMarkAudit
on SemesterMark 
after update,insert 
as 
begin 
	insert into SemesterMarkAudit (
	MarkID, 
	SemesterNumber, 
	CourseID,
	PercentageMark,
	DocumentID,
	UpdatedBy,
	UpdatedOn) 
	select i.MarkID, i.SemesterNumber, i.CourseID, i.PercentageMark, i.DocumentID, SUSER_SNAME(), getdate() 
	from SemesterMark t inner join inserted i on t.MarkID=i.MarkID;
end
go

create trigger TriggerStudentAudit
on Student 
after update,insert 
as 
begin 
	insert into StudentAudit (
	StudentNumber, 
	IDNumber, 
	UpdatedBy,
	UpdatedOn) 
	select i.StudentNumber, i.IDNumber, SUSER_SNAME(), getdate() 
	from Student t inner join inserted i on t.StudentNumber=i.StudentNumber;
end
go
-- 
--
--
--CREATE TRIGGER STUD
--ON Student
--AFTER INSERT  
--AS
--BEGIN
--    INSERT INTO Student_BACKUP
--    SELECT *
--    FROM INSERTED
--END
--GO
--
--CREATE TRIGGER MARKS
--ON SemesterMark
--AFTER INSERT  
--AS 
--BEGIN
--    INSERT INTO SemesterMark_BACKUP
--    SELECT *
--    FROM INSERTED
--END
--GO

--CREATE TRIGGER APPFORM
--ON ApplicationForm
--AFTER INSERT  
--AS
--BEGIN
--    INSERT INTO ApplicationForm_BACKUP
--    SELECT *
--    FROM INSERTED
--END
--GO

--CREATE TRIGGER PROOF_LETTER
--ON AdimittanceLetter
--AFTER INSERT  
--AS 
--BEGIN
--    INSERT INTO AdimittanceLetter_BACKUP
--    SELECT *
--    FROM INSERTED
--END
--GO