-- dmap_object_gen_tag : type : table name : eolomvpz
set search_path = labprod,oracle,dmap_extension,public;
create table "eolomvpz"  (
mpz_keyplz numeric(10) not null,
mpz_keysol numeric(10) not null,
mpz_keyest varchar(3),
mpz_keydep varchar(16),
mpz_keypue varchar(16),
mpz_tipmov varchar(2),
mpz_desmov varchar(60),
mpz_fecmov timestamp(0),
mpz_ca1aux varchar(10),
mpz_ca2aux varchar(10),
mpz_ca3aux varchar(10),
mpz_ca4aux varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eolomvpz
set search_path = labprod,oracle,dmap_extension,public;
alter table eolomvpz alter column mpz_keyplz set not null;
-- dmap_object_gen_tag : type : alter table name : eolomvpz
set search_path = labprod,oracle,dmap_extension,public;
alter table eolomvpz alter column mpz_keysol set not null;
