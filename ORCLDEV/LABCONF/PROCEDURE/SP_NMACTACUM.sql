create or replace procedure labconf."sp_nmactacum"  (ws_nom_rep varchar,ws_ide_pcc varchar,wn_key_usu numeric,wn_key_pro numeric,wn_num_mes numeric,ws_cod_acu varchar,wn_ani_oac numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
--insertar en la tabla de acumulados los registros faltantes
insert into nmloacum
select distinct his_keyemp,his_keycon,his_keypro,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,wn_ani_oac
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and per_nummes = wn_num_mes
and his_codacu = ws_cod_acu
and his_keycon in (select ran_keycon from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keycon::text, '') is not null)
and his_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyemp::text, '') is not null)
and not exists (
select acu_keyemp from nmloacum
where acu_keypro =wn_key_pro
and acu_keyemp = his_keyemp
and acu_keycon = his_keycon
and acu_anioac = per_anioa1);
/* commit; */
if wn_num_mes = 1 then
update nmloacum set acu_uniuno =
(
select coalesce(sum(his_cantid),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 1
),
acu_impuno =
(
select coalesce(sum(his_import),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 1
)
where acu_keypro =wn_key_pro
and acu_keycon in (select ran_keycon from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keycon::text, '') is not null)
and acu_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_anioac = wn_ani_oac;
end if;
if wn_num_mes = 2 then
update nmloacum set acu_unidos =
(
select coalesce(sum(his_cantid),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 2
),
acu_impdos =
(
select coalesce(sum(his_import),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 2
)
where acu_keypro =wn_key_pro
and acu_keycon in (select ran_keycon from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keycon::text, '') is not null)
and acu_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_anioac = wn_ani_oac;
end if;
if wn_num_mes = 3  then
update nmloacum set acu_unitre =
(
select coalesce(sum(his_cantid),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 3
),
acu_imptre =
(
select coalesce(sum(his_import),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 3
)
where acu_keypro =wn_key_pro
and acu_keycon in (select ran_keycon from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keycon::text, '') is not null)
and acu_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_anioac = wn_ani_oac;
end if;
if wn_num_mes = 4  then
update nmloacum set acu_unicua =
(
select coalesce(sum(his_cantid),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 4
),
acu_impcua =
(
select coalesce(sum(his_import),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 4
)
where acu_keypro =wn_key_pro
and acu_keycon in (select ran_keycon from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keycon::text, '') is not null)
and acu_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_anioac = wn_ani_oac;
end if;
if wn_num_mes = 5  then
update nmloacum set acu_unicin =
(
select coalesce(sum(his_cantid),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 5
),
acu_impcin =
(
select coalesce(sum(his_import),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 5
)
where acu_keypro =wn_key_pro
and acu_keycon in (select ran_keycon from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keycon::text, '') is not null)
and acu_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_anioac = wn_ani_oac;
end if;
if wn_num_mes = 6  then
update nmloacum set acu_unisei =
(
select coalesce(sum(his_cantid),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 6
),
acu_impsei =
(
select coalesce(sum(his_import),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 6
)
where acu_keypro =wn_key_pro
and acu_keycon in (select ran_keycon from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keycon::text, '') is not null)
and acu_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_anioac = wn_ani_oac;
end if;
if wn_num_mes = 7  then
update nmloacum set acu_unisie =
(
select coalesce(sum(his_cantid),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 7
),
acu_impsie =
(
select coalesce(sum(his_import),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 7
)
where acu_keypro =wn_key_pro
and acu_keycon in (select ran_keycon from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keycon::text, '') is not null)
and acu_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_anioac = wn_ani_oac;
end if;
if wn_num_mes = 8  then
update nmloacum set acu_unioch =
(
select coalesce(sum(his_cantid),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 8
),
acu_impoch =
(
select coalesce(sum(his_import),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 8
)
where acu_keypro =wn_key_pro
and acu_keycon in (select ran_keycon from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keycon::text, '') is not null)
and acu_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_anioac = wn_ani_oac;
end if;
if wn_num_mes = 9  then
update nmloacum set acu_uninue =
(
select coalesce(sum(his_cantid),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 9
),
acu_impnue =
(
select coalesce(sum(his_import),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 9
)
where acu_keypro =wn_key_pro
and acu_keycon in (select ran_keycon from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keycon::text, '') is not null)
and acu_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_anioac = wn_ani_oac;
end if;
if wn_num_mes = 10 then
update nmloacum set acu_unidie =
(
select coalesce(sum(his_cantid),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 10
),
acu_impdie =
(
select coalesce(sum(his_import),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 10
)
where acu_keypro =wn_key_pro
and acu_keycon in (select ran_keycon from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keycon::text, '') is not null)
and acu_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_anioac = wn_ani_oac;
end if;
if wn_num_mes = 11 then
update nmloacum set acu_unionc =
(
select coalesce(sum(his_cantid),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 11
),
acu_imponc =
(
select coalesce(sum(his_import),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 11
)
where acu_keypro =wn_key_pro
and acu_keycon in (select ran_keycon from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keycon::text, '') is not null)
and acu_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_anioac = wn_ani_oac;
end if;
if wn_num_mes = 12 then
update nmloacum set acu_unidoc =
(
select coalesce(sum(his_cantid),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 12
),
acu_impdoc =
(
select coalesce(sum(his_import),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 12
)
where acu_keypro =wn_key_pro
and acu_keycon in (select ran_keycon from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keycon::text, '') is not null)
and acu_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_anioac = wn_ani_oac;
end if;
if wn_num_mes = 13 then
update nmloacum set acu_unitrc =
(
select coalesce(sum(his_cantid),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 13
),
acu_imptrc =
(
select coalesce(sum(his_import),0)
from nmlohism,nmloperi
where his_keypro = per_keypro and his_keyper = per_keyper
and per_keypro = wn_key_pro
and per_anioa1 = wn_ani_oac
and his_codacu = ws_cod_acu
and his_keycon = acu_keycon
and his_keypro = acu_keypro
and his_keyemp = acu_keyemp
and per_nummes = 13
)
where acu_keypro =wn_key_pro
and acu_keycon in (select ran_keycon from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keycon::text, '') is not null)
and acu_keyemp in (select ran_keyemp from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_anioac = wn_ani_oac;
end if;
/* commit; */
end;
$body$
language plpgsql
;
