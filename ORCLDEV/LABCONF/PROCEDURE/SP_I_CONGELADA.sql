create or replace procedure labconf."sp_i_congelada"  (ws_mes varchar, wi_proceso smallint, ws_periodo varchar, ws_anio varchar, ws_estruc varchar, total inout integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- i.s.i.
-- sistema      : rh2000
-- modulo       : respado de tablas al final del cierre periodo  sobre la tabla "congelada_rh2000"
-- programa     : sp_i_congelada
-- autor        : edmundo dominguez carsi
-- fecha        : agosto de 1999
-- compilado    : agosto de 1999
-- ult. compil. : 18 de octubre de 2002
-- autor        : emilio pulido rangel
-- se agrego al query principal "and   red_keyest = ws_estruc"
-- definicion de variables
pn_keycia      char(4);
pn_keyper      char(7);
pn_keypro      smallint;
pn_keyemp      integer;
pn_keypue      char(16);
pn_status      smallint;
pn_fecing      timestamp(0);
pn_fecrei      timestamp(0);
pn_fecbaj      timestamp(0);
pn_fecaum      timestamp(0);
pn_keyloc      char(16);
pn_forpag      char(2);
pn_numpza      integer;         -- num. plaza*
pn_cveaum      integer;         -- clave aumento*
pn_keydep      char(16);
pn_keycen      char(16);
pn_deprep      integer;         -- depto. sua*
pn_ccdsup      integer;
pn_keyjfe      integer;         -- num. empleado del jefe
pn_keypuj      char(16);        -- puesto del jefe
pn_salmes      decimal(12,2);
pn_salhor      decimal(12,6);
pn_saldia      decimal(12,6);
pn_salint      decimal(12,6);
pn_salivc      decimal(12,6);
pn_salinf      decimal(12,6);
pn_intsin      decimal(12,6);
pn_infsin      decimal(12,6);
pn_varims      decimal(12,6);
pn_varinf      decimal(12,6);
pn_keyvic      integer;
pn_keyest      char(3);
pn_paddep      char(16);
pn_hijdep      char(16);
pn_codniv      char(80);
pn_pesesp      smallint;
pn_numniv      smallint;
wn_chktable    smallint;
wn_contreg     integer;
cursor1 cursor for
select  pro_keycia,his_keyper,his_keypro,emp_keyemp,emp_keypue,emp_status,emp_fecing,emp_fecrei,emp_fecbaj,emp_fecaum,
emp_keyloc,emp_forpag,1,1,emp_keydep,emp_keycen,1,1,1,1,
emp_salmes, emp_salhor, emp_saldia, emp_salint, emp_salivc, emp_salinf, emp_intsin, emp_infsin, emp_varims, emp_varinf,
1, red_keyest, red_paddep, red_hijdep, red_codniv, red_pesesp, red_numniv
from    nmlohism,nmcoempl,nmloproc,eocorede
where   his_keycon = '262' and his_keyper = ws_periodo and his_keypro = wi_proceso and his_keyemp = emp_keyemp
and his_keypro = emp_keypro and emp_keydep = red_hijdep and emp_keypro = pro_keypro and red_keyest = ws_estruc;
begin
wn_contreg := 0;
open cursor1;
loop
fetch cursor1 into
pn_keycia, pn_keyper, pn_keypro, pn_keyemp, pn_keypue, pn_status, pn_fecing, pn_fecrei, pn_fecbaj, pn_fecaum,
pn_keyloc, pn_forpag, pn_numpza, pn_cveaum, pn_keydep, pn_keycen, pn_deprep, pn_ccdsup, pn_keyjfe, pn_keypuj,
pn_salmes, pn_salhor, pn_saldia, pn_salint, pn_salivc, pn_salinf, pn_intsin, pn_infsin, pn_varims, pn_varinf,
pn_keyvic, pn_keyest, pn_paddep, pn_hijdep, pn_codniv, pn_pesesp, pn_numniv;
exit when not found; /* apply on cursor1 */
/* the original statement block */
insert into congelada_rh2000(mes_keyano, mes_keymes, mes_keycia, mes_keyper, mes_keypro, mes_keyemp, mes_keypue,mes_status,mes_fecing,
mes_fecrei, mes_fecbaj, mes_fecaum, mes_keyloc, mes_forpag, mes_numpza, mes_cveaum, mes_keydep, mes_keycen, mes_deprep,
mes_ccdsup, mes_keyjfe, mes_keypuj, mes_salmes, mes_salhor, mes_saldia, mes_salint, mes_salivc, mes_salinf, mes_intsin,
mes_infsin, mes_varims, mes_varinf, mes_keyvic, mes_keyest, mes_paddep, mes_hijdep, mes_codniv, mes_pesesp, mes_numniv)
values (        ws_anio,   ws_mes,    pn_keycia, pn_keyper, pn_keypro, pn_keyemp, pn_keypue, pn_status, pn_fecing,
pn_fecrei, pn_fecbaj, pn_fecaum, pn_keyloc, pn_forpag, pn_numpza, pn_cveaum, pn_keydep, pn_keycen, pn_deprep,
pn_ccdsup, pn_keyjfe, pn_keypuj, pn_salmes, pn_salhor, pn_saldia, pn_salint, pn_salivc, pn_salinf, pn_intsin,
pn_infsin, pn_varims, pn_varinf, pn_keyvic, pn_keyest, pn_paddep, pn_hijdep, pn_codniv, pn_pesesp, pn_numniv);
wn_contreg := wn_contreg + 1;
end loop;
close cursor1;
total := wn_contreg;
--return wn_contreg;
end;
$body$
language plpgsql
;
