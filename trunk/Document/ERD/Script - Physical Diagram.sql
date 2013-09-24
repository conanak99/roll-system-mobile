USE [master]
GO
/****** Object:  Database [RSM]    Script Date: 09/24/2013 15:53:16 ******/
CREATE DATABASE [RSM] ON  PRIMARY 
( NAME = N'RSM', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\RSM.mdf' , SIZE = 2304KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'RSM_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\RSM_log.LDF' , SIZE = 768KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [RSM] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RSM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RSM] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [RSM] SET ANSI_NULLS OFF
GO
ALTER DATABASE [RSM] SET ANSI_PADDING OFF
GO
ALTER DATABASE [RSM] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [RSM] SET ARITHABORT OFF
GO
ALTER DATABASE [RSM] SET AUTO_CLOSE ON
GO
ALTER DATABASE [RSM] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [RSM] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [RSM] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [RSM] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [RSM] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [RSM] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [RSM] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [RSM] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [RSM] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [RSM] SET  ENABLE_BROKER
GO
ALTER DATABASE [RSM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [RSM] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [RSM] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [RSM] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [RSM] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [RSM] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [RSM] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [RSM] SET  READ_WRITE
GO
ALTER DATABASE [RSM] SET RECOVERY SIMPLE
GO
ALTER DATABASE [RSM] SET  MULTI_USER
GO
ALTER DATABASE [RSM] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [RSM] SET DB_CHAINING OFF
GO
USE [RSM]
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Subject](
	[SubjectID] [int] NOT NULL,
	[ShortName] [nvarchar](10) NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[NumberOfSlot] [int] NOT NULL,
	[Description] [char](10) NULL,
 CONSTRAINT [Subject_PK] PRIMARY KEY CLUSTERED 
(
	[SubjectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] NOT NULL,
	[RoleName] [nvarchar](10) NOT NULL,
 CONSTRAINT [Role_PK] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Major]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Major](
	[MajorID] [int] NOT NULL,
	[ShortName] [char](2) NULL,
	[FullName] [varchar](30) NOT NULL,
 CONSTRAINT [Major_PK] PRIMARY KEY CLUSTERED 
(
	[MajorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LogType]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogType](
	[TypeID] [int] NOT NULL,
	[TypeName] [nvarchar](10) NULL,
 CONSTRAINT [LogType_PK] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Semester]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Semester](
	[SemesterID] [int] NOT NULL,
	[SemesterName] [varchar](15) NOT NULL,
	[BeginDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
 CONSTRAINT [Semester_PK] PRIMARY KEY CLUSTERED 
(
	[SemesterID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Class]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Class](
	[ClassID] [int] NOT NULL,
	[MajorID] [int] NOT NULL,
	[ClassName] [char](5) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [Class_PK] PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] NOT NULL,
	[Username] [nvarchar](30) NOT NULL,
	[Password] [nvarchar](30) NOT NULL,
	[RoleID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [User_PK] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubjectMajorMapping]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectMajorMapping](
	[MajorID] [int] NOT NULL,
	[SubjectID] [int] NOT NULL,
 CONSTRAINT [SubjectMajorMapping_PK] PRIMARY KEY CLUSTERED 
(
	[MajorID] ASC,
	[SubjectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Student](
	[StudentID] [int] NOT NULL,
	[ClassID] [int] NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Birthdate] [datetime] NOT NULL,
	[CitizenID] [char](8) NOT NULL,
	[Address] [nvarchar](100) NULL,
	[Email] [nvarchar](50) NULL,
	[IsActive] [bit] NOT NULL,
	[UserID] [int] NULL,
	[StudentCode] [char](7) NOT NULL,
 CONSTRAINT [Student_PK] PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Student] ON [dbo].[Student] 
(
	[StudentCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[StaffID] [int] NOT NULL,
	[Fullname] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[Phone] [nvarchar](12) NULL,
	[IsActive] [bit] NOT NULL,
	[UserID] [int] NULL,
 CONSTRAINT [Staff_PK] PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[InstructorID] [int] NOT NULL,
	[Fullname] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[Phone] [nvarchar](12) NULL,
	[IsActive] [bit] NOT NULL,
	[UserID] [int] NULL,
 CONSTRAINT [Instructor_PK] PRIMARY KEY CLUSTERED 
(
	[InstructorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RollCall]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RollCall](
	[RollCallID] [int] NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[SubjectID] [int] NOT NULL,
	[ClassID] [int] NOT NULL,
	[SemesterID] [int] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [RollCall_PK] PRIMARY KEY CLUSTERED 
(
	[RollCallID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttendanceLog]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttendanceLog](
	[LogID] [int] NOT NULL,
	[RollCallID] [int] NOT NULL,
	[LogDate] [date] NOT NULL,
	[TypeID] [int] NOT NULL,
 CONSTRAINT [AttendanceLog_PK] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstructorTeaching]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstructorTeaching](
	[InstructorID] [int] NOT NULL,
	[RollCallID] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
 CONSTRAINT [InstructorTeaching_PK] PRIMARY KEY CLUSTERED 
(
	[InstructorID] ASC,
	[RollCallID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentInRollCall]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentInRollCall](
	[StudentID] [int] NOT NULL,
	[RollCallID] [int] NOT NULL,
 CONSTRAINT [StudentInRollCall_PK] PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC,
	[RollCallID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentImage]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StudentImage](
	[ImageID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[ImageLink] [varchar](30) NOT NULL,
 CONSTRAINT [StudentImage_PK] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StudentAttendance]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentAttendance](
	[LogID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[IsPresent] [bit] NOT NULL,
	[Note] [nvarchar](20) NULL,
 CONSTRAINT [StudentAttendance_PK] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC,
	[StudentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogImage]    Script Date: 09/24/2013 15:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LogImage](
	[ImageID] [int] NOT NULL,
	[LogID] [int] NOT NULL,
	[ImageLink] [varchar](30) NOT NULL,
 CONSTRAINT [LogImage_PK] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  ForeignKey [FK_Class_Major]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[Class]  WITH CHECK ADD  CONSTRAINT [FK_Class_Major] FOREIGN KEY([MajorID])
REFERENCES [dbo].[Major] ([MajorID])
GO
ALTER TABLE [dbo].[Class] CHECK CONSTRAINT [FK_Class_Major]
GO
/****** Object:  ForeignKey [Role_User_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [Role_User_FK1] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [Role_User_FK1]
GO
/****** Object:  ForeignKey [Major_SubjectMajorMapping_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[SubjectMajorMapping]  WITH CHECK ADD  CONSTRAINT [Major_SubjectMajorMapping_FK1] FOREIGN KEY([MajorID])
REFERENCES [dbo].[Major] ([MajorID])
GO
ALTER TABLE [dbo].[SubjectMajorMapping] CHECK CONSTRAINT [Major_SubjectMajorMapping_FK1]
GO
/****** Object:  ForeignKey [Subject_SubjectMajorMapping_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[SubjectMajorMapping]  WITH CHECK ADD  CONSTRAINT [Subject_SubjectMajorMapping_FK1] FOREIGN KEY([SubjectID])
REFERENCES [dbo].[Subject] ([SubjectID])
GO
ALTER TABLE [dbo].[SubjectMajorMapping] CHECK CONSTRAINT [Subject_SubjectMajorMapping_FK1]
GO
/****** Object:  ForeignKey [Class_Student_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [Class_Student_FK1] FOREIGN KEY([ClassID])
REFERENCES [dbo].[Class] ([ClassID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [Class_Student_FK1]
GO
/****** Object:  ForeignKey [User_Student_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [User_Student_FK1] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [User_Student_FK1]
GO
/****** Object:  ForeignKey [User_Staff_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [User_Staff_FK1] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [User_Staff_FK1]
GO
/****** Object:  ForeignKey [User_Instructor_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[Instructor]  WITH CHECK ADD  CONSTRAINT [User_Instructor_FK1] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Instructor] CHECK CONSTRAINT [User_Instructor_FK1]
GO
/****** Object:  ForeignKey [FK_RollCall_Class]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[RollCall]  WITH CHECK ADD  CONSTRAINT [FK_RollCall_Class] FOREIGN KEY([ClassID])
REFERENCES [dbo].[Class] ([ClassID])
GO
ALTER TABLE [dbo].[RollCall] CHECK CONSTRAINT [FK_RollCall_Class]
GO
/****** Object:  ForeignKey [FK_RollCall_Semester]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[RollCall]  WITH CHECK ADD  CONSTRAINT [FK_RollCall_Semester] FOREIGN KEY([SemesterID])
REFERENCES [dbo].[Semester] ([SemesterID])
GO
ALTER TABLE [dbo].[RollCall] CHECK CONSTRAINT [FK_RollCall_Semester]
GO
/****** Object:  ForeignKey [FK_RollCall_Subject]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[RollCall]  WITH CHECK ADD  CONSTRAINT [FK_RollCall_Subject] FOREIGN KEY([SubjectID])
REFERENCES [dbo].[Subject] ([SubjectID])
GO
ALTER TABLE [dbo].[RollCall] CHECK CONSTRAINT [FK_RollCall_Subject]
GO
/****** Object:  ForeignKey [LogType_AttendanceLog_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[AttendanceLog]  WITH CHECK ADD  CONSTRAINT [LogType_AttendanceLog_FK1] FOREIGN KEY([TypeID])
REFERENCES [dbo].[LogType] ([TypeID])
GO
ALTER TABLE [dbo].[AttendanceLog] CHECK CONSTRAINT [LogType_AttendanceLog_FK1]
GO
/****** Object:  ForeignKey [RollCall_AttendanceLog_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[AttendanceLog]  WITH CHECK ADD  CONSTRAINT [RollCall_AttendanceLog_FK1] FOREIGN KEY([RollCallID])
REFERENCES [dbo].[RollCall] ([RollCallID])
GO
ALTER TABLE [dbo].[AttendanceLog] CHECK CONSTRAINT [RollCall_AttendanceLog_FK1]
GO
/****** Object:  ForeignKey [Instructor_InstructorTeaching_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[InstructorTeaching]  WITH CHECK ADD  CONSTRAINT [Instructor_InstructorTeaching_FK1] FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([InstructorID])
GO
ALTER TABLE [dbo].[InstructorTeaching] CHECK CONSTRAINT [Instructor_InstructorTeaching_FK1]
GO
/****** Object:  ForeignKey [RollCall_InstructorTeaching_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[InstructorTeaching]  WITH CHECK ADD  CONSTRAINT [RollCall_InstructorTeaching_FK1] FOREIGN KEY([RollCallID])
REFERENCES [dbo].[RollCall] ([RollCallID])
GO
ALTER TABLE [dbo].[InstructorTeaching] CHECK CONSTRAINT [RollCall_InstructorTeaching_FK1]
GO
/****** Object:  ForeignKey [RollCall_StudentInRollCall_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[StudentInRollCall]  WITH CHECK ADD  CONSTRAINT [RollCall_StudentInRollCall_FK1] FOREIGN KEY([RollCallID])
REFERENCES [dbo].[RollCall] ([RollCallID])
GO
ALTER TABLE [dbo].[StudentInRollCall] CHECK CONSTRAINT [RollCall_StudentInRollCall_FK1]
GO
/****** Object:  ForeignKey [Student_StudentInRollCall_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[StudentInRollCall]  WITH CHECK ADD  CONSTRAINT [Student_StudentInRollCall_FK1] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[StudentInRollCall] CHECK CONSTRAINT [Student_StudentInRollCall_FK1]
GO
/****** Object:  ForeignKey [Student_StudentImage_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[StudentImage]  WITH CHECK ADD  CONSTRAINT [Student_StudentImage_FK1] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[StudentImage] CHECK CONSTRAINT [Student_StudentImage_FK1]
GO
/****** Object:  ForeignKey [AttendanceLog_StudentAttendance_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[StudentAttendance]  WITH CHECK ADD  CONSTRAINT [AttendanceLog_StudentAttendance_FK1] FOREIGN KEY([LogID])
REFERENCES [dbo].[AttendanceLog] ([LogID])
GO
ALTER TABLE [dbo].[StudentAttendance] CHECK CONSTRAINT [AttendanceLog_StudentAttendance_FK1]
GO
/****** Object:  ForeignKey [Student_StudentAttendance_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[StudentAttendance]  WITH CHECK ADD  CONSTRAINT [Student_StudentAttendance_FK1] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[StudentAttendance] CHECK CONSTRAINT [Student_StudentAttendance_FK1]
GO
/****** Object:  ForeignKey [AttendanceLog_LogImage_FK1]    Script Date: 09/24/2013 15:53:17 ******/
ALTER TABLE [dbo].[LogImage]  WITH CHECK ADD  CONSTRAINT [AttendanceLog_LogImage_FK1] FOREIGN KEY([LogID])
REFERENCES [dbo].[AttendanceLog] ([LogID])
GO
ALTER TABLE [dbo].[LogImage] CHECK CONSTRAINT [AttendanceLog_LogImage_FK1]
GO
