-- dmap_object_gen_tag : type : view name : xxmor_para_copy_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxmor_para_copy_vw"  ("id_solicitud", "linea", "p_ordid", "p_ordlnnum", "p_rotid", "p_advid", "p_sptlen", "p_version", "p_strdt", "p_edt", "p_stnid", "p_plataforma", "p_cut_in", "p_marca", "p_copys_x_fecha", "p_copys_x_orden", "p_matloc_canal", "p_matloc_default", "p_matloc_null", "p_aux1", "p_aux2") as select e.id_solicitud,
d.linea,
(select (estat_id_foraneo)::numeric
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud = e.id_solicitud
and    er.linea        = 0
)                                             as p_ordid,
(r.estat_id_foraneo)::numeric                  as p_ordlnnum,
oracle.substr(d.stnid||'*'
||(select reverse(oracle.substr(reverse(to_char(ser.estat_id_foraneo)),
1,6
))
from   xxmor_solicitudes_est_rep_tab ser
where  ser.id_solicitud = r.id_solicitud
and    ser.linea        = 0
)
||'*'
||to_char(r.estat_id_foraneo, '000')
||'*'
||to_char(trunc(1000000000 * abs(dbms_random.normal))),
1,20
)                                       as p_rotid,
e.advid                                       as p_advid,
trunc(d.duracion)                             as p_sptlen,
d.version                                     as p_version,
to_char(to_timestamp(d.fecha_inicio,'YYYYMMDD')
+ case when f.copys_x_fecha='1' then  case                                     when lunes     != 0 then 0                                     when martes    != 0 then 1                                     when miercoles != 0 then 2                                     when jueves    != 0 then 3                                     when viernes   != 0 then 4                                     when sabado    != 0 then 5                                     when domingo   != 0 then 6                                     else 999                                 end  else 0 end , 'YYYY-MM-DD')        as p_strdt,
to_char(to_timestamp(d.fecha_fin,'YYYYMMDD')
- case when f.copys_x_fecha='1' then  case                                     when domingo   != 0 then 0                                     when sabado    != 0 then 1                                     when viernes   != 0 then 2                                     when jueves    != 0 then 3                                     when miercoles != 0 then 4                                     when martes    != 0 then 5                                     when lunes     != 0 then 6                                     else 999                                  end  else 0 end , 'YYYY-MM-DD')        as p_edt,
d.stnid                                       as p_stnid,
e.plataforma_canal                            as p_plataforma,
case when upper(plataforma_canal)='CUTIN' then  1  else 0 end  as p_cut_in,
d.marca                                       as p_marca,
f.copys_x_fecha                               as p_copys_x_fecha,
f.copys_x_orden                               as p_copys_x_orden,
case when matloc_busqueda='FV' then f.matloc                                    else oracle.substr(d.stnid,1,2) end                                        as p_matloc_canal,
xxmor.xxmor_funcional_pkg_xxmor_matloc_fun(e.id_solicitud, d.linea)  as p_matloc_default,
f.matloc_null                                 as p_matloc_null,
'  '                                          as p_aux1,
'  '                                          as "p_aux2"
from   xxmor_fzas_vtas_tab           f,
xxmor_solicitudes_enc_tab     e,
xxmor_solicitudes_det_tab     d,
xxmor_solicitudes_est_rep_tab r
where  e.id_solicitud                      = d.id_solicitud
and    e.id_fza_ventas                     = f.id_fza_ventas
and    e.id_solicitud                      = r.id_solicitud
and    d.id_solicitud                      = r.id_solicitud
and    d.linea                             = r.linea
--and    r.estat_id_foraneo                  is not null --para que no traiga lineas que an no han sido insertadas en pgm
and    upper(d.version)                    not in ('VER PAUTA', 'SA')
and    r.id_sist                           = 1
--and    coalesce(f.copys_x_orden, 0)             = 0 -- se sustituyo por la funcion 16may2013
and    xxmor.xxmor_funcional_pkg_xxmor_copys_por_orden_fn(f.id_fza_ventas,
e.id_solicitud
)                = 'N'
and    xxmor.xxmor_funcional_pkg_xxmor_fecha_valida_fun(d.fecha_inicio) = 1
and    xxmor.xxmor_funcional_pkg_xxmor_fecha_valida_fun(d.fecha_fin)    = 1
and    xxmor.xxmor_funcional_pkg_xxmor_duracion_valida_fun(d.duracion)     = 1
and    coalesce(xxmor.xxmor_funcional_pkg_xxmor_matloc_fun(e.id_solicitud,
d.linea),'-0'
)               != '-1'
and    xxmor.xxmor_funcional_pkg_xxmor_copys_verhorario_fn(
e.id_solicitud,
d.linea
)                = 'Y'
/*and    not exists                            (   --lineas en las que concom respondi que su versin no existe no se generan copys
select 1
from   xxmor_concom_rpta_tab cr
where  cr.id_solicitud               = d.id_solicitud
and    to_number(cr.numlinea_concom) = d.linea
and    instr(cr.detalle_concom::text, 'VersionHorario') > 0
)*/
and    not exists (   --lineas que sigan teniendo error no se generan copys
select 1
from   xxmor_concom_rpta_tab cr
where  cr.id_solicitud               = d.id_solicitud
and    (cr.numlinea_concom)::numeric  = d.linea
and    cr.estatus_orduni             = 10
)
and    not exists (   --copys que no se hayan insertado
select 1
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud = d.id_solicitud
and    er.linea        = d.linea
and    nullif(er.aux1::text, '') is not null
)
and    exists (   --que se haya insertado el encabezado
select 1
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud     = d.id_solicitud
and    er.linea            = 0
and    nullif(er.estat_id_foraneo::text, '') is not null
)
union
-- agrega los registros de los copys x orden
select e.id_solicitud,
d.linea,
(select (estat_id_foraneo)::numeric
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud = e.id_solicitud
and    er.linea        = 0
)                                             as p_ordid,
(xxmor.xxmor_funcional_pkg_xxmor_numline_fun(d.id_solicitud,
d.linea
)
)::numeric                                     as p_ordlnnum,
--r.estat_id_foraneo as id_foraneo_linea,  -->20121130 octavio llam a para ver que valor ponian aqui en estos casos, => 0
oracle.substr(case when e.id_fza_ventas=7 then           --es de nacional
'MULTI0*'                                        ||(select reverse(oracle.substr(reverse(to_char(r.estat_id_foraneo)),                                                                 1,6)                                                                )                                           from   xxmor_solicitudes_est_rep_tab ser                                           where  ser.id_solicitud = r.id_solicitud                                           and    ser.linea        = 0                                          )                                        ||'*'                                        --|| '000' -- to_char (r.estat_id_foraneo, '000') mismo caso de la llamada
--se quita el 000 por un query mas dinmico que no sobreescriba versiones
||xxmor.xxmor_funcional_pkg_xxmor_numline_fun(d.id_solicitud, (d.linea)::numeric )                                        ||'*'                                        ||to_char(trunc(1000000000 * abs(dbms_random.normal)))  else d.stnid||'*'                                        ||(select reverse(oracle.substr(reverse(to_char(er.estat_id_foraneo)),                                                                 1,6)                                                                 )                                           from   xxmor_solicitudes_est_rep_tab er                                           where  er.id_solicitud = r.id_solicitud                                           and    er.linea        = 0                                          )                                        ||'*'                                        --||'000'                --se quita el 000 por un query mas dinmico que no sobreescriba versiones
||xxmor_funcional_pkg_xxmor_numline_fun(d.id_solicitud, (d.linea)::numeric )                                        ||'*'                                        ||to_char(trunc(1000000000 * abs(dbms_random.normal))) end ,
1, 20)                                          as p_rotid,
e.advid                                                as p_advid,
trunc(d.duracion)                                      as p_sptlen,
d.version                                              as p_version,
xxmor.xxmor_funcional_pkg_xxmor_sol_fechas_fun(e.id_solicitud, null, 'FI_COPY')   as p_strdt,
xxmor.xxmor_funcional_pkg_xxmor_sol_fechas_fun(e.id_solicitud, null, 'FF_COPY')   as p_edt,
case when upper(plataforma_canal)='TVSA' then  ''  else d.stnid end  as p_stnid, --estaba el agrupador 11-07-2012
e.plataforma_canal                                     as p_plataforma,
case when upper(plataforma_canal)='CUTIN' then  1  else 0 end          as p_cut_in,
d.marca                                                as p_marca,
f.copys_x_fecha                                        as p_copys_x_fecha,
f.copys_x_orden                                        as p_copys_x_orden,
case when matloc_busqueda='FV' then  f.matloc                                     else oracle.substr(stnid, 1, 2) end     as p_matloc_canal,
xxmor.xxmor_funcional_pkg_xxmor_matloc_fun(e.id_solicitud, d.linea)           as p_matloc_default,
f.matloc_null                                          as p_matloc_null,
'  '                                                   as aux1,
'  '                                                   as "aux2"
from   xxmor_fzas_vtas_tab           f,
xxmor_solicitudes_enc_tab     e,
xxmor_solicitudes_det_tab     d,
xxmor_solicitudes_est_rep_tab r
where  e.id_solicitud                      = d.id_solicitud
and    e.id_fza_ventas                     = f.id_fza_ventas
and    e.id_solicitud                      = r.id_solicitud
and    d.id_solicitud                      = r.id_solicitud
and    xxmor.xxmor_funcional_pkg_xxmor_fecha_valida_fun(d.fecha_inicio) = 1
and    xxmor.xxmor_funcional_pkg_xxmor_fecha_valida_fun(d.fecha_fin)    = 1
and    xxmor.xxmor_funcional_pkg_xxmor_duracion_valida_fun(d.duracion)     = 1
and    coalesce(xxmor.xxmor_funcional_pkg_xxmor_matloc_fun(e.id_solicitud,
d.linea),'-0') != '-1'
and    d.linea                             = r.linea
and    nullif(r.estat_id_foraneo::text, '') is not null --para que no traiga lineas que an no han sido insertadas en pgm
and    upper(d.version)                   not in ('VER PAUTA', 'SA') --and upper (d.version) != 'VER PAUTA'
and    r.id_sist                           = 1
--and    coalesce(f.copys_x_orden, 0) = 1 -- se sustituyo por la funcion 16may2013
and    xxmor.xxmor_funcional_pkg_xxmor_copys_por_orden_fn(f.id_fza_ventas,
e.id_solicitud) = 'Y'
and    xxmor.xxmor_funcional_pkg_xxmor_copys_verhorario_fn(
e.id_solicitud,
d.linea
)                = 'Y'
/*and    not exists                            (   --lineas en las que concom respondi que su versin no existe no se generan copys
select 1
from   xxmor_concom_rpta_tab cr
where  cr.id_solicitud               = d.id_solicitud
and    to_number(cr.numlinea_concom) = d.linea
and    instr(cr.detalle_concom::text, 'VersionHorario') > 0
)*/
and    exists (   --copys que no se hayan insertado
select 1
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud = d.id_solicitud
and    er.linea        = d.linea
and    nullif(er.aux1::text, '') is null
)
and    not exists (   -- valida que si el copy ya fue insertado, no se inserte
select 1
from   xxmor_solicitudes_det_tab     sd,
xxmor_solicitudes_est_rep_tab er
where  sd.id_solicitud = er.id_solicitud
and    sd.linea        = er.linea
and    sd.version      = d.version
and    sd.stnid        = d.stnid
and    er.id_solicitud = e.id_solicitud
and    nullif(er.aux1::text, '') is not null
)
and exists (   -- que se haya insertado el encabezado
select 1
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud     = d.id_solicitud
and    er.linea            = 0
and    nullif(er.estat_id_foraneo::text, '') is not null
)
and d.linea                                in ( -- las lineas que esten bien, agrupadas por canal y version
select min(d2.linea)
from   xxmor_solicitudes_det_tab d2
where  d2.id_solicitud = d.id_solicitud
and    d2.linea        not in (select distinct (r.numlinea_concom)::numeric
from   xxmor_concom_rpta_tab r
where  r.id_solicitud    = d2.id_solicitud
and    nullif(r.numlinea_concom::text, '') is not null
and    r.estatus_orduni  = '10'
and    r.id_seg_neg      = 1
)
group by d2.version, d2.stnid
);/* dmap converted statement end */
-- estimed cost of view [ xxmor_para_copy_vw ]: 3.70;
