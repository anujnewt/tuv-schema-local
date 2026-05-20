-- dmap_object_gen_tag : type : table name : xxlmk_cred_corp_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_cred_corp_tab"  (
id_sol_cc numeric not null,
id_aut numeric not null,
ind_rechazo_gestor numeric,
id_motivo_ar numeric,
des_coment_ar_cc varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_cred_corp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_cred_corp_tab add constraint xxlmk_cred_corp_tab_pk primary key (id_sol_cc);
-- dmap_object_gen_tag : type : alter table name : xxlmk_cred_corp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_cred_corp_tab alter column id_sol_cc set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_cred_corp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_cred_corp_tab alter column id_aut set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_cred_corp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_cred_corp_tab add constraint xxlmk_cred_corp_tab_fk1 foreign key (id_aut) references xxlmk_autorizaciones_tab(id_aut) on delete no action not deferrable initially immediate;
