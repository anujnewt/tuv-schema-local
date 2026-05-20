-- dmap_object_gen_tag : type : table name : grcaerror
set search_path = usrsiho,oracle,dmap_extension,public;
create table "grcaerror"  (
err_keytvb numeric(10) not null,
err_keytdb numeric(10),
err_desusu varchar(200),
err_destec varchar(200) not null
) ;
-- dmap_object_gen_tag : type : alter table name : grcaerror
set search_path = usrsiho,oracle,dmap_extension,public;
alter table grcaerror alter column err_keytvb set not null;
-- dmap_object_gen_tag : type : alter table name : grcaerror
set search_path = usrsiho,oracle,dmap_extension,public;
alter table grcaerror alter column err_destec set not null;
