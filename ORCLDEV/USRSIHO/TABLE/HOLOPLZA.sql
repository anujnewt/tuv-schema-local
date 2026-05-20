-- dmap_object_gen_tag : type : table name : holoplza
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holoplza"  (
plz_ctvplz numeric(10) not null,
plz_keyfol numeric(10),
plz_keytco numeric(10),
plz_keydep varchar(16),
plz_keypue varchar(16),
plz_keyemp numeric(10),
plz_numcap numeric(5),
plz_keytab varchar(10),
plz_cosuni decimal(13, 2) not null,
plz_keytva numeric(5) not null,
plz_status numeric(10),
plz_fecini timestamp(0),
plz_fecalt timestamp(0),
plz_keyusg numeric(5),
plz_hrsmod varchar(5),
plz_capini numeric(10),
plz_capfin numeric(10),
plz_emptemp numeric(10),
plz_mtomax decimal(13, 2),
plz_mtoeje decimal(13, 2),
plz_periodo varchar(10),
plz_primaria varchar(2),
plz_fecven timestamp(0),
plz_excep varchar(2),
plz_asig numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : holoplza
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoplza alter column plz_ctvplz set not null;
-- dmap_object_gen_tag : type : alter table name : holoplza
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoplza alter column plz_cosuni set not null;
-- dmap_object_gen_tag : type : alter table name : holoplza
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoplza alter column plz_keytva set not null;
