-- dmap_object_gen_tag : type : table name : nmlocalc
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmlocalc"  (
cal_keyprg varchar(15),
cal_status varchar(1),
cal_fecmov timestamp(0),
cal_keypro numeric(5),
cal_keynom numeric(5),
cal_basdat varchar(10)
) ;
