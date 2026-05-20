-- dmap_object_gen_tag : type : table name : xxmor_sol_factur_mails_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_sol_factur_mails_tab"  (
id_solicitud numeric not null,
linea numeric not null,
mails_factur varchar(250)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_sol_factur_mails_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_sol_factur_mails_tab add constraint xxmor_sol_factur_mails_tab_pk primary key (id_solicitud,linea);
-- dmap_object_gen_tag : type : alter table name : xxmor_sol_factur_mails_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_sol_factur_mails_tab alter column id_solicitud set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_sol_factur_mails_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_sol_factur_mails_tab alter column linea set not null;
