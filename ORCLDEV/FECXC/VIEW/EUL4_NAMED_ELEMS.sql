-- dmap_object_gen_tag : type : view name : eul4_named_elems
set search_path = fecxc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "eul4_named_elems"  ("el_type", "el_base_type", "el_id", "el_parent_type", "el_parent_id", "el_created_by", "el_created_date", "el_updated_by", "el_updated_date", "nel_name", "nel_developer_key", "nel_description", "nel_user_prop1", "nel_user_prop2", "nel_devkey_frozen") as select
el_type,
el_base_type,
el_id,
el_parent_type,
el_parent_id,
el_created_by,
el_created_date,
el_updated_by,
el_updated_date,
nel_name,
nel_developer_key,
nel_description,
nel_user_prop1,
nel_user_prop2,
mod( floor( el_element_state / power(2,  0) ),  2 )
nel_devkey_frozen
from (
select 'ASMP'       el_type,
'ASMP'       el_base_type,
asmp_id      el_id,
''         el_parent_type,
0         el_parent_id,
asmp_element_state el_element_state,
asmp_created_by  el_created_by,
asmp_created_date el_created_date,
asmp_updated_by  el_updated_by,
asmp_updated_date el_updated_date,
asmp_name     nel_name,
asmp_developer_key nel_developer_key,
asmp_description  nel_description,
asmp_user_prop1  nel_user_prop1,
asmp_user_prop2  nel_user_prop2
from eul4_asm_policies
union
select 'BA', 'BA', ba_id, '',
0, ba_element_state,
ba_created_by, ba_created_date,
ba_updated_by, ba_updated_date,
ba_name, ba_developer_key, ba_description,
ba_user_prop1, ba_user_prop2
from  eul4_bas
union
select 'DHN', 'DHN', dhn_id, 'DBH',
dhn_hi_id, dhn_element_state,
dhn_created_by, dhn_created_date,
dhn_updated_by, dhn_updated_date,
dhn_name, dhn_developer_key, dhn_description,
dhn_user_prop1, dhn_user_prop2
from  eul4_dbh_nodes
union
select 'DOC', 'DOC', doc_id, '',
0, doc_element_state,
doc_created_by, doc_created_date,
doc_updated_by, doc_updated_date,
doc_name, doc_developer_key, doc_description,
doc_user_prop1, doc_user_prop2
from  eul4_documents
where doc_batch = 0
union
select 'DOM', 'DOM', dom_id, '',
0, dom_element_state,
dom_created_by, dom_created_date,
dom_updated_by, dom_updated_date,
dom_name, dom_developer_key, dom_description,
dom_user_prop1, dom_user_prop2
from  eul4_domains
union
select exp_type, 'IT', exp_id, 'OBJ',
it_obj_id, exp_element_state,
exp_created_by, exp_created_date,
exp_updated_by, exp_updated_date,
exp_name, exp_developer_key, exp_description,
exp_user_prop1, exp_user_prop2
from  eul4_expressions
where exp_type in ('CI', 'CO', 'PAR')
and  nullif(it_obj_id::text, '') is not null
union
select 'FIL', 'FIL', exp_id, 'OBJ',
fil_obj_id, exp_element_state,
exp_created_by, exp_created_date,
exp_updated_by, exp_updated_date,
exp_name, exp_developer_key, exp_description,
exp_user_prop1, exp_user_prop2
from  eul4_expressions
where exp_type = 'FIL'
and  nullif(fil_obj_id::text, '') is not null
union
select exp_type, 'IT', exp_id, 'DOC',
it_doc_id, exp_element_state,
exp_created_by, exp_created_date,
exp_updated_by, exp_updated_date,
exp_name, exp_developer_key, exp_description,
exp_user_prop1, exp_user_prop2
from  eul4_expressions
where exp_type in ('CI', 'CO', 'PAR')
and  nullif(it_doc_id::text, '') is not null
union
select 'FIL', 'FIL', exp_id, 'DOC',
fil_doc_id, exp_element_state,
exp_created_by, exp_created_date,
exp_updated_by, exp_updated_date,
exp_name, exp_developer_key, exp_description,
exp_user_prop1, exp_user_prop2
from  eul4_expressions
where exp_type = 'FIL'
and  nullif(fil_doc_id::text, '') is not null
union
select 'JP', 'JP', exp_id, 'FK',
jp_key_id, exp_element_state,
exp_created_by, exp_created_date,
exp_updated_by, exp_updated_date,
exp_name, exp_developer_key, exp_description,
exp_user_prop1, exp_user_prop2
from  eul4_expressions
where exp_type = 'JP'
union
select 'FA', 'FA', fa_id, 'FUN',
fa_fun_id, fa_element_state,
fa_created_by, fa_created_date,
fa_updated_by, fa_updated_date,
fa_name_s, fa_developer_key, fa_description_s,
fa_user_prop1, fa_user_prop2
from  eul4_fun_arguments
union
select 'FC', 'FC', fc_id, '',
0, fc_element_state,
fc_created_by, fc_created_date,
fc_updated_by, fc_updated_date,
fc_name_s, fc_developer_key, fc_description_s,
fc_user_prop1, fc_user_prop2
from  eul4_fun_ctgs
union
select 'FUN', 'FUN', fun_id, '',
0, fun_element_state,
fun_created_by, fun_created_date,
fun_updated_by, fun_updated_date,
fun_name, fun_developer_key, fun_description_s,
fun_user_prop1, fun_user_prop2
from  eul4_functions
union
select hi_type, 'HI', hi_id, '',
0, hi_element_state,
hi_created_by, hi_created_date,
hi_updated_by, hi_updated_date,
hi_name, hi_developer_key, hi_description,
hi_user_prop1, hi_user_prop2
from  eul4_hierarchies
union
select 'HN', 'HN', hn_id, 'IBH',
hn_hi_id, hn_element_state,
hn_created_by, hn_created_date,
hn_updated_by, hn_updated_date,
hn_name, hn_developer_key, hn_description,
hn_user_prop1, hn_user_prop2
from  eul4_hi_nodes
union
select key_type, 'KEY', key_id, 'OBJ',
key_obj_id, key_element_state,
key_created_by, key_created_date,
key_updated_by, key_updated_date,
key_name, key_developer_key, key_description,
key_user_prop1, key_user_prop2
from  eul4_key_cons
union
select obj_type, 'OBJ', obj_id, '',
0, obj_element_state,
obj_created_by, obj_created_date,
obj_updated_by, obj_updated_date,
obj_name, obj_developer_key, obj_description,
obj_user_prop1, obj_user_prop2
from  eul4_objs
union
select 'SQ', 'SQ', sq_id, 'OBJ',
sq_obj_id, sq_element_state,
sq_created_by, sq_created_date,
sq_updated_by, sq_updated_date,
sq_name, sq_developer_key, sq_description,
sq_user_prop1, sq_user_prop2
from  eul4_sub_queries
union
select 'SRS', 'SRS', srs_id, '',
0, srs_element_state,
srs_created_by, srs_created_date,
srs_updated_by, srs_updated_date,
srs_name, srs_developer_key, srs_description,
srs_user_prop1, srs_user_prop2
from  eul4_sum_rfsh_sets
) alias5;/* dmap converted statement end */
-- estimed cost of view [ eul4_named_elems ]: 1.00;
