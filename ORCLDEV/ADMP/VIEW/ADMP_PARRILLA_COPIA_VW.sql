-- dmap_object_gen_tag : type : view name : admp_parrilla_copia_vw
set search_path = admp,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "admp_parrilla_copia_vw"  ("id_canal", "des_canal", "des_acronimo", "id_parrilla", "fec_parrilla", "dia", "id_tipo_parrilla", "num_version", "id_parrilla_det", "des_ciclo", "des_hora_inicio", "des_hora_fin", "des_hora_inicio_real", "des_hora_fin_real", "des_programa", "des_programa_original", "des_notas") as select  c.id_canal
, c.des_canal
, c.des_acronimo
, p.id_parrilla
, p.fec_parrilla
, 1 + trunc(fec_parrilla) - trunc(fec_parrilla,  'IW') dia
--, to_char(fec_parrilla, 'DAY', 'NLS_DATE_LANGUAGE=''MEXICAN SPANISH''') dia
, p.id_tipo_parrilla
, p.num_version
, pd.id_parrilla_det
, des_ciclo
, des_hora_inicio
, des_hora_fin
, des_hora_inicio_real
, des_hora_fin_real
, pd.des_programa
, pd.des_programa_original
, pd.des_notas
from    admp_canal_tab          c
,admp_parrilla_tab      p
,admp_parrilla_det_tab  pd
where   c.id_canal          =  p.id_canal
and     c.id_estado         = 1::NUMERIC
and     p.id_estado         = 1::NUMERIC
and     p.id_parrilla       = pd.id_parrilla::NUMERIC;/* dmap converted statement end */
-- estimed cost of view [ admp_parrilla_copia_vw ]: 1.00;
