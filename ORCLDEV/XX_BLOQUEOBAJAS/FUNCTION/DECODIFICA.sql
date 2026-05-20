CREATE OR REPLACE NONEDITIONABLE FUNCTION "XX_BLOQUEOBAJAS"."DECODIFICA" (p_password IN VARCHAR2) RETURN VARCHAR2 AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 resultado varchar2(256);
BEGIN
    resultado := p_password;
    resultado := REPLACE(resultado,'&aacute;','?;
    resultado := REPLACE(resultado,'&eacute;','?;
    resultado := REPLACE(resultado,'&iacute;','?;
    resultado := REPLACE(resultado,'&oacute;','?
    resultado := REPLACE(resultado,'&uacute;','?');
    resultado := REPLACE(resultado,'&Aacute;','?');
    resultado := REPLACE(resultado,'&Eacute;','?);
    resultado := REPLACE(resultado,'&Iacute;','?);
    resultado := REPLACE(resultado,'&Oacute;','?);
    resultado := REPLACE(resultado,'&Uacute;','?);
    resultado := REPLACE(resultado,'&iquest;','?');
    resultado := REPLACE(resultado,'&iexcl;','?');
    resultado := REPLACE(resultado,'&ntilde;','?
    resultado := REPLACE(resultado,'&Ntilde;','?);
    resultado := REPLACE(resultado,'&auml;','?;
    resultado := REPLACE(resultado,'&euml;','?;
    resultado := REPLACE(resultado,'&iuml;','?;
    resultado := REPLACE(resultado,'&ouml;','?');
    resultado := REPLACE(resultado,'&uuml;','?');
    resultado := REPLACE(resultado,'&Auml;','?);
    resultado := REPLACE(resultado,'&Euml;','?);
    resultado := REPLACE(resultado,'&Iuml;','?);
    resultado := REPLACE(resultado,'&Ouml;','?);
    resultado := REPLACE(resultado,'&Uuml;','?);
    resultado := REPLACE(resultado,'&Ccedil;','?);
    resultado := REPLACE(resultado,'&ccedil;','?;
    resultado := REPLACE(resultado,'&quot;','"');
    resultado := REPLACE(resultado,'&amp;','&');
    resultado := REPLACE(resultado,'&nbsp;',' ');
    resultado := REPLACE(resultado,'&iexcl;','?');
    resultado := REPLACE(resultado,'&cent;','?');
    resultado := REPLACE(resultado,'&pound;','?');
    resultado := REPLACE(resultado,'&curren;','?');
    resultado := REPLACE(resultado,'&yen;','?');
    resultado := REPLACE(resultado,'&brvbar;','?');
    resultado := REPLACE(resultado,'&sect;','?');
    resultado := REPLACE(resultado,'&uml;','?');
    resultado := REPLACE(resultado,'&copy;','?');
    resultado := REPLACE(resultado,'&ordf;','?');
    resultado := REPLACE(resultado,'&laquo;','?');
    resultado := REPLACE(resultado,'&not;','?');
    resultado := REPLACE(resultado,'&shy;','?');
    resultado := REPLACE(resultado,'&reg;','?');
    resultado := REPLACE(resultado,'&macr;','?');
    resultado := REPLACE(resultado,'&deg;','?');
    resultado := REPLACE(resultado,'&plusmn;','?');
    resultado := REPLACE(resultado,'&sup2;','?');
    resultado := REPLACE(resultado,'&sup3;','?');
    resultado := REPLACE(resultado,'&acute;','?');
    resultado := REPLACE(resultado,'&micro;','?');
    resultado := REPLACE(resultado,'&para;','?');
    resultado := REPLACE(resultado,'&middot;','?');
    resultado := REPLACE(resultado,'&cedil;','?');
    resultado := REPLACE(resultado,'&sup1;','?');
    resultado := REPLACE(resultado,'&ordm;','?');
    resultado := REPLACE(resultado,'&raquo;','?');
    resultado := REPLACE(resultado,'&frac14;','?');
    resultado := REPLACE(resultado,'&frac12;','?');
    resultado := REPLACE(resultado,'&frac34;','?');
    resultado := REPLACE(resultado,'&iquest;','?');
    resultado := REPLACE(resultado,'&Agrave;','?');
    resultado := REPLACE(resultado,'&Aacute;','?');
    resultado := REPLACE(resultado,'&Acirc;','?);
    resultado := REPLACE(resultado,'&Atilde;','?);
    resultado := REPLACE(resultado,'&Aring;','?);
    resultado := REPLACE(resultado,'&AElig;','?);
    resultado := REPLACE(resultado,'&Ccedil;','?);
    resultado := REPLACE(resultado,'&Egrave;','?);
    resultado := REPLACE(resultado,'&Eacute;','?);
    resultado := REPLACE(resultado,'&Ecirc;','?);
    resultado := REPLACE(resultado,'&Igrave;','?);
    resultado := REPLACE(resultado,'&Iacute;','?);
    resultado := REPLACE(resultado,'&Icirc;','?);
    resultado := REPLACE(resultado,'&ETH;','?);
    resultado := REPLACE(resultado,'&Ntilde;','?);
    resultado := REPLACE(resultado,'&Ograve;','?);
    resultado := REPLACE(resultado,'&Oacute;','?);
    resultado := REPLACE(resultado,'&Ocirc;','?);
    resultado := REPLACE(resultado,'&Otilde;','?);
    resultado := REPLACE(resultado,'&times;','?);
    resultado := REPLACE(resultado,'&Oslash;','?);
    resultado := REPLACE(resultado,'&Ugrave;','?);
    resultado := REPLACE(resultado,'&Uacute;','?);
    resultado := REPLACE(resultado,'&Ucirc;','?);
    resultado := REPLACE(resultado,'&Yacute;','?);
    resultado := REPLACE(resultado,'&THORN;','?);
    resultado := REPLACE(resultado,'&szlig;','?);
    resultado := REPLACE(resultado,'&agrave;','?;
    resultado := REPLACE(resultado,'&acirc;','?;
    resultado := REPLACE(resultado,'&atilde;','?;
    resultado := REPLACE(resultado,'&aring;','?;
    resultado := REPLACE(resultado,'&aelig;','?;
    resultado := REPLACE(resultado,'&ccedil;','?;
    resultado := REPLACE(resultado,'&egrave;','?;
    resultado := REPLACE(resultado,'&ecirc;','?;
    resultado := REPLACE(resultado,'&igrave;','?;
    resultado := REPLACE(resultado,'&icirc;','?;
    resultado := REPLACE(resultado,'&eth;','?
    resultado := REPLACE(resultado,'&ograve;','?
    resultado := REPLACE(resultado,'&ocirc;','?
    resultado := REPLACE(resultado,'&otilde;','?');
    resultado := REPLACE(resultado,'&divide;','?');
    resultado := REPLACE(resultado,'&oslash;','?');
    resultado := REPLACE(resultado,'&ugrave;','?');
    resultado := REPLACE(resultado,'&ucirc;','?');
    resultado := REPLACE(resultado,'&yacute;','?');
    resultado := REPLACE(resultado,'&thorn;','?');
    resultado := REPLACE(resultado,'&yuml;','?');
    resultado := REPLACE(resultado,'&euro;','?');
    resultado := REPLACE(resultado,'&lt;','<');
    resultado := REPLACE(resultado,'&gt;','>');
    RETURN resultado;
END DECODIFICA;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "XX_BLOQUEOBAJAS"."DECODIFICA" (p_password IN VARCHAR2) RETURN VARCHAR2 AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 resultado varchar2(256);
BEGIN
    resultado := p_password;
    resultado := REPLACE(resultado,'&aacute;','?;
    resultado := REPLACE(resultado,'&eacute;','?;
    resultado := REPLACE(resultado,'&iacute;','?;
    resultado := REPLACE(resultado,'&oacute;','?
    resultado := REPLACE(resultado,'&uacute;','?');
    resultado := REPLACE(resultado,'&Aacute;','?');
    resultado := REPLACE(resultado,'&Eacute;','?);
    resultado := REPLACE(resultado,'&Iacute;','?);
    resultado := REPLACE(resultado,'&Oacute;','?);
    resultado := REPLACE(resultado,'&Uacute;','?);
    resultado := REPLACE(resultado,'&iquest;','?');
    resultado := REPLACE(resultado,'&iexcl;','?');
    resultado := REPLACE(resultado,'&ntilde;','?
    resultado := REPLACE(resultado,'&Ntilde;','?);
    resultado := REPLACE(resultado,'&auml;','?;
    resultado := REPLACE(resultado,'&euml;','?;
    resultado := REPLACE(resultado,'&iuml;','?;
    resultado := REPLACE(resultado,'&ouml;','?');
    resultado := REPLACE(resultado,'&uuml;','?');
    resultado := REPLACE(resultado,'&Auml;','?);
    resultado := REPLACE(resultado,'&Euml;','?);
    resultado := REPLACE(resultado,'&Iuml;','?);
    resultado := REPLACE(resultado,'&Ouml;','?);
    resultado := REPLACE(resultado,'&Uuml;','?);
    resultado := REPLACE(resultado,'&Ccedil;','?);
    resultado := REPLACE(resultado,'&ccedil;','?;
    resultado := REPLACE(resultado,'&quot;','"');
    resultado := REPLACE(resultado,'&amp;','&');
    resultado := REPLACE(resultado,'&nbsp;',' ');
    resultado := REPLACE(resultado,'&iexcl;','?');
    resultado := REPLACE(resultado,'&cent;','?');
    resultado := REPLACE(resultado,'&pound;','?');
    resultado := REPLACE(resultado,'&curren;','?');
    resultado := REPLACE(resultado,'&yen;','?');
    resultado := REPLACE(resultado,'&brvbar;','?');
    resultado := REPLACE(resultado,'&sect;','?');
    resultado := REPLACE(resultado,'&uml;','?');
    resultado := REPLACE(resultado,'&copy;','?');
    resultado := REPLACE(resultado,'&ordf;','?');
    resultado := REPLACE(resultado,'&laquo;','?');
    resultado := REPLACE(resultado,'&not;','?');
    resultado := REPLACE(resultado,'&shy;','?');
    resultado := REPLACE(resultado,'&reg;','?');
    resultado := REPLACE(resultado,'&macr;','?');
    resultado := REPLACE(resultado,'&deg;','?');
    resultado := REPLACE(resultado,'&plusmn;','?');
    resultado := REPLACE(resultado,'&sup2;','?');
    resultado := REPLACE(resultado,'&sup3;','?');
    resultado := REPLACE(resultado,'&acute;','?');
    resultado := REPLACE(resultado,'&micro;','?');
    resultado := REPLACE(resultado,'&para;','?');
    resultado := REPLACE(resultado,'&middot;','?');
    resultado := REPLACE(resultado,'&cedil;','?');
    resultado := REPLACE(resultado,'&sup1;','?');
    resultado := REPLACE(resultado,'&ordm;','?');
    resultado := REPLACE(resultado,'&raquo;','?');
    resultado := REPLACE(resultado,'&frac14;','?');
    resultado := REPLACE(resultado,'&frac12;','?');
    resultado := REPLACE(resultado,'&frac34;','?');
    resultado := REPLACE(resultado,'&iquest;','?');
    resultado := REPLACE(resultado,'&Agrave;','?');
    resultado := REPLACE(resultado,'&Aacute;','?');
    resultado := REPLACE(resultado,'&Acirc;','?);
    resultado := REPLACE(resultado,'&Atilde;','?);
    resultado := REPLACE(resultado,'&Aring;','?);
    resultado := REPLACE(resultado,'&AElig;','?);
    resultado := REPLACE(resultado,'&Ccedil;','?);
    resultado := REPLACE(resultado,'&Egrave;','?);
    resultado := REPLACE(resultado,'&Eacute;','?);
    resultado := REPLACE(resultado,'&Ecirc;','?);
    resultado := REPLACE(resultado,'&Igrave;','?);
    resultado := REPLACE(resultado,'&Iacute;','?);
    resultado := REPLACE(resultado,'&Icirc;','?);
    resultado := REPLACE(resultado,'&ETH;','?);
    resultado := REPLACE(resultado,'&Ntilde;','?);
    resultado := REPLACE(resultado,'&Ograve;','?);
    resultado := REPLACE(resultado,'&Oacute;','?);
    resultado := REPLACE(resultado,'&Ocirc;','?);
    resultado := REPLACE(resultado,'&Otilde;','?);
    resultado := REPLACE(resultado,'&times;','?);
    resultado := REPLACE(resultado,'&Oslash;','?);
    resultado := REPLACE(resultado,'&Ugrave;','?);
    resultado := REPLACE(resultado,'&Uacute;','?);
    resultado := REPLACE(resultado,'&Ucirc;','?);
    resultado := REPLACE(resultado,'&Yacute;','?);
    resultado := REPLACE(resultado,'&THORN;','?);
    resultado := REPLACE(resultado,'&szlig;','?);
    resultado := REPLACE(resultado,'&agrave;','?;
    resultado := REPLACE(resultado,'&acirc;','?;
    resultado := REPLACE(resultado,'&atilde;','?;
    resultado := REPLACE(resultado,'&aring;','?;
    resultado := REPLACE(resultado,'&aelig;','?;
    resultado := REPLACE(resultado,'&ccedil;','?;
    resultado := REPLACE(resultado,'&egrave;','?;
    resultado := REPLACE(resultado,'&ecirc;','?;
    resultado := REPLACE(resultado,'&igrave;','?;
    resultado := REPLACE(resultado,'&icirc;','?;
    resultado := REPLACE(resultado,'&eth;','?
    resultado := REPLACE(resultado,'&ograve;','?
    resultado := REPLACE(resultado,'&ocirc;','?
    resultado := REPLACE(resultado,'&otilde;','?');
    resultado := REPLACE(resultado,'&divide;','?');
    resultado := REPLACE(resultado,'&oslash;','?');
    resultado := REPLACE(resultado,'&ugrave;','?');
    resultado := REPLACE(resultado,'&ucirc;','?');
    resultado := REPLACE(resultado,'&yacute;','?');
    resultado := REPLACE(resultado,'&thorn;','?');
    resultado := REPLACE(resultado,'&yuml;','?');
    resultado := REPLACE(resultado,'&euro;','?');
    resultado := REPLACE(resultado,'&lt;','<');
    resultado := REPLACE(resultado,'&gt;','>');
    RETURN resultado;
END DECODIFICA;
/
