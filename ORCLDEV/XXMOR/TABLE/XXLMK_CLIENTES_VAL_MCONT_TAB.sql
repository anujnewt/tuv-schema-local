-- dmap_object_gen_tag : type : table name : xxlmk_clientes_val_mcont_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_clientes_val_mcont_tab"  (
id_cliente numeric(38) not null,
nom_cliente varchar(20),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_product numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_clientes_val_mcont_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_clientes_val_mcont_tab add primary key (id_cliente);
-- dmap_object_gen_tag : type : alter table name : xxlmk_clientes_val_mcont_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_clientes_val_mcont_tab alter column id_cliente set not null;
