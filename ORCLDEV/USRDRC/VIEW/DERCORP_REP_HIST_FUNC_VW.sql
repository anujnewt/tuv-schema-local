-- dmap_object_gen_tag : type : view name : dercorp_rep_hist_func_vw
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "dercorp_rep_hist_func_vw"  ("id_func", "id_flex_tbl", "id_empresa", "tipo_admon", "num_empresa", "nom_empresa", "nombre", "nombre_plano", "cargo", "cargo_ingles", "fecha_designacion", "fecha_baja", "suplente", "fecha_desig_suplente", "fecha_baja_suplente", "id_orden", "activo") as select
meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Administrador Unico' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
'N/A'          as suplente,
null          as fecha_desig_suplente,
null          as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 8
union all
--consejo de administracion
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Consejo de Administracion' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 11
union all
--consejo directivo
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Consejo Directivo' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 12
union all
--consejo de gerentes
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Consejo de Gerentes' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 13
union all
--directorio
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Directorio' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 14
union all
--junta directiva
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Junta Directiva' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 15
union all
--comite ejecutivo
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Comite Ejecutivo' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 16
union all
--comite operativo jjaq 26/04/2017 se agrega nueva flex para el reporte
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Comite Operativo' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
/*  (select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,*/
null as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 45
union all
--comite de practicas societarias jjaq 07/01/2019 se agrega nueva flex para el reporte
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Comite de Practicas Societarias' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            = meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
/*  (select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,*/
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 46
union all
--comite directivo jjaq se agrega la nueva 25/04/2017
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Comite Directivo' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
/* (select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,*/
null as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 44
union all
--funcionarios asociacion
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Funcionarios' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 25
union all
--consejo consultivo
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Consejo Consultivo' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 26
union all
--ecm 26/abril/2016
--socio administrador
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Socio Administrador' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 39
union all
--consejo de socios administradores
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Consejo de Socios Administradores' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 40
union all
--comite de auditoria y practicas societarias
selmeta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Administrador Unico' as tipo_admon,
(select   val_cat_val
, meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Comite de Auditoria' as tipo_admon,
(select   val_cat_val
_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
meta.val_c15 as id_orden,
meta.val_c14 as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 43
union all
--vigilancia
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Vigilancia' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo,
(select   atributo1
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 11
and      id_catalogo_valor     = meta.val_c2)as cargo_ingles,
meta.val_c3 as fecha_designacion,
meta.val_c4 as fecha_baja,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 10
and      id_catalogo_valor     = meta.val_c5)as suplente,
meta.val_c6 as fecha_desig_suplente,
meta.val_c7 as fecha_baja_suplente,
memeta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Administrador Unico' as tipo_admon,
(select   val_cat_val
, meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Comite de Auditoria' as tipo_admon,
(select   val_cat_val
, meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Accionistas' as tipo_admon,
(select   val_cat_val
l
--accionistas
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Accionistas' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   trim(both val_cat_val)
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 40
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 40
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
'Accionista'as cargo,
'Shareholder'as cargo_ingles,
null as fecha_designacion,
null as fecha_baja,
'N/A' as suplente,
null as fecha_desig_suplente,
null as fecha_baja_suplente,
'N/A' as id_orden,
'1' as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 7
union all
--apoderados
select  distinct
to_char(apo.id_catalogo_valor) as id_func,
99 as id_flex_tbl,
apo.id_empresa,
'Apoderados' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =apo.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = apo.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = apo.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 32
and      id_catalogo_valor     = apo.id_catalogo_valor)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 32
and      id_catalogo_valor     = apo.id_catalogo_valor)))as nombre_plano,
apo.des_grupo as cargo,
'N/A' as cargo_ingles,
to_char(apo.fec_creation_date,'dd/mm/yyyy') as fecha_designacion,
to_char(apo.fec_fecha_baja,'dd/mm/yyyy') as fecha_baja,
'N/A' as suplente,
null as fecha_desig_suplente,
null as fecha_baja_suplente,
'N/A' as id_orden,
'1' as "activo"
from    dercorp_apoderados_tab apo
where   apo.id_catalogo = 32
union all
--contactos
select  meta.val_c1 as id_func,
meta.id_flex_tbl,
meta.id_empresa,
'Contactos' as tipo_admon,
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo_valor = (select   val_valor
from     dercorp_add_campo_valor_tab
where    id_empresa            =meta.id_empresa
and      id_add_campo          = 502))as num_empresa,
/*(select   nom_empresa
from     dercorp_empresa_tab
where    id_empresa            = meta.id_empresa) as nom_empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as nom_empresa,--argu
(select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 56
and      id_catalogo_valor     = meta.val_c1)as nombre,
upper(app_common_pkg_sin_acentos_fn((select   val_cat_val
from     dercorp_add_campo_cat_val_tab
where    id_catalogo           = 56
and      id_catalogo_valor     = meta.val_c1)))as nombre_plano,
meta.val_c2 as cargo,
'N/A' as cargo_ingles,
null as fecha_designacion,
null as fecha_baja,
'N/A' as suplente,
null as fecha_desig_suplente,
null as fecha_baja_suplente,
'N/A' as id_orden,
'1' as "activo"
from    dercorp_metatbl_tab meta
where   meta.id_flex_tbl = 1;/* dmap converted statement end */
-- estimed cost of view [ dercorp_rep_hist_func_vw ]: 1.10;
