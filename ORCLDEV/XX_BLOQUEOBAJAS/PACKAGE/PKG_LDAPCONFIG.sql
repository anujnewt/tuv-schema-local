CREATE OR REPLACE NONEDITIONABLE PACKAGE "XX_BLOQUEOBAJAS"."PKG_LDAPCONFIG" AS

  PROCEDURE GET_CONFIG(p_ldap_host out VARCHAR2,
                       p_ldap_port out VARCHAR2,
                       p_ldap_user out VARCHAR2,
                       p_ldap_passwd out VARCHAR2,
                       p_ldap_base out VARCHAR2);
  PROCEDURE SET_CONFIG(p_ldap_host in VARCHAR2,
                       p_ldap_port in VARCHAR2,
                       p_ldap_user in VARCHAR2,
                       p_ldap_passwd in VARCHAR2,
                       p_ldap_base in VARCHAR2);

END PKG_LDAPCONFIG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "XX_BLOQUEOBAJAS"."PKG_LDAPCONFIG" AS
  PROCEDURE GET_CONFIG(p_ldap_host out VARCHAR2,
                       p_ldap_port out VARCHAR2,
                       p_ldap_user out VARCHAR2,
                       p_ldap_passwd out VARCHAR2,
                       p_ldap_base out VARCHAR2) AS
  BEGIN
    SELECT ldap_host,ldap_port,ldap_user,ldap_passwd,ldap_base
    INTO p_ldap_host,p_ldap_port,p_ldap_user,p_ldap_passwd,p_ldap_base
    FROM XX_BLOQUEOBAJAS.LDAPCONFIG;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    p_ldap_host:=NULL;
    p_ldap_port:=NULL;
    p_ldap_user:=NULL;
    p_ldap_passwd:=NULL;
    p_ldap_base:=NULL;
  END;

  PROCEDURE SET_CONFIG(p_ldap_host in VARCHAR2,
                       p_ldap_port in VARCHAR2,
                       p_ldap_user in VARCHAR2,
                       p_ldap_passwd in VARCHAR2,
                       p_ldap_base in VARCHAR2) AS
    ldap_host_ori VARCHAR2(256);

    BEGIN
        SELECT ldap_host INTO ldap_host_ori
        FROM XX_BLOQUEOBAJAS.LDAPCONFIG;
        UPDATE XX_BLOQUEOBAJAS.LDAPCONFIG SET
            ldap_host = p_ldap_host,
            ldap_port = p_ldap_port,
            ldap_user = p_ldap_user,
            ldap_passwd= p_ldap_passwd,
            ldap_base = p_ldap_base;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        INSERT INTO XX_BLOQUEOBAJAS.LDAPCONFIG (ldap_host,ldap_port,ldap_user,ldap_passwd,ldap_base) VALUES (p_ldap_host,p_ldap_port,p_ldap_user,p_ldap_passwd,p_ldap_base);
    END;

END PKG_LDAPCONFIG;
/;
/;
