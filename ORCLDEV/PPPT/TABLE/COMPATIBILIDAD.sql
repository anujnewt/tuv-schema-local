-- dmap_object_gen_tag : type : table name : compatibilidad
set search_path = pppt,oracle,dmap_extension,public;
create table "compatibilidad"  (
idpersonal numeric(38) not null,
idpuesto numeric(38) not null,
wais numeric,
therman numeric,
spranger numeric,
herman numeric,
cleaver numeric,
lifo numeric,
experiencia numeric,
escolaridad numeric,
total numeric,
eval360 numeric,
ingles numeric,
ho numeric,
ac numeric,
ortografia numeric,
ppv numeric,
co numeric,
intrac numeric,
eq numeric,
vtasabb numeric,
bmb_cm numeric,
bmb_hm numeric,
iw numeric,
lidsit numeric,
competencias numeric,
competencias0 numeric,
competencias1 numeric,
competencias2 numeric,
word numeric,
excel numeric,
ttcmi numeric
) ;
-- dmap_object_gen_tag : type : alter table name : compatibilidad
set search_path = pppt,oracle,dmap_extension,public;
alter table compatibilidad alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : compatibilidad
set search_path = pppt,oracle,dmap_extension,public;
alter table compatibilidad alter column idpuesto set not null;
