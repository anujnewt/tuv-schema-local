CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_CALCULATAB" (   keypro IN NUMBER,   keypue IN NUMBER,   pertra IN NUMBER,
                                                        idioma IN VARCHAR2, keynac IN VARCHAR2, keytab IN NUMBER,
                                                        dia IN NUMBER,      mes IN NUMBER,      ano IN NUMBER,
                                                        tab OUT NUMBER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 fecha CHAR(10);
BEGIN
        tab := 0;
        fecha := dia || '/' || mes || '/' || ano;
        SELECT COALESCE(MAX(tab_import), 0) INTO tab
        FROM holotabs
        WHERE tab_keypro = keypro
                AND tab_keytab = keytab
                AND tab_keypue = keypue
                AND tab_pertra = pertra
                AND tab_idioma = idioma
                AND tab_keynac = keynac
                AND tab_fecini <= TO_DATE(TRIM(fecha), 'dd/mm/yyyy')
                AND tab_fecfin >= TO_DATE(TRIM(fecha), 'dd/mm/yyyy');
END;
/
