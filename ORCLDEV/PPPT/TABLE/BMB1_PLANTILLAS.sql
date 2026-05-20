-- dmap_object_gen_tag : type : table name : bmb1_plantillas
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb1_plantillas"  (
idresultados numeric(38) not null,
idparte numeric(38) not null,
idpregunta numeric(38) not null,
correcta1 numeric(38),
correcta2 numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb1_plantillas
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_plantillas alter column idresultados set not null;
-- dmap_object_gen_tag : type : alter table name : bmb1_plantillas
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_plantillas alter column idparte set not null;
-- dmap_object_gen_tag : type : alter table name : bmb1_plantillas
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_plantillas alter column idpregunta set not null;
