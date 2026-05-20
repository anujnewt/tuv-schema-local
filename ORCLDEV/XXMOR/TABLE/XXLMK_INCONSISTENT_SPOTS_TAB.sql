-- dmap_object_gen_tag : type : table name : xxlmk_inconsistent_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_inconsistent_spots_tab"  (
id_inconsistent_spot numeric(38) not null,
id_ordhdr numeric(38),
num_spot numeric(38),
ind_canceled numeric(1)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_inconsistent_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_inconsistent_spots_tab alter column id_inconsistent_spot set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_inconsistent_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_inconsistent_spots_tab add constraint xxlmk_inconsistent_spots_tab_xxlmk_ordhdr_tab_fk foreign key (id_ordhdr) references xxlmk_ordhdr_tab(id_ordhdr) on delete no action not deferrable initially immediate;
