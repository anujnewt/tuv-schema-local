CREATE OR REPLACE PROCEDURE usrdrc.dercorp_test_flash_pkg_monitor_resumen_general_pr(pinIdEmpresa numeric,pinIdUser numeric,pistDenomActualNew varchar,pistNombreCortoNew varchar,pistCtaOracleNew varchar,pistActividadNew varchar,pistGiroNew varchar,pistDivisionNew varchar,pistSegResponsableNew varchar,pistClasificacionNew varchar,pistFecClasificacionNew varchar,pistPaisNew varchar,pistAdmiteExtNew varchar,pistDomicilioSocNew varchar,pistTieneInmuebleNew varchar,pistDuracionNew varchar,pistFecInicialNew varchar,pistFecFinalNew varchar,pistConsContableNew varchar,pistTipoSociedadNew varchar,pistAuditoresExtNew varchar) 


AS

$$

DECLARE

v_sql text;

v_con_count int;

v_con_name text;

output1 text;

BEGIN

v_con_name := 'pragma_at_dmap_dblink';

SELECT count(1) INTO v_con_count FROM dblink_get_connections()

WHERE dblink_get_connections__>'{pragma_at_dmap_dblink}';


IF v_con_count = 0 THEN

    PERFORM dblink_connect(v_con_name, 'pragma_at_dmap_dblink');

END IF;


v_sql := FORMAT('CALL dmap_dercorp_test_flash_pkg_monitor_resumen_general_pr(pinIdEmpresa=> %L,pinIdUser=> %L,pistDenomActualNew=> %L,pistNombreCortoNew=> %L,pistCtaOracleNew=> %L,pistActividadNew=> %L,pistGiroNew=> %L,pistDivisionNew=> %L,pistSegResponsableNew=> %L,pistClasificacionNew=> %L,pistFecClasificacionNew=> %L,pistPaisNew=> %L,pistAdmiteExtNew=> %L,pistDomicilioSocNew=> %L,pistTieneInmuebleNew=> %L,pistDuracionNew=> %L,pistFecInicialNew=> %L,pistFecFinalNew=> %L,pistConsContableNew=> %L,pistTipoSociedadNew=> %L,pistAuditoresExtNew=> %L)' , pinIdEmpresa,pinIdUser,pistDenomActualNew,pistNombreCortoNew,pistCtaOracleNew,pistActividadNew,pistGiroNew,pistDivisionNew,pistSegResponsableNew,pistClasificacionNew,pistFecClasificacionNew,pistPaisNew,pistAdmiteExtNew,pistDomicilioSocNew,pistTieneInmuebleNew,pistDuracionNew,pistFecInicialNew,pistFecFinalNew,pistConsContableNew,pistTipoSociedadNew,pistAuditoresExtNew);


SELECT * INTO output1 FROM dblink(v_con_name, v_sql) AS t(result text);


END;

$$ LANGUAGE plpgsql;
CREATE OR REPLACE PROCEDURE usrdrc.dercorp_test_flash_pkg_monitor_resumen_general_pr(pinIdEmpresa numeric,pinIdUser numeric,pistDenomActualNew varchar,pistNombreCortoNew varchar,pistCtaOracleNew varchar,pistActividadNew varchar,pistGiroNew varchar,pistDivisionNew varchar,pistSegResponsableNew varchar,pistClasificacionNew varchar,pistFecClasificacionNew varchar,pistPaisNew varchar,pistAdmiteExtNew varchar,pistDomicilioSocNew varchar,pistTieneInmuebleNew varchar,pistDuracionNew varchar,pistFecInicialNew varchar,pistFecFinalNew varchar,pistConsContableNew varchar,pistTipoSociedadNew varchar,pistAuditoresExtNew varchar) 


AS

$$

DECLARE

v_sql text;

v_con_count int;

v_con_name text;

output1 text;

BEGIN

v_con_name := 'pragma_at_dmap_dblink';

SELECT count(1) INTO v_con_count FROM dblink_get_connections()

WHERE dblink_get_connections@>'{pragma_at_dmap_dblink}';


IF v_con_count = 0 THEN

    PERFORM dblink_connect(v_con_name, 'pragma_at_dmap_dblink');

END IF;


v_sql := FORMAT('CALL dmap_dercorp_test_flash_pkg_monitor_resumen_general_pr(pinIdEmpresa=> %L,pinIdUser=> %L,pistDenomActualNew=> %L,pistNombreCortoNew=> %L,pistCtaOracleNew=> %L,pistActividadNew=> %L,pistGiroNew=> %L,pistDivisionNew=> %L,pistSegResponsableNew=> %L,pistClasificacionNew=> %L,pistFecClasificacionNew=> %L,pistPaisNew=> %L,pistAdmiteExtNew=> %L,pistDomicilioSocNew=> %L,pistTieneInmuebleNew=> %L,pistDuracionNew=> %L,pistFecInicialNew=> %L,pistFecFinalNew=> %L,pistConsContableNew=> %L,pistTipoSociedadNew=> %L,pistAuditoresExtNew=> %L)' , pinIdEmpresa,pinIdUser,pistDenomActualNew,pistNombreCortoNew,pistCtaOracleNew,pistActividadNew,pistGiroNew,pistDivisionNew,pistSegResponsableNew,pistClasificacionNew,pistFecClasificacionNew,pistPaisNew,pistAdmiteExtNew,pistDomicilioSocNew,pistTieneInmuebleNew,pistDuracionNew,pistFecInicialNew,pistFecFinalNew,pistConsContableNew,pistTipoSociedadNew,pistAuditoresExtNew);


SELECT * INTO output1 FROM dblink(v_con_name, v_sql) AS t(result text);


END;

$$ LANGUAGE plpgsql;
