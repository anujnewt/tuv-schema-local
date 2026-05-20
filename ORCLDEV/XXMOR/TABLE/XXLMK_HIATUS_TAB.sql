-- dmap_object_gen_tag : type : table name : xxlmk_hiatus_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_hiatus_tab"  (
id_ordhdr numeric not null,
fec_inicio varchar(8),
fec_fin varchar(8),
des_hora_ini varchar(4),
des_hora_fin varchar(4),
ind_lun varchar(5),
ind_mar varchar(5),
ind_mie varchar(5),
ind_jue varchar(5),
ind_vie varchar(5),
ind_sab varchar(5),
ind_dom varchar(5),
ind_2can varchar(5),
ind_5can varchar(5),
ind_9can varchar(5),
num_hiatus numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_hiatus_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_hiatus_tab alter column id_ordhdr set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_hiatus_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_hiatus_tab add constraint xxlmk_hiatus_tab_fk1 foreign key (id_ordhdr) references xxlmk_ordhdr_tab(id_ordhdr) on delete no action not deferrable initially immediate;
