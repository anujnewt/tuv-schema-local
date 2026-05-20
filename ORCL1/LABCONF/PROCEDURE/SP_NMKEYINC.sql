create or replace procedure labconf."sp_nmkeyinc"  ( wn_sem_ila numeric, ws_key_con varchar, wn_key_pro numeric, wn_key_nom numeric, ws_key_per varchar, wn_key_emp numeric, wn_num_sec numeric, wn_key_inc inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_lon_cve numeric(5);
i          numeric(10);
ws_cve_con varchar(9);
wn_cve_con numeric(10);
ws_cve_pro varchar(10);
wn_cve_pro numeric(10);
ws_cve_nom varchar(10);
wn_cve_nom numeric(10);
ws_cve_per varchar(14);
wn_cve_per numeric(10);
ws_cve_emp varchar(20);
wn_cve_emp numeric(10);
wn_cve_tot numeric(10);
wn_lon_ent numeric(5);
ws_sem_ila varchar(20);
begin
wn_lon_cve := length(ws_key_con);
ws_cve_con:= null;/* dmap converted statement start */
for i in 1..wn_lon_cve loop
ws_cve_con :=  concat(ws_cve_con, to_char(ascii(oracle.substr(ws_key_con,i,1)))) ;/* dmap converted statement end */
end loop;
wn_lon_cve := length(ws_cve_con);
wn_cve_con := 0;
for i in 1..wn_lon_cve loop
wn_cve_con := wn_cve_con + i*(oracle.substr(ws_cve_con,wn_lon_cve + 1 - i,1))::numeric;
end loop;
ws_cve_pro := to_char(wn_key_pro);
wn_lon_cve := length(ws_cve_pro);
wn_cve_pro := 0;
for i in 1..wn_lon_cve loop
wn_cve_pro := wn_cve_pro + i*(oracle.substr(ws_cve_pro,wn_lon_cve + 1 - i,1))::numeric;
end loop;
ws_cve_nom := to_char(wn_key_nom);
wn_lon_cve := length(ws_cve_nom);
wn_cve_nom := 0;
for i in 1..wn_lon_cve loop
wn_cve_nom := wn_cve_nom + i*(oracle.substr(ws_cve_nom,wn_lon_cve + 1 - i,1))::numeric;
end loop;
ws_cve_per := ws_key_per;
wn_lon_cve := length(ws_cve_per);
wn_cve_per := 0;
for i in 1..wn_lon_cve loop
wn_cve_per := wn_cve_per + i*(oracle.substr(ws_cve_per,wn_lon_cve + 1 - i,1))::numeric;
end loop;
ws_cve_emp := to_char(wn_key_emp);
wn_lon_cve := length(ws_cve_emp);
wn_cve_emp := 0;
for i in 1..wn_lon_cve loop
wn_cve_emp := wn_cve_emp + i*(oracle.substr(ws_cve_emp,wn_lon_cve + 1 - i,1))::numeric;
end loop;
ws_sem_ila := to_char(wn_sem_ila + wn_num_sec);/* dmap converted statement start */
wn_cve_tot := wn_cve_emp + ( concat(to_char(wn_cve_pro), to_char(wn_cve_per), to_char(wn_cve_nom))::numeric )  + wn_cve_con;/* dmap converted statement end *//* dmap converted statement start */
wn_lon_ent := length(to_char(floor(( concat(to_char(wn_cve_tot), ws_sem_ila)::numeric)  )));/* dmap converted statement end */
if (wn_lon_ent > 10) then
ws_sem_ila := oracle.substr(ws_sem_ila,wn_lon_ent - 9);
end if;/* dmap converted statement start */
wn_key_inc := ( concat(to_char(wn_cve_tot), ws_sem_ila)::numeric) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
