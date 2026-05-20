-- dmap_object_gen_tag : type : view name : fecxc_folios_manuales_vw
set search_path = fecxc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "fecxc_folios_manuales_vw"  ("cod_sec", "f_deposito", "empresa", "des_empresa", "refcliente", "codbancor", "codfolio", "nchequera", "concepto", "tipocambio", "codmoneda", "desmoneda", "nom_bene", "tipocliente", "tipoplan", "codbancoe", "numcheque", "formapago", "importe", "customer_id", "segmento1") as select /*+ use_nl  */     a.cod_sec_importa                 as cod_sec,
a.f_deposito                      as f_deposito,
a.e_codigo                        as empresa,
c.des_empresa                     as des_empresa,
a.refecliente                     as refcliente,
a.codbancor                       as codbancor,
a.codfolio                        as codfolio,
a.nchequera                       as nchequera,
a.concepto                        as concepto,
a.tipocambio                      as tipocambio,
b.codmoneda                       as codmoneda,
b.desmoneda                       as desmoneda,
a.nom_bene                        as nom_bene,
coalesce(a.tipocliente, 'No definido') as tipocliente,
coalesce(a.tipoplan, 'No definido')    as tipoplan,
a.codbancoe                       as codbancoe,
a.numcheque                       as numcheque,
a.formapago                       as formapago,
a.importe                         as importe,
a.customer_id                     as customer_id,
d.segmento1                       as "segmento1"
from fecxc_empresas c, fecxc_monedas b, fecxc_enc_impges a
left outer join fecxc_det_impges d on (a.cod_sec_importa = d.cod_sec_importa and a.e_codigo = d.e_codigo)
where 1                  = 1 and a.secmoneda        = b.secmoneda and a.e_codigo         = c.e_codigo
union
select /*+ use_nl  */     a.cod_sec_clasifica          as cod_sec,
a.f_deposito                      as f_deposito,
a.e_codigo                        as empresa,
c.des_empresa                     as des_empresa,
a.refecliente                     as refcliente,
a.codbancor                       as codbancor,
a.codfolio                        as codfolio,
a.nchequera                       as nchequera,
a.concepto                        as concepto,
a.tipocambio                      as tipocambio,
b.codmoneda                       as codmoneda,
b.desmoneda                       as desmoneda,
a.nom_bene                        as nom_bene,
coalesce(a.tipocliente,'No definido') as tipocliente,
coalesce(a.tipoplan,'No definido')    as tipoplan,
a.codbancoe                       as codbancoe,
a.numcheque                       as numcheque,
a.formapago                       as formapago,
a.importe                         as importe,
a.customer_id                     as customer_id,
d.segmento1                       as "segmento1"
from fecxc_empresas c, fecxc_monedas b, fecxc_enc_clasificados a
left outer join fecxc_det_clasificados d on (a.e_codigo = d.e_codigo and a.cod_sec_clasifica = d.cod_sec_clasifica)
where 1                   = 1 and a.secmoneda         = b.secmoneda and a.e_codigo          = c.e_codigo;/* dmap converted statement end */
-- estimed cost of view [ fecxc_folios_manuales_vw ]: 1.00;
