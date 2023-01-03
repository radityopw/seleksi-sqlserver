CREATE TABLE [dbo].[penempatan] (
    [kode_penempatan] VARCHAR (50)  NOT NULL,
    [nama]            VARCHAR (255) NOT NULL,
    [daya_tampung]    INT           NOT NULL,
    [isi]             INT           CONSTRAINT [DF_penempatan_isi] DEFAULT ((0)) NOT NULL,
    [min_nilai]       FLOAT (53)    CONSTRAINT [DF_penempatan_nilai_minimum] DEFAULT ((-1)) NOT NULL,
    [sisa_peminat]    INT           CONSTRAINT [DF_penempatan_sisa_peminat] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_penempatan] PRIMARY KEY CLUSTERED ([kode_penempatan] ASC),
    CONSTRAINT [CK_penempatan_daya_tampung] CHECK ([daya_tampung]>(0)),
    CONSTRAINT [CK_penempatan_dt_isi] CHECK ([daya_tampung] >= [isi]),
    CONSTRAINT [CK_penempatan_isi] CHECK ([isi]>=(0))
);

