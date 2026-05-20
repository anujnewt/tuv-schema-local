-- dmap_object_gen_tag : type : table name : xxmor_sol_est_rep_bak_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_sol_est_rep_bak_tab"  (
id_solicitud numeric not null,
linea numeric not null,
id_sist numeric(3) not null,
estat_rep char(2),
estat_id_foraneo varchar(25),
estat_reintento numeric(2),
created_date timestamp(0),
updated_date timestamp(0),
rotid varchar(20),
aux1 varchar(15),
aux2 varchar(15),
aux3 varchar(15),
estat_error_msg varchar(500)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_sol_est_rep_bak_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_sol_est_rep_bak_tab alter column id_solicitud set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_sol_est_rep_bak_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_sol_est_rep_bak_tab alter column linea set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_sol_est_rep_bak_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_sol_est_rep_bak_tab alter column id_sist set not null;
