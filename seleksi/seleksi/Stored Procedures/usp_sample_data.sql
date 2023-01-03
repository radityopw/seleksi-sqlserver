CREATE PROCEDURE [dbo].[usp_sample_data]
AS
	
	-- HAPUS DATA DULU
	TRUNCATE TABLE _peserta_diterima_final;
	TRUNCATE TABLE _peserta_diterima_matic;
	TRUNCATE TABLE peserta;
	TRUNCATE TABLE penempatan;

	
	INSERT INTO penempatan(kode_penempatan,nama,daya_tampung)
	SELECT '1','1',20
	UNION ALL 
	SELECT '2','2',21
	UNION ALL
	SELECT '3','3',19;