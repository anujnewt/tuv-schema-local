-- dmap_object_gen_tag : type : table name : reci_erp
set search_path = usrsiho,oracle,dmap_extension,public;
create table "reci_erp"  (
rec_cvepol varchar(50) not null,
rec_fecpag timestamp(0) not null,
rec_numerr numeric(5),
rec_stsrec varchar(1),
rec_status varchar(1),
rec_tipcam decimal(16, 6),
rec_fecgen timestamp(0),
rec_forpag numeric(10),
rec_fpafin numeric(10),
rec_tcafin decimal(16, 6),
rec_tippag varchar(15),
rec_refere varchar(20),
rec_fecrec timestamp(0),
rec_cveban varchar(7),
rec_ctaban varchar(30)
) ;
-- dmap_object_gen_tag : type : alter table name : reci_erp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table reci_erp alter column rec_cvepol set not null;
-- dmap_object_gen_tag : type : alter table name : reci_erp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table reci_erp alter column rec_fecpag set not null;
