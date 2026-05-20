-- dmap_object_gen_tag : type : table name : fecxc_resta_segmentos
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_resta_segmentos"  (
cod_sec_tipcat numeric(38),
cod_sec_lin numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_resta_segmentos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_resta_segmentos add constraint fk_fecxc_re_segmentos_fecxc_de foreign key (cod_sec_tipcat,cod_sec_lin) references fecxc_det_catalogos(cod_sec_tipcat,cod_sec_lin) on delete no action not deferrable initially immediate;
