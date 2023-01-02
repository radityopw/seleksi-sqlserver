
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
