CREATE OR REPLACE FORCE EDITIONABLE VIEW "FE_EGRESOS"."JAJA666" ("ORGANIZATION_ID", "NAME", "CLA_FE_ID") AS 
  (SELECT o.organization_id, o.NAME, oi.cla_fe_id
      FROM hr.hr_all_organization_units@erp_prod o,fecxp_org_inv_flujo oi
     WHERE o.organization_id = oi.organization_id);
