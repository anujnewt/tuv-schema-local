CREATE OR REPLACE FORCE EDITIONABLE VIEW "PPPT"."PPPCOMPATIBILIDAD" ("IDPERSONA", "IDPERFIL", "COMPATIBILIDAD", "IDPA", "IDPB", "IDP1", "IDP2", "IDP4", "IDP5", "IDP7", "IDP6", "IDP8", "IDP9", "IDP11", "IDP12", "IDP15", "IDP16", "IDP18", "IDP19", "IDP20", "IDP61", "COMPETENCIAS0", "COMPETENCIAS1", "COMPETENCIAS2") AS 
  SELECT     IdPersonal AS IdPersona, IdPuesto AS IdPerfil, Total AS Compatibilidad, Experiencia AS IdPA, Escolaridad AS IdPB, Competencias AS IdP1,
                      Therman AS IdP2, Spranger AS IdP4, Herman AS IdP5, Cleaver AS IdP7, LIFO AS IdP6, Ingles AS IdP8, HO AS IdP9, Ortografia AS IdP11, PPV AS IdP12,
                      INTRAC AS IdP15, EQ AS IdP16, LidSit AS IdP18, Word AS IdP19, Excel AS IdP20, TTCMI AS IdP61, Competencias0, Competencias1, Competencias2
FROM         Compatibilidad;
