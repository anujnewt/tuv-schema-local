-- dmap_object_gen_tag : type : table name : xxlmk_spot_length_factor_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_spot_length_factor_tab"  (
num_spot_length numeric(38) not null,
num_price_factor numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion numeric(38),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_spot_length_factor_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_spot_length_factor_tab add primary key (num_spot_length);
