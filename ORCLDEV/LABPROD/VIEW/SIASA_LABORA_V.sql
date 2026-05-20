-- dmap_object_gen_tag : type : view name : siasa_labora_v
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_labora_v"  ("cve_concepto", "importe", "unidad", "inc_keyemp", "inc_keypue", "inc_keycco", "centro_costos_aplicado", "semana", "cve_puesto", "fecha_ingreso", "fecha_baja", "proceso", "periodo", "cct_cd", "peri_ini", "peri_fin", "peri_mes", "fecha_pago", "per_keynom", "pro_diaper", "pro_despro", "concepto", "plaza", "cve_empresa", "nombre_empresa", "no_empleado", "nombre", "centro_costos_origen", "subcuenta", "desc_puesto", "desc_centro_costos_origen", "per_keyper") as select
inc_keycon cve_concepto,
inc_costo importe,
inc_cantid unidad,
inc_keyemp,
inc_keypue,
inc_keycco,
inc_keycen centro_costos_aplicado,
inc_semana semana,
hem_keypue cve_puesto,
hem_fecaux fecha_ingreso,
hem_fecbaj fecha_baja,
hem_keypro proceso,
per_keyper periodo,
hem_keycen cct_cd,
per_fecini peri_ini,
per_fecfin peri_fin,
per_nummes peri_mes,
per_fecpag fecha_pago,
per_keynom,
pro_diaper,
pro_despro,
con_descon concepto,
hal_keyplz plaza,
cia_ca3aux cve_empresa,
cia_descia nombre_empresa,
emp_keyemp no_empleado,
emp_nomemp nombre,
oracle.substr(dep_refcon,  15,  8) centro_costos_origen,
'000000' subcuenta,
pue_despue desc_puesto,
origen.cen_descen desc_centro_costos_origen,
oracle.substr(nmloperi.per_keyper, 1, 4) as "per_keyper"
from labprod.nmlocepro origen, labprod.nmloproc nmloproc, labprod.nmloperi nmloperi, labprod.nmloconc nmloconc, labprod.nmpasinc nmhisinc, labprod.nmlohemp, labprod.nmlocias, labprod.nmcopues, labprod.nmcoempl, labprod.nmcodeps, (select * from labprod.tvlohalt where nullif(hal_keyplz::text, '') is not null) alias2
where (1 = 1) and (nmhisinc.inc_keycon in ('002','003','004','005','008','010','011','021','035','052','053','054','060','062','074','082','086','091','095','301','303','304','384','386','387','C34','C43','C69','C84','D77','D78')) and (nmhisinc.inc_keypro in (3, 8, 77, 81, 5, 60)) and (nmhisinc.inc_keypro = nmloperi.per_keypro) and (nmloperi.per_keyper = nmhisinc.inc_keyper) and (nmhisinc.inc_keypro = nmloproc.pro_keypro) and (nmloconc.con_keycon = nmhisinc.inc_keycon);/* dmap converted statement end */
-- estimed cost of view [ siasa_labora_v ]: 1.00;
