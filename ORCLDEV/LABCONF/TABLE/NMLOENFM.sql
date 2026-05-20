-- dmap_object_gen_tag : type : table name : nmloenfm
set search_path = labconf,oracle,dmap_extension,public;
create table "nmloenfm"  (
enf_keyfor varchar(9) not null,
enf_de1for varchar(40),
enf_de2for varchar(40),
enf_de3for varchar(40),
enf_idever varchar(15)
) ;
-- dmap_object_gen_tag : type : alter table name : nmloenfm
set search_path = labconf,oracle,dmap_extension,public;
alter table nmloenfm alter column enf_keyfor set not null;
