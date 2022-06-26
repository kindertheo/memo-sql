-- SELECT ALL TABLES FROM A DATABASE AND EXPORT EACH TABLE TO A CSV FILE
DECLARE  tname record;
BEGIN
	FOR tname in 
		SELECT tablename FROM pg_catalog.pg_tables 
		WHERE schemaname != 'pg_catalog' 
		AND schemaname != 'information_schema' 
		AND tablename not like '%rel%' 
	LOOP
		RAISE NOTICE 'tname = %', tname.tablename;
		EXECUTE format('COPY %s TO ''/var/lib/postgres/12/myfolder/%s.csv'' DELIMITER '','' CSV HEADER',
					   tname.tablename, tname.tablename);
	END LOOP;
END;
$$;