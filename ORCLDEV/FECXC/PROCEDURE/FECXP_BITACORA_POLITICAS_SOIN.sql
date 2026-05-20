create or replace procedure fecxc."fecxp_bitacora_politicas_soin"  ( p_usuario varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

insert into  fecxp_b_enc_politicas_soin(version_id, usuario_id, fecha_creacion)
select nextval('sec_politicas_soin'), p_usuario, clock_timestamp()
;
insert into fecxp_b_det_politicas_soin(version_id, cla_fe_id, politica_soin_id, prioridad, e_codigo_ini, e_codigo_fin, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin, ctam03_ini, ctam03_fin, tipo_ini, tipo_fin, division_ini, division_fin, rubro_ini, rubro_fin, activa_regla, ctacr1_ini, ctacr1_fin, ctacr2_ini, ctacr2_fin, tipo_operacion_ini, tipo_operacion_fin, id_tipo_movto, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin)
select currval('sec_politicas_soin'), 				   cla_fe_id, politica_soin_id, prioridad, e_codigo_ini, e_codigo_fin, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin, ctam03_ini, ctam03_fin, tipo_ini, tipo_fin, division_ini, division_fin, rubro_ini, rubro_fin, activa_regla, ctacr1_ini, ctacr1_fin, ctacr2_ini, ctacr2_fin, tipo_operacion_ini, tipo_operacion_fin, id_tipo_movto, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin
from fecxp_politicas_soin;
/* commit; */
end;
$body$
language plpgsql
;
