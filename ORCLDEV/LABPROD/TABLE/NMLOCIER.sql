-- dmap_object_gen_tag : type : table name : nmlocier
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlocier"  (
cie_keycie varchar(10),
cie_descie varchar(60),
cie_keynom numeric(38),
cie_mesini numeric(38),
cie_mesfin numeric(38),
cie_codame varchar(1),
cie_codaa2 varchar(1),
cie_codaa3 varchar(1),
cie_codaa4 varchar(1),
cie_perini varchar(7),
cie_perfin varchar(7),
cie_semini varchar(7),
cie_semfin varchar(7),
cie_datfij varchar(1),
cie_fecbaj timestamp(0),
cie_fecinc timestamp(0),
cie_fectra timestamp(0),
cie_ranpro varchar(200),
cie_ranims varchar(200)
) ;
