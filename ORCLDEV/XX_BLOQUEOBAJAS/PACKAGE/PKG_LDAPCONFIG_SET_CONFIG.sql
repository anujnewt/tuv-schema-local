create or replace procedure xx_bloqueobajas.pkg_ldapconfig_set_config (p_ldap_host varchar, p_ldap_port varchar, p_ldap_user varchar, p_ldap_passwd varchar, p_ldap_base varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ldap_host_ori varchar(256);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select ldap_host into strict ldap_host_ori
from xx_bloqueobajas.ldapconfig;
update xx_bloqueobajas.ldapconfig set
ldap_host = p_ldap_host,
ldap_port = p_ldap_port,
ldap_user = p_ldap_user,
ldap_passwd= p_ldap_passwd,
ldap_base = p_ldap_base;
exception when no_data_found then
insert into xx_bloqueobajas.ldapconfig(ldap_host,ldap_port,ldap_user,ldap_passwd,ldap_base) values (p_ldap_host,p_ldap_port,p_ldap_user,p_ldap_passwd,p_ldap_base);end;
$body$
language plpgsql
;
