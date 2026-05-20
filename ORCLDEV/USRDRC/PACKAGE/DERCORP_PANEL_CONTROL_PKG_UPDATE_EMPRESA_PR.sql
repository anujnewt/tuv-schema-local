create or replace procedure usrdrc.dercorp_panel_control_pkg_update_empresa_pr ( pinidempresa numeric ,pstcve_empresa varchar ,pstnomempresa varchar ,pstattr1 varchar ,pstattr2 varchar ,pstidpais varchar ,pstnum_last_updated_by numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--,pstatributo3           varchar2)as
lstactnomempresa varchar(2000);
lincountrepetidos   numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select count(*) into strict lincountrepetidos
from   dercorp_empresa_tab
where  nom_empresa = pstnomempresa
and id_empresa not in (pinidempresa);--28-sept-2017 excluye empresa jams
if lincountrepetidos > 0  then
raise exception 'eduplicadoexcepcion' using errcode = '50001';
end if;
begin
begin
select  nom_empresa into strict lstactnomempresa
from    dercorp_empresa_tab
where   id_empresa  = pinidempresa;
exception
when others then
lstactnomempresa:= null;
end;
update  dercorp_empresa_tab
set     cve_empresa             = pstcve_empresa
,nom_empresa             = pstnomempresa
,atributo1               = pstattr1
,atributo2               = pstattr2
--,atributo3               = pstatributo3
,fec_last_update_date    = clock_timestamp()
,num_last_updated_by     = pstnum_last_updated_by
where   id_empresa              = pinidempresa;
update dercorp_add_campo_cat_val_tab
set  nom_cat_val            = pstcve_empresa
,val_cat_val            = pstnomempresa
,des_cat_val            = pstnomempresa
,atributo1              = pstattr1
,atributo2              = pstattr2
,fec_last_update_date   = clock_timestamp()
where id_catalogo = 1
and  val_cat_val  = lstactnomempresa;
update dercorp_add_campo_cat_val_tab
set  nom_cat_val            = pstcve_empresa
,val_cat_val            = pstnomempresa
,des_cat_val            = pstnomempresa
,atributo1              = pstattr1
,atributo2              = pstattr2
,fec_last_update_date   = clock_timestamp()
where id_catalogo = 40
and  val_cat_val  = lstactnomempresa;
/**rfc**/
update  dercorp_add_campo_valor_tab
set     val_valor               = pstattr1,
fec_last_update_date    = clock_timestamp()
where   1=1
and     id_empresa   = pinidempresa
and     id_add_campo = 529;
/**pais**/
update  dercorp_add_campo_valor_tab
set     val_valor               = case when pstidpais='null' then '0'  else pstidpais end ,
fec_last_update_date    = clock_timestamp()
where   1=1
and     id_empresa   = pinidempresa
and     id_add_campo = 509;
/**denominacion actual**/
/**nombre corto**/
update  dercorp_add_campo_valor_tab
set     val_valor               = pstcve_empresa,
fec_last_update_date    = clock_timestamp()
where   1=1
and     id_empresa   = pinidempresa
and     id_add_campo = 501;
exception
when sqlstate '50001' then
pstouterror := 'Empresa Duplicada';
when others
then
pstouterror := sqlerrm;
end;end;
$body$
language plpgsql
;
