-- dmap_object_gen_tag : type : view name : rep_inclocal_vw
set search_path = labprod,oracle,dmap_extension,public;
 /* dmap converted statement start */
create or replace view "rep_inclocal_vw"  ("tie_keyemp", "emp_nomemp", "emp_keypue", "pue_despue", "emp_keycen", "cen_descen", "tie_keypro", "tie_keyper", "tie_keysem", "tie_keycon", "con_descon", "tie_hordob", "tie_impdob", "tie_keyusu") as select tie_keyemp, emp_nomemp, emp_keypue, pue_despue, emp_keycen, cen_descen, tie_keypro, tie_keyper, tie_keysem, tie_keycon, con_descon, tie_hordob, tie_impdob, tie_keyusu
from (
select tie_keyemp,emp_nomemp,emp_keypue,pue_despue,emp_keycen,cen_descen,
tie_keypro,tie_keyper,tie_keysem,tie_keycon,con_descon,tie_hordob,
tie_impdob,tie_keyusu
from labprod.tvlotiee,labprod.nmcoempl,labprod.nmlocenc,labprod.nmloconc,labprod.nmcopues
where tie_keyemp = emp_keyemp
and emp_keycen = cen_keycen
and con_keycon = tie_keycon
and pue_keypue = emp_keypue
and tie_keycon not in ('de')
union all
select inc_keyemp,emp_nomemp,emp_keypue,pue_despue,emp_keycen,cen_descen,
inc_keypro,inc_keyper,inc_keysem,inc_keycon,con_descon,inc_cantid,
inc_import,inc_keyusu
from labprod.tvloincl,labprod.nmcoempl,labprod.nmlocenc,labprod.nmloconc,labprod.nmcopues
where inc_keyemp = emp_keyemp
and emp_keycen = cen_keycen
and con_keycon = inc_keycon
and pue_keypue = emp_keypue
union all
select tie_keyemp,emp_nomemp,emp_keypue,pue_despue,emp_keycen,cen_descen,tie_keypro,tie_keyper,
tie_keysem,'003',con_descon,tie_hortri,    tie_imptri,tie_keyusu
from labprod.tvlotiee,labprod.nmcoempl,labprod.nmlocenc,labprod.nmloconc,labprod.nmcopues
where tie_keyemp = emp_keyemp
and emp_keycen = cen_keycen
and con_keycon = '003'
and pue_keypue = emp_keypue
and tie_keycon in ('002')
) alias2;
 /* dmap converted statement end */
-- estimed cost of view [ rep_inclocal_vw ]: 1.00;
