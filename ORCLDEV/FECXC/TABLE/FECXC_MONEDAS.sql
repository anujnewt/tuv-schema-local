-- dmap_object_gen_tag : type : table name : fecxc_monedas
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_monedas"  (
secmoneda numeric(38) not null,
codmoneda varchar(3),
desmoneda varchar(40),
es_moneda_loccal numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_monedas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_monedas add constraint pk_fecxc_monedas primary key (secmoneda);
-- dmap_object_gen_tag : type : alter table name : fecxc_monedas
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_monedas alter column secmoneda set not null;
