-- dmap_object_gen_tag : type : table name : inlodnca
set search_path = labconf,oracle,dmap_extension,public;
create table "inlodnca"  (
nca_keypca numeric(5),
nca_keyeta numeric(5),
nca_feccap timestamp(0),
nca_keyemp numeric(5),
nca_keydep varchar(16),
nca_keypue varchar(16),
nca_keypro numeric(5),
nca_keycur varchar(8),
nca_keysup numeric(5),
nca_cvesta varchar(6),
nca_codreq varchar(6),
nca_pricap varchar(6),
nca_intext varchar(2),
nca_cveins varchar(14),
nca_keygpo varchar(4),
nca_fecini timestamp(0),
nca_status varchar(2),
nca_fecact timestamp(0),
nca_obs001 varchar(50)
) ;
