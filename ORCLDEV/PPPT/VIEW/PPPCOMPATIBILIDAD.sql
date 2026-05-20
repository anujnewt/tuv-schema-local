-- dmap_object_gen_tag : type : view name : pppcompatibilidad
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pppcompatibilidad"  ("idpersona", "idperfil", "compatibilidad", "idpa", "idpb", "idp1", "idp2", "idp4", "idp5", "idp7", "idp6", "idp8", "idp9", "idp11", "idp12", "idp15", "idp16", "idp18", "idp19", "idp20", "idp61", "competencias0", "competencias1", "competencias2") as select     idpersonal as idpersona,  idpuesto as idperfil,  total as compatibilidad,  experiencia as idpa,  escolaridad as idpb,  competencias as idp1,
therman as idp2,  spranger as idp4,  herman as idp5,  cleaver as idp7,  lifo as idp6,  ingles as idp8,  ho as idp9,  ortografia as idp11,  ppv as idp12,
intrac as "idp15",   eq as idp16,   lidsit as idp18,   word as idp19,   excel as idp20,   ttcmi as idp61,   competencias0,   competencias1,   competencias2
from         compatibilidad;/* dmap converted statement end */
-- estimed cost of view [ pppcompatibilidad ]: 1.00;
