-- dmap_object_gen_tag : type : table name : xxlmk_fac_cual_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_fac_cual_tab"  (
id_ordhdr numeric not null,
fec_inicio varchar(8),
fec_fin varchar(8),
pos1_2_ult numeric,
pos_3_pen numeric,
pos_ante numeric,
num_fac_cual numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_fac_cual_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_fac_cual_tab alter column id_ordhdr set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_fac_cual_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_fac_cual_tab add constraint xxlmk_fac_cual_tab_fk1 foreign key (id_ordhdr) references xxlmk_ordhdr_tab(id_ordhdr) on delete no action not deferrable initially immediate;
