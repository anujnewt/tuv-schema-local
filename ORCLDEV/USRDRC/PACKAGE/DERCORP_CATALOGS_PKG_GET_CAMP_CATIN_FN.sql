create or replace  function  usrdrc.dercorp_catalogs_pkg_get_camp_catin_fn (piincatalogid numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstcampo varchar(1000);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select app_config.des_config into strict lstcampo
from (
select config.nom_config,
config.des_config,
config.val_config,
(select id_catalogo
from   dercorp_add_campo_cat_tab
where  cod_catalogo = config.nom_config) id_cat_ori,
(select id_catalogo
from   dercorp_add_campo_cat_tab
where  cod_catalogo = config.val_config) id_cat_in
from   app_config_tab config
where  cod_config = 'CATIN_CAT' ) app_config
where app_config.id_cat_ori = piincatalogid;
exception
when others then
lstcampo := '0';
end;
return lstcampo;end;
--
--
--
$body$
language plpgsql
stable;
