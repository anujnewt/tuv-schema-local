CREATE OR REPLACE FORCE EDITIONABLE VIEW "FECXC"."EUL4_NAMED_ELEMS" ("EL_TYPE", "EL_BASE_TYPE", "EL_ID", "EL_PARENT_TYPE", "EL_PARENT_ID", "EL_CREATED_BY", "EL_CREATED_DATE", "EL_UPDATED_BY", "EL_UPDATED_DATE", "NEL_NAME", "NEL_DEVELOPER_KEY", "NEL_DESCRIPTION", "NEL_USER_PROP1", "NEL_USER_PROP2", "NEL_DEVKEY_FROZEN") AS 
  SELECT
      EL_TYPE,
      EL_BASE_TYPE,
      EL_ID,
      EL_PARENT_TYPE,
      EL_PARENT_ID,
      EL_CREATED_BY,
      EL_CREATED_DATE,
      EL_UPDATED_BY,
      EL_UPDATED_DATE,
      NEL_NAME,
      NEL_DEVELOPER_KEY,
      NEL_DESCRIPTION,
      NEL_USER_PROP1,
      NEL_USER_PROP2,
      mod( floor( EL_ELEMENT_STATE / power(2, 0) ), 2 )
       NEL_DEVKEY_FROZEN
 from
 (
 select 'ASMP'       EL_TYPE,
    'ASMP'       EL_BASE_TYPE,
    asmp_id      EL_ID,
    ''         EL_PARENT_TYPE,
    0         EL_PARENT_ID,
    asmp_element_state EL_ELEMENT_STATE,
    asmp_created_by  EL_CREATED_BY,
    asmp_created_date EL_CREATED_DATE,
    asmp_updated_by  EL_UPDATED_BY,
    asmp_updated_date EL_UPDATED_DATE,
    asmp_name     NEL_NAME,
    asmp_developer_key NEL_DEVELOPER_KEY,
    asmp_description  NEL_DESCRIPTION,
    asmp_user_prop1  NEL_USER_PROP1,
    asmp_user_prop2  NEL_USER_PROP2
 from EUL4_ASM_POLICIES
 union
 select 'BA', 'BA', ba_id, '',
    0, ba_element_state,
    ba_created_by, ba_created_date,
    ba_updated_by, ba_updated_date,
    ba_name, ba_developer_key, ba_description,
    ba_user_prop1, ba_user_prop2
 from  EUL4_BAS
 union
 select 'DHN', 'DHN', dhn_id, 'DBH',
    dhn_hi_id, dhn_element_state,
    dhn_created_by, dhn_created_date,
    dhn_updated_by, dhn_updated_date,
    dhn_name, dhn_developer_key, dhn_description,
    dhn_user_prop1, dhn_user_prop2
 from  EUL4_DBH_NODES
 union
 select 'DOC', 'DOC', doc_id, '',
    0, doc_element_state,
    doc_created_by, doc_created_date,
    doc_updated_by, doc_updated_date,
    doc_name, doc_developer_key, doc_description,
    doc_user_prop1, doc_user_prop2
 from  EUL4_DOCUMENTS
 where doc_batch = 0
 union
 select 'DOM', 'DOM', dom_id, '',
    0, dom_element_state,
    dom_created_by, dom_created_date,
    dom_updated_by, dom_updated_date,
    dom_name, dom_developer_key, dom_description,
    dom_user_prop1, dom_user_prop2
 from  EUL4_DOMAINS
 union
 select exp_type, 'IT', exp_id, 'OBJ',
    it_obj_id, exp_element_state,
    exp_created_by, exp_created_date,
    exp_updated_by, exp_updated_date,
    exp_name, exp_developer_key, exp_description,
    exp_user_prop1, exp_user_prop2
 from  EUL4_EXPRESSIONS
 where exp_type in ('CI', 'CO', 'PAR')
 and  it_obj_id is not null
 union
 select 'FIL', 'FIL', exp_id, 'OBJ',
    fil_obj_id, exp_element_state,
    exp_created_by, exp_created_date,
    exp_updated_by, exp_updated_date,
    exp_name, exp_developer_key, exp_description,
    exp_user_prop1, exp_user_prop2
 from  EUL4_EXPRESSIONS
 where exp_type = 'FIL'
 and  fil_obj_id is not null
 union
 select exp_type, 'IT', exp_id, 'DOC',
    it_doc_id, exp_element_state,
    exp_created_by, exp_created_date,
    exp_updated_by, exp_updated_date,
    exp_name, exp_developer_key, exp_description,
    exp_user_prop1, exp_user_prop2
 from  EUL4_EXPRESSIONS
 where exp_type in ('CI', 'CO', 'PAR')
 and  it_doc_id is not null
 union
 select 'FIL', 'FIL', exp_id, 'DOC',
    fil_doc_id, exp_element_state,
    exp_created_by, exp_created_date,
    exp_updated_by, exp_updated_date,
    exp_name, exp_developer_key, exp_description,
    exp_user_prop1, exp_user_prop2
 from  EUL4_EXPRESSIONS
 where exp_type = 'FIL'
 and  fil_doc_id is not null
 union
 select 'JP', 'JP', exp_id, 'FK',
    jp_key_id, exp_element_state,
    exp_created_by, exp_created_date,
    exp_updated_by, exp_updated_date,
    exp_name, exp_developer_key, exp_description,
    exp_user_prop1, exp_user_prop2
 from  EUL4_EXPRESSIONS
 where exp_type = 'JP'
 union
 select 'FA', 'FA', fa_id, 'FUN',
    fa_fun_id, fa_element_state,
    fa_created_by, fa_created_date,
    fa_updated_by, fa_updated_date,
    fa_name_s, fa_developer_key, fa_description_s,
    fa_user_prop1, fa_user_prop2
 from  EUL4_FUN_ARGUMENTS
 union
 select 'FC', 'FC', fc_id, '',
    0, fc_element_state,
    fc_created_by, fc_created_date,
    fc_updated_by, fc_updated_date,
    fc_name_s, fc_developer_key, fc_description_s,
    fc_user_prop1, fc_user_prop2
 from  EUL4_FUN_CTGS
 union
 select 'FUN', 'FUN', fun_id, '',
    0, fun_element_state,
    fun_created_by, fun_created_date,
    fun_updated_by, fun_updated_date,
    fun_name, fun_developer_key, fun_description_s,
    fun_user_prop1, fun_user_prop2
 from  EUL4_FUNCTIONS
 union
 select hi_type, 'HI', hi_id, '',
    0, hi_element_state,
    hi_created_by, hi_created_date,
    hi_updated_by, hi_updated_date,
    hi_name, hi_developer_key, hi_description,
    hi_user_prop1, hi_user_prop2
 from  EUL4_HIERARCHIES
 union
 select 'HN', 'HN', hn_id, 'IBH',
    hn_hi_id, hn_element_state,
    hn_created_by, hn_created_date,
    hn_updated_by, hn_updated_date,
    hn_name, hn_developer_key, hn_description,
    hn_user_prop1, hn_user_prop2
 from  EUL4_HI_NODES
 union
 select key_type, 'KEY', key_id, 'OBJ',
    key_obj_id, key_element_state,
    key_created_by, key_created_date,
    key_updated_by, key_updated_date,
    key_name, key_developer_key, key_description,
    key_user_prop1, key_user_prop2
 from  EUL4_KEY_CONS
 union
 select obj_type, 'OBJ', obj_id, '',
    0, obj_element_state,
    obj_created_by, obj_created_date,
    obj_updated_by, obj_updated_date,
    obj_name, obj_developer_key, obj_description,
    obj_user_prop1, obj_user_prop2
 from  EUL4_OBJS
 union
 select 'SQ', 'SQ', sq_id, 'OBJ',
    sq_obj_id, sq_element_state,
    sq_created_by, sq_created_date,
    sq_updated_by, sq_updated_date,
    sq_name, sq_developer_key, sq_description,
    sq_user_prop1, sq_user_prop2
 from  EUL4_SUB_QUERIES
 union
 select 'SRS', 'SRS', srs_id, '',
    0, srs_element_state,
    srs_created_by, srs_created_date,
    srs_updated_by, srs_updated_date,
    srs_name, srs_developer_key, srs_description,
    srs_user_prop1, srs_user_prop2
 from  EUL4_SUM_RFSH_SETS
 )
;
