create or replace procedure fecxc.dmap_fecxc_folios_manuales_pkg_fecxc_fill_folmanuales3_pr ( pistsegmento varchar, pistmoneda varchar, pistanio varchar, pistmesinicial varchar, pistmesfinal varchar, pinregistro numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- pragma autonomous_transaction;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if pinregistro = 1
then
delete from fecxc_fmanual_out3_tab;
/* commit; */
end if;
insert into fecxc_fmanual_out3_tab(
cod_sec_clasifica,
num_ecodigo,
id_orden,
num_folio_real,
fec_f_ingreso,
num_folio_manual,
num_monto_folio,
num_otros,
num_iva,
nom_cliente,
num_imp_folio_real,
des_segmento,
fec_creation_date)
select  distinct a.cod_sec_clasifica,
e.e_codigo ,
0,
0,
e.f_deposito,
e.codfolio ,
e.importe,
fecxc_folios_manuales_pkg_fecxc_get_subclasif_otros_2_fn(e.codfolio,pistsegmento),
fecxc_folios_manuales_pkg_fecxc_get_subclasif_iva_int_fn(e.codfolio,pistsegmento),
e.nom_bene,
0,
d.desc_valor,
clock_timestamp()
from fecxc_det_clasificados a,
fecxc_det_clasfecxc b,
fecxc_det_catalogos d,
fecxc_enc_clasificados e,
fecxc_monedas f
where a.cod_sec_catclas = b.cod_sec_catclas
and e.cod_sec_clasifica = a.cod_sec_clasifica
and   e.secmoneda = f.secmoneda
and a.cod_sec_det = b.cod_sec_det
and d.tipo_cat = 'SEGMENTO'
and d.cod_sec_lin = a.segmento1
and d.cod_valor = pistsegmento
and f.codmoneda = pistmoneda
and to_char(e.f_deposito,'MM') between pistmesinicial and pistmesfinal
and to_char(e.f_deposito,'YYYY') = pistanio
and b.cod_subclasif in ('INTERCAMBI','INTERIVA','OTROS','OTROSING','IVA');/* dmap converted statement start */
/* commit; */
exception
when others
then
--posterrbuf  :=  sqlerrm;
--postretcode :=  sqlcode;
perform dbms_output.put_line( concat('Error:', to_char(sqlstate))) ;/* dmap converted statement end */
perform dbms_output.put_line(sqlerrm);
rollback;end;
$body$
language plpgsql
;
