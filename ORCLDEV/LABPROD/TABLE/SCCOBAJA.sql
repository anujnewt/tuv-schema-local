-- dmap_object_gen_tag : type : table name : sccobaja
set search_path = labprod,oracle,dmap_extension,public;
create table "sccobaja"  (
id numeric(38) not null,
baj_keyemp numeric(38),
baj_fecbaj timestamp(0),
baj_fecims timestamp(0),
baj_cvebaj varchar(2),
baj_cvemot varchar(2),
baj_perbaj varchar(7),
baj_status varchar(2),
baj_numliq varchar(6),
baj_keyusu numeric(5),
baj_feccap timestamp(0),
baj_horcap varchar(8),
baj_idplz numeric(38),
baj_idemp numeric(38),
baj_traemp numeric(38),
baj_trapro numeric(5)
) ;
-- dmap_object_gen_tag : type : alter table name : sccobaja
set search_path = labprod,oracle,dmap_extension,public;
alter table sccobaja add constraint sccobaja_pk primary key (id);
