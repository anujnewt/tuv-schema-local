-- dmap_object_gen_tag : type : table name : nmcapims
set search_path = labprod,oracle,dmap_extension,public;
create table "nmcapims"  (
pim_numche varchar(20),
pim_fecche timestamp(0),
pim_keyban varchar(3),
pim_fecdep timestamp(0),
pim_ramche varchar(16),
pim_regims varchar(12),
pim_numinc varchar(14),
pim_recurp varchar(18),
pim_tipinc varchar(2),
pim_diasre numeric(38),
pim_imprec decimal(18, 6),
pim_numpol varchar(10),
pim_observ varchar(50),
pim_impinc decimal(18, 6),
pim_numpag numeric(38),
pim_diaant numeric(38),
pim_impant decimal(18, 6),
pim_difere decimal(18, 6),
pim_ca1aux varchar(20),
pim_ca2aux varchar(20),
pim_ca3aux varchar(20),
pim_ca4aux varchar(20),
pim_ca5aux varchar(20)
) ;
