-- dmap_object_gen_tag : type : view name : glcobita_smart
set search_path = usrsiasa,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "glcobita_smart"  ("bit_keyusu", "bit_logusu", "bit_idepcc", "bit_fecmov", "bit_hormov", "bit_tipmov", "bit_key001", "bit_key002", "bit_key003", "bit_val001", "bit_val002", "bit_val003", "bit_desmen", "bit_ideniv") as select bit_keyusu,
bit_logusu,
bit_idepcc,
to_date(to_char(bit_fecmov,  'DD/MM/YYYY') || ' ' || bit_hormov,
'DD/MM/YYYY HH24:MI:SS')
bit_fecmov,
bit_hormov,
bit_tipmov,
bit_key001,
bit_key002,
bit_key003,
bit_val001,
bit_val002,
bit_val003,
bit_desmen,
bit_ideniv
from usrsiho.glcobita
where nullif(bit_fecmov::text, '') is not null;/* dmap converted statement end */
-- estimed cost of view [ glcobita_smart ]: 1.20;
