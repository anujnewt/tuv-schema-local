-- dmap_object_gen_tag : type : view name : vcfdi2total::NUMERICletra
set search_path = labconf,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "vcfdi2total::NUMERICletra"  ("idcomprobanteemp", "total::NUMERIC") as select idcomprobanteemp, cantidadconletra(total::NUMERIC) total::NUMERIC
from labconf.cfdi2comprobanteemp;/* dmap converted statement end */
-- estimed cost of view [ vcfdi2total::NUMERICletra ]: 1.00;
