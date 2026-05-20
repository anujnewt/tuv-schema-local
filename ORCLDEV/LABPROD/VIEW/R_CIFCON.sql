-- dmap_object_gen_tag : type : view name : r_cifcon
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "r_cifcon"  ("rct_keycon", "rct_descon", "rct_keypro", "rct_keyper", "rct_codimp", "rct_diaper", "p3", "p5", "p10", "p12", "p17", "p18", "p28", "p29", "p30", "p31", "p32", "p33", "p34", "p35", "p37", "p38", "p39", "p40", "p44", "p45", "p46", "p47", "p48", "p49", "p51", "p52", "p60", "p66", "p77", "p78", "p79", "p81", "p94", "p95", "p139", "p169", "p248", "p259", "p260", "p261", "p262", "p263", "p264", "p265", "p266", "p267", "p268", "p269", "p270", "p291", "p385", "p386", "p387", "p388", "p389", "p390", "p391", "p392", "p393", "p395", "p396", "p397", "p398", "p399", "p401", "p402", "p403", "p405", "p409", "p410", "p411", "p427", "p434", "p441", "p444", "p537", "p538", "p543", "p545", "p546") as select rct_keycon, rct_descon, rct_keypro, rct_keyper, rct_codimp, rct_diaper, p3, p5, p10, p12, p17, p18, p28, p29, p30, p31, p32, p33, p34, p35, p37, p38, p39, p40, p44, p45, p46, p47, p48, p49, p51, p52, p60, p66, p77, p78, p79, p81, p94, p95, p139, p169, p248, p259, p260, p261, p262, p263, p264, p265, p266, p267, p268, p269, p270, p291, p385, p386, p387, p388, p389, p390, p391, p392, p393, p395, p396, p397, p398, p399, p401, p402, p403, p405, p409, p410, p411, p427, p434, p441, p444, p537, p538, p543, p545, p546
from (
select *
from (
select mov_keycon rct_keycon,
con_descon rct_descon,
mov_keypro rct_keypro,
'P'||mov_keypro rct_despro,
mov_keyper rct_keyper,
mov_codimp rct_codimp,
mov_import rct_import,
pro_diaper rct_diaper
from labprod.nmwkmovt
left join labprod.nmloconc on con_keycon = mov_keycon
left join labprod.nmloproc on pro_keypro = mov_keypro
where 1=1
and mov_keypro
in
(
select * from crosstab (
$$
select 1 as "row_id", pam_cvesec
from labprod.glcopams
where 2=2 and
pam_keypar='CTCO'
group by rct_despro
order by  rct_despro
$$,
$$
values ('P3'), ('P5'), ('P10'), ('P12'), ('P17'), ('P18'), ('P28'), ('P29'), ('P30'), ('P31'), ('P32'), ('P33'), ('P34'), ('P35'), ('P37'), ('P38'), ('P39'), ('P40'), ('P44'), ('P45'), ('P46'), ('P47'), ('P48'), ('P49'), ('P51'), ('P52'), ('P60'), ('P66'), ('P77'), ('P78'), ('P79'), ('P81'), ('P94'), ('P95'), ('P139'), ('P169'), ('P248'), ('P259'), ('P260'), ('P261'), ('P262'), ('P263'), ('P264'), ('P265'), ('P266'), ('P267'), ('P268'), ('P269'), ('P270'), ('P291'), ('P385'), ('P386'), ('P387'), ('P388'), ('P389'), ('P390'), ('P391'), ('P392'), ('P393'), ('P395'), ('P396'), ('P397'), ('P398'), ('P399'), ('P401'), ('P402'), ('P403'), ('P405'), ('P409'), ('P410'), ('P411'), ('P427'), ('P434'), ('P441'), ('P444'), ('P537'), ('P538'), ('P543'), ('P545'), ('P546')
$$
) as ctab (
rct_despro text,
text,
p3 text,
p5 text,
p10 text,
p12 text,
p17 text,
p18 text,
p28 text,
p29 text,
p30 text,
p31 text,
p32 text,
p33 text,
p34 text,
p35 text,
p37 text,
p38 text,
p39 text,
p40 text,
p44 text,
p45 text,
p46 text,
p47 text,
p48 text,
p49 text,
p51 text,
p52 text,
p60 text,
p66 text,
p77 text,
p78 text,
p79 text,
p81 text,
p94 text,
p95 text,
p139 text,
p169 text,
p248 text,
p259 text,
p260 text,
p261 text,
p262 text,
p263 text,
p264 text,
p265 text,
p266 text,
p267 text,
p268 text,
p269 text,
p270 text,
p291 text,
p385 text,
p386 text,
p387 text,
p388 text,
p389 text,
p390 text,
p391 text,
p392 text,
p393 text,
p395 text,
p396 text,
p397 text,
p398 text,
p399 text,
p401 text,
p402 text,
p403 text,
p405 text,
p409 text,
p410 text,
p411 text,
p427 text,
p434 text,
p441 text,
p444 text,
p537 text,
p538 text,
p543 text,
p545 text,
p546 text
)
) q1
) alias5;
-- estimed cost of view [ r_cifcon ]: 1.10;/* dmap converted statement end */
