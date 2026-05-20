-- dmap_object_gen_tag : type : table name : nmlobebe
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmlobebe"  (
beb_keyemp numeric(10),
beb_keyben numeric(5),
beb_comfam numeric(5),
beb_tipben varchar(2),
beb_fecven timestamp(0),
beb_porpar decimal(7, 4),
beb_forpag varchar(2),
beb_keycon varchar(3),
beb_perini varchar(7),
beb_perfin varchar(7),
beb_status varchar(1),
beb_impfij decimal(12, 2),
beb_fecini timestamp(0)
) ;
