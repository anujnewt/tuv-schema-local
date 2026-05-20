-- dmap_object_gen_tag : type : table name : cfdipagos
set search_path = usrsiho,oracle,dmap_extension,public;
create table "cfdipagos"  (
idcomprobanteemp numeric(10) not null,
pag_keypol varchar(30),
pag_cvepol varchar(40),
pag_keypro numeric(5),
pag_keynom numeric(5),
pag_keyper varchar(7),
pag_keycia varchar(2),
pag_keyemp numeric(10),
pag_fecpag timestamp(0),
pag_ca2aux varchar(10),
pag_forpag varchar(30),
pag_feccar timestamp(0),
pag_horcar varchar(10),
pag_keyusu numeric(10),
pag_idepcc varchar(40),
pag_status numeric(5),
uuid varchar(36),
pag_fectim timestamp(0),
pag_hortim varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdipagos
set search_path = usrsiho,oracle,dmap_extension,public;
alter table cfdipagos alter column idcomprobanteemp set not null;
