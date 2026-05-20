-- dmap_object_gen_tag : type : view name : personalexperiencia
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "personalexperiencia"  ("idpersonal", "empresa", "giro", "domicilio", "telefono", "puesto", "funcion", "experiencia", "jefeinmediato", "sueldo", "sueldof", "de", "a") as select laboral.idpersonal,  laboral.empresa,  laboral.giro,  laboral.domicilio,  laboral.telefono,  laboral.puesto,  laboral.funcion,  catexperiencia.experiencia,  laboral.jefeinmediato,  laboral.sueldo,  laboral.sueldof,  laboral.de,  laboral.a  from laboral left join catexperiencia on laboral.funcion = catexperiencia.idexperiencia;/* dmap converted statement end */
-- estimed cost of view [ personalexperiencia ]: 1.00;
