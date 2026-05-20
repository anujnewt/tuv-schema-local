-- dmap_object_gen_tag : type : table name : nmloperi02
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmloperi02"  (
per_keypro numeric(5) not null,
per_keynom numeric(5),
per_keyper varchar(7) not null,
per_fecini timestamp(0),
per_fecfin timestamp(0),
per_fecpag timestamp(0),
per_feccor timestamp(0),
per_nummes numeric(5),
per_acudos numeric(5),
per_acutre numeric(5),
per_acucua numeric(5),
per_nu1aux varchar(10),
per_nu2aux varchar(10),
per_nu3aux varchar(10),
per_nu4aux varchar(10),
per_nu5aux varchar(10),
per_keypol varchar(10),
per_impnom decimal(18, 2),
per_totemp numeric(10),
per_fecact timestamp(0),
per_horact varchar(6),
per_persel varchar(1),
per_fecpol timestamp(0),
per_despol varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : nmloperi02
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmloperi02 add constraint u119_75 primary key (per_keypro,per_keyper);
