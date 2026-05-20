-- dmap_object_gen_tag : type : table name : congelada_rh2000
set search_path = labconf,oracle,dmap_extension,public;
create table "congelada_rh2000"  (
mes_keyano char(4),
mes_keymes char(4) not null,
mes_keycia char(4) not null,
mes_keyper char(7) not null,
mes_keypro numeric(38) not null,
mes_keyemp numeric(38) not null,
mes_keypue char(16),
mes_status numeric(38),
mes_fecing timestamp(0),
mes_fecrei timestamp(0),
mes_fecbaj timestamp(0),
mes_fecaum timestamp(0),
mes_keyloc char(16),
mes_forpag char(2),
mes_numpza numeric(38),
mes_cveaum numeric(38),
mes_keydep char(16),
mes_keycen char(16),
mes_deprep numeric(38),
mes_ccdsup numeric(38),
mes_keyjfe numeric(38),
mes_keypuj char(16),
mes_salmes decimal(12, 2),
mes_salhor decimal(12, 6),
mes_saldia decimal(12, 6),
mes_salint decimal(12, 6),
mes_salivc decimal(12, 6),
mes_salinf decimal(12, 6),
mes_intsin decimal(12, 6),
mes_infsin decimal(12, 6),
mes_varims decimal(12, 6),
mes_varinf decimal(12, 6),
mes_keyvic numeric(38),
mes_keyest char(3),
mes_paddep char(16),
mes_hijdep char(16),
mes_codniv char(80),
mes_pesesp numeric(38),
mes_numniv numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : congelada_rh2000
set search_path = labconf,oracle,dmap_extension,public;
alter table congelada_rh2000 alter column mes_keymes set not null;
-- dmap_object_gen_tag : type : alter table name : congelada_rh2000
set search_path = labconf,oracle,dmap_extension,public;
alter table congelada_rh2000 alter column mes_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : congelada_rh2000
set search_path = labconf,oracle,dmap_extension,public;
alter table congelada_rh2000 alter column mes_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : congelada_rh2000
set search_path = labconf,oracle,dmap_extension,public;
alter table congelada_rh2000 alter column mes_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : congelada_rh2000
set search_path = labconf,oracle,dmap_extension,public;
alter table congelada_rh2000 alter column mes_keyemp set not null;
