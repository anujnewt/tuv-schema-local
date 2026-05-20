-- dmap_object_gen_tag : type : table name : bmb1_personalresultados
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb1_personalresultados"  (
idpersonal numeric(38) not null,
semejanzas numeric(38),
vocabulario numeric(38),
aritmetica numeric(38),
a numeric(38),
i numeric(38),
m numeric(38),
q1 numeric(38),
responsabilidad numeric(38),
ventas numeric(38),
totala numeric(38),
totalb numeric(38),
total numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb1_personalresultados
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_personalresultados alter column idpersonal set not null;
