create or replace procedure labprod."sp_ubicames"  (vs_cod_acu varchar,vn_uni_dad numeric,vn_imp_ort numeric,wn_key_pro numeric,wn_key_per varchar,acu_uni_uno numeric,acu_uni_dos numeric,acu_uni_tre numeric,acu_uni_cua numeric,acu_uni_cin numeric,acu_uni_sei numeric,acu_uni_sie numeric,acu_uni_och numeric,acu_uni_nue numeric,acu_uni_die numeric,acu_uni_onc numeric,acu_uni_doc numeric,acu_uni_trc numeric,acu_uni_cat numeric,acu_uni_qui numeric,acu_imp_uno numeric,acu_imp_dos numeric,acu_imp_tre numeric,acu_imp_cua numeric,acu_imp_cin numeric,acu_imp_sei numeric,acu_imp_sie numeric,acu_imp_och numeric,acu_imp_nue numeric,acu_imp_die numeric,acu_imp_onc numeric,acu_imp_doc numeric,acu_imp_trc numeric,acu_imp_cat numeric,acu_imp_qui numeric,wn_uni_uno inout numeric,wn_uni_dos inout numeric,wn_uni_tre inout numeric,wn_uni_cua inout numeric,wn_uni_cin inout numeric,wn_uni_sei inout numeric,wn_uni_sie inout numeric,wn_uni_och inout numeric,wn_uni_nue inout numeric,wn_uni_die inout numeric,wn_uni_onc inout numeric,wn_uni_doc inout numeric,wn_uni_trc inout numeric,wn_uni_cat inout numeric,wn_uni_qui inout numeric,wn_imp_uno inout numeric,wn_imp_dos inout numeric,wn_imp_tre inout numeric,wn_imp_cua inout numeric,wn_imp_cin inout numeric,wn_imp_sei inout numeric,wn_imp_sie inout numeric,wn_imp_och inout numeric,wn_imp_nue inout numeric,wn_imp_die inout numeric,wn_imp_onc inout numeric,wn_imp_doc inout numeric,wn_imp_trc inout numeric,wn_imp_cat inout numeric,wn_imp_qui inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_num_mes numeric(5);
wn_acu_dos numeric(5);
wn_acu_tre numeric(5);
wn_acu_cua numeric(5);
wn_mes numeric(5);
begin
wn_uni_uno:=acu_uni_uno;
wn_uni_dos:=acu_uni_dos;
wn_uni_tre:=acu_uni_tre;
wn_uni_cua:=acu_uni_cua;
wn_uni_cin:=acu_uni_cin;
wn_uni_sei:=acu_uni_sei;
wn_uni_sie:=acu_uni_sie;
wn_uni_och:=acu_uni_och;
wn_uni_nue:=acu_uni_nue;
wn_uni_die:=acu_uni_die;
wn_uni_onc:=acu_uni_onc;
wn_uni_doc:=acu_uni_doc;
wn_uni_trc:=acu_uni_trc;
wn_uni_cat:=acu_uni_cat;
wn_uni_qui:=acu_uni_qui;
wn_imp_uno:=acu_imp_uno;
wn_imp_dos:=acu_imp_dos;
wn_imp_tre:=acu_imp_tre;
wn_imp_cua:=acu_imp_cua;
wn_imp_cin:=acu_imp_cin;
wn_imp_sei:=acu_imp_sei;
wn_imp_sie:=acu_imp_sie;
wn_imp_och:=acu_imp_och;
wn_imp_nue:=acu_imp_nue;
wn_imp_die:=acu_imp_die;
wn_imp_onc:=acu_imp_onc;
wn_imp_doc:=acu_imp_doc;
wn_imp_trc:=acu_imp_trc;
wn_imp_cat:=acu_imp_cat;
wn_imp_qui:=acu_imp_qui;
wn_imp_qui:=acu_imp_qui;
begin select per_nummes, per_acudos, per_acutre, per_acucua
into strict wn_num_mes, wn_acu_dos, wn_acu_tre, wn_acu_cua from nmloperi
where per_keypro = wn_key_pro
and per_keyper = wn_key_per;
exception
when no_data_found then
null;
end;
if (vs_cod_acu='ME' ) then
wn_mes:=wn_num_mes;
end if;
if (vs_cod_acu='A2' ) then
wn_mes:=wn_acu_dos;
end if;
if (vs_cod_acu='A3' ) then
wn_mes:=wn_acu_tre;
end if;
if (vs_cod_acu='A4' ) then
wn_mes:=wn_acu_cua;
end if;
if (wn_mes=1 ) then
wn_uni_uno:=(acu_uni_uno+vn_uni_dad);
wn_imp_uno:=(acu_imp_uno +vn_imp_ort);
end if;
if (wn_mes=2 ) then
wn_uni_dos:=(acu_uni_dos+vn_uni_dad);
wn_imp_dos:=(acu_imp_dos+vn_imp_ort);
end if;
if (wn_mes=3 ) then
wn_uni_tre:=(acu_uni_tre+vn_uni_dad);
wn_imp_tre:=(acu_imp_tre +vn_imp_ort);
end if;
if (wn_mes=4 ) then
wn_uni_cua:=(acu_uni_cua+vn_uni_dad);
wn_imp_cua:=(acu_imp_cua +vn_imp_ort);
end if;
if (wn_mes=5 ) then
wn_uni_cin:=(acu_uni_cin+vn_uni_dad);
wn_imp_cin:=(acu_imp_cin +vn_imp_ort);
end if;
if (wn_mes=6 ) then
wn_uni_sei:=(acu_uni_sei+vn_uni_dad);
wn_imp_sei:=(acu_imp_sei +vn_imp_ort);
end if;
if (wn_mes=7 ) then
wn_uni_sie:=(acu_uni_sie+vn_uni_dad);
wn_imp_sie:=(acu_imp_sie +vn_imp_ort);
end if;
if (wn_mes=8 ) then
wn_uni_och:=(acu_uni_och+vn_uni_dad);
wn_imp_och:=(acu_imp_och +vn_imp_ort);
end if;
if (wn_mes=9 ) then
wn_uni_nue:=(acu_uni_nue+vn_uni_dad);
wn_imp_nue:=(acu_imp_nue +vn_imp_ort);
end if;
if (wn_mes=10 ) then
wn_uni_die:=(acu_uni_die+vn_uni_dad);
wn_imp_die:=(acu_imp_die +vn_imp_ort);
end if;
if (wn_mes=11 ) then
wn_uni_onc:=(acu_uni_onc+vn_uni_dad);
wn_imp_onc:=(acu_imp_onc +vn_imp_ort);
end if;
if (wn_mes=12 ) then
wn_uni_doc:=(acu_uni_doc+vn_uni_dad);
wn_imp_doc:=(acu_imp_doc +vn_imp_ort);
end if;
if (wn_mes=13 ) then
wn_uni_tre:=(acu_uni_trc+vn_uni_dad);
wn_imp_tre:=(acu_imp_trc +vn_imp_ort);
end if;
if (wn_mes=14 ) then
wn_uni_cat:=(acu_uni_cat+vn_uni_dad);
wn_imp_cat:=(acu_imp_cat +vn_imp_ort);
end if;
if (wn_mes=15 ) then
wn_uni_qui:=(acu_uni_qui+vn_uni_dad);
wn_imp_qui:=(acu_imp_qui+vn_imp_ort);
end if;end;
$body$
language plpgsql
;
