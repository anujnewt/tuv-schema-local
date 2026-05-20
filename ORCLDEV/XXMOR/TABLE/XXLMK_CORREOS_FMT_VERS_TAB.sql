-- dmap_object_gen_tag : type : table name : xxlmk_correos_fmt_vers_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_correos_fmt_vers_tab"  (
id_correo numeric(38) not null,
des_correo varchar(100),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_correos_fmt_vers_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_correos_fmt_vers_tab add primary key (id_correo);
-- dmap_object_gen_tag : type : alter table name : xxlmk_correos_fmt_vers_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_correos_fmt_vers_tab alter column id_correo set not null;
