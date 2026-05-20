create or replace procedure xxmor."xxmor_reprocesar_enc_det_pr"  ( v_id_sol varchar, v_proc_x_linea varchar, v_garantizado varchar, v_cve_cliente varchar, v_master_contract varchar, v_nombre_email_resp varchar, v_ref_folio varchar, v_cve_agencia varchar, v_nombre_tarifa varchar, v_canal_ord_plat varchar, v_cat_prod varchar, v_total_spots varchar, v_total_ord_sin_desc varchar, v_total_ord_con_desc varchar, v_tipo_fact varchar, v_target varchar, v_comentarios varchar, v_usuario_orduni varchar, v_arrays_size varchar, v_linea array_tvch2, v_stnid array_tvch2, v_fecha_inicio array_tvch2, v_fecha_fin array_tvch2, v_duracion array_tvch2, v_buyuntid array_tvch2, v_hora_inicio array_tvch2, v_hora_fin array_tvch2, v_spots array_tvch2, v_lunes array_tvch2, v_martes array_tvch2, v_miercoles array_tvch2, v_jueves array_tvch2, v_viernes array_tvch2, v_sabado array_tvch2, v_domingo array_tvch2, v_spots_x_semana array_tvch2, v_tipo_servicio array_tvch2, v_bn array_tvch2, v_p_ array_tvch2, v_marca array_tvch2, v_version_ array_tvch2, v_tarifa_sp_sin_desc array_tvch2, v_tarifa_sp_con_desc array_tvch2, v_tot_lin_sin_desc array_tvch2, v_tot_lin_con_desc array_tvch2, v_sobrecargo array_tvch2, v_observaciones array_tvch2, v_id_tarifa varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
limitelineas   numeric;
thelinea       numeric;
sptchrbd       varchar(10);
usrchrbd       varchar(10);
lst_advid      xxmor_solicitudes_enc_tab.advid%type;
lst_accthdrid  xxmor_solicitudes_enc_tab.accthdrid%type;
lst_secnum     xxmor_solicitudes_enc_tab.secnum%type;
begin
lst_secnum := null;
select advid,
accthdrid,
secnum
into strict   lst_advid,
lst_accthdrid,
lst_secnum
from   xxmor_solicitudes_enc_tab
where  id_seg_neg   = 1
and    id_solicitud = (v_id_sol)::numeric;
if lst_advid != v_cve_cliente or lst_accthdrid != v_cve_agencia then
select trim(both cast(secnum as char(2))) as secnum
into strict   lst_secnum
from   paradb.accthdr__ordunidb2
where  trim(both upper(advid))     = trim(both upper(v_cve_cliente))
and    upper(trim(both accthdrid)) = trim(both upper(v_cve_agencia));
end if;
-- 1.- actualzar el encabezado
update   xxmor_solicitudes_enc_tab
set   proc_por_linea   = v_proc_x_linea,
garantizado      = v_garantizado,
advid            = v_cve_cliente,
mcontid          = v_master_contract,
email            = v_nombre_email_resp,
agyestnum        = v_ref_folio,
accthdrid        = v_cve_agencia,
rtcrddscr        = v_nombre_tarifa,
plataforma_canal = v_canal_ord_plat,
prdid_desc       = v_cat_prod,
total_spots      = v_total_spots,
total_sin_desc   = v_total_ord_sin_desc,
total_con_desc   = v_total_ord_con_desc,
tipo_facturacion = v_tipo_fact,
target           = v_target,
comentarios      = v_comentarios,
secnum           = lst_secnum,
updated_by       = v_usuario_orduni,
updated_date     = clock_timestamp(),
rtcrd            = v_id_tarifa
where   id_seg_neg   = 1
and     id_solicitud = (v_id_sol)::numeric;
/* commit; */
--2.- actualizar las lineras
limitelineas := (v_arrays_size)::numeric;
for i in 1 .. limitelineas
loop
thelinea := (v_linea(i))::numeric;
-- buscar valor de spotchar y usrchar
sptchrbd := null;
usrchrbd := null;
begin
select coalesce(spt_chr,null),
coalesce(usr_chr,null)
into strict sptchrbd,
usrchrbd
from   xxmor_cat_tipo_serv_tab
where upper(desc_tipo_servicio) = upper(v_tipo_servicio(i));
exception
when no_data_found then
sptchrbd := null;
usrchrbd := null;
when too_many_rows then
sptchrbd := null;
usrchrbd := null;
end;
update   xxmor_solicitudes_det_tab
set   stnid              = v_stnid(i),
fecha_inicio       = v_fecha_inicio(i),
fecha_fin          = v_fecha_fin(i),
duracion           = v_duracion(i),
buyuntid           = v_buyuntid(i),
hora_inicio        = v_hora_inicio(i),
hora_fin           = v_hora_fin(i),
spots              = v_spots(i),
lunes              = v_lunes(i),
martes             = v_martes(i),
miercoles          = v_miercoles(i),
jueves             = v_jueves(i),
viernes            = v_viernes(i),
sabado             = v_sabado(i),
domingo            = v_domingo(i),
spots_x_semana     = v_spots_x_semana(i),
tipo_servicio      = v_tipo_servicio(i),
usr_chr            = usrchrbd,
spot_chr           = (sptchrbd)::numeric ,
bn                 = v_bn(i),
p                  = v_p_(i),
marca              = v_marca(i),
version            = v_version_(i),
--tarifasp_sin_desc  = v_tarifa_sp_sin_desc (i),
--tarifasp_con_desc  = v_tarifa_sp_con_desc (i),
--tot_linea_sin_desc = v_tot_lin_sin_desc (i),
--tot_linea_con_desc = v_tot_lin_con_desc (i),
sobrecargo         = v_sobrecargo(i),
observaciones      = v_observaciones(i),
updated_by         = v_usuario_orduni,
updated_date       = clock_timestamp()
where   id_solicitud = (v_id_sol)::numeric
and     linea        = thelinea;
/* commit; */
end loop;
/* commit; */
end;
$body$
language plpgsql
;
