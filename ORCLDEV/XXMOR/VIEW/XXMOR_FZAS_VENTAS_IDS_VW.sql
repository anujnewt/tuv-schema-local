-- dmap_object_gen_tag : type : view name : xxmor_fzas_ventas_ids_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxmor_fzas_ventas_ids_vw"  ("id_seg_neg", "id_fza_ventas", "ident_fza_ventas", "region", "agrupador", "cliente", "sufijo", "sptchr", "usrchr", "inclusion") as select a.id_seg_neg,
a.id_fza_ventas,
fv.ident_fza_ventas,
a.region,
b.agrupador,
c.cliente,
d.sufijo,
sptchr,
usrchr,
e.inclusion
from (select id_seg_neg,
id_fza_ventas,
ident_fza_tipo,
ident_fza_val as region
from   xxmor_fzas_vtas_ident_tab
where  ident_fza_tipo = 'P'              --and ident_fza_val = 'DF'
) a
left outer join(select id_seg_neg,
id_fza_ventas,
ident_fza_tipo,
ident_fza_val as agrupador
from xxmor_fzas_vtas_ident_tab
where ident_fza_tipo = 'G' --and ident_fza_val is null
) b
on  a.id_seg_neg    = b.id_seg_neg
and a.id_fza_ventas = b.id_fza_ventas
left outer join(select id_seg_neg,
id_fza_ventas,
ident_fza_tipo,
ident_fza_val as cliente
from xxmor_fzas_vtas_ident_tab
where ident_fza_tipo = 'A' --and ident_fza_val is  null
) c
on  a.id_seg_neg    = c.id_seg_neg
and a.id_fza_ventas = c.id_fza_ventas
left outer join(select id_seg_neg,
id_fza_ventas,
ident_fza_tipo,
ident_fza_val as sufijo
from xxmor_fzas_vtas_ident_tab
where ident_fza_tipo = 'S' --and ident_fza_val = 'CO'
) d
on  a.id_seg_neg    = d.id_seg_neg
and a.id_fza_ventas = d.id_fza_ventas
left outer join(select id_seg_neg,
id_fza_ventas,
sptchr,
usrchr,
inclusion
from xxmor_conf_tipo_srv_tab
where inclusion = 1
) e
on  a.id_seg_neg    = e.id_seg_neg
and a.id_fza_ventas = e.id_fza_ventas
inner join xxmor_fzas_vtas_tab fv
on  a.id_seg_neg    = fv.id_seg_neg
and a.id_fza_ventas = fv.id_fza_ventas
and fv.activa       = '1'
where  nullif(inclusion::text, '') is not null
union
select a.id_seg_neg,
a.id_fza_ventas,
fv.ident_fza_ventas,
a.region,
b.agrupador,
c.cliente,
d.sufijo,
sptchr,
usrchr,
e.inclusion
from (select id_seg_neg,
id_fza_ventas,
ident_fza_tipo,
ident_fza_val as region
from xxmor_fzas_vtas_ident_tab
where ident_fza_tipo = 'P'              --and ident_fza_val = 'DF'
) a
left outer join(select id_seg_neg,
id_fza_ventas,
ident_fza_tipo,
ident_fza_val as agrupador
from xxmor_fzas_vtas_ident_tab
where ident_fza_tipo = 'G' --and ident_fza_val is null
) b
on  a.id_seg_neg    = b.id_seg_neg
and a.id_fza_ventas = b.id_fza_ventas
left outer join(select id_seg_neg,
id_fza_ventas,
ident_fza_tipo,
ident_fza_val as cliente
from   xxmor_fzas_vtas_ident_tab
where  ident_fza_tipo = 'A' --and ident_fza_val is  null
) c
on  a.id_seg_neg    = c.id_seg_neg
and a.id_fza_ventas = c.id_fza_ventas
left outer join(select id_seg_neg,
id_fza_ventas,
ident_fza_tipo,
ident_fza_val as sufijo
from xxmor_fzas_vtas_ident_tab
where ident_fza_tipo = 'S' --and ident_fza_val = 'CO'
) d
on  a.id_seg_neg    = d.id_seg_neg
and a.id_fza_ventas = d.id_fza_ventas
left outer join(select id_seg_neg,
id_fza_ventas,
sptchr,
usrchr,
inclusion
from xxmor_conf_tipo_srv_tab
where inclusion = 0
) e
on  a.id_seg_neg    = e.id_seg_neg
and a.id_fza_ventas = e.id_fza_ventas
inner join xxmor_fzas_vtas_tab fv
on  a.id_seg_neg    = fv.id_seg_neg
and a.id_fza_ventas = fv.id_fza_ventas
and fv.activa       = '1'
where  nullif(inclusion::text, '') is not null;/* dmap converted statement end */
-- estimed cost of view [ xxmor_fzas_ventas_ids_vw ]: 1.00;
