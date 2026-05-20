create or replace procedure usrdrc.ss_login_pkg_set_output_vars_pr ( pobjuserinforow ss_login_pkg_user_info_typ ,pinoutuserid inout numeric ,pstoutuserlongname inout varchar ,pstoutrolid inout varchar ,pstoutrolname inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
pinoutuserid                := pobjuserinforow.user_id;
pstoutuserlongname          := pobjuserinforow.user_long_name;
pstoutrolid                 := pobjuserinforow.rol_id;
pstoutrolname               := pobjuserinforow.rol_name;end;
$body$
language plpgsql
;
