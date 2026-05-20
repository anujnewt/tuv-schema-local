-- dmap_object_gen_tag : type : table name : com_orac_sips_tray
set search_path = labconf,oracle,dmap_extension,public;
create table "com_orac_sips_tray"  (
ora_noctvo numeric(38) not null,
tra_keyemp numeric(38),
tra_fecmov timestamp(0),
tra_tipmov varchar(2),
tra_keydep varchar(16),
tra_keypue varchar(16),
tra_keycat varchar(16),
tra_keycen varchar(16),
tra_saldia decimal(12, 6),
tra_salmes decimal(12, 2),
tra_salint decimal(12, 6),
tra_salivc decimal(12, 6),
tra_salinf decimal(12, 6),
tra_intsin decimal(12, 6),
tra_infsin decimal(12, 6),
tra_keyims varchar(5),
tra_keyper varchar(7),
tra_codloc varchar(16),
tra_keypla numeric(38),
tra_keypro numeric(38),
tra_jorlab varchar(1),
tra_unijor decimal(4, 2),
tra_submov varchar(6),
tra_ca1aux varchar(10),
tra_ca2aux varchar(10),
tra_fecmod timestamp(0),
tra_hormod varchar(8),
ora_status varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : com_orac_sips_tray
set search_path = labconf,oracle,dmap_extension,public;
alter table com_orac_sips_tray alter column ora_noctvo set not null;
