-- dmap_object_gen_tag : type : table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
create table "pploparp"  (
par_keycia varchar(4) not null,
par_keyver numeric(38) not null,
par_keypro numeric(38) not null,
par_diaagu numeric(38) not null,
par_diarut numeric(38) not null,
par_facivc decimal(9, 7) not null,
par_facrtg decimal(9, 7) not null,
par_faceme decimal(9, 7) not null,
par_facem decimal(9, 7) not null,
par_faccv decimal(9, 7) not null,
par_facsar decimal(9, 7) not null,
par_facinf decimal(9, 7) not null,
par_pmavac decimal(6, 3) not null,
par_valfin decimal(10, 3) not null,
par_destra1 numeric(38) not null,
par_destra2 numeric(38) not null,
par_tipproc numeric(38),
par_destra3 numeric(38) not null,
par_destra4 numeric(38) not null,
par_destra5 numeric(38) not null,
par_destra6 numeric(38) not null,
par_destra7 numeric(38) not null,
par_destra8 numeric(38) not null,
par_destra9 numeric(38) not null,
par_destra10 numeric(38) not null,
par_destra11 numeric(38) not null,
par_destra12 numeric(38) not null,
par_impest decimal(8, 6) not null,
par_facpip decimal(8, 2) not null,
par_ptjpat decimal(8, 6) not null,
par_ptjpip decimal(8, 6) not null,
par_ptjqui decimal(8, 6) not null,
par_ptjdec decimal(8, 6) not null,
par_mttfza decimal(9, 2) not null,
par_mttfzb decimal(9, 2) not null,
par_mttfzc decimal(9, 2) not null,
par_ptjval decimal(4, 2) not null,
par_mttvza decimal(9, 2) not null,
par_mttvzb decimal(9, 2) not null,
par_mttvzc decimal(9, 2) not null,
par_semes1 numeric(38) not null,
par_semes2 numeric(38) not null,
par_ptjvas numeric(16),
par_diaags numeric(38),
par_diarus numeric(38),
par_tsfims decimal(9, 2),
par_salmdf decimal(9, 2),
par_fomefi decimal(5, 2),
par_ptumay numeric(38) not null,
par_ptunov numeric(38) not null,
par_pipcon decimal(8, 4),
par_pipsin decimal(8, 4),
par_fomcon decimal(6, 4),
par_fomsin decimal(6, 4),
par_pmacon decimal(6, 3),
par_pmasin decimal(6, 3),
par_vafcon decimal(10, 3),
par_vafsin decimal(10, 3)
) ;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_keyver set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_diaagu set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_diarut set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_facivc set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_facrtg set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_faceme set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_facem set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_faccv set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_facsar set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_facinf set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_pmavac set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_valfin set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_destra1 set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_destra2 set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_destra3 set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_destra4 set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_destra5 set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_destra6 set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_destra7 set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_destra8 set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_destra9 set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_destra10 set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_destra11 set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_destra12 set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_impest set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_facpip set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_ptjpat set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_ptjpip set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_ptjqui set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_ptjdec set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_mttfza set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_mttfzb set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_mttfzc set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_ptjval set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_mttvza set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_mttvzb set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_mttvzc set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_semes1 set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_semes2 set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_ptumay set not null;
-- dmap_object_gen_tag : type : alter table name : pploparp
set search_path = labppto,oracle,dmap_extension,public;
alter table pploparp alter column par_ptunov set not null;
