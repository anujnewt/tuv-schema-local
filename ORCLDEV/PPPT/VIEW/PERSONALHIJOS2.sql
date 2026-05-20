-- dmap_object_gen_tag : type : view name : personalhijos2
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "personalhijos2"  ("idhijo", "idpersonal", "nombre", "sexo", "fecha_nacimiento", "ocupacion") as select personalhijos.idhijo,  personalhijos.idpersonal,  personalhijos.nombre,  sexo.sexo,  personalhijos.dob as fecha_nacimiento,  personalhijos.ocupacion  from personalhijos left join sexo on personalhijos.sexo = sexo.idsexo;/* dmap converted statement end */
-- estimed cost of view [ personalhijos2 ]: 1.00;
