-- dmap_object_gen_tag : type : table name : inlodwor
set search_path = labconf,oracle,dmap_extension,public;
create table "inlodwor"  (
dwo_keywor varchar(4),
dwo_numsec numeric(5),
dwo_tipdat varchar(1),
dwo_funcio varchar(2),
dwo_format varchar(30),
dwo_valorw varchar(60),
dwo_numsql numeric(5),
dwo_seccmp numeric(5)
) ;
