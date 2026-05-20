-- dmap_object_gen_tag : type : table name : pplocale
set search_path = labppto,oracle,dmap_extension,public;
create table "pplocale"  (
cal_keymes numeric(38) not null,
cal_nommes varchar(10),
cal_diames numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pplocale
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocale alter column cal_keymes set not null;
-- dmap_object_gen_tag : type : alter table name : pplocale
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocale alter column cal_diames set not null;
