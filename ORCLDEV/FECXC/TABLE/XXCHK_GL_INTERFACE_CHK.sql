-- dmap_object_gen_tag : type : table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_gl_interface_chk"  (
id_estado_cheque numeric(38) not null,
id_sec_cheque numeric(38) not null,
status varchar(50) not null,
set_of_books_id numeric not null,
accounting_date timestamp(0) not null,
currency_code varchar(3) not null,
currency_conversion_date timestamp(0),
user_currency_conversion_type varchar(30),
currency_conversion_rate numeric,
actual_flag varchar(1) not null,
user_je_category_name varchar(25) not null,
user_je_source_name varchar(25) not null,
segment1 varchar(25),
segment2 varchar(25),
segment3 varchar(25),
segment4 varchar(25),
segment5 varchar(25),
segment6 varchar(25),
segment7 varchar(25),
entered_dr numeric,
entered_cr numeric,
accounted_dr numeric,
accounted_cr numeric,
reference1 varchar(100),
period_name varchar(25),
code_combination_id numeric,
group_id numeric not null,
procesado numeric(38),
date_created timestamp(0) not null default statement_timestamp(),
created_by varchar(30) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_gl_interface_chk alter column id_estado_cheque set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_gl_interface_chk alter column id_sec_cheque set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_gl_interface_chk alter column status set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_gl_interface_chk alter column set_of_books_id set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_gl_interface_chk alter column accounting_date set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_gl_interface_chk alter column currency_code set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_gl_interface_chk alter column actual_flag set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_gl_interface_chk alter column user_je_category_name set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_gl_interface_chk alter column user_je_source_name set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_gl_interface_chk alter column group_id set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_gl_interface_chk alter column date_created set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_gl_interface_chk alter column created_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_gl_interface_chk add constraint fk_xxchk_gl_fk_xxgl_e_xxchk_ca foreign key (id_estado_cheque) references xxchk_cat_edos(id_estado_cheque) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxchk_gl_interface_chk
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_gl_interface_chk add constraint fk_xxchk_gl_rk_xxgl_c_xxchk_ca foreign key (id_sec_cheque) references xxchk_captura_cheques(id_sec_cheque) on delete no action not deferrable initially immediate;
