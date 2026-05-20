-- dmap_object_gen_tag : type : table name : holoreci_ter
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holoreci_ter"  (
rec_ejerci numeric(10) not null,
rec_keypro numeric(5) not null,
rec_keyrec numeric(10) not null,
rec_keyemp numeric(10) not null,
rec_regrfc varchar(13) not null,
rec_cvefac varchar(50) not null,
rec_keyapr varchar(6) not null,
rec_keynom numeric(5) not null,
rec_numemi numeric(10) not null,
rec_stsrec numeric(5) not null,
rec_numrem numeric(10),
rec_import decimal(16, 2),
rec_fecpag timestamp(0),
rec_feccob timestamp(0),
rec_keyusg numeric(5) not null,
rec_fecact timestamp(0) not null,
rec_keyusc numeric(5),
rec_keypol numeric(10),
rec_stsfis varchar(1),
rec_fecfis timestamp(0),
rec_remtra varchar(20),
rec_stsfon numeric(5),
rec_impiva decimal(16, 2),
rec_impisr timestamp(0),
rec_stscon numeric(5)
) ;
-- dmap_object_gen_tag : type : alter table name : holoreci_ter
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreci_ter add constraint pk_hreci_ter primary key (rec_ejerci,rec_keypro,rec_keyrec);
-- dmap_object_gen_tag : type : alter table name : holoreci_ter
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreci_ter alter column rec_ejerci set not null;
-- dmap_object_gen_tag : type : alter table name : holoreci_ter
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreci_ter alter column rec_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : holoreci_ter
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreci_ter alter column rec_keyrec set not null;
-- dmap_object_gen_tag : type : alter table name : holoreci_ter
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreci_ter alter column rec_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : holoreci_ter
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreci_ter alter column rec_regrfc set not null;
-- dmap_object_gen_tag : type : alter table name : holoreci_ter
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreci_ter alter column rec_cvefac set not null;
-- dmap_object_gen_tag : type : alter table name : holoreci_ter
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreci_ter alter column rec_keyapr set not null;
-- dmap_object_gen_tag : type : alter table name : holoreci_ter
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreci_ter alter column rec_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : holoreci_ter
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreci_ter alter column rec_numemi set not null;
-- dmap_object_gen_tag : type : alter table name : holoreci_ter
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreci_ter alter column rec_stsrec set not null;
-- dmap_object_gen_tag : type : alter table name : holoreci_ter
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreci_ter alter column rec_keyusg set not null;
-- dmap_object_gen_tag : type : alter table name : holoreci_ter
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreci_ter alter column rec_fecact set not null;
