-- dmap_object_gen_tag : type : table name : empagdxm
set search_path = usrsiho,oracle,dmap_extension,public;
create table "empagdxm"  (
pag_keypag numeric(10) not null,
pag_keydet numeric(10) not null,
pag_keyemp numeric(10) not null,
pag_hrlleg varchar(5) not null,
pag_hrsali varchar(5) not null,
pag_tabula numeric not null,
pag_viatic numeric,
pag_nohras numeric,
pag_exhras numeric,
pag_imphre numeric,
pag_totale numeric not null,
pag_keypue varchar(16) not null
) ;
-- dmap_object_gen_tag : type : alter table name : empagdxm
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empagdxm alter column pag_keypag set not null;
-- dmap_object_gen_tag : type : alter table name : empagdxm
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empagdxm alter column pag_keydet set not null;
-- dmap_object_gen_tag : type : alter table name : empagdxm
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empagdxm alter column pag_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : empagdxm
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empagdxm alter column pag_hrlleg set not null;
-- dmap_object_gen_tag : type : alter table name : empagdxm
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empagdxm alter column pag_hrsali set not null;
-- dmap_object_gen_tag : type : alter table name : empagdxm
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empagdxm alter column pag_tabula set not null;
-- dmap_object_gen_tag : type : alter table name : empagdxm
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empagdxm alter column pag_totale set not null;
-- dmap_object_gen_tag : type : alter table name : empagdxm
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empagdxm alter column pag_keypue set not null;
