create or replace procedure usrdrc.pendium_con_poderes_pkg_query_otorga_poder_pg (porcrsresultado inout refcursor ,pinid_ep_fk numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select
null as "apoderados"
,null as "facultades"
,null as "mancomunados"
,poder.id_opoder_ep_pk
,poder.id_ep_fk
,poder.num_podertipo
,poder.des_podertipo
,poder.num_vigenciatipo
,poder.des_vigenciatipo
,poder.num_vigenciatiempo
,poder.fec_vigenciainicio
,poder.fec_vigenciafin
,poder.desc_caracteristicas
,poder.desc_actosdominio
,poder.desc_actosadmon
,poder.desc_pleitoscobranza
,poder.desc_revocados
,poder.num_created_by
,poder.fec_creation_date
,poder.num_last_updated_by
,poder.fec_last_update_date
,poder.num_last_update_login
,poder.atributo1
,poder.atributo2
,poder.atributo3
,poder.atributo4
,poder.atributo5
,poder.atributo6
,poder.atributo7
,poder.atributo8
,poder.atributo9
,poder.atributo10
,poder.atributo11
,poder.atributo12
,poder.atributo13
,poder.atributo14
,poder.atributo15
,poder.attribute_category
,poder.num_order
,poder.desc_tituloscredito
,poder.desc_vigencia
,poder.ind_status
,poder.desc_descripcion
,poder.des_poder
,poder.desc_apoderados
,coalesce(pe.des_poder,'') as desc_poder_especial
from pendium_otorgapoder_ep_tab poder
inner join pendium_escritura_poder_tab esc on esc.id_ep_pk = poder.id_ep_fk
left join pendium_otorgapoder_ep_tab pe
join pendium_escritura_poder_tab esc_b on (esc_b.id_ep_pk = pe.id_ep_fk and esc_b.ind_tipo_escritura = 'PE' and esc_b.ind_status = 1  and pe.ind_status = 1)
on trim(both coalesce(to_char(poder.des_poder),' ')) = coalesce(pe.des_podertipo,' ') and esc_b.id_empresa = esc.id_empresa and coalesce(esc.des_escritura,' ') = coalesce(esc_b.des_escritura,' ')
and esc.ind_delegado_por = esc_b.ind_delegado_por and coalesce(esc.fec_fecha,' ') = coalesce(esc_b.fec_fecha,' ') and coalesce(esc.num_documentum_instr,' ') = coalesce(esc_b.num_documentum_instr,' ')
and coalesce(esc.fec_otorgamiento_instr,' ') = coalesce(esc_b.fec_otorgamiento_instr,' ') and esc.num_licenciado = esc_b.num_licenciado and coalesce(esc.num_insc_regpub,' ') = coalesce(esc_b.num_insc_regpub,' ')
and coalesce(esc.fec_registro,' ') = coalesce(esc_b.fec_registro,' ')
where
poder.id_ep_fk  = pinid_ep_fk
and poder.ind_status = 1
and esc.ind_status = 1
order by  num_order;end;
$body$
language plpgsql
;
