create or replace procedure fecxc."fecxp_bitacora_politicas_erp"  ( p_usuario varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

insert into fecxp_b_enc_politicas_erp(version_id, usuario_id, fecha_creacion)
select nextval('sec_politicas_erp'), p_usuario, clock_timestamp()
;
insert into fecxp_b_det_politicas_erp(version_id, politica_erp_id, cla_fe_id, prioridad, oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin, activa_regla, tipo_operacion_ini, tipo_operacion_fin, id_tipo_movto, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin)
select currval('sec_politicas_erp'), 				  politica_erp_id, cla_fe_id, prioridad, oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin, activa_regla, tipo_operacion_ini, tipo_operacion_fin, id_tipo_movto, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin
from fecxp_politicas_erp;
/* commit; */
end;
$body$
language plpgsql
;
