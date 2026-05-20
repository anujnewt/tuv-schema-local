create or replace  function  xx_bloqueobajas."decodifica"  (p_password varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
resultado varchar(256);
begin
resultado := p_password;
resultado := replace(resultado,'&aacute;','?;
resultado := replace(resultado,'&eacute;','?;
resultado := replace(resultado,'&iacute;','?;
resultado := replace(resultado,'&oacute;','?
resultado := replace(resultado,'&uacute;','?');
resultado := replace(resultado,'&Aacute;','?');
resultado := replace(resultado,'&Eacute;','?);
resultado := replace(resultado,'&Iacute;','?);
resultado := replace(resultado,'&Oacute;','?);
resultado := replace(resultado,'&Uacute;','?);
resultado := replace(resultado,'&iquest;','?');
resultado := replace(resultado,'&iexcl;','?');
resultado := replace(resultado,'&ntilde;','?
resultado := replace(resultado,'&Ntilde;','?);
resultado := replace(resultado,'&auml;','?;
resultado := replace(resultado,'&euml;','?;
resultado := replace(resultado,'&iuml;','?;
resultado := replace(resultado,'&ouml;','?');
resultado := replace(resultado,'&uuml;','?');
resultado := replace(resultado,'&Auml;','?);
resultado := replace(resultado,'&Euml;','?);
resultado := replace(resultado,'&Iuml;','?);
resultado := replace(resultado,'&Ouml;','?);
resultado := replace(resultado,'&Uuml;','?);
resultado := replace(resultado,'&Ccedil;','?);
resultado := replace(resultado,'&ccedil;','?;
resultado := replace(resultado,'&quot;','"');
resultado := replace(resultado,'&amp;','&');
resultado := replace(resultado,'&nbsp;',' ');
resultado := replace(resultado,'&iexcl;','?');
resultado := replace(resultado,'&cent;','?');
resultado := replace(resultado,'&pound;','?');
resultado := replace(resultado,'&curren;','?');
resultado := replace(resultado,'&yen;','?');
resultado := replace(resultado,'&brvbar;','?');
resultado := replace(resultado,'&sect;','?');
resultado := replace(resultado,'&uml;','?');
resultado := replace(resultado,'&copy;','?');
resultado := replace(resultado,'&ordf;','?');
resultado := replace(resultado,'&laquo;','?');
resultado := replace(resultado,'&not;','?');
resultado := replace(resultado,'&shy;','?');
resultado := replace(resultado,'&reg;','?');
resultado := replace(resultado,'&macr;','?');
resultado := replace(resultado,'&deg;','?');
resultado := replace(resultado,'&plusmn;','?');
resultado := replace(resultado,'&sup2;','?');
resultado := replace(resultado,'&sup3;','?');
resultado := replace(resultado,'&acute;','?');
resultado := replace(resultado,'&micro;','?');
resultado := replace(resultado,'&para;','?');
resultado := replace(resultado,'&middot;','?');
resultado := replace(resultado,'&cedil;','?');
resultado := replace(resultado,'&sup1;','?');
resultado := replace(resultado,'&ordm;','?');
resultado := replace(resultado,'&raquo;','?');
resultado := replace(resultado,'&frac14;','?');
resultado := replace(resultado,'&frac12;','?');
resultado := replace(resultado,'&frac34;','?');
resultado := replace(resultado,'&iquest;','?');
resultado := replace(resultado,'&Agrave;','?');
resultado := replace(resultado,'&Aacute;','?');
resultado := replace(resultado,'&Acirc;','?);
resultado := replace(resultado,'&Atilde;','?);
resultado := replace(resultado,'&Aring;','?);
resultado := replace(resultado,'&AElig;','?);
resultado := replace(resultado,'&Ccedil;','?);
resultado := replace(resultado,'&Egrave;','?);
resultado := replace(resultado,'&Eacute;','?);
resultado := replace(resultado,'&Ecirc;','?);
resultado := replace(resultado,'&Igrave;','?);
resultado := replace(resultado,'&Iacute;','?);
resultado := replace(resultado,'&Icirc;','?);
resultado := replace(resultado,'&ETH;','?);
resultado := replace(resultado,'&Ntilde;','?);
resultado := replace(resultado,'&Ograve;','?);
resultado := replace(resultado,'&Oacute;','?);
resultado := replace(resultado,'&Ocirc;','?);
resultado := replace(resultado,'&Otilde;','?);
resultado := replace(resultado,'&times;','?);
resultado := replace(resultado,'&Oslash;','?);
resultado := replace(resultado,'&Ugrave;','?);
resultado := replace(resultado,'&Uacute;','?);
resultado := replace(resultado,'&Ucirc;','?);
resultado := replace(resultado,'&Yacute;','?);
resultado := replace(resultado,'&THORN;','?);
resultado := replace(resultado,'&szlig;','?);
resultado := replace(resultado,'&agrave;','?;
resultado := replace(resultado,'&acirc;','?;
resultado := replace(resultado,'&atilde;','?;
resultado := replace(resultado,'&aring;','?;
resultado := replace(resultado,'&aelig;','?;
resultado := replace(resultado,'&ccedil;','?;
resultado := replace(resultado,'&egrave;','?;
resultado := replace(resultado,'&ecirc;','?;
resultado := replace(resultado,'&igrave;','?;
resultado := replace(resultado,'&icirc;','?;
resultado := replace(resultado,'&eth;','?
resultado := replace(resultado,'&ograve;','?
resultado := replace(resultado,'&ocirc;','?
resultado := replace(resultado,'&otilde;','?');
resultado := replace(resultado,'&divide;','?');
resultado := replace(resultado,'&oslash;','?');
resultado := replace(resultado,'&ugrave;','?');
resultado := replace(resultado,'&ucirc;','?');
resultado := replace(resultado,'&yacute;','?');
resultado := replace(resultado,'&thorn;','?');
resultado := replace(resultado,'&yuml;','?');
resultado := replace(resultado,'&euro;','?');
resultado := replace(resultado,'&lt;','<');
resultado := replace(resultado,'&gt;','>');
return resultado;
end;
--dmap converted function completed
$body$
language plpgsql
stable;
