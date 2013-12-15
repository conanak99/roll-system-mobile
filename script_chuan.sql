USE [master]
GO
/****** Object:  Database [RSM]    Script Date: 12/15/2013 16:40:33 ******/
CREATE DATABASE [RSM] ON  PRIMARY 
( NAME = N'RSM', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\RSM.mdf' , SIZE = 3328KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
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
/****** Object:  Table [dbo].[Semester]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Semester](
	[SemesterID] [int] IDENTITY(1,1) NOT NULL,
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
SET IDENTITY_INSERT [dbo].[Semester] ON
INSERT [dbo].[Semester] ([SemesterID], [SemesterName], [BeginDate], [EndDate]) VALUES (2, N'Summer 2013', CAST(0x94360B00 AS Date), CAST(0xEE360B00 AS Date))
INSERT [dbo].[Semester] ([SemesterID], [SemesterName], [BeginDate], [EndDate]) VALUES (3, N'Fall 2013', CAST(0x87370B00 AS Date), CAST(0xFF370B00 AS Date))
INSERT [dbo].[Semester] ([SemesterID], [SemesterName], [BeginDate], [EndDate]) VALUES (5, N'Spring 2014', CAST(0x01380B00 AS Date), CAST(0x79380B00 AS Date))
SET IDENTITY_INSERT [dbo].[Semester] OFF
/****** Object:  Table [dbo].[SubjectType]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectType](
	[TypeID] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SubjectType] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[SubjectType] ON
INSERT [dbo].[SubjectType] ([TypeID], [TypeName]) VALUES (1, N'Information Technology')
INSERT [dbo].[SubjectType] ([TypeID], [TypeName]) VALUES (2, N'Financial')
INSERT [dbo].[SubjectType] ([TypeID], [TypeName]) VALUES (3, N'Foreign Language')
INSERT [dbo].[SubjectType] ([TypeID], [TypeName]) VALUES (4, N'Math')
INSERT [dbo].[SubjectType] ([TypeID], [TypeName]) VALUES (5, N'Soft Skill')
SET IDENTITY_INSERT [dbo].[SubjectType] OFF
/****** Object:  Table [dbo].[Major]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Major](
	[MajorID] [int] IDENTITY(1,1) NOT NULL,
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
SET IDENTITY_INSERT [dbo].[Major] ON
INSERT [dbo].[Major] ([MajorID], [ShortName], [FullName]) VALUES (1, N'SE', N'Software Engineering')
INSERT [dbo].[Major] ([MajorID], [ShortName], [FullName]) VALUES (2, N'FB', N'Financial Banking')
INSERT [dbo].[Major] ([MajorID], [ShortName], [FullName]) VALUES (3, N'BA', N'Business Administrator')
SET IDENTITY_INSERT [dbo].[Major] OFF
/****** Object:  Table [dbo].[LogType]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogType](
	[TypeID] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](10) NULL,
 CONSTRAINT [LogType_PK] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[LogType] ON
INSERT [dbo].[LogType] ([TypeID], [TypeName]) VALUES (1, N'Auto')
INSERT [dbo].[LogType] ([TypeID], [TypeName]) VALUES (2, N'Manual')
SET IDENTITY_INSERT [dbo].[LogType] OFF
/****** Object:  Table [dbo].[Role]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](10) NOT NULL,
 CONSTRAINT [Role_PK] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Role] ON
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (2, N'Staff')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (3, N'Student')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (4, N'Instructor')
SET IDENTITY_INSERT [dbo].[Role] OFF
/****** Object:  Table [dbo].[User]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
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
SET IDENTITY_INSERT [dbo].[User] ON
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (1, N'admin1', N'12345', 1, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (2, N'admin2', N'123456', 1, 0)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (3, N'khanhkt', N'123456', 4, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (5, N'phuonglhk', N'123456', 4, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (6, N'hungnh', N'123456', 4, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (7, N'sutv', N'123456', 4, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (11, N'quangnt', N'123456', 2, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (12, N'quangnt2', N'123456', 2, 0)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (13, N'quangnt3', N'123456', 2, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (14, N'vinhnt', N'123456', 2, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (15, N'longnt', N'123456', 2, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (16, N'hienlv', N'123456', 2, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (17, N'taint', N'123456', 4, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (18, N'uyenvtt', N'123456', 4, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (19, N'camdth', N'123456', 4, 0)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (20, N'nhultl', N'123456', 4, 0)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (21, N'hoangph', N'123456', 4, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (22, N'hoant', N'123456', 4, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (23, N'hoangph2', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (24, N'khoatnd', N'123456', 4, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (25, N'minhth', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (26, N'quangt', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (27, N'quyent', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (32, N'vinhnt2', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (33, N'huynhhd', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (34, N'baola', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (36, N'nghiahd', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (37, N'hunghq', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (38, N'baotq', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (39, N'khanhkt2', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (40, N'huynq', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (41, N'binhnt', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (42, N'locnh', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (43, N'khoatnd2', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (45, N'liemlv', N'123456', 1, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (46, N'trietcm', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (47, N'ahst_user', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (48, N'ehst_user', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (49, N'dhst_user', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (50, N'bhst_user', N'123456', 3, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [RoleID], [IsActive]) VALUES (51, N'chst_user', N'123456', 3, 1)
SET IDENTITY_INSERT [dbo].[User] OFF
/****** Object:  Table [dbo].[Class]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Class](
	[ClassID] [int] IDENTITY(1,1) NOT NULL,
	[MajorID] [int] NOT NULL,
	[ClassName] [varchar](10) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [Class_PK] PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Class] ON [dbo].[Class] 
(
	[ClassName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Class] ON
INSERT [dbo].[Class] ([ClassID], [MajorID], [ClassName], [IsActive]) VALUES (3, 1, N'SE0670  ', 1)
INSERT [dbo].[Class] ([ClassID], [MajorID], [ClassName], [IsActive]) VALUES (4, 1, N'SE0692  ', 1)
INSERT [dbo].[Class] ([ClassID], [MajorID], [ClassName], [IsActive]) VALUES (5, 1, N'SE0453  ', 0)
INSERT [dbo].[Class] ([ClassID], [MajorID], [ClassName], [IsActive]) VALUES (6, 2, N'FB0594  ', 1)
INSERT [dbo].[Class] ([ClassID], [MajorID], [ClassName], [IsActive]) VALUES (7, 2, N'FB0599  ', 1)
INSERT [dbo].[Class] ([ClassID], [MajorID], [ClassName], [IsActive]) VALUES (8, 2, N'FB0504  ', 0)
INSERT [dbo].[Class] ([ClassID], [MajorID], [ClassName], [IsActive]) VALUES (9, 1, N'SE0570  ', 1)
INSERT [dbo].[Class] ([ClassID], [MajorID], [ClassName], [IsActive]) VALUES (11, 3, N'BA0394  ', 1)
INSERT [dbo].[Class] ([ClassID], [MajorID], [ClassName], [IsActive]) VALUES (12, 3, N'BA0983  ', 1)
INSERT [dbo].[Class] ([ClassID], [MajorID], [ClassName], [IsActive]) VALUES (13, 3, N'BA0329  ', 1)
INSERT [dbo].[Class] ([ClassID], [MajorID], [ClassName], [IsActive]) VALUES (14, 3, N'BA0932  ', 0)
INSERT [dbo].[Class] ([ClassID], [MajorID], [ClassName], [IsActive]) VALUES (15, 1, N'SE0999  ', 1)
INSERT [dbo].[Class] ([ClassID], [MajorID], [ClassName], [IsActive]) VALUES (17, 1, N'SE0845  ', 1)
INSERT [dbo].[Class] ([ClassID], [MajorID], [ClassName], [IsActive]) VALUES (18, 1, N'HL_XML01', 1)
SET IDENTITY_INSERT [dbo].[Class] OFF
/****** Object:  Table [dbo].[Subject]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Subject](
	[SubjectID] [int] IDENTITY(1,1) NOT NULL,
	[ShortName] [nvarchar](10) NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[NumberOfSlot] [int] NOT NULL,
	[Description] [char](10) NULL,
	[IsActive] [bit] NOT NULL,
	[NumberOfSession] [int] NOT NULL,
	[IsSlotFixed] [bit] NOT NULL,
	[TypeID] [int] NOT NULL,
 CONSTRAINT [Subject_PK] PRIMARY KEY CLUSTERED 
(
	[SubjectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Subject] ON
INSERT [dbo].[Subject] ([SubjectID], [ShortName], [FullName], [NumberOfSlot], [Description], [IsActive], [NumberOfSession], [IsSlotFixed], [TypeID]) VALUES (1, N'XML', N'XML', 1, NULL, 1, 30, 0, 1)
INSERT [dbo].[Subject] ([SubjectID], [ShortName], [FullName], [NumberOfSlot], [Description], [IsActive], [NumberOfSession], [IsSlotFixed], [TypeID]) VALUES (3, N'HCI', N'Human Computer Interaction', 1, NULL, 1, 15, 1, 1)
INSERT [dbo].[Subject] ([SubjectID], [ShortName], [FullName], [NumberOfSlot], [Description], [IsActive], [NumberOfSession], [IsSlotFixed], [TypeID]) VALUES (4, N'AJ', N'Advanced Java', 2, NULL, 1, 30, 0, 1)
INSERT [dbo].[Subject] ([SubjectID], [ShortName], [FullName], [NumberOfSlot], [Description], [IsActive], [NumberOfSession], [IsSlotFixed], [TypeID]) VALUES (5, N'Submit 1', N'Submit 1', 1, NULL, 1, 25, 1, 3)
INSERT [dbo].[Subject] ([SubjectID], [ShortName], [FullName], [NumberOfSlot], [Description], [IsActive], [NumberOfSession], [IsSlotFixed], [TypeID]) VALUES (7, N'Submit 2', N'Submit 2', 1, NULL, 1, 25, 1, 3)
INSERT [dbo].[Subject] ([SubjectID], [ShortName], [FullName], [NumberOfSlot], [Description], [IsActive], [NumberOfSession], [IsSlotFixed], [TypeID]) VALUES (8, N'POA', N'Principal of Accounting', 1, NULL, 1, 15, 1, 2)
INSERT [dbo].[Subject] ([SubjectID], [ShortName], [FullName], [NumberOfSlot], [Description], [IsActive], [NumberOfSession], [IsSlotFixed], [TypeID]) VALUES (9, N'ML', N'Market Leader', 1, NULL, 1, 30, 1, 2)
INSERT [dbo].[Subject] ([SubjectID], [ShortName], [FullName], [NumberOfSlot], [Description], [IsActive], [NumberOfSession], [IsSlotFixed], [TypeID]) VALUES (10, N'OS', N'Operating System', 2, NULL, 1, 20, 1, 1)
INSERT [dbo].[Subject] ([SubjectID], [ShortName], [FullName], [NumberOfSlot], [Description], [IsActive], [NumberOfSession], [IsSlotFixed], [TypeID]) VALUES (11, N'I2SE', N'Introduce to Software Engineering', 1, NULL, 1, 20, 1, 1)
INSERT [dbo].[Subject] ([SubjectID], [ShortName], [FullName], [NumberOfSlot], [Description], [IsActive], [NumberOfSession], [IsSlotFixed], [TypeID]) VALUES (13, N'JPN 1.1', N'Japanese 1.1', 1, NULL, 1, 40, 1, 3)
INSERT [dbo].[Subject] ([SubjectID], [ShortName], [FullName], [NumberOfSlot], [Description], [IsActive], [NumberOfSession], [IsSlotFixed], [TypeID]) VALUES (14, N'JPN 1.2', N'Japanese 1.2', 1, NULL, 1, 40, 1, 3)
INSERT [dbo].[Subject] ([SubjectID], [ShortName], [FullName], [NumberOfSlot], [Description], [IsActive], [NumberOfSession], [IsSlotFixed], [TypeID]) VALUES (15, N'AD', N'Advanced Database', 1, NULL, 1, 30, 1, 1)
INSERT [dbo].[Subject] ([SubjectID], [ShortName], [FullName], [NumberOfSlot], [Description], [IsActive], [NumberOfSession], [IsSlotFixed], [TypeID]) VALUES (16, N'I2DB', N'Introduction to Database', 1, NULL, 1, 25, 1, 1)
INSERT [dbo].[Subject] ([SubjectID], [ShortName], [FullName], [NumberOfSlot], [Description], [IsActive], [NumberOfSession], [IsSlotFixed], [TypeID]) VALUES (17, N'SPM', N'Software Project Management', 2, NULL, 1, 20, 1, 1)
SET IDENTITY_INSERT [dbo].[Subject] OFF
/****** Object:  Table [dbo].[SubjectMajorMapping]    Script Date: 12/15/2013 16:40:35 ******/
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
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (1, 1)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (1, 3)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (1, 4)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (1, 5)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (1, 7)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (1, 8)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (1, 10)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (1, 15)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (1, 16)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (1, 17)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (2, 5)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (2, 7)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (2, 8)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (3, 5)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (3, 7)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (3, 8)
INSERT [dbo].[SubjectMajorMapping] ([MajorID], [SubjectID]) VALUES (3, 9)
/****** Object:  Table [dbo].[Student]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Student](
	[StudentID] [int] IDENTITY(1,1) NOT NULL,
	[ClassID] [int] NULL,
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
SET IDENTITY_INSERT [dbo].[Student] ON
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (1, 9, N'Pham Huy Hoàng', CAST(0x0000839F00000000 AS DateTime), N'09080880', N'Que Lao Cai', N'anhdung82vn@yahoo.com', 1, 23, N'SE60740')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (2, 3, N'Trịnh Hoàng Minh', CAST(0x0000838900000000 AS DateTime), N'3243234 ', N'weqwqe', N'abc@gmail.com', 1, 25, N'SE60741')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (3, 15, N'Tran Quang', CAST(0x0000834200000000 AS DateTime), N'34232321', N'HCM', N'quang@fpt.edu.vn', 1, 26, N'SE60742')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (4, 15, N'Trần Quyền', CAST(0x0000836100000000 AS DateTime), N'21312312', N'HCM', N'quyen@fpt.edu.vn', 1, 27, N'SE60730')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (5, 3, N'Nguyễn Hữu Lộc', CAST(0x000084EE00000000 AS DateTime), N'23435121', N'HCM', N'loc@fpt.edu.vn', 1, 42, N'SE60973')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (9, 4, N'Lê Văn Hùng', CAST(0x0000821100000000 AS DateTime), N'03049009', NULL, N'emailA@email.com', 1, NULL, N'03930  ')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (10, 4, N'Lê Tâm', CAST(0x0000821100000000 AS DateTime), N'03049003', NULL, N'emailB@email.com', 1, NULL, N'FB60943')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (11, 15, N'Nguyễn Bình', CAST(0x0000821100000000 AS DateTime), N'30920320', NULL, N'emailC@email.com', 1, NULL, N'FB63930')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (12, 4, N'Lê Lâm Bình', CAST(0x0000821100000000 AS DateTime), N'03049009', NULL, N'emailD@email.com', 1, NULL, N'FB60942')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (13, 15, N'Đào Bảo Long', CAST(0x0000839F00000000 AS DateTime), N'32432143', NULL, N'long@long.com', 1, NULL, N'SE60749')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (15, 15, N'Nguyễn Thế Vinh', CAST(0x0000837E00000000 AS DateTime), N'35765421', NULL, N'vinh@vinh.com', 1, 32, N'SE60985')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (16, 15, N'Hà Duy Huỳnh', CAST(0x00007F7800000000 AS DateTime), N'23432212', NULL, N'dinhvo@vo.com', 1, 33, N'SE09603')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (18, 15, N'Lê Anh Bảo', CAST(0x00007F2500000000 AS DateTime), N'12231129', NULL, N'anhbao@gmail.com', 1, 34, N'60749  ')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (19, NULL, N'Thanh Huy', CAST(0x00008E3A00000000 AS DateTime), N'32456678', NULL, N'thanhhuy@huy.com', 1, NULL, N'60593  ')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (20, 4, N'Hồ Đắc Nghĩa', CAST(0x0000843E00000000 AS DateTime), N'65784552', NULL, N'dacnghia@nghia.com', 1, 36, N'60970  ')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (21, 4, N'Hồ Quang Hưng', CAST(0x0000848800000000 AS DateTime), N'69575357', NULL, N'quanghung@gmail.com', 1, 37, N'06954  ')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (22, 4, N'Trương Quang Bảo', CAST(0x000081A200000000 AS DateTime), N'66776789', NULL, N'quangbao@bao.com', 1, 38, N'60575  ')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (25, 15, N'GV Kiều Trọng Khánh', CAST(0x0000651900000000 AS DateTime), N'56645456', NULL, N'khanhkt@fpt.edu.vn', 1, 39, N'SE94059')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (28, 9, N'Nguyễn Quốc Huy', CAST(0x0000825100000000 AS DateTime), N'61231597', N'Hồ Chí Minh', N'huynq@fpt.edu.vn', 1, NULL, N'SE50964')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (29, 9, N'Nguyễn Thanh Bình', CAST(0x0000839E00000000 AS DateTime), N'47821369', NULL, N'binhnt@fpt.edu.vn', 1, 41, N'48721  ')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (30, 9, N'Hà Minh Thanh', CAST(0x0000806800000000 AS DateTime), N'12589364', NULL, N'thanhhm@fpt.edu.vn', 1, NULL, N'26989  ')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (31, 15, N'Nguyễn Huy Hưng', CAST(0x000080C600000000 AS DateTime), N'78932598', NULL, N'hungnh@fpt.edu.vn', 1, NULL, N'SE05964')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (32, 15, N'Phan Ngọc Trầm', CAST(0x0000822F00000000 AS DateTime), N'34242324', NULL, N'tramph@fpt.edu.vn', 1, NULL, N'04943  ')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (33, NULL, N'Hoàng Trọng Khánh', CAST(0x0000823300000000 AS DateTime), N'26698986', NULL, N'khanhht@fpt.edu.vn', 1, NULL, N'SE60970')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (34, 3, N'Nguyễn Hoàng Huy', CAST(0x0000839F00000000 AS DateTime), N'78596587', N'Ho Chi Minh', N'huynh@fpt.edu.vn', 1, NULL, N'SE60609')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (35, 3, N'Nguyễn Minh Thức', CAST(0x0000A1BC00000000 AS DateTime), N'98698563', N'Ho Chi Minh', N'thucnm@fpt.edu.vn', 1, NULL, N'SE60643')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (36, 3, N'Đoàn Hồ Anh Triết', CAST(0x00009E5E00000000 AS DateTime), N'12345678', NULL, N'trietdha@fpt.edu.vn', 1, NULL, N'SE60975')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (38, 3, N'Nguyễn Nhật Hoàng', CAST(0x0000A0A700000000 AS DateTime), N'14523658', N'Lê ', N'hoangnn@fpt.edu.vn', 1, NULL, N'SE60890')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (40, 3, N'Nguyễn Thị Thùy Linh', CAST(0x000080E300000000 AS DateTime), N'23454654', NULL, N'linhntt@fpt.edu.vn', 1, NULL, N'SE63904')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (46, 3, N'Nguyễn Thanh Hòa', CAST(0x0000806800000000 AS DateTime), N'34324322', NULL, N'hoant@fpt.edu.vn', 1, NULL, N'SE60699')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (51, 3, N'Châu Minh Triết', CAST(0x0000807000000000 AS DateTime), N'26565923', NULL, N'trietcm@fpt.edu.vn', 1, 46, N'SE60678')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (52, 3, N'Phạm Hồng Sang', CAST(0x000080C500000000 AS DateTime), N'03940324', NULL, N'sangph@fpt.edu.vn', 1, NULL, N'SE60243')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (53, 3, N'Đỗ Tấn Liêm', CAST(0x000080E400000000 AS DateTime), N'23698563', NULL, N'liemdt@fpt.edu.vn', 1, NULL, N'SE60725')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (54, 3, N'Trần Nguyễn Đăng Khoa', CAST(0x0000816300000000 AS DateTime), N'34242322', NULL, N'khoatnd@fpt.edu.vn', 1, 43, N'SE60943')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (55, 17, N'Lại Văn Sâm', CAST(0x0000834200000000 AS DateTime), N'34364345', N'Địa Chỉ A', N'hse@fpt.edu.vn', 1, NULL, N'60984  ')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (56, 17, N'Trần Văn Ơn', CAST(0x0000834200000000 AS DateTime), N'34364345', NULL, N'hsd@fpt.edu.vn', 1, NULL, N'60983  ')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (59, 17, N'Nguyễn Lê Văn', CAST(0x0000834200000000 AS DateTime), N'34364345', NULL, N'hsa@fpt.edu.vn', 1, NULL, N'60954  ')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (60, 17, N'Lê Văn Hưng', CAST(0x0000834200000000 AS DateTime), N'34364345', NULL, N'hsb@fpt.edu.vn', 1, NULL, N'SE60955')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (61, 17, N'Nguyễn Văn Hưng', CAST(0x0000834200000000 AS DateTime), N'34364345', NULL, N'hsd@fpt.edu.vn', 1, NULL, N'SE60956')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (62, 15, N'GV Lại Đức Hùng', CAST(0x0000808800000000 AS DateTime), N'35090650', NULL, N'hungld@fpt.edu.vn', 1, NULL, N'SE60396')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (63, 15, N'GV Lâm Hữu Khánh Phương', CAST(0x0000808700000000 AS DateTime), N'35090651', NULL, N'phuonglhk@fpt.edu.vn', 1, NULL, N'SE60356')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (64, 15, N'GV Ngô Đăng Hà An', CAST(0x0000808900000000 AS DateTime), N'35090653', NULL, N'anndh@fpt.edu.vn', 1, NULL, N'SE60358')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (65, 15, N'GV Nguyễn Trọng Tài', CAST(0x0000724400000000 AS DateTime), N'69059604', NULL, N'taint@fpt.edu.vn', 1, NULL, N'SE69403')
INSERT [dbo].[Student] ([StudentID], [ClassID], [FullName], [Birthdate], [CitizenID], [Address], [Email], [IsActive], [UserID], [StudentCode]) VALUES (66, 15, N'GV Nguyễn Hồng Phương', CAST(0x0000728100000000 AS DateTime), N'98089098', NULL, NULL, 1, NULL, N'SE90534')
SET IDENTITY_INSERT [dbo].[Student] OFF
/****** Object:  Table [dbo].[Staff]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[StaffID] [int] IDENTITY(1,1) NOT NULL,
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
SET IDENTITY_INSERT [dbo].[Staff] ON
INSERT [dbo].[Staff] ([StaffID], [Fullname], [Email], [Phone], [IsActive], [UserID]) VALUES (1, N'Nguyễn Tử Quảng', N'quangnt@fpt.edu.vn', N'548931549', 1, 11)
INSERT [dbo].[Staff] ([StaffID], [Fullname], [Email], [Phone], [IsActive], [UserID]) VALUES (3, N'Nguyễn Tử Vinh', N'vinhnt@fpt.edu.vn', N'547575563', 1, 14)
INSERT [dbo].[Staff] ([StaffID], [Fullname], [Email], [Phone], [IsActive], [UserID]) VALUES (5, N'Nguyễn Tử Long', N'longnt@fpt.edu.vn', N'354655451', 1, 15)
INSERT [dbo].[Staff] ([StaffID], [Fullname], [Email], [Phone], [IsActive], [UserID]) VALUES (6, N'Lê Văn Hiên', N'hienlv@fpt.edu.vn', N'46577867', 1, 16)
INSERT [dbo].[Staff] ([StaffID], [Fullname], [Email], [Phone], [IsActive], [UserID]) VALUES (7, N'Nguyễn Tử Quang', N'qnt@fpt.edu.vn', N'324654345', 1, 12)
INSERT [dbo].[Staff] ([StaffID], [Fullname], [Email], [Phone], [IsActive], [UserID]) VALUES (8, N'Nguyễn Tử Quáng', N'bgc@fpt.edu.vn', N'326989565', 1, 13)
INSERT [dbo].[Staff] ([StaffID], [Fullname], [Email], [Phone], [IsActive], [UserID]) VALUES (11, N'Lê Văn Liêm', N'abc@fpt.edu.vn', N'32323232232', 1, 45)
SET IDENTITY_INSERT [dbo].[Staff] OFF
/****** Object:  Table [dbo].[Instructor]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[InstructorID] [int] IDENTITY(1,1) NOT NULL,
	[Fullname] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](12) NULL,
	[IsActive] [bit] NOT NULL,
	[UserID] [int] NULL,
	[ApiToken] [nvarchar](100) NULL,
 CONSTRAINT [Instructor_PK] PRIMARY KEY CLUSTERED 
(
	[InstructorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Instructor] ON
INSERT [dbo].[Instructor] ([InstructorID], [Fullname], [Email], [Phone], [IsActive], [UserID], [ApiToken]) VALUES (1, N'Kiều Trọng Khánh', N'khanhkt@fpt.edu.vn', N'0902032109', 1, 3, N'1/xO7ZhIUX9bGtg_z4XqWUYFhu-VJnj2gC4AKOUxW0Ulg')
INSERT [dbo].[Instructor] ([InstructorID], [Fullname], [Email], [Phone], [IsActive], [UserID], [ApiToken]) VALUES (2, N'Lâm Hữu Khánh Phương', N'phuonglhk@fpt.edu.vn', N'232131231', 1, 5, NULL)
INSERT [dbo].[Instructor] ([InstructorID], [Fullname], [Email], [Phone], [IsActive], [UserID], [ApiToken]) VALUES (3, N'Nguyễn Huy Hùng', N'huynq@fpt.edu.vn', N'095653658', 1, 6, NULL)
INSERT [dbo].[Instructor] ([InstructorID], [Fullname], [Email], [Phone], [IsActive], [UserID], [ApiToken]) VALUES (4, N'Thân Văn Sử', N'sutv@fpt.edu.vn', N'09032312', 1, 7, NULL)
INSERT [dbo].[Instructor] ([InstructorID], [Fullname], [Email], [Phone], [IsActive], [UserID], [ApiToken]) VALUES (5, N'Nguyễn Trọng Tài', N'taint@fpt.edu.vn', N'347765563', 1, 17, NULL)
INSERT [dbo].[Instructor] ([InstructorID], [Fullname], [Email], [Phone], [IsActive], [UserID], [ApiToken]) VALUES (6, N'Võ Thị Thu Uyên', N'uyenvtt@fpt.edu.vn', N'568767656', 1, 18, NULL)
INSERT [dbo].[Instructor] ([InstructorID], [Fullname], [Email], [Phone], [IsActive], [UserID], [ApiToken]) VALUES (7, N'Đỗ Thị Hồng Cẩm', N'camdth@fpt.edu.vn', N'056554555', 1, 19, NULL)
INSERT [dbo].[Instructor] ([InstructorID], [Fullname], [Email], [Phone], [IsActive], [UserID], [ApiToken]) VALUES (8, N'Lê Thị Lan Như', N'nhultl@fpt.edu.vn', N'465454342', 1, 20, NULL)
INSERT [dbo].[Instructor] ([InstructorID], [Fullname], [Email], [Phone], [IsActive], [UserID], [ApiToken]) VALUES (10, N'Phạm Huy Hoàng', N'hoangph@fpt.edu.vn', N'543435341', 1, 21, NULL)
INSERT [dbo].[Instructor] ([InstructorID], [Fullname], [Email], [Phone], [IsActive], [UserID], [ApiToken]) VALUES (11, N'Nguyễn Thanh Hòa', N'hoant@fpt.edu.vn', N'676786676', 1, 22, NULL)
INSERT [dbo].[Instructor] ([InstructorID], [Fullname], [Email], [Phone], [IsActive], [UserID], [ApiToken]) VALUES (12, N'Trần Nguyễn Đăng Khoa', N'khoatnd@fpt.edu.vn', N'657543433', 1, 24, NULL)
SET IDENTITY_INSERT [dbo].[Instructor] OFF
/****** Object:  Table [dbo].[InstructorTeaching]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstructorTeaching](
	[InstructorID] [int] NOT NULL,
	[SubjectTypeID] [int] NOT NULL,
 CONSTRAINT [PK_InstructorTeaching] PRIMARY KEY CLUSTERED 
(
	[InstructorID] ASC,
	[SubjectTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[InstructorTeaching] ([InstructorID], [SubjectTypeID]) VALUES (1, 1)
INSERT [dbo].[InstructorTeaching] ([InstructorID], [SubjectTypeID]) VALUES (2, 1)
INSERT [dbo].[InstructorTeaching] ([InstructorID], [SubjectTypeID]) VALUES (3, 1)
INSERT [dbo].[InstructorTeaching] ([InstructorID], [SubjectTypeID]) VALUES (4, 1)
INSERT [dbo].[InstructorTeaching] ([InstructorID], [SubjectTypeID]) VALUES (4, 4)
INSERT [dbo].[InstructorTeaching] ([InstructorID], [SubjectTypeID]) VALUES (5, 1)
INSERT [dbo].[InstructorTeaching] ([InstructorID], [SubjectTypeID]) VALUES (6, 3)
INSERT [dbo].[InstructorTeaching] ([InstructorID], [SubjectTypeID]) VALUES (7, 3)
INSERT [dbo].[InstructorTeaching] ([InstructorID], [SubjectTypeID]) VALUES (8, 3)
INSERT [dbo].[InstructorTeaching] ([InstructorID], [SubjectTypeID]) VALUES (10, 2)
INSERT [dbo].[InstructorTeaching] ([InstructorID], [SubjectTypeID]) VALUES (10, 5)
INSERT [dbo].[InstructorTeaching] ([InstructorID], [SubjectTypeID]) VALUES (11, 2)
INSERT [dbo].[InstructorTeaching] ([InstructorID], [SubjectTypeID]) VALUES (12, 2)
INSERT [dbo].[InstructorTeaching] ([InstructorID], [SubjectTypeID]) VALUES (12, 5)
/****** Object:  Table [dbo].[StudentImage]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StudentImage](
	[ImageID] [int] IDENTITY(1,1) NOT NULL,
	[StudentID] [int] NOT NULL,
	[ImageLink] [varchar](100) NOT NULL,
 CONSTRAINT [StudentImage_PK] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[StudentImage] ON
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (34, 1, N'1002264_620799254605612_1673863743_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (37, 2, N'69610_453289044744266_1240599754_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (38, 2, N'179737_453289011410936_1145479918_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (39, 2, N'196759_10150236657372004_4374128_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (42, 2, N'207933_1676302436550_2881323_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (49, 13, N'IMG_0464_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (50, 13, N'IMG_0465_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (52, 13, N'long2_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (54, 13, N'long4_face_7.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (55, 13, N'long5_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (67, 16, N'IMG_0461_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (68, 16, N'IMG_0462_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (69, 16, N'IMG_0463_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (70, 16, N'IMG_0464_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (71, 16, N'IMG_0465_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (77, 13, N'IMG_0445_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (78, 13, N'IMG_0446_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (81, 1, N'208670_1676294916362_1660_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (94, 19, N'thanh_huy1_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (95, 19, N'thanh_huy2_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (96, 19, N'thanh_huy3_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (97, 19, N'thanh_huy4_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (98, 19, N'thanh_huy7_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (99, 19, N'thanh_huy8_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (100, 9, N'IMG_0466_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (101, 9, N'IMG_0467_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (102, 9, N'IMG_0468_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (103, 9, N'IMG_0469_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (104, 9, N'IMG_0470_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (105, 9, N'IMG_0471_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (106, 9, N'IMG_0473_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (107, 10, N'IMG_0466_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (108, 10, N'IMG_0467_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (109, 10, N'IMG_0468_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (110, 10, N'IMG_0469_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (111, 10, N'IMG_0470_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (112, 10, N'IMG_0471_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (113, 10, N'IMG_0472_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (114, 10, N'IMG_0473_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (115, 10, N'IMG_0474_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (116, 11, N'IMG_0466_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (117, 11, N'IMG_0467_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (120, 11, N'IMG_0470_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (122, 12, N'IMG_0466_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (123, 12, N'IMG_0467_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (124, 12, N'IMG_0468_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (125, 12, N'IMG_0469_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (126, 12, N'IMG_0470_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (127, 12, N'IMG_0471_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (128, 20, N'IMG_0463_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (129, 20, N'IMG_0464_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (130, 20, N'IMG_0465_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (138, 1, N'2 (19)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (140, 1, N'4 (7)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (143, 1, N'5 (5)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (193, 30, N'47828_416986688415912_418829072_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (194, 30, N'168943_181511775217763_1688994_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (195, 30, N'181989_181511635217777_5665310_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (199, 30, N'303748_323650614327817_1417466598_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (200, 30, N'308703_323650980994447_2041565627_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (203, 30, N'408242_335397063140277_1695220390_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (205, 30, N'1185880_667554829922139_1225925995_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (206, 30, N'1236338_660280823982873_773752520_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (237, 25, N'7212_4786651833437_956169543_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (240, 25, N'71468_4438621963062_280254372_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (243, 25, N'309986_180225435467238_1594602431_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (246, 25, N'397797_180225785467203_655446237_n_face_6.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (247, 25, N'480904_180225265467255_204386536_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (248, 25, N'536078_4438600682530_1444566911_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (249, 25, N'547818_4438661404048_1937798470_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (254, 25, N'934925_180225688800546_1040379376_n_face_7.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (256, 25, N'988670_4786651313424_1814650048_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (257, 25, N'1013086_560063834036788_1412588044_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (258, 25, N'1044505_640483679313788_2040525208_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (261, 1, N'197956_10150236657432004_4064172_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (281, 2, N'69610_453289044744266_1240599754_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (282, 2, N'179737_453289011410936_1145479918_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (283, 2, N'526566_453287991411038_383317350_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (284, 2, N'526656_453288461410991_1348918863_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (285, 2, N'547955_453288741410963_1691832178_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (288, 1, N'1 (5)_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (295, 1, N'2 (20)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (297, 1, N'5 (2)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (299, 1, N'5 (4)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (311, 4, N'SE0999_AJ_07-10-2013_photo_07-10-2013_08-46-29_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (318, 4, N'07-10-2013_photo_07-10-2013_08-44-49_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (320, 33, N'19709_344811498960885_962547864_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (321, 33, N'69279_343126632462705_1132250678_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (322, 33, N'69694_341121065996595_330490603_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (323, 33, N'73455_343131105795591_1989520991_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (324, 33, N'377668_343128169129218_1868656045_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (325, 33, N'527991_343128832462485_1302240679_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (326, 33, N'535580_343128122462556_2062507737_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (327, 33, N'538139_344811838960851_175106626_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (328, 33, N'555987_344812255627476_1777792825_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (330, 33, N'24-10-2013_photo_24-10-2013_08-38-58_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (336, 4, N'24-10-2013_photo_24-10-2013_08-37-14_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (339, 25, N'SE0999_AJ_07-10-2013_photo_07-10-2013_08-44-49_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (340, 30, N'25-10-2013_photo_28-10-2013_09-33-24_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (341, 30, N'25-10-2013_photo_28-10-2013_09-32-29_face_0.jpg')
GO
print 'Processed 100 total records'
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (342, 25, N'25-10-2013_photo_28-10-2013_09-32-29_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (343, 30, N'25-10-2013_photo_28-10-2013_09-30-11_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (344, 1, N'25-10-2013_photo_28-10-2013_09-40-32_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (353, 25, N'24-10-2013_photo_24-10-2013_08-37-14_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (367, 40, N'8082_519306401460594_1689356227_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (368, 40, N'184051_4625215670709_203669433_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (369, 40, N'299177_2400810861979_206125_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (370, 40, N'311302_2465074668534_1863154504_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (371, 40, N'408006_519306318127269_1734644398_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (372, 40, N'559392_4831537908636_1561897427_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (373, 40, N'389788_10200888124107683_7124359_n_face_5.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (375, 40, N'402392_10200888124227686_271184973_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (376, 40, N'429766_509669522424282_634389333_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (377, 40, N'482253_10200888247790775_65019677_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (378, 40, N'549186_509669469090954_3582194_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (379, 34, N'9892_378580162248649_1410140173_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (380, 34, N'62394_10200876730262844_1031844442_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (381, 34, N'77070_411003352301551_1365942882_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (382, 34, N'251826_3381862436558_455560461_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (383, 34, N'375201_4999977434616_386375152_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (384, 34, N'406290_309361302432501_292795045_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (385, 34, N'408318_309361089099189_572442512_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (386, 34, N'416865_428578617215309_654867074_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (387, 34, N'537109_461276457258987_1933708444_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (388, 34, N'543920_4999977474617_765081551_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (389, 34, N'582777_461277807258852_1585421997_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (390, 38, N'6968_10151275485703514_1211057062_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (391, 38, N'181441_237523953028491_1311046191_n_face_4.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (392, 38, N'252366_10151275497568514_1679113308_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (393, 38, N'386391_347045948640435_381972954_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (394, 38, N'401149_347045888640441_480742487_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (395, 38, N'528346_298940890176495_662254227_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (396, 38, N'538018_552799121398834_1152001926_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (397, 38, N'538378_323863851014518_730391858_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (398, 38, N'551726_298942526842998_1266735854_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (399, 38, N'946085_183569695132812_186794000_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (400, 36, N'150717_10151443364826484_1941737117_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (401, 36, N'163344_10151443363001484_1842810513_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (402, 36, N'188207_10151443365651484_1853784508_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (403, 36, N'253487_461586957252919_1144511445_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (404, 36, N'382323_10151443372956484_688062432_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (405, 36, N'482640_10151443374196484_2140114834_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (406, 36, N'525555_10151443367726484_1083299001_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (407, 36, N'539658_10151443366271484_1789397608_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (408, 36, N'558092_10151443365471484_1585637166_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (409, 36, N'581124_10151443374211484_1470102408_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (410, 36, N'600130_10151443366991484_1070523182_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (411, 5, N'179618_3953506255061_1975006304_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (412, 5, N'1185718_624330324276118_2096814423_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (413, 5, N'1231644_624329457609538_987529271_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (415, 5, N'1238027_298432256962470_2137064125_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (416, 5, N'1239514_298433346962361_1433659724_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (417, 5, N'1239823_624330814276069_1158868425_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (418, 5, N'1240598_298433040295725_505726172_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (419, 5, N'69683_4348926763439_1526840579_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (420, 5, N'316953_475544529171514_691914392_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (421, 52, N'148959_432834800123024_1163803809_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (422, 52, N'269272_3746947452252_1685981249_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (423, 52, N'307191_432833583456479_167100592_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (424, 52, N'407842_463382123719082_134646340_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (425, 52, N'531915_535694816499070_255870946_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (426, 52, N'550972_432835143456323_193575692_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (427, 52, N'581601_428578623881975_15474569_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (428, 52, N'582437_3678316697055_1001782508_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (429, 52, N'994023_161466597385299_1460113029_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (430, 52, N'1187009_535694659832419_1333692726_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (431, 52, N'1238814_535694906499061_673960597_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (432, 46, N'416865_428578617215309_654867074_n_face_5.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (433, 46, N'531915_535694816499070_255870946_n_face_4.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (434, 46, N'581601_428578623881975_15474569_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (435, 46, N'582437_3678316697055_1001782508_n_face_5.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (436, 46, N'644013_535704059831479_1168856726_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (437, 46, N'994023_161466597385299_1460113029_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (438, 46, N'994312_530670283669616_1819688709_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (439, 46, N'1175620_530670337002944_873641733_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (440, 46, N'1187009_535694659832419_1333692726_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (441, 46, N'1236523_535704073164811_518695112_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (442, 46, N'1238814_535694906499061_673960597_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (443, 46, N'1239549_535704079831477_1128721532_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (444, 54, N'531915_535694816499070_255870946_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (445, 54, N'549582_535695123165706_873422141_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (446, 54, N'994023_161466597385299_1460113029_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (447, 54, N'1001267_535695106499041_219480251_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (448, 54, N'1187009_535694659832419_1333692726_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (449, 54, N'1238814_535694906499061_673960597_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (450, 54, N'12210_411003768968176_733897604_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (451, 54, N'559947_411004882301398_1416068080_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (452, 53, N'148612_428578673881970_885022895_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (453, 53, N'282869_428578657215305_134609457_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (454, 53, N'292829_273878085969221_1860462995_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (455, 53, N'296352_275744892449207_525655283_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (457, 53, N'382120_411005282301358_619544131_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (458, 53, N'395049_411003685634851_851796168_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (459, 53, N'405350_2118266934602_2037191867_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (460, 53, N'559947_411004882301398_1416068080_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (461, 35, N'(1)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (462, 35, N'(2)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (463, 35, N'(3)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (464, 35, N'(4)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (465, 35, N'(5)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (466, 35, N'(6)_face_0.jpg')
GO
print 'Processed 200 total records'
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (467, 35, N'(7)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (468, 35, N'(8)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (469, 35, N'(9)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (470, 35, N'(10)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (479, 52, N'SE0670_XML_photo_31-10-2013_09-18-33_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (480, 53, N'SE0670_XML_photo_31-10-2013_09-18-33_face_4.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (484, 35, N'SE0670_XML_photo_31-10-2013_09-19-34_face_6.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (485, 53, N'SE0670_XML_photo_31-10-2013_09-23-50_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (487, 53, N'SE0670_XML_photo_31-10-2013_09-23-38_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (489, 53, N'SE0670_XML_photo_31-10-2013_09-23-27_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (490, 40, N'SE0670_XML_photo_31-10-2013_09-23-27_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (494, 53, N'SE0670_XML_photo_31-10-2013_09-23-17_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (495, 35, N'SE0670_XML_photo_31-10-2013_09-23-17_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (496, 59, N'2013-10-31 09-06-35-911_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (497, 59, N'2013-10-31 09-06-36-185_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (498, 59, N'2013-10-31 09-06-36-391_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (499, 59, N'2013-10-31 09-06-36-587_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (500, 59, N'2013-10-31 09-06-36-738_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (501, 59, N'2013-10-31 09-06-36-894_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (502, 59, N'2013-10-31 09-06-37-205_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (503, 59, N'2013-10-31 09-06-37-495_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (504, 59, N'2013-10-31 09-06-37-653_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (505, 59, N'2013-10-31 09-06-37-819_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (506, 60, N'2013-10-31 09-06-47-732_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (507, 60, N'2013-10-31 09-06-48-002_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (508, 60, N'2013-10-31 09-06-48-451_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (509, 60, N'2013-10-31 09-06-48-631_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (510, 60, N'2013-10-31 09-06-48-815_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (511, 61, N'2013-10-31 09-06-48-815_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (512, 60, N'2013-10-31 09-06-48-966_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (513, 61, N'2013-10-31 09-06-48-966_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (514, 60, N'2013-10-31 09-06-49-105_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (515, 61, N'2013-10-31 09-06-49-105_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (516, 60, N'2013-10-31 09-06-49-250_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (517, 56, N'2013-10-31 09-06-49-250_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (518, 61, N'2013-10-31 09-06-49-250_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (519, 60, N'2013-10-31 09-06-49-362_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (520, 56, N'2013-10-31 09-06-49-362_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (521, 61, N'2013-10-31 09-06-49-362_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (522, 60, N'2013-10-31 09-06-49-468_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (523, 56, N'2013-10-31 09-06-49-468_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (524, 60, N'2013-10-31 09-06-49-608_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (525, 56, N'2013-10-31 09-06-49-608_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (526, 60, N'2013-10-31 09-06-49-751_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (527, 56, N'2013-10-31 09-06-49-751_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (528, 56, N'2013-10-31 09-06-49-954_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (529, 56, N'2013-10-31 09-06-50-073_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (531, 56, N'2013-10-31 09-08-12-027_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (532, 56, N'2013-10-31 09-08-12-351_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (534, 56, N'2013-10-31 09-08-12-727_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (536, 60, N'2013-10-31 09-08-12-916_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (537, 56, N'2013-10-31 09-08-12-916_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (539, 61, N'2013-10-31 09-09-22-531_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (540, 61, N'2013-10-31 09-09-23-042_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (541, 56, N'2013-10-31 09-09-26-313_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (542, 56, N'2013-10-31 09-09-26-435_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (553, 2, N'300498_273878059302557_995048238_n_face_5.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (554, 2, N'382120_411005282301358_619544131_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (555, 54, N'300849_3105581816857_1291754647_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (556, 54, N'382120_411005282301358_619544131_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (557, 54, N'395049_411003685634851_851796168_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (558, 51, N'63639_3694327616914_1409379090_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (559, 51, N'73980_4118193813304_1038930512_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (560, 51, N'156367_3734495661090_1997664861_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (561, 51, N'189545_4581069304902_1205913456_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (562, 29, N'07-10-2013_photo_07-10-2013_08-42-48_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (564, 29, N'21-10-2013_photo_21-10-2013_08-16-40_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (565, 29, N'25-10-2013_photo_28-10-2013_09-32-29_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (566, 29, N'1678_4040996283414_118210022_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (567, 29, N'63100_4195081015436_1649916955_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (570, 29, N'156367_3734495661090_1997664861_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (571, 29, N'189545_4581069304902_1205913456_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (572, 29, N'550926_368330333222897_1644516311_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (573, 29, N'555151_3995228259242_1485574183_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (575, 28, N'07-10-2013_photo_07-10-2013_08-00-27_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (576, 28, N'07-10-2013_photo_07-10-2013_08-42-48_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (577, 28, N'07-10-2013_photo_07-10-2013_08-45-44_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (578, 28, N'21-10-2013_photo_21-10-2013_08-16-40_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (579, 28, N'39663_144984578862154_5965201_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (580, 28, N'SE0670_XML_photo_31-10-2013_09-18-33_face_8.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (581, 28, N'SE0670_XML_photo_31-10-2013_09-19-34_face_11.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (582, 28, N'SE0670_XML_photo_31-10-2013_09-23-38_face_10.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (588, 25, N'SE0999  _AJ_photo_25-11-2013_14-18-18_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (589, 1, N'SE0999  _AJ_photo_25-11-2013_14-18-18_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (590, 1, N'SE0999  _AJ_photo_28-11-2013_14-22-29_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (591, 29, N'SE0999  _AJ_photo_01-12-2013_15-27-40_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (597, 65, N'IMAG0236_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (598, 65, N'IMAG0238_face_4.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (599, 65, N'IMAG0239_face_4.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (603, 1, N'SE0999  _AJ_photo_02-12-2013_07-15-33_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (604, 1, N'SE0999  _AJ_photo_02-12-2013_07-15-42_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (605, 1, N'SE0999  _AJ_photo_13-12-2013_11-23-48_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (606, 28, N'SE0999  _AJ_photo_13-12-2013_11-23-48_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (607, 1, N'SE0999  _AJ_photo_13-12-2013_11-23-59_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (608, 28, N'SE0999  _AJ_photo_13-12-2013_11-23-59_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (609, 66, N'261859_180225448800570_1314409475_n_face_5.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (610, 66, N'390699_180909582065490_34678113_n_face_8.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (611, 66, N'480904_180225265467255_204386536_n_face_6.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (612, 66, N'540374_569745343039786_1081277448_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (613, 66, N'600795_180692315420550_626828702_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (614, 66, N'931251_180225128800602_1664103146_n_face_6.jpg')
GO
print 'Processed 300 total records'
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (615, 66, N'942581_180692095420572_1013206898_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (616, 66, N'1149062_220520028104445_58646328_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (617, 66, N'1229836_220519781437803_65711749_n_face_7.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (618, 66, N'1236406_220519568104491_32810934_n_face_6.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (619, 66, N'1280877_220519921437789_1928894500_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (620, 65, N'390699_180909582065490_34678113_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (621, 65, N'540374_569745343039786_1081277448_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (622, 65, N'600795_180692315420550_626828702_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (623, 65, N'944836_180909455398836_1911756935_n_face_6.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (625, 65, N'1229836_220519781437803_65711749_n_face_6.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (626, 65, N'1236406_220519568104491_32810934_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (627, 65, N'1280877_220519921437789_1928894500_n_face_8.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (628, 62, N'63071_4826900624582_72682135_n (1)_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (629, 62, N'63071_4826900624582_72682135_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (631, 62, N'405252_3138890106664_1589458501_n_face_6.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (632, 63, N'420626_180692132087235_221654784_n_face_7.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (634, 63, N'600795_180692315420550_626828702_n_face_5.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (636, 63, N'942581_180692095420572_1013206898_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (637, 64, N'1149062_220520028104445_58646328_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (638, 64, N'63071_4826900624582_72682135_n (1)_face_4.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (639, 63, N'63071_4826900624582_72682135_n (1)_face_5.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (640, 64, N'390699_180909582065490_34678113_n_face_4.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (641, 64, N'944836_180909455398836_1911756935_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (642, 64, N'1229836_220519781437803_65711749_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (643, 64, N'1236406_220519568104491_32810934_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (644, 64, N'1280877_220519921437789_1928894500_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (645, 62, N'8576_10200413420352261_1488736875_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (646, 62, N'67613_2501331148189_1218277264_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (647, 62, N'209008_447575038598037_1487186435_n_face_2.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (648, 62, N'561806_4425575696837_1769890878_n_face_3.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (649, 62, N'733794_237070496431079_1345619933_n_face_7.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (651, 62, N'994145_10200413423632343_1456879184_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (652, 62, N'1004720_10200413421152281_172266521_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (654, 62, N'1013072_10200413431272534_2138155597_n_face_1.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (655, 63, N'1379903_4891879513708_637320706_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (656, 64, N'310487_228701767187727_2061800505_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (657, 64, N'1240454_668657899812955_2034404663_n_face_0.jpg')
INSERT [dbo].[StudentImage] ([ImageID], [StudentID], [ImageLink]) VALUES (658, 64, N'1452106_489163834531125_1822912728_n_face_0.jpg')
SET IDENTITY_INSERT [dbo].[StudentImage] OFF
/****** Object:  Table [dbo].[Request]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Request](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[StudentID] [int] NOT NULL,
	[CheckedAdminID] [int] NULL,
	[IsResponse] [bit] NOT NULL,
	[Context] [nvarchar](100) NOT NULL,
	[CreatedAdminID] [int] NULL,
 CONSTRAINT [PK_Request] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Request] ON
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (15, 2, 1, 1, N'ranh roi gui choi', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (17, 4, 1, 1, N'ranh roi gui choi', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (18, 4, 1, 1, N'ranh roi gui choi', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (19, 22, NULL, 0, N'ranh roi gui choi', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (20, 22, NULL, 0, N'ranh roi gui choi', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (21, 29, NULL, 0, N'ranh roi gui choi', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (22, 5, NULL, 0, N'ranh roi gui choi', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (23, 5, NULL, 0, N'ranh roi gui choi', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (24, 21, NULL, 0, N'ranh roi gui choi', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (27, 1, 1, 1, N'ranh roi gui choi', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (28, 9, NULL, 0, N'ranh gui a vai cai anh choi', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (29, 10, NULL, 0, N'ranh gui a vai cai anh choi', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (30, 11, NULL, 0, N'ranh gui a vai cai anh choi', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (31, 2, 1, 1, N'ranh gui anh vai cai anh ngam choi', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (32, 2, NULL, 0, N'ngam chua du, gui tiep', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (33, 2, NULL, 0, N'Upload 5 more img.', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (34, 4, NULL, 0, N'Upload 5 more img.', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (35, 54, 1, 1, N'up hình đi em', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (36, 22, NULL, 0, N'', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (37, 51, 1, 1, N'Upload 10 tấm', 1)
INSERT [dbo].[Request] ([RequestID], [StudentID], [CheckedAdminID], [IsResponse], [Context], [CreatedAdminID]) VALUES (38, 28, 1, 1, N'Upload 10 hinh', 1)
SET IDENTITY_INSERT [dbo].[Request] OFF
/****** Object:  Table [dbo].[RollCall]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RollCall](
	[RollCallID] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[BeginDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[SubjectID] [int] NOT NULL,
	[ClassID] [int] NOT NULL,
	[SemesterID] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[InstructorID] [int] NOT NULL,
 CONSTRAINT [RollCall_PK] PRIMARY KEY CLUSTERED 
(
	[RollCallID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[RollCall] ON
INSERT [dbo].[RollCall] ([RollCallID], [StartTime], [EndTime], [BeginDate], [EndDate], [SubjectID], [ClassID], [SemesterID], [Status], [InstructorID]) VALUES (39, CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), CAST(0xD5370B00 AS Date), CAST(0xFE370B00 AS Date), 4, 15, 3, 2, 1)
INSERT [dbo].[RollCall] ([RollCallID], [StartTime], [EndTime], [BeginDate], [EndDate], [SubjectID], [ClassID], [SemesterID], [Status], [InstructorID]) VALUES (43, CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), CAST(0xD5370B00 AS Date), CAST(0xE9370B00 AS Date), 16, 3, 3, 3, 2)
INSERT [dbo].[RollCall] ([RollCallID], [StartTime], [EndTime], [BeginDate], [EndDate], [SubjectID], [ClassID], [SemesterID], [Status], [InstructorID]) VALUES (45, CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), CAST(0xD5370B00 AS Date), CAST(0xFE370B00 AS Date), 15, 9, 3, 2, 2)
INSERT [dbo].[RollCall] ([RollCallID], [StartTime], [EndTime], [BeginDate], [EndDate], [SubjectID], [ClassID], [SemesterID], [Status], [InstructorID]) VALUES (47, CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), CAST(0xD5370B00 AS Date), CAST(0xE9370B00 AS Date), 8, 17, 3, 3, 11)
INSERT [dbo].[RollCall] ([RollCallID], [StartTime], [EndTime], [BeginDate], [EndDate], [SubjectID], [ClassID], [SemesterID], [Status], [InstructorID]) VALUES (48, CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), CAST(0xAB370B00 AS Date), CAST(0xBF370B00 AS Date), 3, 9, 3, 3, 2)
INSERT [dbo].[RollCall] ([RollCallID], [StartTime], [EndTime], [BeginDate], [EndDate], [SubjectID], [ClassID], [SemesterID], [Status], [InstructorID]) VALUES (49, CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), CAST(0x0D380B00 AS Date), CAST(0x2F380B00 AS Date), 16, 15, 5, 3, 3)
INSERT [dbo].[RollCall] ([RollCallID], [StartTime], [EndTime], [BeginDate], [EndDate], [SubjectID], [ClassID], [SemesterID], [Status], [InstructorID]) VALUES (53, CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), CAST(0xD5370B00 AS Date), CAST(0xFE370B00 AS Date), 1, 15, 3, 2, 1)
INSERT [dbo].[RollCall] ([RollCallID], [StartTime], [EndTime], [BeginDate], [EndDate], [SubjectID], [ClassID], [SemesterID], [Status], [InstructorID]) VALUES (54, CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), CAST(0xE3370B00 AS Date), CAST(0xFE370B00 AS Date), 10, 9, 3, 2, 1)
SET IDENTITY_INSERT [dbo].[RollCall] OFF
/****** Object:  Table [dbo].[StudySession]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudySession](
	[SessionID] [int] IDENTITY(1,1) NOT NULL,
	[RollCallID] [int] NOT NULL,
	[InstructorID] [int] NOT NULL,
	[SessionDate] [date] NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[ClassID] [int] NOT NULL,
	[Note] [nvarchar](50) NULL,
 CONSTRAINT [PK_StudySession] PRIMARY KEY CLUSTERED 
(
	[SessionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[StudySession] ON
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1949, 45, 2, CAST(0xD5370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'18-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1950, 45, 2, CAST(0xD6370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'19-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1951, 45, 2, CAST(0xD7370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'20-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1952, 45, 2, CAST(0xD8370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'21-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1953, 45, 2, CAST(0xD9370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'22-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1954, 45, 2, CAST(0xDC370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'25-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1955, 45, 2, CAST(0xDD370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'26-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1956, 45, 2, CAST(0xDE370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'27-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1957, 45, 2, CAST(0xDF370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'28-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1958, 45, 2, CAST(0xE0370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'29-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1959, 45, 2, CAST(0xE3370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'02-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1960, 45, 2, CAST(0xE4370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'03-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1961, 45, 2, CAST(0xE5370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'04-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1962, 45, 2, CAST(0xE6370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'05-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1963, 45, 2, CAST(0xE7370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'06-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1964, 45, 2, CAST(0xEA370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'09-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1965, 45, 2, CAST(0xEB370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'10-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1966, 45, 2, CAST(0xEC370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'11-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1967, 45, 2, CAST(0xED370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'12-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1968, 45, 2, CAST(0xEE370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'13-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1969, 45, 2, CAST(0xF1370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'16-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1970, 45, 2, CAST(0xF2370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'17-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1971, 45, 2, CAST(0xF3370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'18-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1972, 45, 2, CAST(0xF4370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'19-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1973, 45, 2, CAST(0xF5370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'20-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1974, 45, 2, CAST(0xF8370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'23-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1975, 45, 2, CAST(0xF9370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'24-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1976, 45, 2, CAST(0xFA370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'25-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1977, 45, 2, CAST(0xFB370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'26-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (1978, 45, 2, CAST(0xFC370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 9, N'27-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2009, 47, 11, CAST(0xD5370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'18-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2010, 47, 11, CAST(0xD6370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'19-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2011, 47, 11, CAST(0xD7370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'20-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2012, 47, 11, CAST(0xD8370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'21-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2013, 47, 11, CAST(0xD9370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'22-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2014, 47, 11, CAST(0xDC370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'25-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2015, 47, 11, CAST(0xDD370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'26-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2016, 47, 11, CAST(0xDE370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'27-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2017, 47, 11, CAST(0xDF370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'28-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2018, 47, 11, CAST(0xE0370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'29-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2019, 47, 11, CAST(0xE3370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'02-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2020, 47, 11, CAST(0xE4370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'03-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2021, 47, 11, CAST(0xE5370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'04-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2022, 47, 11, CAST(0xE6370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'05-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2023, 47, 11, CAST(0xE7370B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 17, N'06-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2189, 43, 2, CAST(0xD5370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'18-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2190, 43, 2, CAST(0xD6370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'19-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2191, 43, 2, CAST(0xD7370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'20-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2192, 43, 2, CAST(0xD8370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'21-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2193, 43, 2, CAST(0xD9370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'22-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2194, 43, 2, CAST(0xDC370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'25-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2195, 43, 2, CAST(0xDD370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'26-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2196, 43, 2, CAST(0xDE370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'27-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2197, 43, 2, CAST(0xDF370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'28-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2198, 43, 2, CAST(0xE0370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'29-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2199, 43, 2, CAST(0xE3370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'02-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2200, 43, 2, CAST(0xE4370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'03-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2201, 43, 2, CAST(0xE5370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'04-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2202, 43, 2, CAST(0xE6370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'05-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2203, 43, 2, CAST(0xE7370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x070066D503840000 AS Time), 3, N'06-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2534, 48, 2, CAST(0xAB370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'07-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2535, 48, 2, CAST(0xAC370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'08-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2536, 48, 2, CAST(0xAD370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'09-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2537, 48, 2, CAST(0xAE370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'10-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2538, 48, 2, CAST(0xAF370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'11-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2539, 48, 2, CAST(0xB2370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'14-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2540, 48, 2, CAST(0xB3370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'15-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2541, 48, 2, CAST(0xB4370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'16-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2542, 48, 2, CAST(0xB5370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'17-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2543, 48, 2, CAST(0xB6370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'18-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2544, 48, 2, CAST(0xB9370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'21-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2545, 48, 2, CAST(0xBA370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'22-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2546, 48, 2, CAST(0xBB370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'23-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2547, 48, 2, CAST(0xBC370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'24-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2548, 48, 2, CAST(0xBD370B00 AS Date), CAST(0x07008E7657490000 AS Time), CAST(0x07002A1DEA550000 AS Time), 9, N'25-10-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2549, 49, 3, CAST(0x0D380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'13-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2550, 49, 3, CAST(0x0E380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'14-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2551, 49, 3, CAST(0x12380B00 AS Date), CAST(0x0700448E02580000 AS Time), CAST(0x0700E03495640000 AS Time), 15, N'18-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2552, 49, 3, CAST(0x10380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'16-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2553, 49, 3, CAST(0x11380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'17-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2554, 49, 3, CAST(0x14380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'20-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2555, 49, 3, CAST(0x15380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'21-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2556, 49, 3, CAST(0x16380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'22-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2557, 49, 3, CAST(0x17380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'23-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2558, 49, 3, CAST(0x18380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'24-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2559, 49, 3, CAST(0x1B380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'27-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2560, 49, 3, CAST(0x1C380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'28-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2561, 49, 3, CAST(0x1D380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'29-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2562, 49, 3, CAST(0x1E380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'30-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2563, 49, 3, CAST(0x1F380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'31-01-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2564, 49, 3, CAST(0x22380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'03-02-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2565, 49, 3, CAST(0x23380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'04-02-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2566, 49, 3, CAST(0x24380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'05-02-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2567, 49, 3, CAST(0x25380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'06-02-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2568, 49, 3, CAST(0x26380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'07-02-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2569, 49, 3, CAST(0x29380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'10-02-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2570, 49, 3, CAST(0x2A380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'11-02-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2571, 49, 3, CAST(0x2B380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'12-02-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2572, 49, 3, CAST(0x2C380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'13-02-2014 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2573, 49, 3, CAST(0x2D380B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'14-02-2014 : ')
GO
print 'Processed 100 total records'
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2694, 39, 1, CAST(0xD5370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'18-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2695, 39, 1, CAST(0xD6370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'19-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2696, 39, 1, CAST(0xD7370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'20-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2697, 39, 1, CAST(0xD8370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'21-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2698, 39, 1, CAST(0xD9370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'22-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2699, 39, 1, CAST(0xDC370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'25-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2700, 39, 1, CAST(0xDD370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'26-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2701, 39, 1, CAST(0xDE370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'27-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2702, 39, 1, CAST(0xDF370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'28-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2703, 39, 1, CAST(0xE0370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'29-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2704, 39, 1, CAST(0xE3370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'02-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2705, 39, 1, CAST(0xE4370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'03-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2706, 39, 1, CAST(0xE5370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'04-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2707, 39, 1, CAST(0xE6370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'05-12-2013 : Thầy Khánh hết bệnh.')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2708, 39, 1, CAST(0xE7370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'06-12-2013 : Thầy Khánh hết bệnh.')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2709, 39, 1, CAST(0xEA370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'09-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2710, 39, 1, CAST(0xEB370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'10-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2711, 39, 1, CAST(0xEC370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'11-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2712, 39, 1, CAST(0xED370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'12-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2713, 39, 1, CAST(0xEE370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'13-12-2013 : Day tum lum')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2714, 39, 1, CAST(0xF1370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'16-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2715, 39, 1, CAST(0xF2370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'17-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2716, 39, 1, CAST(0xF3370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'18-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2717, 39, 1, CAST(0xF4370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'19-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2718, 39, 1, CAST(0xF5370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'20-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2719, 39, 1, CAST(0xF8370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'23-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2720, 39, 1, CAST(0xF9370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'24-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2721, 39, 1, CAST(0xFA370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'25-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2722, 39, 1, CAST(0xFB370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'26-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2723, 39, 1, CAST(0xFC370B00 AS Date), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x07002A1DEA550000 AS Time), 15, N'27-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2790, 53, 1, CAST(0xD5370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'18-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2791, 53, 1, CAST(0xD6370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'19-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2792, 53, 1, CAST(0xD7370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'20-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2793, 53, 1, CAST(0xD8370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'21-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2794, 53, 1, CAST(0xD9370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'22-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2795, 53, 1, CAST(0xDC370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'25-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2796, 53, 1, CAST(0xDD370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'26-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2797, 53, 1, CAST(0xDE370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'27-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2798, 53, 1, CAST(0xDF370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'28-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2799, 53, 1, CAST(0xE0370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'29-11-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2800, 53, 1, CAST(0xE3370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'02-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2801, 53, 1, CAST(0xE4370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'03-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2802, 53, 1, CAST(0xE5370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'04-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2803, 53, 1, CAST(0xE6370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'05-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2804, 53, 1, CAST(0xE7370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'06-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2805, 53, 1, CAST(0xEA370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'09-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2806, 53, 1, CAST(0xEB370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'10-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2807, 53, 1, CAST(0xEC370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'11-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2808, 53, 1, CAST(0xED370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'12-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2809, 53, 1, CAST(0xEE370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'13-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2810, 53, 1, CAST(0xF1370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'16-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2811, 53, 1, CAST(0xF2370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'17-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2812, 53, 1, CAST(0xF3370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'18-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2813, 53, 1, CAST(0xF4370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'19-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2814, 53, 1, CAST(0xF5370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'20-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2815, 53, 1, CAST(0xF8370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'23-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2816, 53, 1, CAST(0xF9370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'24-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2817, 53, 1, CAST(0xFA370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'25-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2818, 53, 1, CAST(0xFB370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'26-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2819, 53, 1, CAST(0xFC370B00 AS Date), CAST(0x07001417C6680000 AS Time), CAST(0x0700B0BD58750000 AS Time), 15, N'27-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2820, 54, 1, CAST(0xE3370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'02-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2821, 54, 1, CAST(0xE4370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'03-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2822, 54, 1, CAST(0xE5370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'04-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2823, 54, 1, CAST(0xE6370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'05-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2824, 54, 1, CAST(0xE7370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'06-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2825, 54, 1, CAST(0xEA370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'09-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2826, 54, 1, CAST(0xEB370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'10-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2827, 54, 1, CAST(0xEC370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'11-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2828, 54, 1, CAST(0xED370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'12-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2829, 54, 1, CAST(0xEE370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'13-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2830, 54, 1, CAST(0xF1370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'16-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2831, 54, 1, CAST(0xF2370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'17-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2832, 54, 1, CAST(0xF3370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'18-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2833, 54, 1, CAST(0xF4370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'19-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2834, 54, 1, CAST(0xF5370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'20-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2835, 54, 1, CAST(0xF8370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'23-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2836, 54, 1, CAST(0xF9370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'24-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2837, 54, 1, CAST(0xFA370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'25-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2838, 54, 1, CAST(0xFB370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'26-12-2013 : ')
INSERT [dbo].[StudySession] ([SessionID], [RollCallID], [InstructorID], [SessionDate], [StartTime], [EndTime], [ClassID], [Note]) VALUES (2839, 54, 1, CAST(0xFC370B00 AS Date), CAST(0x0700CA2E71770000 AS Time), CAST(0x07001CEDAE920000 AS Time), 9, N'27-12-2013 : ')
SET IDENTITY_INSERT [dbo].[StudySession] OFF
/****** Object:  Table [dbo].[StudentInRollCall]    Script Date: 12/15/2013 16:40:35 ******/
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
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (1, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (1, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (1, 48)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (1, 49)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (1, 54)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (2, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (2, 48)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (3, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (3, 48)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (3, 53)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (4, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (4, 48)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (4, 53)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (5, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (5, 48)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (10, 48)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (11, 53)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (12, 48)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (13, 48)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (13, 53)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (15, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (15, 48)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (15, 53)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (16, 53)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (18, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (18, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (18, 48)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (18, 53)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (20, 48)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (21, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (22, 48)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (25, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (25, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (25, 49)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (25, 53)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (28, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (28, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (28, 49)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (28, 54)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (29, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (29, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (29, 49)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (29, 54)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (30, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (30, 49)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (30, 54)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (31, 53)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (32, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (32, 53)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (33, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (33, 49)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (34, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (35, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (36, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (36, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (38, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (40, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (46, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (51, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (52, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (52, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (53, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (54, 43)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (55, 47)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (56, 47)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (59, 47)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (60, 47)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (61, 47)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (62, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (62, 53)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (63, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (63, 53)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (64, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (64, 53)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (65, 39)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (65, 53)
INSERT [dbo].[StudentInRollCall] ([StudentID], [RollCallID]) VALUES (66, 53)
/****** Object:  Table [dbo].[AttendanceLog]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttendanceLog](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[RollCallID] [int] NOT NULL,
	[LogDate] [date] NOT NULL,
	[TypeID] [int] NOT NULL,
 CONSTRAINT [AttendanceLog_PK] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AttendanceLog] ON
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (115, 39, CAST(0xD5370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (116, 39, CAST(0xD5370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (117, 39, CAST(0xD6370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (118, 39, CAST(0xD6370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (119, 39, CAST(0xD7370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (120, 48, CAST(0xAB370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (121, 48, CAST(0xAC370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (122, 48, CAST(0xAD370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (123, 48, CAST(0xAE370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (124, 48, CAST(0xAF370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (125, 48, CAST(0xB2370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (126, 48, CAST(0xB3370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (127, 48, CAST(0xB4370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (128, 48, CAST(0xB5370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (129, 48, CAST(0xB6370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (130, 48, CAST(0xB9370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (131, 48, CAST(0xBA370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (132, 48, CAST(0xBB370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (133, 48, CAST(0xBC370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (134, 48, CAST(0xBD370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (135, 48, CAST(0xAB370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (136, 48, CAST(0xAC370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (137, 48, CAST(0xAD370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (138, 48, CAST(0xAE370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (139, 48, CAST(0xAF370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (140, 48, CAST(0xB2370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (141, 48, CAST(0xB3370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (142, 48, CAST(0xB4370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (143, 48, CAST(0xB5370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (144, 48, CAST(0xB6370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (145, 48, CAST(0xB9370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (146, 48, CAST(0xBA370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (147, 48, CAST(0xBB370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (148, 48, CAST(0xBC370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (149, 48, CAST(0xBD370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (150, 39, CAST(0xD8370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (151, 39, CAST(0xD8370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (152, 39, CAST(0xD7370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (153, 39, CAST(0xDC370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (154, 39, CAST(0xDC370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (155, 39, CAST(0xD9370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (156, 39, CAST(0xD9370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (157, 39, CAST(0xDD370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (158, 39, CAST(0xDD370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (159, 39, CAST(0xDE370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (160, 39, CAST(0xDE370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (161, 39, CAST(0xDF370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (162, 39, CAST(0xDF370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (172, 39, CAST(0xE3370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (173, 39, CAST(0xE3370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (174, 39, CAST(0xE0370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (175, 39, CAST(0xE4370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (176, 39, CAST(0xE4370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (177, 39, CAST(0xE0370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (178, 39, CAST(0xE5370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (179, 39, CAST(0xE5370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (183, 39, CAST(0xE6370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (184, 39, CAST(0xE7370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (185, 39, CAST(0xE6370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (186, 39, CAST(0xE7370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (192, 43, CAST(0xD5370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (193, 43, CAST(0xD6370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (194, 43, CAST(0xD7370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (195, 43, CAST(0xD8370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (196, 43, CAST(0xD9370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (197, 43, CAST(0xDC370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (198, 43, CAST(0xDD370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (199, 43, CAST(0xDE370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (200, 43, CAST(0xDF370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (201, 43, CAST(0xE0370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (202, 43, CAST(0xE3370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (203, 43, CAST(0xE4370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (204, 43, CAST(0xE5370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (205, 43, CAST(0xE6370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (206, 43, CAST(0xE7370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (207, 39, CAST(0xEA370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (208, 39, CAST(0xEB370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (209, 39, CAST(0xEC370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (210, 39, CAST(0xED370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (211, 39, CAST(0xED370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (238, 45, CAST(0xD5370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (239, 45, CAST(0xD6370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (240, 45, CAST(0xD7370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (241, 45, CAST(0xD8370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (242, 45, CAST(0xD9370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (243, 45, CAST(0xDC370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (244, 45, CAST(0xDD370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (245, 45, CAST(0xDE370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (246, 45, CAST(0xDF370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (247, 45, CAST(0xE0370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (248, 45, CAST(0xE3370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (249, 45, CAST(0xE4370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (250, 45, CAST(0xE5370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (251, 45, CAST(0xE6370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (252, 45, CAST(0xE7370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (253, 45, CAST(0xEA370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (254, 45, CAST(0xEB370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (255, 45, CAST(0xEC370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (256, 47, CAST(0xD5370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (257, 47, CAST(0xD6370B00 AS Date), 1)
GO
print 'Processed 100 total records'
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (258, 47, CAST(0xD7370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (259, 47, CAST(0xD8370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (260, 47, CAST(0xD9370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (261, 47, CAST(0xDC370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (262, 47, CAST(0xDD370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (263, 47, CAST(0xDE370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (264, 47, CAST(0xDF370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (265, 47, CAST(0xE0370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (266, 47, CAST(0xE3370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (267, 47, CAST(0xE4370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (268, 47, CAST(0xE5370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (269, 47, CAST(0xE6370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (270, 47, CAST(0xE7370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (271, 39, CAST(0xEA370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (273, 45, CAST(0xED370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (278, 39, CAST(0xEE370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (279, 39, CAST(0xEE370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (280, 53, CAST(0xD5370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (281, 53, CAST(0xD6370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (282, 53, CAST(0xD7370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (283, 53, CAST(0xD8370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (284, 53, CAST(0xD9370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (285, 53, CAST(0xDC370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (286, 53, CAST(0xDD370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (287, 53, CAST(0xDE370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (288, 53, CAST(0xDF370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (289, 53, CAST(0xE0370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (290, 53, CAST(0xE3370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (291, 53, CAST(0xE4370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (292, 53, CAST(0xE5370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (293, 53, CAST(0xE6370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (294, 53, CAST(0xE7370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (295, 53, CAST(0xEA370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (296, 53, CAST(0xEB370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (297, 53, CAST(0xEC370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (298, 53, CAST(0xED370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (299, 53, CAST(0xEE370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (300, 53, CAST(0xD5370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (301, 53, CAST(0xD6370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (302, 53, CAST(0xD7370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (303, 53, CAST(0xD8370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (304, 53, CAST(0xD9370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (305, 53, CAST(0xDC370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (306, 53, CAST(0xDD370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (307, 53, CAST(0xDE370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (308, 53, CAST(0xDF370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (309, 53, CAST(0xE0370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (310, 53, CAST(0xE3370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (311, 53, CAST(0xE5370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (312, 53, CAST(0xE6370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (313, 53, CAST(0xE7370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (314, 53, CAST(0xEB370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (315, 53, CAST(0xEC370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (316, 53, CAST(0xED370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (317, 53, CAST(0xEE370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (318, 54, CAST(0xE3370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (319, 54, CAST(0xE4370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (320, 54, CAST(0xE5370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (321, 54, CAST(0xE6370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (322, 54, CAST(0xE7370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (323, 54, CAST(0xEA370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (324, 54, CAST(0xEB370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (325, 54, CAST(0xEC370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (326, 54, CAST(0xED370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (327, 54, CAST(0xEE370B00 AS Date), 1)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (328, 54, CAST(0xE3370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (329, 54, CAST(0xE4370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (330, 54, CAST(0xE5370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (331, 54, CAST(0xE6370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (332, 54, CAST(0xE7370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (333, 54, CAST(0xEA370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (334, 54, CAST(0xEC370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (335, 54, CAST(0xED370B00 AS Date), 2)
INSERT [dbo].[AttendanceLog] ([LogID], [RollCallID], [LogDate], [TypeID]) VALUES (336, 54, CAST(0xEE370B00 AS Date), 2)
SET IDENTITY_INSERT [dbo].[AttendanceLog] OFF
/****** Object:  Table [dbo].[RequestImage]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RequestImage](
	[ImageID] [int] IDENTITY(1,1) NOT NULL,
	[RequestID] [int] NOT NULL,
	[ImageLink] [varchar](100) NOT NULL,
 CONSTRAINT [PK_RequestImage] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[RequestImage] ON
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (19, 17, N'580882_389797857742811_593816044_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (20, 17, N'602697_3616377268204_1774719767_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (21, 17, N'923041_4322180192836_235894881_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (23, 18, N'63639_3694327616914_1409379090_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (24, 18, N'73980_4118193813304_1038930512_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (25, 18, N'156367_3734495661090_1997664861_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (26, 19, N'1 (4)_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (27, 19, N'1 (5)_face_1.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (28, 19, N'2 (5)_face_1.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (29, 19, N'2 (12)_face_1.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (30, 19, N'2 (14)_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (31, 20, N'184942_131179410285374_1751206_n_face_3.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (32, 20, N'994023_161466597385299_1460113029_n_face_5.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (33, 20, N'1003154_1400829886798237_1866474790_n_face_1.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (34, 21, N'6968_10151275485703514_1211057062_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (35, 21, N'181441_237523953028491_1311046191_n_face_4.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (36, 21, N'252366_10151275497568514_1679113308_n_face_1.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (37, 21, N'386391_347045948640435_381972954_n_face_3.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (38, 21, N'401149_347045888640441_480742487_n_face_3.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (39, 21, N'528346_298940890176495_662254227_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (40, 22, N'9892_378580162248649_1410140173_n_face_2.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (41, 22, N'62394_10200876730262844_1031844442_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (42, 22, N'77070_411003352301551_1365942882_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (43, 22, N'251826_3381862436558_455560461_n_face_1.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (44, 23, N'416865_428578617215309_654867074_n_face_5.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (45, 23, N'537109_461276457258987_1933708444_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (48, 24, N'148959_432834800123024_1163803809_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (49, 24, N'269272_3746947452252_1685981249_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (50, 24, N'307191_432833583456479_167100592_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (51, 24, N'407842_463382123719082_134646340_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (52, 24, N'531915_535694816499070_255870946_n_face_5.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (54, 24, N'581601_428578623881975_15474569_n_face_3.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (60, 27, N'148612_428578673881970_885022895_n_face_3.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (62, 27, N'296352_275744892449207_525655283_n_face_2.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (63, 15, N'300498_273878059302557_995048238_n_face_5.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (64, 15, N'382120_411005282301358_619544131_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (65, 31, N'148612_428578673881970_885022895_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (66, 31, N'282869_428578657215305_134609457_n_face_1.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (67, 31, N'292829_273878085969221_1860462995_n_face_2.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (68, 31, N'296352_275744892449207_525655283_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (70, 27, N'382120_411005282301358_619544131_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (71, 27, N'395049_411003685634851_851796168_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (73, 35, N'300849_3105581816857_1291754647_n_face_1.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (74, 35, N'382120_411005282301358_619544131_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (75, 35, N'395049_411003685634851_851796168_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (76, 37, N'63639_3694327616914_1409379090_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (77, 37, N'73980_4118193813304_1038930512_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (78, 37, N'156367_3734495661090_1997664861_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (79, 37, N'189545_4581069304902_1205913456_n_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (80, 38, N'07-10-2013_photo_07-10-2013_08-00-27_face_0.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (81, 38, N'07-10-2013_photo_07-10-2013_08-42-48_face_3.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (82, 38, N'07-10-2013_photo_07-10-2013_08-45-44_face_2.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (83, 38, N'21-10-2013_photo_21-10-2013_08-16-40_face_1.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (84, 38, N'39663_144984578862154_5965201_n_face_2.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (85, 38, N'SE0670_XML_photo_31-10-2013_09-18-33_face_8.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (86, 38, N'SE0670_XML_photo_31-10-2013_09-19-34_face_11.jpg')
INSERT [dbo].[RequestImage] ([ImageID], [RequestID], [ImageLink]) VALUES (87, 38, N'SE0670_XML_photo_31-10-2013_09-23-38_face_10.jpg')
SET IDENTITY_INSERT [dbo].[RequestImage] OFF
/****** Object:  Table [dbo].[StudentAttendance]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentAttendance](
	[LogID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[IsPresent] [bit] NOT NULL,
	[Note] [nvarchar](50) NULL,
 CONSTRAINT [StudentAttendance_PK] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC,
	[StudentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (115, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (115, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (115, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (115, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (115, 30, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (115, 33, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (116, 1, 0, N'(khanhkt) P->A : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (116, 21, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (116, 25, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (116, 28, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (116, 29, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (116, 30, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (116, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (116, 33, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (116, 62, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (116, 63, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (116, 64, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (117, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (117, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (117, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (117, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (117, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (117, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (118, 1, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (118, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (118, 25, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (118, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (118, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (118, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (118, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (118, 33, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (118, 62, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (118, 63, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (118, 64, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (119, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (119, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (119, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (119, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (119, 30, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (119, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (135, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (135, 2, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (135, 3, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (135, 4, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (135, 5, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (135, 10, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (135, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (135, 13, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (135, 15, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (135, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (135, 20, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (135, 22, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (136, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (136, 2, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (136, 3, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (136, 4, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (136, 5, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (136, 10, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (136, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (136, 13, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (136, 15, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (136, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (136, 20, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (136, 22, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (137, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (137, 2, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (137, 3, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (137, 4, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (137, 5, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (137, 10, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (137, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (137, 13, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (137, 15, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (137, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (137, 20, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (137, 22, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (138, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (138, 2, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (138, 3, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (138, 4, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (138, 5, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (138, 10, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (138, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (138, 13, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (138, 15, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (138, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (138, 20, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (138, 22, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (139, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (139, 2, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (139, 3, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (139, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (139, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (139, 10, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (139, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (139, 13, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (139, 15, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (139, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (139, 20, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (139, 22, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (140, 1, 1, NULL)
GO
print 'Processed 100 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (140, 2, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (140, 3, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (140, 4, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (140, 5, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (140, 10, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (140, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (140, 13, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (140, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (140, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (140, 20, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (140, 22, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (141, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (141, 2, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (141, 3, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (141, 4, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (141, 5, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (141, 10, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (141, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (141, 13, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (141, 15, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (141, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (141, 20, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (141, 22, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (142, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (142, 2, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (142, 3, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (142, 4, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (142, 5, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (142, 10, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (142, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (142, 13, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (142, 15, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (142, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (142, 20, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (142, 22, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (143, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (143, 2, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (143, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (143, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (143, 5, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (143, 10, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (143, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (143, 13, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (143, 15, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (143, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (143, 20, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (143, 22, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (144, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (144, 2, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (144, 3, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (144, 4, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (144, 5, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (144, 10, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (144, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (144, 13, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (144, 15, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (144, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (144, 20, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (144, 22, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (145, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (145, 2, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (145, 3, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (145, 4, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (145, 5, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (145, 10, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (145, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (145, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (145, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (145, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (145, 20, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (145, 22, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (146, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (146, 2, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (146, 3, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (146, 4, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (146, 5, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (146, 10, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (146, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (146, 13, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (146, 15, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (146, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (146, 20, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (146, 22, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (147, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (147, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (147, 3, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (147, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (147, 5, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (147, 10, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (147, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (147, 13, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (147, 15, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (147, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (147, 20, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (147, 22, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (148, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (148, 2, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (148, 3, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (148, 4, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (148, 5, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (148, 10, 1, NULL)
GO
print 'Processed 200 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (148, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (148, 13, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (148, 15, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (148, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (148, 20, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (148, 22, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (149, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (149, 2, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (149, 3, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (149, 4, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (149, 5, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (149, 10, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (149, 12, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (149, 13, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (149, 15, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (149, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (149, 20, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (149, 22, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (150, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (150, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (150, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (150, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (150, 30, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (150, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (151, 1, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (151, 21, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (151, 25, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (151, 28, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (151, 29, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (151, 30, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (151, 32, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (151, 33, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (151, 62, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (151, 63, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (151, 64, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (152, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (152, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (152, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (152, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (152, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (152, 30, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (152, 32, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (152, 33, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (152, 62, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (152, 63, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (152, 64, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (153, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (153, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (153, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (153, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (153, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (153, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (154, 1, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (154, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (154, 25, 0, N'(khanhkt) P->A : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (154, 28, 0, N'(khanhkt) P->A : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (154, 29, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (154, 30, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (154, 32, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (154, 33, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (154, 62, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (154, 63, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (154, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (155, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (155, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (155, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (155, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (155, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (155, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (156, 1, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (156, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (156, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (156, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (156, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (156, 30, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (156, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (156, 33, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (156, 62, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (156, 63, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (156, 64, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (157, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (157, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (157, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (157, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (157, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (157, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (158, 1, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (158, 21, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (158, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (158, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (158, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (158, 30, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (158, 32, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (158, 33, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (158, 62, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (158, 63, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (158, 64, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (159, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (159, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (159, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (159, 29, 1, NULL)
GO
print 'Processed 300 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (159, 30, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (159, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (160, 1, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (160, 21, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (160, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (160, 28, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (160, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (160, 30, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (160, 32, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (160, 33, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (160, 62, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (160, 63, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (160, 64, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (161, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (161, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (161, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (161, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (161, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (161, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (162, 1, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (162, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (162, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (162, 28, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (162, 29, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (162, 30, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (162, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (162, 33, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (162, 62, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (162, 63, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (162, 64, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (172, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (172, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (172, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (172, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (172, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (172, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (173, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (173, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (173, 25, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (173, 28, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (173, 29, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (173, 30, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (173, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (173, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (173, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (173, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (173, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (176, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (176, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (176, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (176, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (176, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (176, 30, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (176, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (176, 33, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (176, 62, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (176, 63, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (176, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (177, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (177, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (177, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (177, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (177, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (177, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (177, 32, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (177, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (177, 62, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (177, 63, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (177, 64, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 30, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 32, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 52, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (178, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 30, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 32, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 33, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 36, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 52, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 62, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 63, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 64, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (179, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 18, 1, NULL)
GO
print 'Processed 400 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 52, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (183, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 30, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (184, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 1, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 21, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 25, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 32, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 33, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 36, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 52, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (185, 65, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 1, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 18, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 21, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 25, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 28, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 30, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 32, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 33, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 36, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 52, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 62, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 63, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 64, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (186, 65, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (192, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (193, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 3, 0, NULL)
GO
print 'Processed 500 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (194, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (195, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (196, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (197, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (198, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 4, 0, NULL)
GO
print 'Processed 600 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (199, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (200, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (201, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (202, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (203, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 5, 0, NULL)
GO
print 'Processed 700 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (204, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (205, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 2, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 5, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 34, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 35, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 38, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 40, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 46, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 51, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 53, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (206, 54, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (207, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (208, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (209, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 1, 0, NULL)
GO
print 'Processed 800 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 52, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (210, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 1, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 29, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 52, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 62, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 63, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 64, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (211, 65, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (256, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (256, 56, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (256, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (256, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (256, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (257, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (257, 56, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (257, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (257, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (257, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (258, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (258, 56, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (258, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (258, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (258, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (259, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (259, 56, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (259, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (259, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (259, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (260, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (260, 56, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (260, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (260, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (260, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (261, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (261, 56, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (261, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (261, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (261, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (262, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (262, 56, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (262, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (262, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (262, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (263, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (263, 56, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (263, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (263, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (263, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (264, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (264, 56, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (264, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (264, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (264, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (265, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (265, 56, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (265, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (265, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (265, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (266, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (266, 56, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (266, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (266, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (266, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (267, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (267, 56, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (267, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (267, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (267, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (268, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (268, 56, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (268, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (268, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (268, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (269, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (269, 56, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (269, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (269, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (269, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (270, 55, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (270, 56, 0, NULL)
GO
print 'Processed 900 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (270, 59, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (270, 60, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (270, 61, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 1, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 21, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 28, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 29, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 30, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 33, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 36, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 52, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (271, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 1, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 18, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 21, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 63, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (278, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 1, 0, N'(khanhkt) P->A : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 18, 0, N'(khanhkt) P->A : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 21, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 28, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 29, 1, N'(khanhkt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 33, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 36, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 52, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 63, 1, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (279, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (280, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (281, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (282, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 25, 0, NULL)
GO
print 'Processed 1000 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (283, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (284, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (285, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (286, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (287, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (288, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (289, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 13, 0, NULL)
GO
print 'Processed 1100 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (290, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (291, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (292, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (293, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (294, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (295, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (296, 66, 0, NULL)
GO
print 'Processed 1200 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (297, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (298, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 13, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 25, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 31, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 32, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 62, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 63, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 64, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 65, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (299, 66, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 3, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 4, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 11, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (300, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 3, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 4, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 11, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (301, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 3, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 4, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 11, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (302, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 3, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 4, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 11, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 62, 1, N'(quangnt) A->P : ')
GO
print 'Processed 1300 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (303, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 3, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 4, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 11, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (304, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 3, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 4, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 11, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (305, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 3, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 4, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 11, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (306, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 3, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 4, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 11, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (307, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 3, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 4, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 11, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (308, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 3, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 4, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 11, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (309, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 18, 1, N'(quangnt) A->P : ')
GO
print 'Processed 1400 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (310, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 3, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 4, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 11, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 15, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 16, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 18, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (311, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (312, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 11, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (313, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 3, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 4, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 11, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (314, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 11, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (315, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 11, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (316, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 3, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 4, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 11, 0, NULL)
GO
print 'Processed 1500 total records'
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 13, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 15, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 16, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 18, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 25, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 31, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 32, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 62, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 63, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 64, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 65, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (317, 66, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (318, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (318, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (318, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (318, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (319, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (319, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (319, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (319, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (320, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (320, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (320, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (320, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (321, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (321, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (321, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (321, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (322, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (322, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (322, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (322, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (323, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (323, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (323, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (323, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (324, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (324, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (324, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (324, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (325, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (325, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (325, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (325, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (326, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (326, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (326, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (326, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (327, 1, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (327, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (327, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (327, 30, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (328, 1, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (328, 28, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (328, 29, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (328, 30, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (329, 1, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (329, 28, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (329, 29, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (329, 30, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (330, 1, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (330, 28, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (330, 29, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (330, 30, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (331, 1, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (331, 28, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (331, 29, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (331, 30, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (332, 1, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (332, 28, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (332, 29, 0, NULL)
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (332, 30, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (333, 1, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (333, 28, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (333, 29, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (333, 30, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (334, 1, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (334, 28, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (334, 29, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (334, 30, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (335, 1, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (335, 28, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (335, 29, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (335, 30, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (336, 1, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (336, 28, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (336, 29, 1, N'(quangnt) A->P : ')
INSERT [dbo].[StudentAttendance] ([LogID], [StudentID], [IsPresent], [Note]) VALUES (336, 30, 1, N'(quangnt) A->P : ')
/****** Object:  Table [dbo].[LogImage]    Script Date: 12/15/2013 16:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LogImage](
	[ImageID] [int] IDENTITY(1,1) NOT NULL,
	[LogID] [int] NOT NULL,
	[ImageLink] [varchar](100) NOT NULL,
 CONSTRAINT [LogImage_PK] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[LogImage] ON
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (172, 115, N'SE0999  _AJ_photo_20-11-2013_15-52-26.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (173, 115, N'SE0999  _AJ_photo_20-11-2013_15-52-50.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (174, 115, N'SE0999  _AJ_21-10-2013_photo_21-10-2013_08-16-40.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (175, 115, N'SE0999  _AJ_25-10-2013_photo_28-10-2013_09-32-29.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (176, 117, N'SE0999  _AJ_07-10-2013_photo_07-10-2013_08-42-48.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (177, 119, N'SE0999  _AJ_07-10-2013_photo_07-10-2013_08-45-44.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (178, 119, N'SE0999  _AJ_25-10-2013_photo_28-10-2013_09-32-29.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (179, 150, N'SE0999  _AJ_photo_21-11-2013_14-35-48.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (180, 153, N'SE0999  _AJ_photo_25-11-2013_14-18-18.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (181, 155, N'SE0999  _AJ_21-10-2013_photo_21-10-2013_08-16-40.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (182, 157, N'SE0999  _AJ_07-10-2013_photo_07-10-2013_08-45-44.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (183, 159, N'SE0999  _AJ_25-10-2013_photo_28-10-2013_09-32-29.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (184, 161, N'SE0999  _AJ_photo_28-11-2013_14-22-29.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (230, 172, N'SE0999  _AJ_photo_02-12-2013_07-15-33.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (231, 172, N'SE0999  _AJ_photo_02-12-2013_07-15-42.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (232, 178, N'SE0999  _AJ_photo_04-12-2013_07-34-11.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (233, 178, N'SE0999  _AJ_photo_04-12-2013_07-34-26.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (234, 178, N'SE0999  _AJ_photo_04-12-2013_07-34-33.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (240, 183, N'SE0999  _AJ_07-10-2013_photo_07-10-2013_08-42-48.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (241, 184, N'SE0999  _AJ_25-10-2013_photo_28-10-2013_09-32-29.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (242, 210, N'SE0999  _AJ_07-10-2013_photo_07-10-2013_08-42-48.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (245, 278, N'SE0999  _AJ_photo_13-12-2013_11-23-48.jpg')
INSERT [dbo].[LogImage] ([ImageID], [LogID], [ImageLink]) VALUES (246, 278, N'SE0999  _AJ_photo_13-12-2013_11-23-59.jpg')
SET IDENTITY_INSERT [dbo].[LogImage] OFF
/****** Object:  ForeignKey [Role_User_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [Role_User_FK1] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [Role_User_FK1]
GO
/****** Object:  ForeignKey [FK_Class_Major]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[Class]  WITH CHECK ADD  CONSTRAINT [FK_Class_Major] FOREIGN KEY([MajorID])
REFERENCES [dbo].[Major] ([MajorID])
GO
ALTER TABLE [dbo].[Class] CHECK CONSTRAINT [FK_Class_Major]
GO
/****** Object:  ForeignKey [FK_Subject_SubjectType]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[Subject]  WITH CHECK ADD  CONSTRAINT [FK_Subject_SubjectType] FOREIGN KEY([TypeID])
REFERENCES [dbo].[SubjectType] ([TypeID])
GO
ALTER TABLE [dbo].[Subject] CHECK CONSTRAINT [FK_Subject_SubjectType]
GO
/****** Object:  ForeignKey [Major_SubjectMajorMapping_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[SubjectMajorMapping]  WITH CHECK ADD  CONSTRAINT [Major_SubjectMajorMapping_FK1] FOREIGN KEY([MajorID])
REFERENCES [dbo].[Major] ([MajorID])
GO
ALTER TABLE [dbo].[SubjectMajorMapping] CHECK CONSTRAINT [Major_SubjectMajorMapping_FK1]
GO
/****** Object:  ForeignKey [Subject_SubjectMajorMapping_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[SubjectMajorMapping]  WITH CHECK ADD  CONSTRAINT [Subject_SubjectMajorMapping_FK1] FOREIGN KEY([SubjectID])
REFERENCES [dbo].[Subject] ([SubjectID])
GO
ALTER TABLE [dbo].[SubjectMajorMapping] CHECK CONSTRAINT [Subject_SubjectMajorMapping_FK1]
GO
/****** Object:  ForeignKey [Class_Student_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [Class_Student_FK1] FOREIGN KEY([ClassID])
REFERENCES [dbo].[Class] ([ClassID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [Class_Student_FK1]
GO
/****** Object:  ForeignKey [User_Student_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [User_Student_FK1] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [User_Student_FK1]
GO
/****** Object:  ForeignKey [User_Staff_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [User_Staff_FK1] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [User_Staff_FK1]
GO
/****** Object:  ForeignKey [User_Instructor_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[Instructor]  WITH CHECK ADD  CONSTRAINT [User_Instructor_FK1] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Instructor] CHECK CONSTRAINT [User_Instructor_FK1]
GO
/****** Object:  ForeignKey [FK_InstructorTeaching_Instructor]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[InstructorTeaching]  WITH CHECK ADD  CONSTRAINT [FK_InstructorTeaching_Instructor] FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([InstructorID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InstructorTeaching] CHECK CONSTRAINT [FK_InstructorTeaching_Instructor]
GO
/****** Object:  ForeignKey [FK_InstructorTeaching_SubjectType]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[InstructorTeaching]  WITH CHECK ADD  CONSTRAINT [FK_InstructorTeaching_SubjectType] FOREIGN KEY([SubjectTypeID])
REFERENCES [dbo].[SubjectType] ([TypeID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InstructorTeaching] CHECK CONSTRAINT [FK_InstructorTeaching_SubjectType]
GO
/****** Object:  ForeignKey [Student_StudentImage_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[StudentImage]  WITH CHECK ADD  CONSTRAINT [Student_StudentImage_FK1] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[StudentImage] CHECK CONSTRAINT [Student_StudentImage_FK1]
GO
/****** Object:  ForeignKey [FK_Request_Student]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[Request]  WITH CHECK ADD  CONSTRAINT [FK_Request_Student] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_Request_Student]
GO
/****** Object:  ForeignKey [FK_Request_User]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[Request]  WITH CHECK ADD  CONSTRAINT [FK_Request_User] FOREIGN KEY([CheckedAdminID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_Request_User]
GO
/****** Object:  ForeignKey [FK_RollCall_Class]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[RollCall]  WITH CHECK ADD  CONSTRAINT [FK_RollCall_Class] FOREIGN KEY([ClassID])
REFERENCES [dbo].[Class] ([ClassID])
GO
ALTER TABLE [dbo].[RollCall] CHECK CONSTRAINT [FK_RollCall_Class]
GO
/****** Object:  ForeignKey [FK_RollCall_Instructor]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[RollCall]  WITH CHECK ADD  CONSTRAINT [FK_RollCall_Instructor] FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([InstructorID])
GO
ALTER TABLE [dbo].[RollCall] CHECK CONSTRAINT [FK_RollCall_Instructor]
GO
/****** Object:  ForeignKey [FK_RollCall_Semester]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[RollCall]  WITH CHECK ADD  CONSTRAINT [FK_RollCall_Semester] FOREIGN KEY([SemesterID])
REFERENCES [dbo].[Semester] ([SemesterID])
GO
ALTER TABLE [dbo].[RollCall] CHECK CONSTRAINT [FK_RollCall_Semester]
GO
/****** Object:  ForeignKey [FK_RollCall_Subject]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[RollCall]  WITH CHECK ADD  CONSTRAINT [FK_RollCall_Subject] FOREIGN KEY([SubjectID])
REFERENCES [dbo].[Subject] ([SubjectID])
GO
ALTER TABLE [dbo].[RollCall] CHECK CONSTRAINT [FK_RollCall_Subject]
GO
/****** Object:  ForeignKey [FK_StudySession_Class]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[StudySession]  WITH CHECK ADD  CONSTRAINT [FK_StudySession_Class] FOREIGN KEY([ClassID])
REFERENCES [dbo].[Class] ([ClassID])
GO
ALTER TABLE [dbo].[StudySession] CHECK CONSTRAINT [FK_StudySession_Class]
GO
/****** Object:  ForeignKey [FK_StudySession_Instructor]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[StudySession]  WITH CHECK ADD  CONSTRAINT [FK_StudySession_Instructor] FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([InstructorID])
GO
ALTER TABLE [dbo].[StudySession] CHECK CONSTRAINT [FK_StudySession_Instructor]
GO
/****** Object:  ForeignKey [FK_StudySession_RollCall]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[StudySession]  WITH CHECK ADD  CONSTRAINT [FK_StudySession_RollCall] FOREIGN KEY([RollCallID])
REFERENCES [dbo].[RollCall] ([RollCallID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StudySession] CHECK CONSTRAINT [FK_StudySession_RollCall]
GO
/****** Object:  ForeignKey [RollCall_StudentInRollCall_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[StudentInRollCall]  WITH CHECK ADD  CONSTRAINT [RollCall_StudentInRollCall_FK1] FOREIGN KEY([RollCallID])
REFERENCES [dbo].[RollCall] ([RollCallID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StudentInRollCall] CHECK CONSTRAINT [RollCall_StudentInRollCall_FK1]
GO
/****** Object:  ForeignKey [Student_StudentInRollCall_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[StudentInRollCall]  WITH CHECK ADD  CONSTRAINT [Student_StudentInRollCall_FK1] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StudentInRollCall] CHECK CONSTRAINT [Student_StudentInRollCall_FK1]
GO
/****** Object:  ForeignKey [LogType_AttendanceLog_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[AttendanceLog]  WITH CHECK ADD  CONSTRAINT [LogType_AttendanceLog_FK1] FOREIGN KEY([TypeID])
REFERENCES [dbo].[LogType] ([TypeID])
GO
ALTER TABLE [dbo].[AttendanceLog] CHECK CONSTRAINT [LogType_AttendanceLog_FK1]
GO
/****** Object:  ForeignKey [RollCall_AttendanceLog_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[AttendanceLog]  WITH CHECK ADD  CONSTRAINT [RollCall_AttendanceLog_FK1] FOREIGN KEY([RollCallID])
REFERENCES [dbo].[RollCall] ([RollCallID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AttendanceLog] CHECK CONSTRAINT [RollCall_AttendanceLog_FK1]
GO
/****** Object:  ForeignKey [FK_RequestImage_Request]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[RequestImage]  WITH CHECK ADD  CONSTRAINT [FK_RequestImage_Request] FOREIGN KEY([RequestID])
REFERENCES [dbo].[Request] ([RequestID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RequestImage] CHECK CONSTRAINT [FK_RequestImage_Request]
GO
/****** Object:  ForeignKey [AttendanceLog_StudentAttendance_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[StudentAttendance]  WITH CHECK ADD  CONSTRAINT [AttendanceLog_StudentAttendance_FK1] FOREIGN KEY([LogID])
REFERENCES [dbo].[AttendanceLog] ([LogID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StudentAttendance] CHECK CONSTRAINT [AttendanceLog_StudentAttendance_FK1]
GO
/****** Object:  ForeignKey [Student_StudentAttendance_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[StudentAttendance]  WITH CHECK ADD  CONSTRAINT [Student_StudentAttendance_FK1] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StudentAttendance] CHECK CONSTRAINT [Student_StudentAttendance_FK1]
GO
/****** Object:  ForeignKey [AttendanceLog_LogImage_FK1]    Script Date: 12/15/2013 16:40:35 ******/
ALTER TABLE [dbo].[LogImage]  WITH CHECK ADD  CONSTRAINT [AttendanceLog_LogImage_FK1] FOREIGN KEY([LogID])
REFERENCES [dbo].[AttendanceLog] ([LogID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LogImage] CHECK CONSTRAINT [AttendanceLog_LogImage_FK1]
GO
