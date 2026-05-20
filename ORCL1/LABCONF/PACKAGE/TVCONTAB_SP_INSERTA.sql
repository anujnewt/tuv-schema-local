create or replace procedure labconf.tvcontab_sp_inserta (datospf tvcontab_partefija, referencia labconf.nmcodeps.dep_refcon%type, ctaconcepto labconf.nmloconc.con_ctaref%type, seietu labconf.nmloconc.con_porcen%type, impcar labconf.nmlohism.his_import%type, impabo labconf.nmlohism.his_import%type, tipo labconf.tvwkpoli.pol_tipo%type) as $body$
declare
-- pgv moved types start
-- pgv moved types end
cia 			varchar(3);
neg 			varchar(2);
cuenta 		varchar(3);
subcta 		varchar(6);
ccostos		varchar(8);
icia 			varchar(3);
top 			varchar(1);
ietu 			varchar(4);
tot_car 	nmlohism.his_import%type;
tot_abo 	nmlohism.his_import%type;
--dmap conversion comment: global temp variables moved as local temp variables
proceso_temp numeric;
periodo_temp varchar;
nomina_temp numeric;
dr_ciaori_temp varchar;
dr_ciades_temp varchar;
dr_concep_temp varchar;
dr_cta_temp varchar;
dr_scta_temp varchar;
madre_temp numeric;
hija_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'TVCONTAB');
--dmap conversion comment: gtt declaration added
tot_car :=0;
tot_abo :=0;
if impcar < 0 then
tot_abo := (impcar * -1);
else
if impcar > 0 then
tot_car := impcar;
end if;
end if;
if impabo < 0 then
tot_car := (impabo * -1);
else
if impabo > 0 then
tot_abo := impabo;
end if;
end if;
if seietu = '2005' or seietu = '2006' then
ietu := seietu;
else
ietu := '2999';
end if;
if tipo = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'MADRE', 'number', 'N')::numeric then
if upper(oracle.substr(ctaconcepto,1,3)) = 'XXX' then  --cia
cia := oracle.substr(referencia, 1, 3);
else
cia :=  oracle.substr(ctaconcepto, 1, 3);
end if;
if upper(oracle.substr(ctaconcepto,4,2)) = 'XX' then  --negocio
neg := oracle.substr(referencia, 4, 2);
else
neg :=  oracle.substr(ctaconcepto, 4, 2);
end if;
if upper(oracle.substr(ctaconcepto, 6, 3)) = 'XXX' then --cuenta
cuenta := oracle.substr(referencia, 6, 3);
else
cuenta := oracle.substr(ctaconcepto, 6, 3);
end if;
if upper(oracle.substr(ctaconcepto, 9, 6)) = 'XXXXXX' then --sub cuenta
subcta := oracle.substr(referencia, 9, 6);
else
subcta := oracle.substr(ctaconcepto, 9, 6);
end if;
if upper(oracle.substr(ctaconcepto, 15, 8)) = 'XXXXXXXX' then -- ccostos
ccostos := oracle.substr(referencia, 15, 8);
else
ccostos := oracle.substr(ctaconcepto, 15, 8);
end if;
if upper(oracle.substr(ctaconcepto, 23, 3)) = 'XXX' then -- icia
icia := oracle.substr(referencia, 23, 3);
else
icia := oracle.substr(ctaconcepto, 23, 3);
end if;
if upper(oracle.substr(ctaconcepto, 26, 1)) = 'X' then -- top
top := oracle.substr(referencia, 26, 1);
else
top := oracle.substr(ctaconcepto, 26, 1);
end if;
if cia <> '000' and subcta <> '000000' then
insert into labconf.tvwkpoli values (datospf.keyemp, datospf.keypro,
datospf.keycon, datospf.codimp, datospf.descon,
cia, neg, cuenta, subcta, ccostos, icia, top,
ietu, tot_car, tot_abo, datospf.keycia, datospf.keypol,
datospf.cveban, datospf.forpag, datospf.keyben, datospf.comfam, tipo, datospf.fecmov);
end if;
else  --hija
if upper(oracle.substr(ctaconcepto, 1, 3)) = 'XXX' then  --cia
cia := oracle.substr(referencia, 27, 3);
else
cia :=  oracle.substr(ctaconcepto, 1, 3);
end if;
if upper(oracle.substr(ctaconcepto, 4, 2)) = 'XX' then  --negocio
neg := oracle.substr(referencia, 30, 2);
else
neg :=  oracle.substr(ctaconcepto, 4, 2);
end if;
if upper(oracle.substr(ctaconcepto, 6, 3)) = 'XXX' then --cuenta
cuenta := oracle.substr(referencia, 32, 3);
else
cuenta := oracle.substr(ctaconcepto, 6, 3);
end if;
if upper(oracle.substr(ctaconcepto, 9, 6)) = 'XXXXXX' then --sub cuenta
subcta := oracle.substr(referencia, 35, 6);
else
subcta := oracle.substr(ctaconcepto, 9, 6);
end if;
if upper(oracle.substr(ctaconcepto, 15, 8)) = 'XXXXXXXX' then -- ccostos
ccostos := oracle.substr(referencia, 41, 8);
else
ccostos := oracle.substr(ctaconcepto, 15, 8);
end if;
if upper(oracle.substr(ctaconcepto, 23, 3)) = 'XXX' then -- icia
icia := oracle.substr(referencia, 49, 3);
else
icia := oracle.substr(ctaconcepto, 23, 3);
end if;
if upper(oracle.substr(ctaconcepto, 26, 1)) = 'X' then -- top
top := oracle.substr(referencia, 52, 1);
else
top := oracle.substr(ctaconcepto, 26, 1);
end if;
if cia <> '000' and subcta <> '000000' then
insert into labconf.tvwkpoli values (datospf.keyemp, datospf.keypro, datospf.keycon,
datospf.codimp, datospf.descon,
cia, neg, cuenta, subcta, ccostos, icia, top,
ietu, tot_car, tot_abo, datospf.keycia, datospf.keypol,
datospf.cveban, datospf.forpag, datospf.keyben, datospf.comfam, tipo, datospf.fecmov);
end if;
dr_scta_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'DR_SCTA', 'varchar2', 'N')::varchar;
dr_cta_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'DR_CTA', 'varchar2', 'N')::varchar;
-- ---------------------------------------------------------------------------------------------------------
-- eljm -- registro duplicado para cia 522 de empresa hija 019
-- cia para aplicar doble registro		019
-- cve concepto de comisiones					m39
-- cta para afectacion								126
-- scta para afectacion								012002
-- dr_ciaori tvwkpoli.pol_cia%type;  		-- cia origen para aplicar doble registro		019
-- dr_ciades tvwkpoli.pol_cia%type;  		-- cia destino para aplicar doble registro	522
-- dr_concep nmlohism.his_keycon%type; 	-- cve concepto de comisiones					    	m39
-- dr_cta   	tvwkpoli.pol_cta%type;		-- cta para afectacion								      126
-- dr_scta   tvwkpoli.pol_scta%type;  	-- scta para afectacion											012002
if cia = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'DR_CIAORI', 'varchar2', 'N')::varchar then		-- opci compa¿¿¿¿ia hija para aplicar doble registro
if datospf.keycon = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'DR_CONCEP', 'varchar2', 'N')::varchar then  -- opci clave concepto comisiones
insert into labconf.tvwkpoli values (datospf.keyemp, datospf.keypro, datospf.keycon, datospf.codimp, datospf.descon, -- cia,   neg,  cuenta, subcta,  ccostos,    icia,  top,
dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'DR_CIADES', 'varchar2', 'N')::varchar, '01', dr_cta_temp, dr_scta_temp, '00000000', '000', '0', ietu, tot_car, tot_abo, datospf.keycia, datospf.keypol, datospf.cveban, datospf.forpag, datospf.keyben, datospf.comfam, tipo, datospf.fecmov);
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'DR_CTA', 'varchar2',(dr_cta_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'DR_SCTA', 'varchar2',(dr_scta_temp)::text, 'N');
end if;
end if;
-- ---------------------------------------------------------------------------------------------------------
end if;
/* commit; */
end;
$body$
language plpgsql
;
