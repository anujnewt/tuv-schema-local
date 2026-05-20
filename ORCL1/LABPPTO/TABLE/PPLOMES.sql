-- dmap_object_gen_tag : type : table name : pplomes
set search_path = labppto,oracle,dmap_extension,public;
create table "pplomes"  (
mes_keymes numeric(38) not null,
mes_nommes varchar(10),
mes_diames numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pplomes
set search_path = labppto,oracle,dmap_extension,public;
alter table pplomes alter column mes_keymes set not null;
-- dmap_object_gen_tag : type : alter table name : pplomes
set search_path = labppto,oracle,dmap_extension,public;
alter table pplomes alter column mes_diames set not null;
