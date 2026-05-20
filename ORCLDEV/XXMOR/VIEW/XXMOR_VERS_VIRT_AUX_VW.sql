-- dmap_object_gen_tag : type : view name : xxmor_vers_virt_aux_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "xxmor_vers_virt_aux_vw"  ("id_request", "id_solicitud", "id_seg_neg", "linea", "id_fza_ventas", "advid", "extcpynum", "nomanclen", "actanclen", "ancstrdt", "ancedt", "usrchr", "sptchr", "prdid1", "vidsrc", "audsrc", "brnd", "autoid", "proactday", "actday", "propgmid", "prostn", "aux01", "aux02", "aux03", "aux04", "aux05") as select e.id_request,
e.id_solicitud,
e.id_seg_neg,
d.linea,
e.id_fza_ventas,
e.advid,
d.version as extcpynum,                 --identificador de la versin
d.duracion as nomanclen,               --duracin nominal en segundos
(d.duracion)::numeric  * 1000 as actanclen,  --duracin actual en milisegundos
/*(select to_char (
min (to_timestamp(fecha_inicio, 'yyyy-mm-dd'))
- to_char (min (to_timestamp(fecha_inicio, 'yyyy-mm-dd')),
'D')
+ 2,
'YYYY-MM-DD')
from xxmor_solicitudes_det_tab det
where det.id_solicitud = e.id_solicitud::NUMERIC
--and det.linea_estatus not in (46, 36)
)
as */
----------- primer intento de fecha
/*  (   select decode(to_char(min(to_timestamp(fecha_inicio,'YYYY-MM-DD')) ,'D'),'1'
,to_char((min(to_timestamp(fecha_inicio,'YYYY-MM-DD'))
- to_char(min(to_timestamp(fecha_inicio,'YYYY-MM-DD')),'D')
) - 5
,'YYYY-MM-DD'
)
,to_char((min(to_timestamp(fecha_inicio,'YYYY-MM-DD'))
- to_char(min(to_timestamp(fecha_inicio,'YYYY-MM-DD')),'D')
) + 2
,'YYYY-MM-DD'
)
) lunes_ant
from   xxmor_solicitudes_det_tab det
where  det.id_solicitud = e.id_solicitud::NUMERIC  )   */
to_char(statement_timestamp(),'yyyy-mm-dd')  ancstrdt, -- fecha de inicio de la version: el lunes anterior a la primer transmisin.
to_char((to_char(statement_timestamp(), 'yyyy'))::numeric  + 1) || '-01-31'
as ancedt,                                            --fecha fin
d.usr_chr as usrchr,                           --user characteristic
d.spot_chr as sptchr,                          --spot characteristic
'00PT' as prdid1,                        --tipo de producto  -- e.prdid
'VR' as vidsrc,                         --fuente del video (virtual)
'VR' as audsrc,                          --fuente del audio (virtual)
d.marca as brnd,                                --marca del producto
fv.matloc as autoid, --automation id solo para provincia (tn, jc,nl)
'0000000' as proactday, --das en que se puede transmitir la versin
'1111111' as actday,    --das en que se puede transmitir la versin
'  ' as propgmid,
'  ' as prostn,
'12345678901234567890  ' as aux01,                     -- auxiliar 1
'12345678901234567890  ' as aux02,                     -- auxiliar 2
'12345678901234567890  ' as aux03,                     -- auxiliar 3
'12345678901234567890  ' as aux04,                     -- auxiliar 4
'12345678901234567890  ' as "aux05                      -- auxiliar 5"
from xxmor_solicitudes_enc_tab e,
xxmor_solicitudes_det_tab d,
xxmor_fzas_vtas_tab fv
where e.id_solicitud = d.id_solicitud::NUMERIC
and e.id_fza_ventas = fv.id_fza_ventas::NUMERIC
and fv.mercadotecnia = 1
and e.id_seg_neg = 1::NUMERIC
;/* dmap converted statement end */
-- estimed cost of view [ xxmor_vers_virt_aux_vw ]: 1.30;
