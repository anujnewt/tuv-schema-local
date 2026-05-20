-- dmap_object_gen_tag : type : table name : bmb2_personalresultados
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb2_personalresultados"  (
idpersonal numeric(38) not null,
idpruebaabc numeric(38) not null,
idxresultados numeric(38) not null,
valor numeric
) ;
-- dmap_object_gen_tag : type : alter table name : bmb2_personalresultados
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb2_personalresultados alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : bmb2_personalresultados
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb2_personalresultados alter column idpruebaabc set not null;
-- dmap_object_gen_tag : type : alter table name : bmb2_personalresultados
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb2_personalresultados alter column idxresultados set not null;
