-- dmap_object_gen_tag : type : index name : xxmor_archivos_ftp_n1
set search_path = xxmor,oracle,dmap_extension,public;
create index xxmor_archivos_ftp_n1 on xxmor_archivos_ftp_tab (nom_archivo);
