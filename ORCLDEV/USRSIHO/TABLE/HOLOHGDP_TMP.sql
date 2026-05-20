-- dmap_object_gen_tag : type : table name : holohgdp_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holohgdp_tmp"  (
hgd_keysec numeric(10) not null,
hgd_keydep varchar(16),
hgd_keyrph numeric(10),
hgd_fechag timestamp(0),
hgd_keyemp numeric(10),
hgd_regrfc varchar(13),
hgd_recurp varchar(18),
hgd_keypue varchar(16),
hgd_capini numeric(10),
hgd_capfin numeric(10),
hgd_numcap numeric(10),
hgd_keycon varchar(3),
hgd_marcon varchar(1),
hgd_marcos varchar(1),
hgd_costog numeric,
hgd_keysue varchar(4),
hgd_keytco numeric(3),
hgd_keyfol numeric(6),
hgd_keyusu numeric(10),
hgd_minleg numeric(6),
hgd_minsal numeric(6),
hgd_minext numeric(6),
hgd_mincom numeric(6)
) ;
-- dmap_object_gen_tag : type : alter table name : holohgdp_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holohgdp_tmp add constraint pk_holohgdp_tmp primary key (hgd_keysec);
