﻿/*
Deployment script for seleksi

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "seleksi"
:setvar DefaultFilePrefix "seleksi"
:setvar DefaultDataPath "D:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS2017\MSSQL\DATA\"
:setvar DefaultLogPath "D:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS2017\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
PRINT N'Creating [dbo].[_peserta_diterima_final]...';


GO
CREATE TABLE [dbo].[_peserta_diterima_final] (
    [kode_peserta]    VARCHAR (50)  NOT NULL,
    [nama]            VARCHAR (255) NOT NULL,
    [kode_penempatan] VARCHAR (50)  NOT NULL,
    [pil_ke]          TINYINT       NOT NULL,
    [nilai]           FLOAT (53)    NOT NULL,
    [kode_status]     TINYINT       NOT NULL,
    CONSTRAINT [PK_peserta_diterima_final] PRIMARY KEY CLUSTERED ([kode_peserta] ASC, [pil_ke] ASC)
);


GO
PRINT N'Creating [dbo].[_peserta_diterima_matic]...';


GO
CREATE TABLE [dbo].[_peserta_diterima_matic] (
    [kode_peserta]    VARCHAR (50)  NOT NULL,
    [nama]            VARCHAR (255) NOT NULL,
    [kode_penempatan] VARCHAR (50)  NOT NULL,
    [pil_ke]          TINYINT       NOT NULL,
    [nilai]           FLOAT (53)    NOT NULL,
    [kode_status]     TINYINT       NOT NULL,
    CONSTRAINT [PK_peserta_diterima_matic] PRIMARY KEY CLUSTERED ([kode_peserta] ASC, [pil_ke] ASC)
);


GO
PRINT N'Creating [dbo].[penempatan]...';


GO
CREATE TABLE [dbo].[penempatan] (
    [kode_penempatan] VARCHAR (50)  NOT NULL,
    [nama]            VARCHAR (255) NOT NULL,
    [daya_tampung]    INT           NOT NULL,
    [isi]             INT           NOT NULL,
    [min_nilai]       FLOAT (53)    NOT NULL,
    [sisa_peminat]    INT           NOT NULL,
    CONSTRAINT [PK_penempatan] PRIMARY KEY CLUSTERED ([kode_penempatan] ASC)
);


GO
PRINT N'Creating [dbo].[peserta]...';


GO
CREATE TABLE [dbo].[peserta] (
    [kode_peserta]    VARCHAR (50)  NOT NULL,
    [nama]            VARCHAR (255) NOT NULL,
    [kode_penempatan] VARCHAR (50)  NOT NULL,
    [pil_ke]          TINYINT       NOT NULL,
    [nilai]           FLOAT (53)    NOT NULL,
    [kode_status]     TINYINT       NOT NULL,
    CONSTRAINT [PK_peserta] PRIMARY KEY CLUSTERED ([kode_peserta] ASC, [pil_ke] ASC)
);


GO
PRINT N'Creating [dbo].[status]...';


GO
CREATE TABLE [dbo].[status] (
    [kode_status] TINYINT      NOT NULL,
    [nama]        VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_status] PRIMARY KEY CLUSTERED ([kode_status] ASC)
);


GO
PRINT N'Creating [dbo].[DF_peserta_diterima_final_kode_status]...';


GO
ALTER TABLE [dbo].[_peserta_diterima_final]
    ADD CONSTRAINT [DF_peserta_diterima_final_kode_status] DEFAULT ((0)) FOR [kode_status];


GO
PRINT N'Creating [dbo].[DF_peserta_diterima_matic_kode_status]...';


GO
ALTER TABLE [dbo].[_peserta_diterima_matic]
    ADD CONSTRAINT [DF_peserta_diterima_matic_kode_status] DEFAULT ((0)) FOR [kode_status];


GO
PRINT N'Creating [dbo].[DF_penempatan_isi]...';


GO
ALTER TABLE [dbo].[penempatan]
    ADD CONSTRAINT [DF_penempatan_isi] DEFAULT ((0)) FOR [isi];


GO
PRINT N'Creating [dbo].[DF_penempatan_nilai_minimum]...';


GO
ALTER TABLE [dbo].[penempatan]
    ADD CONSTRAINT [DF_penempatan_nilai_minimum] DEFAULT ((-1)) FOR [min_nilai];


GO
PRINT N'Creating [dbo].[DF_penempatan_sisa_peminat]...';


GO
ALTER TABLE [dbo].[penempatan]
    ADD CONSTRAINT [DF_penempatan_sisa_peminat] DEFAULT ((0)) FOR [sisa_peminat];


GO
PRINT N'Creating [dbo].[DF_peserta_kode_status]...';


GO
ALTER TABLE [dbo].[peserta]
    ADD CONSTRAINT [DF_peserta_kode_status] DEFAULT ((0)) FOR [kode_status];


GO
PRINT N'Creating [dbo].[FK_peserta_diterima_final_penempatan]...';


GO
ALTER TABLE [dbo].[_peserta_diterima_final] WITH NOCHECK
    ADD CONSTRAINT [FK_peserta_diterima_final_penempatan] FOREIGN KEY ([kode_penempatan]) REFERENCES [dbo].[penempatan] ([kode_penempatan]);


GO
PRINT N'Creating [dbo].[FK_peserta_diterima_final_status]...';


GO
ALTER TABLE [dbo].[_peserta_diterima_final] WITH NOCHECK
    ADD CONSTRAINT [FK_peserta_diterima_final_status] FOREIGN KEY ([kode_status]) REFERENCES [dbo].[status] ([kode_status]);


GO
PRINT N'Creating [dbo].[FK_peserta_diterima_matic_penempatan]...';


GO
ALTER TABLE [dbo].[_peserta_diterima_matic] WITH NOCHECK
    ADD CONSTRAINT [FK_peserta_diterima_matic_penempatan] FOREIGN KEY ([kode_penempatan]) REFERENCES [dbo].[penempatan] ([kode_penempatan]);


GO
PRINT N'Creating [dbo].[FK_peserta_diterima_matic_status]...';


GO
ALTER TABLE [dbo].[_peserta_diterima_matic] WITH NOCHECK
    ADD CONSTRAINT [FK_peserta_diterima_matic_status] FOREIGN KEY ([kode_status]) REFERENCES [dbo].[status] ([kode_status]);


GO
PRINT N'Creating [dbo].[FK_peserta_penempatan]...';


GO
ALTER TABLE [dbo].[peserta] WITH NOCHECK
    ADD CONSTRAINT [FK_peserta_penempatan] FOREIGN KEY ([kode_penempatan]) REFERENCES [dbo].[penempatan] ([kode_penempatan]);


GO
PRINT N'Creating [dbo].[FK_peserta_status]...';


GO
ALTER TABLE [dbo].[peserta] WITH NOCHECK
    ADD CONSTRAINT [FK_peserta_status] FOREIGN KEY ([kode_status]) REFERENCES [dbo].[status] ([kode_status]);


GO
PRINT N'Creating [dbo].[CK_peserta_diterima_final_nilai]...';


GO
ALTER TABLE [dbo].[_peserta_diterima_final] WITH NOCHECK
    ADD CONSTRAINT [CK_peserta_diterima_final_nilai] CHECK ([nilai]>(0));


GO
PRINT N'Creating [dbo].[CK_peserta_diterima_final_pil_ke]...';


GO
ALTER TABLE [dbo].[_peserta_diterima_final] WITH NOCHECK
    ADD CONSTRAINT [CK_peserta_diterima_final_pil_ke] CHECK ([pil_ke]>(0));


GO
PRINT N'Creating [dbo].[CK_peserta_diterima_matic_nilai]...';


GO
ALTER TABLE [dbo].[_peserta_diterima_matic] WITH NOCHECK
    ADD CONSTRAINT [CK_peserta_diterima_matic_nilai] CHECK ([nilai]>(0));


GO
PRINT N'Creating [dbo].[CK_peserta_diterima_matic_pil_ke]...';


GO
ALTER TABLE [dbo].[_peserta_diterima_matic] WITH NOCHECK
    ADD CONSTRAINT [CK_peserta_diterima_matic_pil_ke] CHECK ([pil_ke]>(0));


GO
PRINT N'Creating [dbo].[CK_penempatan_daya_tampung]...';


GO
ALTER TABLE [dbo].[penempatan] WITH NOCHECK
    ADD CONSTRAINT [CK_penempatan_daya_tampung] CHECK ([daya_tampung]>(0));


GO
PRINT N'Creating [dbo].[CK_penempatan_dt_isi]...';


GO
ALTER TABLE [dbo].[penempatan] WITH NOCHECK
    ADD CONSTRAINT [CK_penempatan_dt_isi] CHECK ([daya_tampung]<=[isi]);


GO
PRINT N'Creating [dbo].[CK_penempatan_isi]...';


GO
ALTER TABLE [dbo].[penempatan] WITH NOCHECK
    ADD CONSTRAINT [CK_penempatan_isi] CHECK ([isi]>=(0));


GO
PRINT N'Creating [dbo].[CK_peserta_nilai]...';


GO
ALTER TABLE [dbo].[peserta] WITH NOCHECK
    ADD CONSTRAINT [CK_peserta_nilai] CHECK ([nilai]>(0));


GO
PRINT N'Creating [dbo].[CK_peserta_pil_ke]...';


GO
ALTER TABLE [dbo].[peserta] WITH NOCHECK
    ADD CONSTRAINT [CK_peserta_pil_ke] CHECK ([pil_ke]>(0));


GO
PRINT N'Creating [dbo].[peserta_diterima]...';


GO
create view peserta_diterima with schemabinding as 
select kode_peserta,nama,kode_penempatan,pil_ke,nilai 
from dbo.peserta 
where kode_status = 1;
GO
PRINT N'Creating [dbo].[peserta_diterima].[PK]...';


GO
CREATE UNIQUE CLUSTERED INDEX [PK]
    ON [dbo].[peserta_diterima]([kode_peserta] ASC);


GO
PRINT N'Creating [dbo].[_hitung_min_nilai]...';


GO

CREATE PROCEDURE _hitung_min_nilai
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE b 
	SET b.min_nilai = a.nilai
	FROM (
		SELECT kode_penempatan,nilai
		FROM (
			SELECT a.kode_penempatan,min(a.nilai) as nilai,b.daya_tampung,count(a.kode_peserta) as jml_terima
			FROM _peserta_diterima_final a
			JOIN penempatan b ON a.kode_penempatan = b.kode_penempatan
			GROUP BY a.kode_penempatan,b.daya_tampung
		) as table_a
		WHERE jml_terima = daya_tampung
	) a 
	JOIN penempatan b ON a.kode_penempatan = b.kode_penempatan
END
GO
PRINT N'Creating [dbo].[_hitung_sisa_peminat]...';


GO

CREATE PROCEDURE _hitung_sisa_peminat
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE a 
	SET a.sisa_peminat = b.jml
	FROM penempatan a
	JOIN (
	    
		SELECT b.kode_penempatan,count(*) as jml
		FROM peserta a
		JOIN penempatan b ON a.kode_penempatan = b.kode_penempatan
		WHERE a.KODE_PESERTA NOT IN (
			SELECT kode_peserta
			FROM _peserta_diterima_final
		) AND a.nilai > b.min_nilai
		GROUP BY b.kode_penempatan
	) b ON a.kode_penempatan = b.kode_penempatan;

END
GO
PRINT N'Creating [dbo].[usp_seleksi]...';


GO

CREATE PROCEDURE usp_seleksi
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @sisa_peminat int;

    -- Hapus Temporary Table
	
	TRUNCATE TABLE _peserta_diterima_final;
	TRUNCATE TABLE _peserta_diterima_matic;

	--hitung sisa peminat 
	exec _hitung_min_nilai;
	exec _hitung_sisa_peminat;
	SELECT @sisa_peminat = sum(sisa_peminat)
	FROM penempatan;

	-- ulangi selama sisa peminat masih ada
	WHILE @sisa_peminat > 0 
	BEGIN

		SELECT kode_peserta,kode_penempatan,pil_ke,nilai
		FROM (
			SELECT ax.KODE_PESERTA,ax.KODE_PENEMPATAN,ax.PIL_KE,ax.NILAI
			,ROW_NUMBER() OVER(PARTITION BY ax.KODE_PENEMPATAN ORDER BY ax.NILAI DESC) as rn
				,b.daya_tampung
			FROM (
				SELECT KODE_PESERTA,KODE_PENEMPATAN,PIL_KE,NILAI
				FROM _peserta_diterima_final
				UNION
				SELECT KODE_PESERTA,KODE_PENEMPATAN,PIL_KE,NILAI
				FROM (
					SELECT a.KODE_PESERTA,a.KODE_PENEMPATAN,a.PIL_KE,a.NILAI
					,ROW_NUMBER() OVER(PARTITION BY a.kode_peserta ORDER BY a.pil_ke ASC) as rn
					FROM peserta a
					JOIN penempatan b ON a.kode_penempatan = b.kode_penempatan
					WHERE a.KODE_PESERTA NOT IN (
						SELECT kode_peserta
						FROM _peserta_diterima_final
					) AND a.nilai > b.min_nilai
				) a
				WHERE rn = 1
			) ax
			JOIN penempatan b ON ax.KODE_PENEMPATAN = b.KODE_PENEMPATAN 
		) axx 
		WHERE rn <= daya_tampung;

		TRUNCATE TABLE _peserta_diterima_final;

		INSERT INTO _peserta_diterima_final(kode_peserta,kode_penempatan,pil_ke,nilai)
		SELECT kode_peserta,kode_penempatan,pil_ke,nilai
		FROM _peserta_diterima_matic;

		exec _hitung_min_nilai;
		exec _hitung_sisa_peminat;
		SELECT @sisa_peminat = sum(sisa_peminat)
		FROM penempatan;

	END
END
GO
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
INSERT [dbo].[status] ([kode_status], [nama]) VALUES (0, N'BELUM DIPROSES')
GO
INSERT [dbo].[status] ([kode_status], [nama]) VALUES (1, N'DITERIMA')
GO
INSERT [dbo].[status] ([kode_status], [nama]) VALUES (2, N'TIDAK DITERIMA')
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[_peserta_diterima_final] WITH CHECK CHECK CONSTRAINT [FK_peserta_diterima_final_penempatan];

ALTER TABLE [dbo].[_peserta_diterima_final] WITH CHECK CHECK CONSTRAINT [FK_peserta_diterima_final_status];

ALTER TABLE [dbo].[_peserta_diterima_matic] WITH CHECK CHECK CONSTRAINT [FK_peserta_diterima_matic_penempatan];

ALTER TABLE [dbo].[_peserta_diterima_matic] WITH CHECK CHECK CONSTRAINT [FK_peserta_diterima_matic_status];

ALTER TABLE [dbo].[peserta] WITH CHECK CHECK CONSTRAINT [FK_peserta_penempatan];

ALTER TABLE [dbo].[peserta] WITH CHECK CHECK CONSTRAINT [FK_peserta_status];

ALTER TABLE [dbo].[_peserta_diterima_final] WITH CHECK CHECK CONSTRAINT [CK_peserta_diterima_final_nilai];

ALTER TABLE [dbo].[_peserta_diterima_final] WITH CHECK CHECK CONSTRAINT [CK_peserta_diterima_final_pil_ke];

ALTER TABLE [dbo].[_peserta_diterima_matic] WITH CHECK CHECK CONSTRAINT [CK_peserta_diterima_matic_nilai];

ALTER TABLE [dbo].[_peserta_diterima_matic] WITH CHECK CHECK CONSTRAINT [CK_peserta_diterima_matic_pil_ke];

ALTER TABLE [dbo].[penempatan] WITH CHECK CHECK CONSTRAINT [CK_penempatan_daya_tampung];

ALTER TABLE [dbo].[penempatan] WITH CHECK CHECK CONSTRAINT [CK_penempatan_dt_isi];

ALTER TABLE [dbo].[penempatan] WITH CHECK CHECK CONSTRAINT [CK_penempatan_isi];

ALTER TABLE [dbo].[peserta] WITH CHECK CHECK CONSTRAINT [CK_peserta_nilai];

ALTER TABLE [dbo].[peserta] WITH CHECK CHECK CONSTRAINT [CK_peserta_pil_ke];


GO
PRINT N'Update complete.';


GO
