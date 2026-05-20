create or replace procedure xx_bloqueobajas.pkg_ldapconfig_get_config (p_ldap_host inout varchar, p_ldap_port inout varchar, p_ldap_user inout varchar, p_ldap_passwd inout varchar, p_ldap_base inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select ldap_host,ldap_port,ldap_user,ldap_passwd,ldap_base
into strict p_ldap_host,p_ldap_port,p_ldap_user,p_ldap_passwd,p_ldap_base
from xx_bloqueobajas.ldapconfig;
exception when no_data_found then
p_ldap_host:=null;
p_ldap_port:=null;
p_ldap_user:=null;
p_ldap_passwd:=null;
p_ldap_base:=null;end;
$body$
language plpgsql
;
