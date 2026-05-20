-- DMAP_OBJECT_GEN_TAG : TYPE : EDITIONABLE NAME : ss_login_pkg_user_info_typ
SET search_path = usrdrc,oracle,dmap_extension,public;

CREATE TYPE ss_login_pkg_user_info_typ AS (
USER_ID                   NUMERIC         :=NULL,
                                USER_LONG_NAME            varchar(100)  :=NULL,
                                USERNAME                  varchar(30)   :=NULL,
                                REAL_PASSWORD             varchar(255)  :=NULL,
                                STATUS_ID                 NUMERIC         :=NULL,
                                ROL_ID                    NUMERIC         :=NULL,
                                ROL_NAME                  varchar(20)   :=NULL,
                                ROL_DESCRIPTION           varchar(100)  :=NULL,
                                PASSWORD_EXPIRATION_DAYS  NUMERIC         :=NULL

);
