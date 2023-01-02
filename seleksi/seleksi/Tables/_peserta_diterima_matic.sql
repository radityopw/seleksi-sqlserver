CREATE TABLE [dbo].[_peserta_diterima_matic] (
    [kode_peserta]    VARCHAR (50)  NOT NULL,
    [nama]            VARCHAR (255) NOT NULL,
    [kode_penempatan] VARCHAR (50)  NOT NULL,
    [pil_ke]          TINYINT       NOT NULL,
    [nilai]           FLOAT (53)    NOT NULL,
    [kode_status]     TINYINT       CONSTRAINT [DF_peserta_diterima_matic_kode_status] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_peserta_diterima_matic] PRIMARY KEY CLUSTERED ([kode_peserta] ASC, [pil_ke] ASC),
    CONSTRAINT [CK_peserta_diterima_matic_nilai] CHECK ([nilai]>(0)),
    CONSTRAINT [CK_peserta_diterima_matic_pil_ke] CHECK ([pil_ke]>(0)),
    CONSTRAINT [FK_peserta_diterima_matic_penempatan] FOREIGN KEY ([kode_penempatan]) REFERENCES [dbo].[penempatan] ([kode_penempatan]),
    CONSTRAINT [FK_peserta_diterima_matic_status] FOREIGN KEY ([kode_status]) REFERENCES [dbo].[status] ([kode_status])
);

