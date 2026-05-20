-- dmap_object_gen_tag : type : view name : xxmor_para_enc_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxmor_para_enc_vw"  ("id_solicitud", "p_ordid", "p_advid", "p_accthdrid", "p_stnid", "p_ordtyp", "p_strdt", "p_edt", "p_mcontid", "p_agyestnum", "p_prdid1", "p_rtcrd", "p_usrfld1", "p_usrfl10", "p_totsptord", "p_cmt", "p_target", "p_created_by", "p_totvalord", "proc_por_linea", "p_id_sol_hna", "p_id_hna_pdgm", "p_fza_vtas", "p_aux1", "p_aux2", "p_email") as select --las ordenes (solicitudes) procesar por linea
enc.id_solicitud,
(select (er.aux2)::numeric
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud = enc.id_solicitud
and    er.linea        = 0
)                                  as p_ordid,
oracle.substr(enc.advid, 1, 6)            as p_advid,
enc.accthdrid                      as p_accthdrid,
case when coalesce(fv.respeta_canal,'0')='0' then  enc.agrupador                                         else enc.plataforma_canal end                             as p_stnid,
0                                  as p_ordtyp,
xxmor_funcional_pkg_xxmor_sol_fechas_fun(    enc.id_solicitud,
null,
'FI_ENC'
)               as p_strdt,
xxmor_funcional_pkg_xxmor_sol_fechas_fun(    enc.id_solicitud,
null,
'FF_ENC'
)               as p_edt,
enc.mcontid                        as p_mcontid,
enc.agyestnum                      as p_agyestnum,
(select oracle.substr(prdid_desc, 0, 4)
from   xxmor_solicitudes_enc_tab det
where  det.id_solicitud = enc.id_solicitud
)                                  as p_prdid1,
enc.rtcrd                          as p_rtcrd,
(select oracle.substr(tipo_facturacion, 0, 6)
from   xxmor_solicitudes_enc_tab
where id_solicitud = enc.id_solicitud
)                                  as p_usrfld1,
0                                  as p_usrfl10,
xxmor_funcional_pkg_xxmor_sol_totales_fun(    enc.id_solicitud,
null,
'TOT_SPOTS_BIEN'
)               as p_totsptord,
enc.comentarios                    as p_cmt,
upper(trim(both target))                as p_target,
enc.created_by                     as p_created_by,
xxmor_funcional_pkg_xxmor_sol_totales_fun(    enc.id_solicitud,
null,
'TOT_X_O'
)               as p_totvalord,
(case when nullif(enc.proc_por_linea::text, '') is not null then '1' else '0' end) as proc_por_linea,
coalesce(enc.id_solicitud_hna,0)        as p_id_sol_hna,
(select coalesce((er.estat_id_foraneo)::numeric ,0)
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud = enc.id_solicitud_hna
and    er.linea        = 0
)                                  as p_id_hna_pdgm,
(select fv.ident_fza_ventas
from   xxmor_fzas_vtas_tab fv
where  fv.id_fza_ventas = enc.id_fza_ventas
)                                  as p_fza_vtas,
(select count(1)
from   xxmor_solicitudes_det_tab d
where  id_solicitud = enc.id_solicitud
and    exists (select 1
from   xxmor_solicitudes_est_rep_tab r
where  r.id_solicitud = d.id_solicitud
and    r.linea        = d.linea
and    nullif(r.aux2::text, '') is null
)
and exists (            --lineas que ya hayan entrado a paradigm
select 1
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud     = d.id_solicitud
and    er.linea            = d.linea
and    nullif(er.estat_id_foraneo::text, '') is null
)
and not exists (                    -- que las lineas esten bien
select 1
from   xxmor_concom_rpta_tab cr
where  cr.estatus_orduni             = '10'
and    cr.id_solicitud               = d.id_solicitud
and    (cr.numlinea_concom)::numeric  = d.linea
)
)                                  as p_aux1,
'  '                               as p_aux2,
enc.email                          as "p_email"
from   xxmor_solicitudes_enc_tab enc,
xxmor_fzas_vtas_tab       fv,
xxmor_concom_rpta_tab     cr
where  enc.id_fza_ventas                     = fv.id_fza_ventas
and    enc.id_solicitud                      = cr.id_solicitud
and    nullif(cr.numlinea_concom::text, '') is null
and    cr.estatus_orduni                     = 20
and    xxmor_funcional_pkg_xxmor_fecha_enc_val_fun(enc.id_solicitud) > 0
and    xxmor_funcional_pkg_xxmor_orden_estatus_fun(enc.id_solicitud,
null,
'BANDERA_INSERT'
)                  = 1
and    xxmor_funcional_pkg_xxmor_sol_agr_mult_val_fun(enc.id_solicitud) = 1
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud    = enc.id_solicitud
and    nullif(c.numlinea_concom::text, '') is null
and    c.estatus_orduni  = '10'
)
union
select --las ordenes procesar por orden
enc.id_solicitud,
(select (aux2)::numeric
from   xxmor_solicitudes_est_rep_tab
where  id_solicitud = enc.id_solicitud
and    linea        = 0
)                                  as p_ordid,
oracle.substr(enc.advid, 1, 6)            as p_advid,
enc.accthdrid                      as p_accthdrid,
case when coalesce(fv.respeta_canal,'0')='0' then  enc.agrupador                                         else enc.plataforma_canal end                             as p_stnid,
0                                  as p_ordtyp,
xxmor_funcional_pkg_xxmor_sol_fechas_fun(enc.id_solicitud,
null,
'FI_ENC'
)               as p_strdt,
xxmor_funcional_pkg_xxmor_sol_fechas_fun(enc.id_solicitud,
null,
'FF_ENC'
)               as p_edt,
enc.mcontid                        as p_mcontid,
enc.agyestnum                      as p_agyestnum,
(select oracle.substr(prdid_desc, 0, 4)
from   xxmor_solicitudes_enc_tab det
where det.id_solicitud = enc.id_solicitud
)                                  as p_prdid1,
enc.rtcrd                          as p_rtcrd,
(select oracle.substr(tipo_facturacion, 0, 6)
from   xxmor_solicitudes_enc_tab
where  id_solicitud = enc.id_solicitud
)                                  as p_usrfld1,
0                                  as p_usrfl10,
xxmor_funcional_pkg_xxmor_sol_totales_fun(enc.id_solicitud,
null,
'TOT_SPOTS_BIEN'
)               as p_totsptord,
enc.comentarios                    as p_cmt,
upper(trim(both target))                as p_target,
enc.created_by                     as p_created_by,
xxmor_funcional_pkg_xxmor_sol_totales_fun(enc.id_solicitud,
null,
'TOT_X_O'
)               as p_totvalord,
(case when nullif(enc.proc_por_linea::text, '') is not null then '1' else '0' end) as proc_por_linea,
coalesce(enc.id_solicitud_hna,0)        as p_id_sol_hna,
(select coalesce((er.estat_id_foraneo)::numeric ,0)
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud = enc.id_solicitud_hna
and    er.linea        = 0
)                                  as p_id_hna_pdgm,
(select fv.ident_fza_ventas
from   xxmor_fzas_vtas_tab fv
where  fv.id_fza_ventas = enc.id_fza_ventas
)                                  as p_fza_vtas,
(select count(1)
from   xxmor_solicitudes_det_tab d
where  id_solicitud = enc.id_solicitud
and    exists (select 1
from   xxmor_solicitudes_est_rep_tab r
where  r.id_solicitud = d.id_solicitud
and    r.linea        = d.linea
and    nullif(r.aux2::text, '') is null
)
and    exists (            --lineas que ya hayan entrado a paradigm
select 1
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud     = d.id_solicitud
and    er.linea            = d.linea
and    nullif(er.estat_id_foraneo::text, '') is null
)
and    not exists (                    -- que las lineas esten bien
select 1
from   xxmor_concom_rpta_tab cr
where  cr.estatus_orduni = '10'
and    cr.id_solicitud = d.id_solicitud
and    (cr.numlinea_concom)::numeric  = d.linea
)
)                                  as p_aux1,
'  '                               as p_aux2,
enc.email                          as "p_email"
from   xxmor_solicitudes_enc_tab enc,
xxmor_fzas_vtas_tab       fv,
xxmor_concom_rpta_tab     cr
where  enc.id_fza_ventas                     = fv.id_fza_ventas
and    enc.id_solicitud                      = cr.id_solicitud
and    nullif(cr.numlinea_concom::text, '') is null
and    nullif(proc_por_linea::text, '') is not null
and    cr.estatus_orduni                     = 20
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud    = enc.id_solicitud
and    nullif(c.numlinea_concom::text, '') is null
and    c.estatus_orduni  = '10'
)
and    xxmor_funcional_pkg_xxmor_fecha_enc_val_fun(enc.id_solicitud) > 0
and    cr.id_solicitud                       not in (select distinct id_solicitud
from   xxmor_concom_rpta_tab
where  id_seg_neg     = 1
and    estatus_orduni = 10
except
select id_solicitud
from   xxmor_concom_rpta_tab
where  id_seg_neg     = 1
and    estatus_orduni = 20
and    nullif(numlinea_concom::text, '') is null
)
and    xxmor_funcional_pkg_xxmor_sol_agr_mult_val_fun(enc.id_solicitud) = 1;/* dmap converted statement end */
-- estimed cost of view [ xxmor_para_enc_vw ]: 1.00;
