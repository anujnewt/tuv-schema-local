-- dmap_object_gen_tag : type : table name : molocale
set search_path = labconf,oracle,dmap_extension,public;
create table "molocale"  (
cal_dborig numeric(5),
cal_dboper numeric(5),
cal_keycal numeric(5),
cal_anomes varchar(6),
cal_ultact timestamp(0),
cal_nivel varchar(2),
cal_valor varchar(16),
cal_cvetur numeric(5),
cal_tabcam varchar(20),
cal_diades varchar(7)
) ;
