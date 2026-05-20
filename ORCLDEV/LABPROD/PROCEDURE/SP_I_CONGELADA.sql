CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_I_CONGELADA" 
(ws_mes in varchar2, wi_proceso in SMALLINT, ws_periodo in varchar2, ws_anio in varchar2, ws_estruc in varchar2, total OUT integer) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  -- I.S.I.
  -- Sistema      : rh2000
  -- Modulo       : Respado de Tablas al Final del Cierre Periodo  sobre la tabla "congelada_rh2000"
  -- Programa     : sp_i_congelada
  -- Autor        : Edmundo Dominguez Carsi
  -- Fecha        : Agosto de 1999
  -- Compilado    : Agosto de 1999
  -- Ult. Compil. : 18 de Octubre de 2002
  -- Autor        : Emilio Pulido Rangel
  -- se agrego al query principal "AND   red_keyest = ws_estruc"
-- Definicion de Variables
   pn_keycia      char(4) ;
   pn_keyper      char(7) ;
   pn_keypro      smallint;
   pn_keyemp      integer;
   pn_keypue      char(16) ;
   pn_status      smallint;
   pn_fecing      date;
   pn_fecrei      date;
   pn_fecbaj      date;
   pn_fecaum      date;
   pn_keyloc      char(16) ;
   pn_forpag      char(2) ;
   pn_numpza      INTEGER;         -- Num. Plaza*
   pn_cveaum      INTEGER;         -- Clave Aumento*
   pn_keydep      char(16) ;
   pn_keycen      char(16) ;
   pn_deprep      INTEGER;         -- Depto. Sua*
   pn_ccdsup      INTEGER;
   pn_keyjfe      integer;         -- Num. Empleado del Jefe
   pn_keypuj      char(16) ;        -- Puesto del Jefe
   pn_salmes      decimal(12,2) ;
   pn_salhor      decimal(12,6) ;
   pn_saldia      decimal(12,6) ;
   pn_salint      decimal(12,6) ;
   pn_salivc      decimal(12,6) ;
   pn_salinf      decimal(12,6) ;
   pn_intsin      decimal(12,6) ;
   pn_infsin      decimal(12,6) ;
   pn_varims      decimal(12,6) ;
   pn_varinf      decimal(12,6) ;
   pn_keyvic      INTEGER;
   pn_keyest      char(3);
   pn_paddep      char(16);
   pn_hijdep      char(16);
   pn_codniv      char(80);
   pn_pesesp      smallint;
   pn_numniv      smallint;
   wn_chktable    SMALLINT;
   wn_contreg     INTEGER;
CURSOR cursor1 IS
		SELECT  pro_keycia,his_keyper,his_keypro,emp_keyemp,emp_keypue,emp_status,emp_fecing,emp_fecrei,emp_fecbaj,emp_fecaum,
        emp_keyloc,emp_forpag,1,1,emp_keydep,emp_keycen,1,1,1,1,
        emp_salmes, emp_salhor, emp_saldia, emp_salint, emp_salivc, emp_salinf, emp_intsin, emp_infsin, emp_varims, emp_varinf,
        1, red_keyest, red_paddep, red_hijdep, red_codniv, red_pesesp, red_numniv
		FROM    nmlohism,nmcoempl,nmloproc,eocorede
		WHERE   his_keycon = '262' AND his_keyper = ws_periodo AND his_keypro = wi_proceso AND his_keyemp = emp_keyemp
		AND his_keypro = emp_keypro AND emp_keydep = red_hijdep AND emp_keypro = pro_keypro AND red_keyest = ws_estruc;
BEGIN
  wn_contreg := 0;
  OPEN cursor1;
	LOOP
      FETCH cursor1 INTO
          pn_keycia, pn_keyper, pn_keypro, pn_keyemp, pn_keypue, pn_status, pn_fecing, pn_fecrei, pn_fecbaj, pn_fecaum,
          pn_keyloc, pn_forpag, pn_numpza, pn_cveaum, pn_keydep, pn_keycen, pn_deprep, pn_ccdsup, pn_keyjfe, pn_keypuj,
          pn_salmes, pn_salhor, pn_saldia, pn_salint, pn_salivc, pn_salinf, pn_intsin, pn_infsin, pn_varims, pn_varinf,
          pn_keyvic, pn_keyest, pn_paddep, pn_hijdep, pn_codniv, pn_pesesp, pn_numniv;
		EXIT WHEN cursor1%NOTFOUND;
      /* The original statement block */
      INSERT INTO congelada_rh2000
		(mes_keyano, mes_keymes, mes_keycia, mes_keyper, mes_keypro, mes_keyemp, mes_keypue,mes_status,mes_fecing,
		mes_fecrei, mes_fecbaj, mes_fecaum, mes_keyloc, mes_forpag, mes_numpza, mes_cveaum, mes_keydep, mes_keycen, mes_deprep,
		mes_ccdsup, mes_keyjfe, mes_keypuj, mes_salmes, mes_salhor, mes_saldia, mes_salint, mes_salivc, mes_salinf, mes_intsin,
		mes_infsin, mes_varims, mes_varinf, mes_keyvic, mes_keyest, mes_paddep, mes_hijdep, mes_codniv, mes_pesesp, mes_numniv)
	  VALUES(        ws_anio,   ws_mes,    pn_keycia, pn_keyper, pn_keypro, pn_keyemp, pn_keypue, pn_status, pn_fecing,
		pn_fecrei, pn_fecbaj, pn_fecaum, pn_keyloc, pn_forpag, pn_numpza, pn_cveaum, pn_keydep, pn_keycen, pn_deprep,
		pn_ccdsup, pn_keyjfe, pn_keypuj, pn_salmes, pn_salhor, pn_saldia, pn_salint, pn_salivc, pn_salinf, pn_intsin,
		pn_infsin, pn_varims, pn_varinf, pn_keyvic, pn_keyest, pn_paddep, pn_hijdep, pn_codniv, pn_pesesp, pn_numniv) ;
		wn_contreg := wn_contreg + 1;
	END LOOP;
 CLOSE cursor1;
  total := wn_contreg;
--return wn_contreg;
END;
/
