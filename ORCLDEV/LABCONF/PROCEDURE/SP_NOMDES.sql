create or replace procedure labconf."sp_nomdes"  (ws_cve_des varchar,wn_num_aux numeric,ws_des_cam inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_cve_alf varchar(5);
ws_nom_cam varchar(10);
begin
if (wn_num_aux=1 ) then
begin select pam_folini
into strict ws_nom_cam from glcopams
where pam_keypar = (
select pam_folini from glcopams
where pam_keypar='00'
and pam_cvesec='calnom')
and pam_cvesec='OPCI05';
exception
when no_data_found then
null;
end;
else
begin select pam_folini
into strict ws_nom_cam from glcopams
where pam_keypar = (
select pam_folini from glcopams
where pam_keypar='00'
and pam_cvesec='calnom')
and pam_cvesec='OPCI06';
exception
when no_data_found then
null;
end;
end if;
if ws_nom_cam='emp_keycen' then
begin select cen_descen
into strict ws_des_cam from nmlocenc
where cen_keycen=ws_cve_des;
exception
when no_data_found then
null;
end;
elsif ws_nom_cam='emp_keyloc' then
begin select loc_desloc
into strict ws_des_cam from nmlolocp
where loc_keyloc=ws_cve_des;
exception
when no_data_found then
null;
end;
elsif ws_nom_cam='emp_keyims' then
begin select ims_razsoc
into strict ws_des_cam from nmloimss
where ims_keyims=ws_cve_des;
exception
when no_data_found then
null;
end;
elsif ws_nom_cam='emp_keycat' then
begin select cat_descat
into strict ws_des_cam from nmlocate
where cat_keycat=ws_cve_des;
exception
when no_data_found then
null;
end;
elsif ws_nom_cam='emp_cvezon' then
begin select pam_folini
into strict ws_cve_alf from glcopams
where pam_keypar = (
select pam_folini from glcopams
where pam_keypar='00'
and pam_cvesec='cifdep')
and pam_cvesec='OPCI01';
exception
when no_data_found then
null;
end;
begin select pam_nompar
into strict ws_des_cam from glcopams
where pam_keypar=ws_cve_alf
and pam_cvesec=ws_cve_des;
exception
when no_data_found then
null;
end;
elsif ws_nom_cam='emp_tipemp' then
begin select pam_folini
into strict ws_cve_alf from glcopams
where pam_keypar = (
select pam_folini from glcopams
where pam_keypar='00'
and pam_cvesec='cifdep')
and pam_cvesec='OPCI02';
exception
when no_data_found then
null;
end;
begin select pam_nompar
into strict ws_des_cam from glcopams
where pam_keypar=ws_cve_alf
and pam_cvesec=ws_cve_des;
exception
when no_data_found then
null;
end;
else
ws_des_cam:='no existe descripci?
end if;end;
$body$
language plpgsql
;
