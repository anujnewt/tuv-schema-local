create or replace procedure fecxc."fecxp_bitacora_clasif_fe"  ( p_usuario varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

insert into fecxp_b_enc_clasificacion_fe(version_id, usuario_id, fecha_creacion)
select nextval('sec_clasificacion_fe'), p_usuario, clock_timestamp()
;
insert into fecxp_b_det_clasificacion_fe(version_id, cla_fe_id, cla_fe_des, cla_atributo1, cla_atributo2, cla_atributo3, cla_atributo4, cla_atributo5, cla_atributo6, genera_saldo)
select currval('sec_clasificacion_fe'), cla_fe_id, cla_fe_des, cla_atributo1, cla_atributo2, cla_atributo3, cla_atributo4, cla_atributo5, cla_atributo6, genera_saldo
from fecxp_clasificacion_fe;
/* commit; */
end;
$body$
language plpgsql
;
