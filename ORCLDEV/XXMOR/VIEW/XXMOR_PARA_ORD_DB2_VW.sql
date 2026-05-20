-- dmap_object_gen_tag : type : view name : xxmor_para_ord_db2_vw
set search_path = xxmor,oracle,dmap_extension,public;
 /* dmap converted statement start */
create or replace view "xxmor_para_ord_db2_vw"  ("id_solicitud", "linea", "tipo", "rotid", "call_procedure") as select id_solicitud,
'0' as linea,
'encabezado' as tipo,
null rotid,
'call mor.xxmor_guardaencabezado_pr('
|| coalesce(to_char(p_ordid || ', '),  'null, ')
|| (case when nullif(p_advid::text,  '') is not null then '''' || p_advid || ''', ' else 'null, ' end)
|| (case when nullif(p_accthdrid::text,  '') is not null then '''' || p_accthdrid || ''', ' else 'null, ' end)
|| (case when nullif(p_stnid::text,  '') is not null then '''' || p_stnid || ''', ' else 'null, ' end)
|| coalesce(to_char('' || p_ordtyp || ', '),  'null, ')
|| (case when nullif(p_strdt::text,  '') is not null then '''' || p_strdt || ''', ' else 'null, ' end)
|| (case when nullif(p_edt::text,  '') is not null then '''' || p_edt || ''', ' else 'null, ' end)
|| (case when nullif(p_mcontid::text,  '') is not null then '''' || p_mcontid || ''', ' else 'null, ' end)
|| (case when nullif(p_agyestnum::text,  '') is not null then '''' || p_agyestnum || ''', ' else 'null, ' end)
|| (case when nullif(p_prdid1::text,  '') is not null then '''' || p_prdid1 || ''', ' else 'null, ' end)
|| (case when nullif(p_rtcrd::text,  '') is not null then '''' || p_rtcrd || ''', ' else 'null, ' end)
|| (case when nullif(p_usrfld1::text,  '') is not null then '''' || p_usrfld1 || ''', ' else 'null, ' end)
|| coalesce(to_char('' || p_usrfl10 || ', '),  'null, ')
|| case when trim(both p_totsptord) = null then  'null, ' when nullif(trim(both  from p_totsptord::text), '') is null then  'null,'  else p_totsptord || ',' end
|| (case when nullif(p_cmt::text, '') is not null then '''' || p_cmt || ''',' else 'null,' end)
|| (case when nullif(p_rotid::text, '') is not null then '''' || p_rotid || ''',' else 'null,' end)
|| coalesce(to_char('' || p_copy_x_orden || ','), 'null,')
|| coalesce(to_char('' || p_sptlen || ','), 'null')
|| (case when nullif(p_matloc::text, '') is not null then '''' || p_matloc || ''',' else 'null,' end)
|| (case when nullif(p_version::text, '') is not null then '''' || p_version || ''',' else 'null,' end)
|| coalesce(to_char('' || p_cut_in || ','), 'null,')
|| (case when nullif(p_aux1::text, '') is not null then '''' || p_aux1 || ''',' else 'null,' end)
|| (case when nullif(p_aux2::text, '') is not null then '''' || p_aux2 || ''',' else 'null,' end)
|| (case when nullif(p_aux3::text, '') is not null then '''' || p_aux3 || ''',' else 'null,' end)
|| (case when nullif(p_aux4::text, '') is not null then '''' || p_aux4 || ''',' else 'null,' end)
|| (case when nullif(p_aux5::text, '') is not null then '''' || p_aux5 || ''')' else 'null, ?)' end)
as "call_procedure"
from xxmor_para_enc_vw
--where id_solicitud = 9462
union
select id_solicitud,
linea,
'linea' as tipo,
null rotid,
'call mor.mor.xxmor_guardalinea_pr('
|| case when trim(both ordid) = null then  'null,' when nullif(trim(both from ordid::text), '') is null then  'null,'  else ordid || ',' end
|| (case when nullif(stnid::text, '') is not null then '''' || stnid || ''',' else 'null,' end)
|| coalesce(to_char('' || spot_chr || ','), 'null,')
|| (case when nullif(usr_chr::text, '') is not null then '''' || usr_chr || ''',' else 'null,' end)
|| coalesce(to_char('' || secnum || ','), 'null,')
|| (case when nullif(strdt::text, '') is not null then '''' || strdt || ''',' else 'null,' end)
|| (case when nullif(edt::text, '') is not null then '''' || edt || ''',' else 'null,' end)
|| (case when nullif(buyuntid::text, '') is not null then '''' || buyuntid || ''',' else 'null,' end)
|| coalesce(to_char('' || strtim || ','), 'null,')
|| coalesce(to_char('' || etim || ','), 'null,')
|| coalesce(to_char('' || sptlen || ','), 'null,')
|| (case when nullif(sptpat::text, '') is not null then '''' || sptpat || ''',' else 'null,' end)
|| coalesce(to_char('' || rt || ','), 'null,')
|| (case when nullif(bkdt::text, '') is not null then '''' || bkdt || ''',' else 'null,' end)
|| coalesce(to_char('' || revsts || ','), 'null,')
|| coalesce(to_char('' || usrfl11 || ','), 'null,')
|| coalesce(to_char('' || lnsptord || ','), 'null,')
|| coalesce(to_char('' || lnvalord || ','), 'null,')
|| (case when nullif(prdid1::text, '') is not null then '''' || prdid1 || ''',' else 'null,' end)
|| (case when nullif(brnd::text, '') is not null then '''' || brnd || ''',' else 'null,' end)
|| (case when nullif(cmt::text, '') is not null then '''' || cmt || ''',' else 'null,' end)
|| (case when nullif(p_rotid::text, '') is not null then '''' || p_rotid || ''',' else 'null,' end)
|| (case when nullif(advid::text, '') is not null then '''' || advid || ''',' else 'null,' end)
|| (case when nullif(version::text, '') is not null then '''' || version || ''',' else 'null,' end)
|| coalesce(to_char('' || p_copy_x_linea || ','), 'null,')
|| coalesce(to_char('' || cut_in || ','), 'null,')
|| (case when nullif(matloc::text, '') is not null then '''' || matloc || ''',' else 'null,' end)
|| (case when nullif(p_aux1::text, '') is not null then '''' || p_aux1 || ''',' else 'null,' end)
|| (case when nullif(p_aux2::text, '') is not null then '''' || p_aux2 || ''',' else 'null,' end)
|| (case when nullif(p_aux3::text, '') is not null then '''' || p_aux3 || ''',' else 'null,' end)
|| (case when nullif(p_aux4::text, '') is not null then '''' || p_aux4 || ''',' else 'null,' end)
|| (case when nullif(p_aux5::text, '') is not null then '''' || p_aux5 || ''',?),' else 'null,?)' end)
as "call_procedure"
from xxmor_para_lin_vw
--where id_solicitud = 9462
union
select id_solicitud,
linea,
'copy' as tipo,
rotid,
'call mor.xxmor_guardacopys_pr('
|| (case when nullif(rotid::text, '') is not null then '''' || rotid || ''',' else 'null,' end)
|| coalesce(to_char('' || id_foraneo_orden || ','), 'null,')
|| coalesce(to_char('' || id_foraneo_linea || ','), 'null,')
|| (case when nullif(advid::text, '') is not null then '''' || advid || ''',' else 'null,' end)
|| coalesce(to_char('' || duracion || ','), 'null,')
|| (case when nullif(fecha_inicio::text, '') is not null then '''' || fecha_inicio || ''',' else 'null,' end)
|| (case when nullif(matloc::text, '') is not null then '''' || matloc || ''',' else 'null,' end)
|| (case when nullif(version::text, '') is not null then '''' || version || ''',' else 'null,' end)
|| coalesce(to_char('' || cut_in || ','), 'null,')
|| (case when nullif(stnid::text, '') is not null then '''' || stnid || ''',' else 'null,' end)
|| (case when nullif(plataforma_canal::text, '') is not null then '''' || plataforma_canal || ''',' else 'null,' end)
|| (case when nullif(fecha_fin::text, '') is not null then '''' || fecha_fin || ''',' else 'null,' end)
|| (case when nullif(marca::text, '') is not null then '''' || marca || ''',' else 'null,' end)
|| (case when copys_x_fecha || nullif(copys_x_orden::text, '') is not null then '''' || copys_x_fecha || copys_x_orden || ''',' else 'null,' end)
|| (case when nullif(matloc_null::text, '') is not null then '''' || matloc_null || ''',?)' else 'null,?)' end)
as "call_procedure"
from xxmor_para_copy_vw
;
 /* dmap converted statement end */
-- estimed cost of view [ xxmor_para_ord_db2_vw ]: 22.80;
