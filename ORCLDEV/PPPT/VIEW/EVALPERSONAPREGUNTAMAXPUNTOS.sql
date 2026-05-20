-- dmap_object_gen_tag : type : view name : evalpersonapreguntamaxpuntos
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "evalpersonapreguntamaxpuntos"  ("idpersonaevaluacion", "idpregunta", "idseccion", "idopcion", "maxpuntos") as select evalpersonapregunta.idpersonaevaluacion,  evalpersonapregunta.idpregunta,  evalpersonapregunta.idseccion,  evalpersonapregunta.idopcion,  max(evacatopcion.puntos) as maxpuntos
from evalpersonapregunta inner join evacatopcion on evalpersonapregunta.idpregunta = evacatopcion.idpregunta
group by evalpersonapregunta.idpregunta, evalpersonapregunta.idpersonaevaluacion, evalpersonapregunta.idseccion,  evalpersonapregunta.idopcion;/* dmap converted statement end */
-- estimed cost of view [ evalpersonapreguntamaxpuntos ]: 1.00;
