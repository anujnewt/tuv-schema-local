-- dmap_object_gen_tag : type : table name : holocont
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holocont"  (
con_keyplz numeric(10) not null,
con_keyfol numeric(10),
con_keytco numeric(10),
con_keydep varchar(16),
con_keypue varchar(16),
con_ctvplz numeric(10) not null,
con_keyemp numeric(10),
con_regrfc varchar(13),
con_preano numeric(5),
con_numcap numeric(5),
con_fecoto timestamp(0),
con_fecini timestamp(0) not null,
con_fecven timestamp(0),
con_keytab varchar(6),
con_pertra varchar(6),
con_idioma varchar(6),
con_keynac varchar(6),
con_cosuni decimal(13, 2) not null,
con_despev varchar(80),
con_keytva numeric(5) not null,
con_keytic varchar(6),
con_diapag varchar(60),
con_tmpsal varchar(80),
con_araesp varchar(60),
con_stsfir varchar(1) not null,
con_stsplz varchar(1),
con_stspag varchar(1) not null,
con_fecfir timestamp(0),
con_feccan timestamp(0),
con_numcdi numeric(5),
con_recfis varchar(1),
con_descap varchar(80),
con_keyusg numeric(5),
con_contra varchar(20),
con_hrsjor varchar(5),
con_cccont varchar(16),
con_tippag numeric(10),
con_anopre numeric(10),
con_descan varchar(20),
con_observ varchar(80)
) ;
-- dmap_object_gen_tag : type : alter table name : holocont
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocont alter column con_keyplz set not null;
-- dmap_object_gen_tag : type : alter table name : holocont
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocont alter column con_ctvplz set not null;
-- dmap_object_gen_tag : type : alter table name : holocont
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocont alter column con_fecini set not null;
-- dmap_object_gen_tag : type : alter table name : holocont
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocont alter column con_cosuni set not null;
-- dmap_object_gen_tag : type : alter table name : holocont
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocont alter column con_keytva set not null;
-- dmap_object_gen_tag : type : alter table name : holocont
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocont alter column con_stsfir set not null;
-- dmap_object_gen_tag : type : alter table name : holocont
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocont alter column con_stspag set not null;
