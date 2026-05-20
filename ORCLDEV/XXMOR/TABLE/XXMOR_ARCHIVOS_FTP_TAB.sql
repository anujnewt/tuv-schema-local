-- dmap_object_gen_tag : type : table name : xxmor_archivos_ftp_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_archivos_ftp_tab"  (
nom_archivo varchar(240) not null,
estatus varchar(5) not null,
desc_error varchar(4000),
id_archivo numeric(15),
created_date timestamp(0) not null default statement_timestamp(),
created_by varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_archivos_ftp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_archivos_ftp_tab alter column nom_archivo set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_archivos_ftp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_archivos_ftp_tab alter column estatus set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_archivos_ftp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_archivos_ftp_tab alter column created_date set not null;
