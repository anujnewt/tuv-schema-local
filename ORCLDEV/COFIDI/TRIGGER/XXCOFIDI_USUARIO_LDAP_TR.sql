-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_usuario_ldap_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_usuario_ldap_tr ON xxcofidi_usuario_ldap_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_usuario_ldap_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_usuario_ldap_tr"
BEFORE INSERT ON xxcofidi_usuario_ldap_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_usuario_ldap_tr();
