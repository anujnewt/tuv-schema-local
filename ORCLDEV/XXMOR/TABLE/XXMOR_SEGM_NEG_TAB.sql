-- dmap_object_gen_tag : type : table name : xxmor_segm_neg_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_segm_neg_tab"  (
id_seg_neg numeric not null,
nombre_sn varchar(30) not null,
url_concom varchar(250)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_segm_neg_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_segm_neg_tab add constraint xxmor_segm_neg_tab_pk primary key (id_seg_neg);
-- dmap_object_gen_tag : type : alter table name : xxmor_segm_neg_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_segm_neg_tab alter column id_seg_neg set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_segm_neg_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_segm_neg_tab alter column nombre_sn set not null;
