-- dmap_object_gen_tag : type : table name : fecxc_segmultimon
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_segmultimon"  (
sec_seg numeric(38) not null,
cod_sec_tipcat numeric(38),
cod_sec_lin numeric(38),
secmoneda numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_segmultimon
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_segmultimon add unique (cod_sec_lin);
-- dmap_object_gen_tag : type : alter table name : fecxc_segmultimon
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_segmultimon add constraint pk_fecxc_segmultimon primary key (sec_seg);
-- dmap_object_gen_tag : type : alter table name : fecxc_segmultimon
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_segmultimon alter column sec_seg set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_segmultimon
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_segmultimon add constraint fk_fecxc_se_segespeci_fecxc_de foreign key (cod_sec_tipcat,cod_sec_lin) references fecxc_det_catalogos(cod_sec_tipcat,cod_sec_lin) on delete no action not deferrable initially immediate;
