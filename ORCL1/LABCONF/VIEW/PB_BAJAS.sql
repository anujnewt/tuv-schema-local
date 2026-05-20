-- dmap_object_gen_tag : type : view name : pb_bajas
set search_path = labconf,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "pb_bajas"  ("fecha_captura", "keyemp", "nombre", "proceso", "desc_proceso", "ambiente_actual", "fecha_baja", "tipo_baja", "desc_tipobaja", "keyemp_nuevo", "proceso_nuevo", "desc_proceso_nuevo", "ambiente_nuevo", "estatus", "desc_status") as select baj_feccap fecha_captura,
baj_keyemp keyemp,
emp_nomemp nombre,
emp_keypro proceso,
pro.pro_despro desc_proceso,
case when nullif(sepb.pam_cvesec::text,  '') is null then 'TELEVISA' else 'TELECOM' end ambiente_actual,
baj_fecbaj fecha_baja,
baj_cvebaj tipo_baja,
ba.pam_nompar desc_tipobaja,
baj_traemp keyemp_nuevo,
baj_trapro proceso_nuevo,
protra.pro_despro desc_proceso_nuevo,
case when nullif(baj_trapro::text,  '') is null then '' when nullif(sepb2.pam_cvesec::text,  '') is null then 'TELEVISA' else 'TELECOM' end ambiente_nuevo,
baj_status estatus,
case
when baj_status = '1' then 'PRE-BAJA'
when baj_status = '2' then 'BAJA'
when baj_status = '3' then 'CANCELACION PREBAJA'
when baj_status = '4' then 'CANCELACION BAJA'
else 'NO EXISTE DESCRIPCION'
end
desc_status
from labconf.sccobaja
inner join labconf.nmcoempl on baj_keyemp::NUMERIC = emp_keyemp::NUMERIC
inner join labconf.nmloproc pro on emp_keypro::NUMERIC = pro.pro_keypro::NUMERIC
inner join labconf.glcopams ba
on ba.pam_keypar::VARCHAR = 'BA'::VARCHAR and ba.pam_cvesec::VARCHAR = baj_cvebaj::VARCHAR
left join labconf.nmloproc protra on protra.pro_keypro::NUMERIC = baj_trapro::NUMERIC
left join labconf.glcopams sepb
on sepb.pam_keypar::VARCHAR = 'SEPB'::VARCHAR and sepb.pam_cvesec::VARCHAR = emp_keypro::VARCHAR
left join labconf.glcopams sepb2
on sepb2.pam_keypar::VARCHAR = 'SEPB'::VARCHAR and sepb2.pam_cvesec::VARCHAR = baj_trapro::VARCHAR;/* dmap converted statement end */
-- estimed cost of view [ pb_bajas ]: 1.00;
