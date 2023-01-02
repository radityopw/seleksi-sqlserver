CREATE TABLE [dbo].[status] (
    [kode_status] TINYINT      NOT NULL,
    [nama]        VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_status] PRIMARY KEY CLUSTERED ([kode_status] ASC)
);

