create or replace procedure usrdrc.dercorp_panel_control_pkg_insert_empresa_pr ( pstcve_empresa varchar, pstnomempresa varchar, pstattr1 varchar, pstattr2 varchar, pstidpais varchar, pstnum_created_by numeric, pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--pstatributo3           varchar2)as
lincountrepetidos   numeric;
linconsecutivo      numeric;
lincountexisteemp   numeric;
lincountexisteacc   numeric;
lincountrfc         numeric;
lincountpais        numeric;
linidempresa        numeric;
lindenomactu        numeric;
linidcatval         numeric;
lincountnomcorto    numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select count(*) into strict lincountrepetidos
from   dercorp_empresa_tab
where  nom_empresa = pstnomempresa;
if lincountrepetidos > 0  then
raise exception 'eduplicadoexcepcion' using errcode = '50001';
end if;
--select max(id_empresa) into linconsecutivo
--from dercorp_empresa_tab;
select nextval('dercorp_empresa_seq') into strict linconsecutivo
;
--linconsecutivo := linconsecutivo + 1;
begin
insert into dercorp_empresa_tab( id_empresa
,cve_empresa
,nom_empresa
,atributo1
,atributo2
,fec_creation_date
,fec_last_update_date
,num_created_by)
--,atributo3)
values (
linconsecutivo
,pstcve_empresa
,pstnomempresa
,pstattr1
,pstattr2
,clock_timestamp()
,clock_timestamp()
,pstnum_created_by);
--,pstatributo3);
--inserta denominacion social
select count(*) into strict lincountexisteemp
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and val_cat_val   = pstnomempresa;
select nextval('dercorp_cat_val_seq') into strict linidcatval
;
if lincountexisteemp = 0
then
insert into dercorp_add_campo_cat_val_tab( id_catalogo_valor
,id_catalogo
,cod_cat_val
,nom_cat_val
,val_cat_val
,des_cat_val
,atributo1
,atributo2
,fec_creation_date)
values                                   (linidcatval
,1
,(select max((cod_cat_val::numeric)::numeric ) + 1
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1)
,pstcve_empresa
,pstnomempresa
,pstnomempresa
,pstattr1
,pstattr2
,clock_timestamp()
);
else
update dercorp_add_campo_cat_val_tab
set  nom_cat_val            = pstcve_empresa
,val_cat_val            = pstnomempresa
,des_cat_val            = pstnomempresa
,atributo1              = pstattr1
,atributo2              = pstattr2
,fec_last_update_date   = clock_timestamp()
where id_catalogo = 1
and  val_cat_val  = pstnomempresa;
end if;
--inserta en accionistas
select count(*) into strict lincountexisteacc
from dercorp_add_campo_cat_val_tab
where id_catalogo = 40
and val_cat_val   = pstnomempresa;
if lincountexisteacc = 0
then
insert into dercorp_add_campo_cat_val_tab( id_catalogo_valor
,id_catalogo
,cod_cat_val
,nom_cat_val
,val_cat_val
,des_cat_val
,atributo1
,atributo2
,fec_creation_date)
values                                   (nextval('dercorp_cat_val_seq')
,40
,(select max((cod_cat_val::numeric)::numeric ) + 1
from dercorp_add_campo_cat_val_tab
where id_catalogo = 40)
,pstcve_empresa
,pstnomempresa
,pstnomempresa
,pstattr1
,pstattr2
,clock_timestamp()
);
else
update dercorp_add_campo_cat_val_tab
set  nom_cat_val            = pstcve_empresa
,val_cat_val            = pstnomempresa
,des_cat_val            = pstnomempresa
,atributo1              = pstattr1
,atributo2              = pstattr2
,fec_last_update_date   = clock_timestamp()
where id_catalogo = 40
and  val_cat_val  = pstnomempresa;
end if;
/********inserta rfc*******/
select id_empresa into strict linidempresa
from dercorp_empresa_tab
where nom_empresa = pstnomempresa;
select count(*) into strict lincountrfc
from dercorp_add_campo_valor_tab
where id_add_campo = 529 --codigo rfc
and id_empresa     = linidempresa;
--and val_valor      = pstattr1;
if lincountrfc = 0
then
insert into dercorp_add_campo_valor_tab( id_add_campo
,id_empresa
,val_valor
,fec_creation_date)
values ( 529
,linconsecutivo
,pstattr1
,clock_timestamp());
else
update  dercorp_add_campo_valor_tab
set     val_valor               = pstattr1,
fec_last_update_date    = clock_timestamp()
where   1=1
and     id_empresa   = linidempresa
and     id_add_campo = 529;
end if;
/********inserta pais*******/
select count(*) into strict lincountpais
from dercorp_add_campo_valor_tab
where id_add_campo = 509 --codigo rfc
and id_empresa     = linidempresa;
--and val_valor      = pstidpais;
if lincountpais = 0
then
insert into dercorp_add_campo_valor_tab( id_add_campo
,id_empresa
,val_valor
,fec_creation_date)
values ( 509
,linconsecutivo
,case when pstidpais='null' then '0'  else pstidpais end
,clock_timestamp());
else
update  dercorp_add_campo_valor_tab
set     val_valor               = case when pstidpais='null' then '0'  else pstidpais end ,
fec_last_update_date    = clock_timestamp()
where   1=1
and     id_empresa   = linidempresa
and     id_add_campo = 509;
end if;
/********inserta denom actual*******/
select count(*) into strict lindenomactu
from dercorp_add_campo_valor_tab
where id_add_campo = 500 --codigo rfc
and id_empresa     = linidempresa;
--and val_valor      = linidcatval;
if lindenomactu = 0
then
insert into dercorp_add_campo_valor_tab( id_add_campo
,id_empresa
,val_valor
,fec_creation_date)
values ( 500
,linconsecutivo
,linidcatval
,clock_timestamp());
else
update  dercorp_add_campo_valor_tab
set     val_valor               = linidcatval,
fec_last_update_date    = clock_timestamp()
where   1=1
and     id_empresa   = linidempresa
and     id_add_campo = 500;
end if;
/********inserta nombre corto*******/
select count(*) into strict lincountnomcorto
from dercorp_add_campo_valor_tab
where id_add_campo = 501 --nombre corto
and id_empresa     = linidempresa;
--and val_valor      = linidcatval;
if lincountnomcorto = 0
then
insert into dercorp_add_campo_valor_tab( id_add_campo
,id_empresa
,val_valor
,fec_creation_date)
values ( 501
,linconsecutivo
,pstcve_empresa
,clock_timestamp());
else
update  dercorp_add_campo_valor_tab
set     val_valor               = pstcve_empresa,
fec_last_update_date    = clock_timestamp()
where   1=1
and     id_empresa   = linidempresa
and     id_add_campo = 501;
end if;
exception
when sqlstate '50001' then
pstouterror := 'Empresa Duplicada';
when others then
pstouterror := sqlerrm;
end;end;
$body$
language plpgsql
;
