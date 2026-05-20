create or replace procedure xxmor.xxlmk_ordlmk_pkg_xxlmk_aut_tm_ln_pr ( p_id_solicitud numeric, poinnum_auts inout numeric ) as $body$
declare
ora2pg_rowcount int;
-- pgv moved types start
-- pgv moved types end
aut_lns cursor for
select  ol.id_ordhdr, ol.num_linea
from    xxlmk_ordln_tab     ol
where   ol.id_ordhdr = p_id_solicitud
and not exists (select 1 from xxlmk_autorizaciones_tab a where a.id_orden = ol.id_ordhdr and ind_tipo_aut = 'TM');
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
poinnum_auts    := 0;
for aut_ln in aut_lns
loop
insert into xxlmk_autorizaciones_tab(id_aut, id_orden, ind_estatus,
fec_creacion, cve_creado_por, fec_actualizacion, cve_actualizado_por,
ind_tipo_aut, ind_nivel, num_linea, des_aut
)
values (nextval('xxlmk_autorizaciones_sq'), aut_ln.id_ordhdr, 1,
clock_timestamp(), 'System', clock_timestamp(), 'System',
'TM', 'L', aut_ln.num_linea, 'Taria Manual'
);
poinnum_auts := poinnum_auts + sql%rowcount;
get diagnostics ora2pg_rowcount = row_count;
if ora2pg_rowcount > 0) then
update  xxlmk_ordln_tab
set     ind_estatus = 3
where   id_ordhdr = p_id_solicitud
and     num_linea = aut_ln.num_linea;
end if;
end loop;end;
$body$
language plpgsql
;
