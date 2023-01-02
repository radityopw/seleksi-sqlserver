
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
