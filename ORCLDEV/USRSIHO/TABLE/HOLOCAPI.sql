-- dmap_object_gen_tag : type : table name : holocapi
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holocapi"  (
cap_keydep varchar(16) not null,
cap_keycap numeric(10) not null,
cap_descap varchar(60),
cap_nu1aux varchar(10),
cap_nu2aux varchar(10),
cap_ca1aux varchar(10),
cap_ca2aux varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : holocapi
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocapi add constraint pk_hcapi primary key (cap_keydep,cap_keycap);
-- dmap_object_gen_tag : type : alter table name : holocapi
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocapi alter column cap_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : holocapi
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocapi alter column cap_keycap set not null;
