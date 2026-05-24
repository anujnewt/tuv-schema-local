create or replace procedure fecxc.fecxc_folios_manuales_pkg_fecxc_fill_folmanuales_pr ( pistsegmento varchar, pistmoneda varchar, pistanio varchar, pistmesinicial varchar, pistmesfinal varchar, pinregistro numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- pragma autonomous_transaction;
line_codigo            numeric;
lincod_sec_clasifica   numeric;
lin_importe            numeric;
life_f_deposito        timestamp(0);
list_nom_bene          varchar(150);
licont                 numeric := 0;
i                      record;
curfolioreal cursor for
select distinct trim(split_part(a.concepto,' ',1))::numeric as folio_real
from fecxc_folios_manuales_vw a,fecxc_det_catalogos b
where 1=1--a.empresa = 3868
and b.cod_sec_lin = a.segmento1
and b.tipo_cat = 'SEGMENTO'
and a.codfolio < 0
and b.cod_valor = pistsegmento  --argumel
and a.concepto like '%RECLA%INGRESO%'
and codmoneda = pistmoneda
and to_char(a.f_deposito,'MM') between pistmesinicial and pistmesfinal
and to_char(a.f_deposito,'YYYY') = pistanio
and fecxc_divxperiodo_pkg_isnumeric_fn(coalesce(split_part(a.concepto,' ',1),'DUMMY')) = 1;
--and trim(oracle.substr(a.concepto,0,instr(a.concepto,  ))) not in(33403454,33627798)
--and trim(oracle.substr(a.concepto,0,instr(a.concepto,  ))) not in (select num_folio_real from fecxc_fmanual_out_tab);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
if pinregistro = 1
then
delete from fecxc_fmanual_out_tab;
/* commit; */
end if;
for i in curfolioreal
loop
line_codigo := null;
lincod_sec_clasifica := null;
lin_importe := null;
life_f_deposito := null;
list_nom_bene := null;
licont := licont+100;
begin
select a.e_codigo,
a.cod_sec_clasifica,
a.importe,
a.f_deposito ,
a.nom_bene
into strict line_codigo,
lincod_sec_clasifica,
lin_importe,
life_f_deposito,
list_nom_bene
from fecxc_enc_clasificados a
where codfolio = i.folio_real;/* dmap converted statement start */
exception when no_data_found
then
raise notice '% No existe informacion para este registro FECXC_FILL_FOLMANUALES_PR Folio: %', SQLERRM, i.folio_real;
continue;/* dmap converted statement end */
end;
--      and trim(oracle.substr(a.concepto,0,instr(a.concepto,  ))) not in (select num_folio_real from fecxc_fmanual_out_tab);
insert into fecxc_fmanual_out_tab(
num_ecodigo,
cod_sec_clasifica,
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
select a.e_codigo,
cod_sec_clasifica,
licont,
i.folio_real,
life_f_deposito,
null,
case when cod_subclasif = 'BASE' then importe  end,
case when cod_subclasif in ('OTROS','INTERCAMBI','INTERIVA','OTROSING') then importe  end,
case when cod_subclasif = 'IVA' then importe  end,
list_nom_bene,
--n_linea_clas,
lin_importe,
d.desc_valor,
clock_timestamp()
from fecxc_enc_clasfecxc c, fecxc_det_clasfecxc b, fecxc_det_clasificados a
left outer join fecxc_det_catalogos d on (a.segmento1 = d.cod_sec_lin)
where a.cod_sec_catclas = b.cod_sec_catclas and a.cod_sec_det       = b.cod_sec_det and a.cod_sec_catclas   = c.cod_sec_catclas  and e_codigo            =line_codigo and cod_sec_clasifica   =lincod_sec_clasifica and lincod_sec_clasifica not in (select cod_sec_clasifica from fecxc_fmanual_out_tab);
/*******************************************************************************/
licont := licont+1;
insert into fecxc_fmanual_out_tab(
num_ecodigo,
cod_sec_clasifica,
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
select a.empresa,
a.cod_sec,
licont,
trim(split_part(a.concepto,' ',1))::numeric,
a.f_deposito,
a.codfolio,
fecxc_folios_manuales_pkg_fecxc_get_subclasif_base_fn(a.codfolio,pistsegmento),
fecxc_folios_manuales_pkg_fecxc_get_subclasif_otros_fn(a.codfolio,pistsegmento),
fecxc_folios_manuales_pkg_fecxc_get_subclasif_iva_fn(a.codfolio,pistsegmento),
a.nom_bene,
lin_importe,
b.desc_valor,
clock_timestamp()
from fecxc_folios_manuales_vw a,fecxc_det_catalogos b
where 1=1--a.empresa = 3868
and b.cod_sec_lin = a.segmento1
and b.tipo_cat = 'SEGMENTO'
and a.codfolio < 0
and b.cod_valor = pistsegmento
and a.concepto like '%RECLA%INGRESO%'
and codmoneda = pistmoneda
and to_char(a.f_deposito,'MM') between pistmesinicial and pistmesfinal
and to_char(a.f_deposito,'YYYY') = pistanio
and trim(split_part(a.concepto,' ',1))::numeric = i.folio_real
and fecxc_divxperiodo_pkg_isnumeric_fn(coalesce(split_part(a.concepto,' ',1),'DUMMY')) = 1;
end loop;/* dmap converted statement start */
/* commit; */
exception
when others
then
raise notice 'Error: %', SQLERRM;/* dmap converted statement end */
rollback;
end;end;
$body$
language plpgsql
;
