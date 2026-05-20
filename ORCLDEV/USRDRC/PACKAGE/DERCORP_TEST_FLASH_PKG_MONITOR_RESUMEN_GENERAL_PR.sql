create or replace procedure usrdrc.dmap_dercorp_test_flash_pkg_monitor_resumen_general_pr ( pinidempresa numeric, piniduser numeric, pistdenomactualnew varchar, pistnombrecortonew varchar, pistctaoraclenew varchar, pistactividadnew varchar, pistgironew varchar, pistdivisionnew varchar, pistsegresponsablenew varchar, pistclasificacionnew varchar, pistfecclasificacionnew varchar, pistpaisnew varchar, pistadmiteextnew varchar, pistdomiciliosocnew varchar, pisttieneinmueblenew varchar, pistduracionnew varchar, pistfecinicialnew varchar, pistfecfinalnew varchar, pistconscontablenew varchar, pisttiposociedadnew varchar, pistauditoresextnew varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstdenomactualold       varchar(1000);
lstnombrecortoold       varchar(1000);
lstctaoracleold         varchar(1000);
lstactividadold         varchar(1000);
lstgiroold              varchar(1000);
lstdivisionold          varchar(1000);
lstsegresponsableold    varchar(1000);
lstclasificacionold     varchar(1000);
lstfecclasificacionold  varchar(1000);
lstpaisold              varchar(1000);
lstadmiteextold         varchar(1000);
lstdomiciliosocold      varchar(1000);
lsttieneinmuebleold     varchar(1000);
lstduracionold          varchar(1000);
lstfecinicialold        varchar(1000);
lstfecfinalold          varchar(1000);
lstconscontableold      varchar(1000);
lsttiposociedadold      varchar(1000);
lstauditoresextold      varchar(1000);
linidreg                numeric;
lstreturnfunc           varchar(1000);-- pragma autonomous_transaction;
i record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
for i in (
select
c.id_add_campo ,
c.nom_campo,
v.val_valor,
c.des_tipo_campo,
c.des_formula,
c.id_catalogo,
c.id_seccion,
c.id_subseccion
from
dercorp_add_campo_tab c
left join dercorp_add_campo_valor_tab v on v.id_add_campo     = c.id_add_campo
and v.id_empresa      = pinidempresa
where
c.id_subseccion = 17
order by
id_seccion,
id_subseccion,
c.id_agrupacion,
(c.id_order)::numeric  )
loop
linidreg := 0;
if i.id_add_campo = 500 --******denominacion actual*****
then
lstdenomactualold := i.val_valor;
if trim(both lstdenomactualold) <> trim(both pistdenomactualnew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistdenomactualnew,lstdenomactualold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 501 --*****nombre corto*****
then
lstnombrecortoold := i.val_valor;
if trim(both lstnombrecortoold) <> trim(both pistnombrecortonew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistnombrecortonew,lstnombrecortoold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 502 --*****cuenta oracle*****
then
lstctaoracleold := i.val_valor;
if trim(both lstctaoracleold) <> trim(both pistctaoraclenew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistctaoraclenew,lstctaoracleold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 503 --*****actividad*****
then
lstactividadold := i.val_valor;
if trim(both lstactividadold) <> trim(both pistactividadnew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistactividadnew,lstactividadold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 504 --*****giro*****
then
lstgiroold := i.val_valor;
if trim(both lstgiroold) <> trim(both pistgironew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistgironew,lstgiroold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 505 --*****division*****
then
lstdivisionold := i.val_valor;
if trim(both lstdivisionold) <> trim(both pistdivisionnew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistdivisionnew,lstdivisionold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 506 --*****segmento reportable*****
then
lstsegresponsableold := i.val_valor;
if trim(both lstsegresponsableold) <> trim(both pistsegresponsablenew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistsegresponsablenew,lstsegresponsableold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 507--*****clasificacion:*****
then
lstclasificacionold := i.val_valor;
if trim(both lstclasificacionold) <> trim(both pistclasificacionnew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistclasificacionnew,lstclasificacionold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 508--*****fecha clasificacion:*****
then
lstfecclasificacionold := i.val_valor;
if trim(both lstfecclasificacionold) <> trim(both pistfecclasificacionnew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistfecclasificacionnew,lstfecclasificacionold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 509--*****pais:*****
then
lstpaisold := i.val_valor;
if trim(both lstpaisold) <> trim(both pistpaisnew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistpaisnew,lstpaisold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 510--*****admite extranjeros:*****
then
lstadmiteextold := i.val_valor;
if trim(both lstadmiteextold) <> trim(both pistadmiteextnew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistadmiteextnew,lstadmiteextold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 511--*****domicilio social:*****
then
lstdomiciliosocold := i.val_valor;
if trim(both lstdomiciliosocold) <> trim(both pistdomiciliosocnew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistdomiciliosocnew,lstdomiciliosocold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 512--*****tiene inmuebles:*****
then
lsttieneinmuebleold := i.val_valor;
if trim(both lsttieneinmuebleold) <> trim(both pisttieneinmueblenew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pisttieneinmueblenew,lsttieneinmuebleold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 513--*****duracion:*****
then
lstduracionold := i.val_valor;
if trim(both lstduracionold) <> trim(both pistduracionnew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistduracionnew,lstduracionold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 514--*****fecha inicial:*****
then
lstfecinicialold := i.val_valor;
if trim(both lstfecinicialold) <> trim(both pistfecinicialnew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistfecinicialnew,lstfecinicialold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 515--*****fecha final:*****
then
lstfecfinalold := i.val_valor;
if trim(both lstfecfinalold) <> trim(both pistfecfinalnew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistfecfinalnew,lstfecfinalold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 516--*****consolidacion contable:*****
then
lstconscontableold := i.val_valor;
if trim(both lstconscontableold) <> trim(both pistconscontablenew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistconscontablenew,lstconscontableold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 517--*****tipo de sociedad:*****
then
lsttiposociedadold := i.val_valor;
if trim(both lsttiposociedadold) <> trim(both pisttiposociedadnew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pisttiposociedadnew,lsttiposociedadold,piniduser,pinidempresa);
end if;
end if;
if i.id_add_campo = 1052--*****auditores externos*****
then
lstauditoresextold := i.val_valor;
if trim(both lstauditoresextold) <> trim(both pistauditoresextnew)
then
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(i.nom_campo,pistauditoresextnew,lstauditoresextold,piniduser,pinidempresa);
end if;
end if;
end loop;
exception
when others then
rollback;
lstreturnfunc:=dercorp_test_flash_pkg_insert_rg_log_fn(sqlerrm,'ERROR','ERROR','ERROR',pinidempresa);
end;
/* commit; */
null;end;
$body$
language plpgsql
;
