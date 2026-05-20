CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "LABPROD"."R_INCLOCGTV" ("TIE_KEYEMP", "EMP_NOMEMP", "EMP_KEYPUE", "PUE_DESPUE", "EMP_KEYCEN", "CEN_DESCEN", "TIE_KEYPRO", "TIE_KEYPER", "TIE_KEYSEM", "TIE_KEYCON", "CON_DESCON", "TIE_HORDOB", "TIE_IMPDOB", "TIE_KEYUSU") AS 
  SELECT "TIE_KEYEMP","EMP_NOMEMP","EMP_KEYPUE","PUE_DESPUE","EMP_KEYCEN","CEN_DESCEN","TIE_KEYPRO","TIE_KEYPER","TIE_KEYSEM","TIE_KEYCON","CON_DESCON","TIE_HORDOB","TIE_IMPDOB","TIE_KEYUSU"
FROM
(
    select TIE_KEYEMP,emp_nomemp,emp_keypue,pue_despue,emp_keycen,cen_descen,
           TIE_KEYPRO,TIE_KEYPER,TIE_KEYSEM,TIE_KEYCON,con_descon,TIE_HORDOB,
           TIE_IMPDOB,TIE_KEYUSU
    from labprod.tvlotiee,LABPROD.nmcoempl,labprod.nmlocenc,LABPROD.nmloconc,LABPROD.nmcopues
    where tie_keyemp = emp_keyemp
    and emp_keycen = cen_keycen
    and con_keycon = tie_keycon
    and pue_keypue = emp_keypue
    and tie_keycon not in('DE')
    union all
    select inc_keyemp,emp_nomemp,emp_keypue,pue_despue,emp_keycen,cen_descen,
           inc_keypro,inc_keyper,inc_keysem,inc_keycon,con_descon,inc_cantid,
           inc_import,inc_keyusu
    from labprod.tvloincl,labprod.nmcoempl,LABPROD.nmlocenc,LABPROD.nmloconc,LABPROD.nmcopues
    where inc_keyemp = emp_keyemp
    and emp_keycen = cen_keycen
    and con_keycon = inc_keycon
    and pue_keypue = emp_keypue
    union all
    select TIE_KEYEMP,emp_nomemp,emp_keypue,pue_despue,emp_keycen,cen_descen,TIE_KEYPRO,TIE_KEYPER,
           TIE_KEYSEM,'003',con_descon,TIE_HORTRI,    TIE_IMPTRI,TIE_KEYUSU
    from labprod.tvlotiee,labprod.nmcoempl,LABPROD.nmlocenc,LABPROD.nmloconc,LABPROD.nmcopues
    where tie_keyemp = emp_keyemp
    and emp_keycen = cen_keycen
    and con_keycon = '003'
    and pue_keypue = emp_keypue
    and tie_keycon in('002')
)
WHERE TIE_KEYPRO NOT IN (SELECT PAM_CVESEC FROM LABPROD.GLCOPAMS WHERE PAM_KEYPAR='CTCO');
