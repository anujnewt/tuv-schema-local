create or replace  function  fecxc.fecxc_folios_manuales_pkg_fecxc_get_subclasif_otros_2_fn ( piinfolio_manual numeric, pistsegmento varchar ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
lin_importe numeric := 0;
lin_cod_sec numeric;
lin_empresa numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select distinct a.cod_sec,
a.empresa
into strict lin_cod_sec,
lin_empresa
from fecxc_folios_manuales_vw a
where codfolio = piinfolio_manual;
select sum(b.importe) into strict lin_importe
from(
select sum(coalesce(importe,0)) as importe
from
fecxc_det_clasificados a,
fecxc_det_clasfecxc b,
fecxc_enc_clasfecxc c
where a.cod_sec_catclas = b.cod_sec_catclas
and a.cod_sec_det   = b.cod_sec_det
--                        and  a.segmento1 = d.cod_sec_lin(+)
and a.cod_sec_catclas = c.cod_sec_catclas
and e_codigo          = lin_empresa
and cod_sec_clasifica = lin_cod_sec
and cod_subclasif     in ('OTROS','INTERCAMBI','OTROSING')
and a.segmento1 = (select cod_sec_lin from fecxc_det_catalogos where cod_valor = pistsegmento and tipo_cat='SEGMENTO')
group by cod_subclasif
union
select sum(coalesce(importe,0))as importe
from
fecxc_det_impges a,
fecxc_det_clasfecxc b,
fecxc_enc_clasfecxc c
where a.cod_sec_catclas = b.cod_sec_catclas
and a.cod_sec_det   = b.cod_sec_det
--                        and  a.segmento1 = d.cod_sec_lin(+)
and a.cod_sec_catclas = c.cod_sec_catclas
and e_codigo          = lin_empresa
and cod_sec_importa   = lin_cod_sec
and cod_subclasif     in ('OTROS','INTERCAMBI','OTROSING')
and a.segmento1 = (select cod_sec_lin from fecxc_det_catalogos where cod_valor = pistsegmento and tipo_cat='SEGMENTO')
group by cod_subclasif
)b;/* dmap converted statement start */
exception when no_data_found
then perform dbms_output.put_line( concat(sqlerrm, ' No existe informacion para este registro FECXC_GET_SUBCLASIF_OTROS_FN Folio: ', piinfolio_manual)) ;/* dmap converted statement end */
end;
return coalesce(lin_importe,0);end;
$body$
language plpgsql
stable;
