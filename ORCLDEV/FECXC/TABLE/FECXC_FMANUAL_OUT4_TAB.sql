-- dmap_object_gen_tag : type : table name : fecxc_fmanual_out4_tab
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_fmanual_out4_tab"  (
cod_sec_clasifica numeric not null,
id_orden numeric,
num_folio_real numeric,
num_ecodigo numeric,
fec_f_ingreso timestamp(0),
num_folio_manual numeric,
num_monto_folio numeric,
num_otros numeric,
num_iva numeric,
nom_cliente varchar(150),
num_imp_folio_real numeric,
des_segmento varchar(150),
attribute1 varchar(250),
attribute2 varchar(250),
attribute3 varchar(250),
attribute4 varchar(250),
attribute5 varchar(250),
attribute6 varchar(250),
attribute7 varchar(250),
attribute8 varchar(250),
attribute9 varchar(250),
attribute10 varchar(250),
attribute11 varchar(250),
attribute12 varchar(250),
attribute13 varchar(250),
attribute14 varchar(250),
attribute15 varchar(250),
fec_creation_date timestamp(0),
last_login numeric,
num_created_by numeric(15),
num_last_updated_by numeric(15),
fec_last_update_date timestamp(0),
num_last_update_login numeric(15)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_fmanual_out4_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_fmanual_out4_tab alter column cod_sec_clasifica set not null;
