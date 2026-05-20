CREATE OR REPLACE FORCE EDITIONABLE VIEW "PPPT"."PUESTOEXPERIENCIA2" ("IDPUESTO", "IDEXPERIENCIA", "EXPERIENCIA", "PESO") AS 
  SELECT PuestoExperiencia.IdPuesto, PuestoExperiencia.IdExperiencia, CatExperiencia.Experiencia, PuestoExperiencia.Peso FROM PuestoExperiencia LEFT JOIN CatExperiencia ON PuestoExperiencia.IdExperiencia = CatExperiencia.IdExperiencia;
