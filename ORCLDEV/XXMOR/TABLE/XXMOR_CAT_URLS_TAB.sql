-- dmap_object_gen_tag : type : table name : xxmor_cat_urls_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_cat_urls_tab"  (
id_seg_neg numeric not null,
id_url numeric not null,
url varchar(250) not null,
desc_url varchar(260),
orden_url numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_urls_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_urls_tab add constraint xxmor_cat_urls_tab_pk primary key (id_seg_neg,id_url);
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_urls_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_urls_tab alter column id_seg_neg set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_urls_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_urls_tab alter column id_url set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_urls_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_urls_tab alter column url set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_urls_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_urls_tab add constraint fk_cat_urls_segm_neg foreign key (id_seg_neg) references xxmor_segm_neg_tab(id_seg_neg) on delete no action not deferrable initially immediate;
