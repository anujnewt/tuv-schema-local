create or replace  function  fecxc.fecxc_folios_manuales_pkg_fecxc_get_subclasif_fn ( piinfolio numeric ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
list_subclasif          varchar(150);
lin_cod_sec_clasifica   numeric;
lin_ecodigo             numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select a.cod_sec_clasifica,
a.e_codigo
into strict lin_cod_sec_clasifica,
lin_ecodigo
from fecxc_enc_clasificados a
where codfolio =piinfolio;
select cod_subclasif into strict list_subclasif
from fecxc_enc_clasfecxc c, fecxc_det_clasfecxc b, fecxc_det_clasificados a
left outer join fecxc_det_catalogos d on (a.segmento1 = d.cod_sec_lin)
where a.cod_sec_catclas = b.cod_sec_catclas and a.cod_sec_det = b.cod_sec_det  and a.cod_sec_catclas = c.cod_sec_catclas and e_codigo = lin_ecodigo and cod_sec_clasifica = lin_cod_sec_clasifica;/* dmap converted statement start */
exception when no_data_found
then perform dbms_output.put_line( concat(sqlerrm, ' No existe informacion para este registro FECXC_GET_SUBCLASIF_FN Folio; ', piinfolio)) ;/* dmap converted statement end */
end;
return   list_subclasif;end;
$body$
language plpgsql
stable;
