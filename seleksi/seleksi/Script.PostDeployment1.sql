/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

DELETE FROM [dbo].[status];

INSERT [dbo].[status] ([kode_status], [nama]) VALUES (0, N'BELUM DIPROSES')
GO
INSERT [dbo].[status] ([kode_status], [nama]) VALUES (1, N'DITERIMA')
GO
INSERT [dbo].[status] ([kode_status], [nama]) VALUES (2, N'TIDAK DITERIMA')
GO