CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."SS_MENU_PKG" AS
  FUNCTION GET_MENU(PARAM_ROL_ID NUMBER) RETURN VARCHAR2;
END SS_MENU_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."SS_MENU_PKG" AS
  --
  --
  --
  FUNCTION GET_MENU(PARAM_ROL_ID NUMBER) RETURN VARCHAR2
  AS
    liinIdMenu NUMBER;
    MENU_STRING LONG;
    var_id_rol_menu int;
    var_id_seccion int;
    var_texto varchar(50);
    var_id_parent int;
    var_nombre_seccion varchar(100);
    var_url varchar(100);
  BEGIN
      SELECT
        ID_MENU INTO liinIdMenu
      FROM
        SS_ROL_TAB
      WHERE
        ID_ROL = PARAM_ROL_ID
      ;
      MENU_STRING := '';
      MENU_STRING := MENU_STRING ||
              'd = new dTree(''d'');' ||
              'd.config.useCookies = false;' ||
              'd.config.useCookies = false;' ||
              'd.config.inOrder = true;' ||
              'd.config.useIcons = true;';
      MENU_STRING := MENU_STRING ||
            'd.add(0,-1,''Inicio'',''../../jsp/home/content.jsp'','''',''contentFrame'');';
      FOR XX_ELEM IN (
                SELECT
                  MNU.ID_MENU_ELEMENT,
                  MNU.ID_MENU_ELEMENT_PARENT,
                  MNU.NOM_NAME,
                  SEC.NOM_NAME SEC_NAME,
                  MNU.ID_SECTION,
                  SEC.DES_URL,
                  MNU.DES_TARGET
                FROM
                  SS_MENU_ELEMENT_TAB MNU
                  LEFT JOIN SS_SECTION_TAB SEC ON SEC.ID_SECTION = MNU.ID_SECTION
                WHERE
                  MNU.ID_MENU = liinIdMenu
                AND
                  MNU.ATRIBUTO1 = 1  --Habilitado
                ORDER BY
                  MNU.ID_ORDER
                  --MNU.ID_MENU_ELEMENT
                  )
      LOOP
          MENU_STRING := MENU_STRING  ||
              'd.add('  ||
              NVL(XX_ELEM.ID_MENU_ELEMENT,'')  ||
              ',' ||
              NVL(XX_ELEM.ID_MENU_ELEMENT_PARENT,'0') ||
              ',' ||
              '''' ||
              NVL(XX_ELEM.NOM_NAME, XX_ELEM.SEC_NAME) ||
              ''',' ||
              '''' ||
              NVL(XX_ELEM.DES_URL,'') ||
              ''',' ||
              '''' ||
              NVL(NULL,'') ||
              ''',' ||
              '''' || XX_ELEM.DES_TARGET || ''');';
      END LOOP;
      MENU_STRING := CONCAT(MENU_STRING ,   'document.write(d);');
      MENU_STRING := CONCAT(MENU_STRING ,   'd.openAll();');
      RETURN MENU_STRING;
  END GET_MENU;
END SS_MENU_PKG;
/;
