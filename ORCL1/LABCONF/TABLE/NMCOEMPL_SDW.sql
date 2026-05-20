-- dmap_object_gen_tag : type : table name : nmcoempl_sdw
set search_path = labconf,oracle,dmap_extension,public;
create table "nmcoempl_sdw"  (
marca_act varchar(2),
cmd varchar(15),
old_emp_keyemp numeric(38),
old_emp_keydep varchar(16),
old_emp_keypue varchar(16),
old_emp_keycen varchar(16),
old_emp_nomemp varchar(60),
old_emp_regrfc varchar(13),
old_emp_recurp varchar(18),
old_emp_regims varchar(12),
old_emp_keypro numeric(38),
old_emp_status numeric(38),
old_emp_keyloc varchar(16),
old_emp_fecing timestamp(0),
old_emp_fecbaj timestamp(0),
old_emp_fecaux timestamp(0),
old_emp_ca2aux varchar(10),
new_emp_keyemp numeric(38),
new_emp_keydep varchar(16),
new_emp_keypue varchar(16),
new_emp_keycen varchar(16),
new_emp_nomemp varchar(60),
new_emp_regrfc varchar(13),
new_emp_recurp varchar(18),
new_emp_regims varchar(12),
new_emp_keypro numeric(38),
new_emp_status numeric(38),
new_emp_keyloc varchar(16),
new_emp_fecing timestamp(0),
new_emp_fecbaj timestamp(0),
new_emp_fecaux timestamp(0),
new_emp_ca2aux varchar(10),
orderid1 timestamp(0),
orderid2 numeric(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmcoempl_sdw
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcoempl_sdw add primary key (orderid2);
