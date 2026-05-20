-- dmap_object_gen_tag : type : table name : empersonas
set search_path = usrsiho,oracle,dmap_extension,public;
create table "empersonas"  (
per_keyper numeric(10) not null,
per_nombre varchar(40),
per_apepat varchar(20),
per_apemat varchar(20),
per_fecnac timestamp(0),
per_regrfc varchar(13),
per_recurp varchar(18),
per_seudon varchar(40),
per_direci varchar(30),
per_coloni varchar(20),
per_poblac varchar(20),
per_ciudad varchar(20),
per_keydem numeric(10) not null,
per_keyenf numeric(10) not null,
per_codpos varchar(5),
per_keynac numeric(10),
per_keyzoe numeric(5) not null,
per_telef1 varchar(15),
per_telef2 varchar(15),
per_telef3 varchar(15),
per_lugnac varchar(30),
per_origen varchar(30),
per_paires varchar(3),
per_keysex numeric(5) not null,
per_keyedc numeric(5),
per_keyban varchar(7),
per_ctaban varchar(16),
per_keyrgf numeric(10),
per_cedula varchar(20),
per_refcon varchar(20),
per_fecing timestamp(0),
per_keyemp numeric(10),
per_keypue numeric(10),
per_altura numeric,
per_keycom numeric(5),
per_pesokg numeric,
per_keytez numeric(5),
per_keytoj numeric(5),
per_keycoj numeric(5),
per_keycab numeric(5),
per_keynar numeric(5),
per_keyboc numeric(5),
per_estatu varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : empersonas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empersonas alter column per_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : empersonas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empersonas alter column per_keydem set not null;
-- dmap_object_gen_tag : type : alter table name : empersonas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empersonas alter column per_keyenf set not null;
-- dmap_object_gen_tag : type : alter table name : empersonas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empersonas alter column per_keyzoe set not null;
-- dmap_object_gen_tag : type : alter table name : empersonas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empersonas alter column per_keysex set not null;
