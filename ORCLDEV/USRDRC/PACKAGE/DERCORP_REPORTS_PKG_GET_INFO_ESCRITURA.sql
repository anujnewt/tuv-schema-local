create or replace  function  usrdrc.dercorp_reports_pkg_get_info_escritura (idempresa varchar, escritura varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
countconstitutiva integer;
countpoderesgenerales integer;
textresult varchar(1000);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
count(*) into strict countconstitutiva
from
dercorp_add_campo_valor_tab
where
val_valor = escritura
and
id_empresa = idempresa;
/*
select
count(*) into countpoderesgenerales
from dercorp_metatbl_tab
where
val_c8 = escritura
and
id_empresa = idempresa;
*/
textresult:= null;/* dmap converted statement start */
if countconstitutiva > 0 then
select
concat(' de fecha ', coalesce(dercorp_reportflex_pkg_get_field_text_value(552, idempresa),'')
, ' firmada ante el ', coalesce(dercorp_reportflex_pkg_get_field_text_value(553, idempresa),'') )   concat(-- lic
, ' Notario # '
, coalesce(dercorp_reportflex_pkg_get_field_text_value(554, idempresa),'')
, ' de  ', coalesce(dercorp_reportflex_pkg_get_entidad_value(553, idempresa),'') ) --entidad federativa
into strict textresult
;/* dmap converted statement end *//* dmap converted statement start */
else
--if countpoderesgenerales > 0 then
select
concat(' de fecha ', coalesce(val_c9,'')
, ' firmada ante el ' , coalesce((select nom_cat_val from dercorp_add_campo_cat_val_tab
where id_catalogo = 12
and id_catalogo_valor = val_c10),'') )   concat(-- lic
, ' Notario # ' , coalesce(val_c11,'')
, ' de ', coalesce((select atributo2 from dercorp_add_campo_cat_val_tab
where id_catalogo = 12
and id_catalogo_valor = val_c10),'') )  -- entidad federativa
into strict textresult
from dercorp_metatbl_tab
where
val_c8 = escritura
and
id_empresa = idempresa
limit 1;/* dmap converted statement end */
end if;
return textresult;end;
$body$
language plpgsql
;
