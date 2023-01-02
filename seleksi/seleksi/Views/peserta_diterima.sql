create view peserta_diterima with schemabinding as 
select kode_peserta,nama,kode_penempatan,pil_ke,nilai 
from dbo.peserta 
where kode_status = 1;
GO
CREATE UNIQUE CLUSTERED INDEX [PK]
    ON [dbo].[peserta_diterima]([kode_peserta] ASC);

