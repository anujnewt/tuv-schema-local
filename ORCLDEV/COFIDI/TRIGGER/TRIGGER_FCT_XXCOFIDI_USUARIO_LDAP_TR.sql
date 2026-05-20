CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_usuario_ldap_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_USUARIO_LDAP_PK::text, '') IS NULL THEN
SELECT cofidi.nextval('xxcofidi_usuario_ldap_sq')
INTO STRICT NEW.ID_USUARIO_LDAP_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
