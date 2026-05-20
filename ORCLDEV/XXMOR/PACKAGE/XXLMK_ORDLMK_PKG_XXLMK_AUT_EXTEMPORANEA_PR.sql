create or replace procedure xxmor.xxlmk_ordlmk_pkg_xxlmk_aut_extemporanea_pr ( p_id_solicitud numeric, piinnum_auts inout numeric ) as $body$
declare
ora2pg_rowcount int;
-- pgv moved types start
-- pgv moved types end
aut_lns cursor for
select e.id_ordhdr, d.num_linea,
'ERROR', 'EXTEMPORANEA', 'AUTORIZACIN - Extemporanea.- La primera transmisn tiene una fecha menor a la actual' as desc_aut
from   xxlmk_ordhdr_tab e,
xxlmk_ordln_tab d
where  e.id_ordhdr = p_id_solicitud
and    e.id_ordhdr = d.id_ordhdr
and    trunc(clock_timestamp()) > (select to_timestamp(det.des_fec_ini,'yyyymmdd')
+  case when can_lun     != 0 then 0
when can_mar    != 0 then 1
when can_mie != 0 then 2
when can_jue    != 0 then 3
when can_vie   != 0 then 4
when can_sab    != 0 then 5
when can_dom   != 0 then 6
else 999 end
from   xxlmk_ordln_tab det
where  det.id_ordhdr = d.id_ordhdr
and    det.num_linea        = d.num_linea
)
and  d.ind_estatus = 1
and not exists (select 1 from xxlmk_autorizaciones_tab a where a.id_orden = d.id_ordhdr and a.ind_tipo_aut = 'EXT' );
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
piinnum_auts := 0;
for aut_ln in aut_lns
loop
insert into xxlmk_autorizaciones_tab(id_aut, id_orden, ind_estatus,
fec_creacion, cve_creado_por, fec_actualizacion, cve_actualizado_por,
ind_tipo_aut, ind_nivel, num_linea, des_aut
)
values (nextval('xxlmk_autorizaciones_sq'), aut_ln.id_ordhdr, 1,
clock_timestamp(), 'System', clock_timestamp(), 'System',
'EXT', 'L', aut_ln.num_linea, aut_ln.desc_aut
);
get diagnostics ora2pg_rowcount = row_count;
piinnum_auts := piinnum_auts +  ora2pg_rowcount;
update  xxlmk_ordln_tab
set     ind_estatus = 3
where   id_ordhdr = p_id_solicitud
and     num_linea = aut_ln.num_linea;
end loop;end;
$body$
language plpgsql
;
