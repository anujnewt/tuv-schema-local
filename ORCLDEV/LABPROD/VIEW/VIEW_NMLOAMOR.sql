-- dmap_object_gen_tag : type : view name : view_nmloamor
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "view_nmloamor"  ("amo_keyemp", "amo_keycon", "amo_keypre", "amo_refere", "amo_keypro", "amo_keydep", "amo_keypue", "amo_keycat", "amo_keyubi", "amo_keyper", "amo_keynom", "amo_numpag", "amo_tiptra", "amo_refpag", "amo_fecpag", "amo_imppag", "amo_unipag", "amo_intpag", "amo_porint", "amo_conpro", "amo_fecnom", "amo_ctreve", "amo_ca1aux", "amo_ca2aux", "amo_uniope") as (select
amo_keyemp,
amo_keycon,
amo_keypre,
amo_refere,
amo_keypro,
amo_keydep,
amo_keypue,
amo_keycat,
amo_keyubi,
amo_keyper,
amo_keynom,
amo_numpag,
amo_tiptra,
amo_refpag,
amo_fecpag,
amo_imppag,
amo_unipag,
amo_intpag,
amo_porint,
amo_conpro,
amo_fecnom,
amo_ctreve,
amo_ca1aux,
amo_ca2aux,
amo_uniope
from labprod.nmloamor
where amo_keypre in (select pre_keypre from labprod.nmlopres where pre_keycon in ('121','118'))
);/* dmap converted statement end */
-- estimed cost of view [ view_nmloamor ]: 1.00;
