
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
