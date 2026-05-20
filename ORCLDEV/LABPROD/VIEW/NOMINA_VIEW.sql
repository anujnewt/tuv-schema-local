-- dmap_object_gen_tag : type : view name : nomina_view
set search_path = labprod,oracle,dmap_extension,public;
 /* dmap converted statement start */
create or replace view "nomina_view"  ("empresatelevisa", "descempresatelevisa", "cveubicacion", "descubicacion", "tiponomina", "cveprocesonomina", "descprocesonomina", "numeroempleado", "nombrecompleto", "rfc", "curp", "telefono", "codigopostal", "domicilio", "colonia", "ciudad", "municipio", "descmunicipio", "entidad", "descentidad", "capacidadendeudamiento", "per_keyper", "per_fecini", "per_fecfin", "per_fecpag") as select
pro_keycia empresatelevisa,
cia_descia descempresatelevisa,
emp_keyloc cveubicacion,
loc_desloc descubicacion,
pro_diaper tiponomina,
pro_keypro cveprocesonomina,
pro_despro descprocesonomina,
emp_keyemp numeroempleado,
emp_nomemp nombrecompleto,
emp_regrfc rfc,
emp_recurp curp,
emp_telemp telefono,
emp_codemp codigopostal,
emp_domemp domicilio,
emp_colemp colonia,
emp_cidemp ciudad,
emp_munemp municipio,
a.pam_nompar descmunicipio,
emp_entemp entidad,
b.pam_nompar descentidad,
pde_capnew capacidadendeudamiento,
per_keyper,
per_fecini,
per_fecfin,
per_fecpag
from
nmcoempl,
nmloproc,
nmlocias,
nmlolocp,
glcopams a,
tvcapdes,
glcopams b,
nmloperi
where
emp_keypro     = pro_keypro
and pro_keycia   = cia_keycia
and emp_keyloc   = loc_keyloc
and emp_keyemp   = pde_keyemp
and a.pam_cvesec = emp_munemp
and a.pam_keypar = 'mu'
and b.pam_cvesec = emp_entemp
and b.pam_keypar = 'ef'
and per_keypro   = emp_keypro
and emp_status   = 1
and per_fecpag between statement_timestamp() - interval '7 days' and statement_timestamp() + interval '7 days'
and per_keynom = 1;
 /* dmap converted statement end */
-- estimed cost of view [ nomina_view ]: 1.00;
