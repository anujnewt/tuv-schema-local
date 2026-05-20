-- dmap_object_gen_tag : type : table name : nmcorvac
set search_path = labconf,oracle,dmap_extension,public;
create table "nmcorvac"  (
rva_keyemp numeric(38) not null,
rva_antigu numeric(38) not null,
rva_consec numeric(38) not null,
rva_fecsol timestamp(0),
rva_period varchar(10),
rva_fecini timestamp(0),
rva_fecfin timestamp(0),
rva_diadis decimal(6, 2),
rva_autori varchar(20),
rva_motivo varchar(18),
rva_keydep varchar(18),
rva_keycen varchar(18),
rva_numfol varchar(12),
rva_numusu numeric(38),
rva_feccap timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : nmcorvac
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcorvac add primary key (rva_keyemp,rva_antigu,rva_consec);
-- dmap_object_gen_tag : type : alter table name : nmcorvac
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcorvac alter column rva_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmcorvac
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcorvac alter column rva_antigu set not null;
