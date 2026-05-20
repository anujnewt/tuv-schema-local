-- dmap_object_gen_tag : type : table name : xxlmk_errs_book_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_errs_book_spots_tab"  (
id_error numeric(38) not null,
id_spot numeric(38),
num_msg numeric(38),
des_msg varchar(4000),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_book_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_book_spots_tab add primary key (id_error);
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_book_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_book_spots_tab alter column id_error set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_book_spots_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_book_spots_tab add constraint xxlmkerrsbookspotstab_fk_01 foreign key (id_spot) references xxlmk_lineas_spots_tab(id_spot) on delete no action not deferrable initially immediate;
