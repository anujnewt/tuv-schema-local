-- dmap_object_gen_tag : type : view name : admp_rep_parrilla_x_canal_vm
set search_path = admp,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "admp_rep_parrilla_x_canal_vm"  ("id_canal", "des_canal", "des_acronimo", "id_parrilla", "fec_parrilla", "num_version", "id_tipo_parrilla", "des_tipo_parrilla", "id_parrilla_det", "id_genero", "des_genero", "cod_hex_color", "cod_hex_borde", "cod_hex_texto", "des_ciclo", "des_hora_inicio", "des_hora_fin", "des_hora_inicio_real", "des_hora_fin_real", "des_hora_inicio_iso", "des_hora_fin_iso", "id_tipo", "des_tipo", "des_programa", "des_programa_original", "id_clasificacion", "cod_clasificacion", "des_clasificacion", "id_formato", "cod_formato", "des_formato", "id_restriccion", "cod_restriccion", "des_restriccion", "des_notas") as select  c.id_canal
, c.des_canal
, c.des_acronimo
, p.id_parrilla
, p.fec_parrilla
, p.num_version
, p.id_tipo_parrilla
, tp.des_tipo_parrilla
, pd.id_parrilla_det
, g.id_genero
, g.des_genero
, g.cod_hex_color
, g.cod_hex_borde
, g.cod_hex_texto
, des_ciclo
, des_hora_inicio
, des_hora_fin
, des_hora_inicio_real
, des_hora_fin_real
, des_hora_inicio_iso
, des_hora_fin_iso
, t.id_tipo
, t.des_tipo
, pd.des_programa
, pd.des_programa_original
, cl.id_clasificacion
, cl.cod_clasificacion
, cl.des_clasificacion
, f.id_formato
, f.cod_formato
, f.des_formato
, r.id_restriccion
, r.cod_restriccion
, r.des_restriccion
, pd.des_notas
from admp_genero_tab g, admp_canal_tab c, admp_parrilla_tab p
left outer join admp_tipo_parrilla_tab tp on (p.id_tipo_parrilla = tp.id_tipo_parrilla)
, admp_parrilla_det_tab pd
left outer join admp_tipo_tab t on (pd.id_tipo = t.id_tipo)
left outer join admp_clasificacion_tab cl on (pd.id_clasificacion = cl.id_clasificacion)
left outer join admp_formato_tab f on (pd.id_formato = f.id_formato)
left outer join admp_restriccion_tab r on (pd.id_restriccion = r.id_restriccion)
where c.id_canal          =  p.id_canal and c.id_estado         = 1 and p.id_estado         = 1 and p.id_parrilla       = pd.id_parrilla and pd.id_genero        = g.id_genero;/* dmap converted statement end */
-- estimed cost of view [ admp_rep_parrilla_x_canal_vm ]: 1.00;
