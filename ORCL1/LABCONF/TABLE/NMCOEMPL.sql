-- dmap_object_gen_tag : type : table name : nmcoempl
set search_path = labconf,oracle,dmap_extension,public;
create table "nmcoempl"  (
emp_keyemp numeric(10) not null,
emp_keydep varchar(16),
emp_keypue varchar(16),
emp_keycen varchar(16),
emp_keycat varchar(16),
emp_nomemp varchar(60) not null,
emp_nomcor varchar(20),
emp_domemp varchar(100),
emp_colemp varchar(100),
emp_cidemp varchar(20),
emp_pobemp varchar(20),
emp_munemp varchar(6),
emp_entemp varchar(2),
emp_codemp varchar(5),
emp_telemp varchar(60),
emp_regrfc varchar(13),
emp_recurp varchar(18),
emp_regims varchar(12),
emp_reginf varchar(12),
emp_cvesex varchar(1),
emp_keyims varchar(5),
emp_cvezon numeric(5),
emp_keypro numeric(5) not null,
emp_cvetur numeric(5),
emp_tipemp varchar(6),
emp_tipsal varchar(1),
emp_status numeric(5) not null,
emp_salhor decimal(12, 6),
emp_saldia decimal(12, 6),
emp_salmes decimal(12, 2),
emp_salint decimal(12, 6),
emp_salivc decimal(12, 6),
emp_salinf decimal(12, 6),
emp_intsin decimal(12, 6),
emp_infsin decimal(12, 6),
emp_varims decimal(12, 6),
emp_varinf decimal(12, 6),
emp_anthor decimal(12, 6),
emp_antdia decimal(12, 6),
emp_antmes decimal(12, 2),
emp_antint decimal(12, 6),
emp_antivc decimal(12, 6),
emp_antinf decimal(12, 6),
emp_antits decimal(12, 6),
emp_antifs decimal(12, 6),
emp_refcon varchar(20),
emp_cveban varchar(7),
emp_ctaban varchar(18),
emp_forpag varchar(2),
emp_diades numeric(5),
emp_numliq varchar(6),
emp_keyloc varchar(16),
emp_fecing timestamp(0),
emp_fecrei timestamp(0),
emp_fecven timestamp(0),
emp_fecpla timestamp(0),
emp_fecaum timestamp(0),
emp_peraum varchar(7),
emp_fecbaj timestamp(0),
emp_cvebaj varchar(4),
emp_jorlab varchar(1),
emp_unijor decimal(4, 2),
emp_pering varchar(7),
emp_perbaj varchar(7),
emp_perdep varchar(7),
emp_perpue varchar(7),
emp_percat varchar(7),
emp_perpro varchar(7),
emp_fecaux timestamp(0),
emp_ca1aux varchar(10),
emp_ca2aux varchar(10),
emp_ca3aux varchar(10),
emp_ca4aux varchar(10),
emp_pctbec decimal(5, 2),
emp_fecmod timestamp(0),
emp_hormod varchar(8),
emp_fecalt timestamp(0),
emp_bajfec timestamp(0),
emp_fecsal timestamp(0),
emp_perpag varchar(7),
emp_inifec timestamp(0),
emp_finfec timestamp(0),
emp_cobert varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : nmcoempl
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcoempl add constraint nmempl01 unique (emp_keyemp);
-- dmap_object_gen_tag : type : alter table name : nmcoempl
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcoempl alter column emp_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmcoempl
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcoempl alter column emp_nomemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmcoempl
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcoempl alter column emp_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : nmcoempl
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcoempl alter column emp_status set not null;
