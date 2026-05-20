-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table acinterpretacion (
iddimension numeric(38),
tipo numeric(38),
interpretacion varchar(4000)
) server  options(schema 'PPPT', table 'ACINTERPRETACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table acpruebas (
idprueba numeric(38),
prueba varchar(50)
) server  options(schema 'PPPT', table 'ACPRUEBAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table asunto (
idasunto numeric(38),
asunto varchar(255)
) server  options(schema 'PPPT', table 'ASUNTO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table auxiliar (
idauxiliar numeric(38) not null,
id1 numeric(38),
id2 numeric(38),
id3 numeric(38),
id4 numeric(38),
txt1 varchar(50),
txt2 varchar(50),
txt3 varchar(50),
txt4 varchar(50),
txt5 varchar(50),
txt6 varchar(50),
txt7 varchar(50),
txt8 varchar(50),
txt9 varchar(50),
txt10 varchar(50),
txt11 varchar(50),
txt12 varchar(50)
) server  options(schema 'PPPT', table 'AUXILIAR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb1_estenes (
idpais numeric(38) not null,
idfactor numeric(38) not null,
leyenda varchar(50),
orden numeric(38),
c1 numeric(38),
c2 numeric(38),
c3 numeric(38),
c4 numeric(38),
c5 numeric(38),
c6 numeric(38),
c7 numeric(38),
c8 numeric(38),
c9 numeric(38),
c10 numeric(38)
) server  options(schema 'PPPT', table 'BMB1_ESTENES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb1_estenesok (
idpais numeric(38) not null,
idfactor numeric(38) not null,
leyenda varchar(50),
orden numeric(38),
c1 numeric(38),
c2 numeric(38),
c3 numeric(38),
c4 numeric(38),
c5 numeric(38),
c6 numeric(38),
c7 numeric(38),
c8 numeric(38),
c9 numeric(38),
c10 numeric(38)
) server  options(schema 'PPPT', table 'BMB1_ESTENESOK', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb1_factores (
idresultado numeric(38) not null,
resultado varchar(50)
) server  options(schema 'PPPT', table 'BMB1_FACTORES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb1_interpretacion (
idfactor numeric(38) not null,
nivel numeric(38) not null,
interpretacion varchar(255)
) server  options(schema 'PPPT', table 'BMB1_INTERPRETACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb1_pais (
idpais numeric(38) not null,
pais varchar(50)
) server  options(schema 'PPPT', table 'BMB1_PAIS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb1_partea (
idpregunta numeric(38) not null,
pregunta varchar(255),
opcion1 varchar(50),
opcion2 varchar(50),
opcion3 varchar(50),
opcion4 varchar(50)
) server  options(schema 'PPPT', table 'BMB1_PARTEA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb1_parteb1 (
idpregunta numeric(38) not null,
pregunta varchar(255),
opcion1 varchar(100),
opcion2 varchar(100),
opcion3 varchar(100)
) server  options(schema 'PPPT', table 'BMB1_PARTEB1', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb1_parteb2 (
idpregunta numeric(38) not null,
par1 varchar(50),
par2 varchar(50)
) server  options(schema 'PPPT', table 'BMB1_PARTEB2', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb1_percentiles (
idpais numeric(38) not null,
leyenda varchar(100),
punt1 varchar(50),
punt2 varchar(50),
punt3 varchar(50),
punt4 varchar(50),
p1 numeric(38),
p2 numeric(38),
p3 numeric(38),
p4 numeric(38),
p5 numeric(38),
p6 numeric(38),
p7 numeric(38),
p8 numeric(38),
p9 numeric(38),
p10 numeric(38),
p11 numeric(38),
p12 numeric(38),
p13 numeric(38),
p14 numeric(38),
p15 numeric(38),
p16 numeric(38),
p17 numeric(38),
p18 numeric(38),
p19 numeric(38),
p20 numeric(38),
p21 numeric(38),
p22 numeric(38)
) server  options(schema 'PPPT', table 'BMB1_PERCENTILES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb1_personaldatos (
idpersonal numeric(38) not null,
idpais numeric(38) not null,
idregion numeric(38),
agencia varchar(100),
ubicacion varchar(100)
) server  options(schema 'PPPT', table 'BMB1_PERSONALDATOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb1_personalresultados (
idpersonal numeric(38) not null,
semejanzas numeric(38),
vocabulario numeric(38),
aritmetica numeric(38),
a numeric(38),
i numeric(38),
m numeric(38),
q1 numeric(38),
responsabilidad numeric(38),
ventas numeric(38),
totala numeric(38),
totalb numeric(38),
total numeric(38)
) server  options(schema 'PPPT', table 'BMB1_PERSONALRESULTADOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb1_plantillas (
idresultados numeric(38) not null,
idparte numeric(38) not null,
idpregunta numeric(38) not null,
correcta1 numeric(38),
correcta2 numeric(38)
) server  options(schema 'PPPT', table 'BMB1_PLANTILLAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb1_regiones (
idregion numeric(38) not null,
region varchar(50)
) server  options(schema 'PPPT', table 'BMB1_REGIONES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb1_resvendedor (
idpersonal numeric(38) not null,
fecha timestamp(0) not null,
partea varchar(90),
parteb varchar(113),
status numeric(38)
) server  options(schema 'PPPT', table 'BMB1_RESVENDEDOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb2_estenes (
idpruebaabc numeric(38) not null,
idx1 numeric(38),
idx2 numeric(38),
idx3 numeric(38),
idx4 numeric(38),
idx5 numeric(38),
idx6 numeric(38),
idx7 numeric(38),
idx8 numeric(38),
idx9 numeric(38),
idx10 numeric(38)
) server  options(schema 'PPPT', table 'BMB2_ESTENES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb2_personalresultados (
idpersonal numeric(38) not null,
idpruebaabc numeric(38) not null,
idxresultados numeric(38) not null,
valor numeric
) server  options(schema 'PPPT', table 'BMB2_PERSONALRESULTADOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table bmb2_pruebasabc (
idpruebaabc numeric(38) not null,
nombre varchar(50)
) server  options(schema 'PPPT', table 'BMB2_PRUEBASABC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table capcurso (
idcurso numeric(38) not null,
curso varchar(100) not null,
duracion numeric(38) not null,
cupo numeric(38) not null,
frecuencia numeric(38) not null,
costopersonatipo numeric(38) not null,
costopersonavalor numeric not null,
costopersonaobs varchar(255),
contacto varchar(255),
idempresa numeric(38) not null,
descripcion varchar(4000),
objetivo varchar(4000)
) server  options(schema 'PPPT', table 'CAPCURSO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table capcursorequisito (
idcurso numeric(38) not null,
idcursorequerido numeric(38) not null
) server  options(schema 'PPPT', table 'CAPCURSOREQUISITO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table capcursotipo (
idcurso numeric(38) not null,
idtipocurso numeric(38) not null
) server  options(schema 'PPPT', table 'CAPCURSOTIPO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table capinstitucion (
idinstitucion numeric(38) not null,
institucion varchar(100) not null,
idempresa numeric(38) not null
) server  options(schema 'PPPT', table 'CAPINSTITUCION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table capinstructor (
idinstructor numeric(38) not null,
instructor varchar(100) not null,
telefonos varchar(100),
email varchar(100),
titulo varchar(100),
idempresa numeric(38) not null
) server  options(schema 'PPPT', table 'CAPINSTRUCTOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table cappuestocurso (
idpuesto numeric(38) not null,
idcurso numeric(38) not null
) server  options(schema 'PPPT', table 'CAPPUESTOCURSO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table captipocurso (
idtipocurso numeric(38) not null,
tipocurso varchar(100) not null,
idempresa numeric(38) not null
) server  options(schema 'PPPT', table 'CAPTIPOCURSO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catarea (
idarea numeric(38) not null,
area varchar(200),
idempresa numeric(38) not null
) server  options(schema 'PPPT', table 'CATAREA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catareainteres (
idareainteres numeric(38) not null,
areainteres varchar(50)
) server  options(schema 'PPPT', table 'CATAREAINTERES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catcentrocostos (
idcentrocostos numeric(38) not null,
centrocostos varchar(100) not null,
idseccion numeric(38) not null,
idempresa numeric(38) not null
) server  options(schema 'PPPT', table 'CATCENTROCOSTOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catcompetencias360 (
idcompetencia numeric(38) not null,
competencia varchar(255),
tipo numeric(38),
definicion varchar(4000),
idempresa numeric(38),
inactiva numeric(1)
) server  options(schema 'PPPT', table 'CATCOMPETENCIAS360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catconductasobs360 (
idconducta numeric(38) not null,
idcompetencia numeric(38),
peso numeric(38),
conducta varchar(255),
cursos varchar(4000),
niveles numeric(38)
) server  options(schema 'PPPT', table 'CATCONDUCTASOBS360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catcursos360 (
idcurso numeric(38) not null,
curso varchar(255) not null,
interno numeric(38),
duracion numeric(38),
temario varchar(4000)
) server  options(schema 'PPPT', table 'CATCURSOS360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catdepartamento (
iddepartamento numeric(38) not null,
departamento varchar(100) not null,
idarea numeric(38),
idempresa numeric(38)
) server  options(schema 'PPPT', table 'CATDEPARTAMENTO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catdimension (
iddimension numeric(38) not null,
dimension varchar(100),
iddimensiontipo numeric(38)
) server  options(schema 'PPPT', table 'CATDIMENSION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catdimensiontipo (
iddimensiontipo numeric(38) not null,
dimensiontipo varchar(100)
) server  options(schema 'PPPT', table 'CATDIMENSIONTIPO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catempresa360 (
idempresa numeric(38) not null,
nombre varchar(100),
mision varchar(4000),
vision varchar(4000),
valores varchar(4000),
objetivos varchar(4000)
) server  options(schema 'PPPT', table 'CATEMPRESA360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catescolaridad (
idescolaridad numeric(38) not null,
escolaridad varchar(50),
especialidad numeric(38),
nivel numeric(38)
) server  options(schema 'PPPT', table 'CATESCOLARIDAD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catespecialidad (
idespecialidad numeric(38) not null,
especialidad varchar(50)
) server  options(schema 'PPPT', table 'CATESPECIALIDAD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catexperiencia (
idexperiencia numeric(38) not null,
experiencia varchar(50)
) server  options(schema 'PPPT', table 'CATEXPERIENCIA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catexpfuncional (
idexpfuncional numeric(38) not null,
expfuncional varchar(50)
) server  options(schema 'PPPT', table 'CATEXPFUNCIONAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table cathabilidad (
idhabilidad numeric(38) not null,
habilidad varchar(100),
idhabilidadtipo numeric(38),
idprueba numeric(38)
) server  options(schema 'PPPT', table 'CATHABILIDAD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table cathabilidadtipo (
idhabilidadtipo numeric(38) not null,
habilidadtipo varchar(100)
) server  options(schema 'PPPT', table 'CATHABILIDADTIPO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catseccion (
idseccion numeric(38) not null,
seccion varchar(100) not null,
idempresa numeric(38) not null
) server  options(schema 'PPPT', table 'CATSECCION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table catsucursal (
idsucursal numeric(38) not null,
sucursal varchar(100),
idexterno numeric(38) not null
) server  options(schema 'PPPT', table 'CATSUCURSAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table comparacion (
idcomparacion numeric(38) not null,
npuestos numeric(38)
) server  options(schema 'PPPT', table 'COMPARACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table comparacionpersonal (
idcomparacion numeric(38) not null,
idpersonal numeric(38) not null,
idpuesto0 numeric,
idpuesto1 numeric,
idpuesto2 numeric,
idpuesto3 numeric,
idpuesto4 numeric,
idpuesto5 numeric,
idpuesto6 numeric,
idpuesto7 numeric,
idpuesto8 numeric,
idpuesto9 numeric
) server  options(schema 'PPPT', table 'COMPARACIONPERSONAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table comparacionpuesto (
idcomparacion numeric(38) not null,
idpuesto numeric(38) not null
) server  options(schema 'PPPT', table 'COMPARACIONPUESTO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table comparacionpuestotxt (
idcomparacion numeric(38) not null,
puesto1 varchar(50),
puesto2 varchar(50),
puesto3 varchar(50),
puesto4 varchar(50),
puesto5 varchar(50),
puesto6 varchar(50),
puesto7 varchar(50),
puesto8 varchar(50),
puesto9 varchar(50),
puesto10 varchar(50)
) server  options(schema 'PPPT', table 'COMPARACIONPUESTOTXT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table compatibilidad (
idpersonal numeric(38) not null,
idpuesto numeric(38) not null,
wais numeric,
therman numeric,
spranger numeric,
herman numeric,
cleaver numeric,
lifo numeric,
experiencia numeric,
escolaridad numeric,
total numeric,
eval360 numeric,
ingles numeric,
ho numeric,
ac numeric,
ortografia numeric,
ppv numeric,
co numeric,
intrac numeric,
eq numeric,
vtasabb numeric,
bmb_cm numeric,
bmb_hm numeric,
iw numeric,
lidsit numeric,
competencias numeric,
competencias0 numeric,
competencias1 numeric,
competencias2 numeric,
word numeric,
excel numeric,
ttcmi numeric
) server  options(schema 'PPPT', table 'COMPATIBILIDAD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table compatibilidadcompetencias (
idpersona numeric(38) not null,
idperfil numeric(38) not null,
idcompetencia numeric(38) not null,
compatibilidad0 numeric not null,
compatibilidad1 numeric not null,
compatibilidad2 numeric not null
) server  options(schema 'PPPT', table 'COMPATIBILIDADCOMPETENCIAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table compatibilidadnivelperfil (
idpersona numeric(38) not null,
idnivel numeric(38) not null,
idempresa numeric(38) not null,
compatibilidad0 numeric not null,
compatibilidad1 numeric not null,
compatibilidad2 numeric not null
) server  options(schema 'PPPT', table 'COMPATIBILIDADNIVELPERFIL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table conductacurso360 (
idconducta numeric(38),
idcurso numeric(38)
) server  options(schema 'PPPT', table 'CONDUCTACURSO360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table conductanivel360 (
idconducta numeric(38) not null,
nivel numeric(38) not null
) server  options(schema 'PPPT', table 'CONDUCTANIVEL360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table configuracion (
idconfig numeric(38),
logo bytea,
icono bytea,
version varchar(50)
) server  options(schema 'PPPT', table 'CONFIGURACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table consulta (
idconsulta numeric(38) not null,
consulta varchar(255) not null,
sql varchar(4000)
) server  options(schema 'PPPT', table 'CONSULTA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table consultapersona (
idconsulta numeric(38) not null,
idpersonal numeric(38) not null
) server  options(schema 'PPPT', table 'CONSULTAPERSONA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table co_acciones (
idaccion numeric(38) not null,
accion varchar(255),
responsable varchar(255),
avance numeric(38),
inicio timestamp(0),
fin timestamp(0),
status numeric(38),
alta timestamp(0)
) server  options(schema 'PPPT', table 'CO_ACCIONES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table co_caracteristica (
idcaracteristica numeric(38) not null,
caracteristica varchar(100),
descripcion varchar(100),
idgrupo numeric(38)
) server  options(schema 'PPPT', table 'CO_CARACTERISTICA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table co_comentariorep (
idcomentariorep numeric(38) not null,
comentariorep varchar(255),
tipo numeric(38)
) server  options(schema 'PPPT', table 'CO_COMENTARIOREP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table co_comentarios (
idcomentario numeric(38) not null,
comentario varchar(255),
idcomentariorep numeric(38),
tipo numeric(38)
) server  options(schema 'PPPT', table 'CO_COMENTARIOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table co_grupos (
idgrupo numeric(38) not null,
grupo varchar(100)
) server  options(schema 'PPPT', table 'CO_GRUPOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table co_personalcomentario (
idpersonalcomentario numeric(38) not null,
idpersonal numeric(38),
idcomentario numeric(38),
anio numeric(38),
tipo numeric(38)
) server  options(schema 'PPPT', table 'CO_PERSONALCOMENTARIO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table co_personalestadistica (
idpersonal numeric(38) not null,
anio numeric(38) not null,
valor1 numeric not null,
valor2 numeric not null
) server  options(schema 'PPPT', table 'CO_PERSONALESTADISTICA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table co_personalpregunta (
idpersonal numeric(38) not null,
idcaracteristica numeric(38) not null,
idpregunta numeric(38) not null,
anio numeric(38) not null,
valor numeric(38),
valor2 numeric(38),
status numeric(38)
) server  options(schema 'PPPT', table 'CO_PERSONALPREGUNTA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table co_pregunta (
idcaracteristica numeric(38) not null,
idpregunta numeric(38) not null,
pregunta varchar(255),
negativo varchar(255),
accion varchar(255)
) server  options(schema 'PPPT', table 'CO_PREGUNTA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table co_status (
idstatus numeric(38) not null,
status varchar(50)
) server  options(schema 'PPPT', table 'CO_STATUS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table dbmodulos (
idmodulo numeric(38) not null,
modulo varchar(50),
tipomodulo numeric(38),
activo numeric(38)
) server  options(schema 'PPPT', table 'DBMODULOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table dbpermisos (
idusuario numeric(38) not null,
idmodulo numeric(38) not null
) server  options(schema 'PPPT', table 'DBPERMISOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table dbusuarios (
idusuario numeric(38) not null,
usuario varchar(50),
"password" varchar(20),
admin numeric(38),
activo numeric(38),
readonly numeric(38),
filtropersonas varchar(4000)
) server  options(schema 'PPPT', table 'DBUSUARIOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table dimension (
iddimension numeric(38),
dimension varchar(50)
) server  options(schema 'PPPT', table 'DIMENSION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table dimensionasunto (
iddimension numeric(38),
idasunto numeric(38),
valor numeric(38)
) server  options(schema 'PPPT', table 'DIMENSIONASUNTO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table dimensionp (
iddimensionp numeric(38),
dimensionp varchar(50)
) server  options(schema 'PPPT', table 'DIMENSIONP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table eccompetencianivel (
idcompetencia numeric(38) not null,
nivel numeric(38) not null,
titulo char(150),
descripcion varchar(4000)
) server  options(schema 'PPPT', table 'ECCOMPETENCIANIVEL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table eccompetenciapregunta (
idcompetenciapregunta numeric(38) not null,
idcompetencia numeric(38) not null,
nivel numeric(38) not null,
pregunta varchar(4000) not null
) server  options(schema 'PPPT', table 'ECCOMPETENCIAPREGUNTA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table ecpersonacompetencia (
identrevista numeric(38) not null,
idcompetencia numeric(38) not null,
nivel numeric(38) not null,
resultado numeric not null,
compatibilidad numeric not null,
comentarios varchar(4000)
) server  options(schema 'PPPT', table 'ECPERSONACOMPETENCIA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table ecpersonapregunta (
idpersonapregunta numeric(38) not null,
identrevista numeric(38) not null,
idcompetencia numeric(38) not null,
nivel numeric(38) not null,
respuesta numeric(38),
pregunta varchar(4000)
) server  options(schema 'PPPT', table 'ECPERSONAPREGUNTA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table ecpersonapuesto (
identrevista numeric(38) not null,
idpersonal numeric(38) not null,
idpuesto numeric(38) not null,
fecha timestamp(0) not null,
resultado numeric not null,
compatibilidad numeric not null,
entrevistador varchar(100),
comentarios varchar(4000)
) server  options(schema 'PPPT', table 'ECPERSONAPUESTO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table ecpuestocompetencianivel (
idpuesto numeric(38) not null,
idcompetencia numeric(38) not null,
nivel numeric(38) not null,
npnivel numeric(38),
npinferior numeric(38),
npsuperior numeric(38)
) server  options(schema 'PPPT', table 'ECPUESTOCOMPETENCIANIVEL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table ecpuestocompetenciapregunta (
idpuestopregunta numeric(38) not null,
idpuesto numeric(38) not null,
idcompetenciapregunta numeric(38) not null
) server  options(schema 'PPPT', table 'ECPUESTOCOMPETENCIAPREGUNTA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table entidadevaluacion360 (
idgrupoentidad numeric(38) not null,
idparametroevaluacion numeric(38) not null,
tipoevaluacion numeric(38) not null,
identidad1 numeric(38) not null,
identidad2 numeric(38) not null,
status numeric(38),
valor numeric(38)
) server  options(schema 'PPPT', table 'ENTIDADEVALUACION360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table escala (
idescala numeric(38),
iddimension numeric(38),
rango numeric(38),
valor numeric(38)
) server  options(schema 'PPPT', table 'ESCALA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table escolaridad (
idpersonal numeric(38) not null,
grado numeric(38) not null,
especialidad numeric(38) not null,
escuela varchar(50),
ubicacion varchar(50),
titulo numeric(38),
de numeric(38),
a numeric(38),
actual numeric(38)
) server  options(schema 'PPPT', table 'ESCOLARIDAD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table estructura (
idestructura numeric(38) not null,
estructura varchar(100) not null,
idestructuranivel numeric(38) not null,
idestructurapadre numeric(38) not null,
clave varchar(50),
idempresa numeric(38) not null
) server  options(schema 'PPPT', table 'ESTRUCTURA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table estructuranivel (
idestructuranivel numeric(38) not null,
estructuranivel varchar(50) not null,
nivel numeric(38) not null,
usaclave numeric(38) not null,
idempresa numeric(38) not null
) server  options(schema 'PPPT', table 'ESTRUCTURANIVEL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table evacatopcion (
idopcion numeric(38) not null,
idpregunta numeric(38) not null,
puntos numeric(38) not null,
opcion varchar(4000) not null
) server  options(schema 'PPPT', table 'EVACATOPCION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table evacatpregunta (
idpregunta numeric(38) not null,
idempresa numeric(38) not null,
idtema numeric(38) not null,
idcompetencia numeric(38) not null,
nivel numeric(38) not null,
activa numeric(1) not null,
casignada numeric(38) not null,
pregunta varchar(4000) not null
) server  options(schema 'PPPT', table 'EVACATPREGUNTA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table evacattema (
idtema numeric(38) not null,
tema varchar(100) not null,
idempresa numeric(38) not null
) server  options(schema 'PPPT', table 'EVACATTEMA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table evalpersona (
idpersonaevaluacion numeric(38) not null,
idpersona numeric(38) not null,
idevaluacion numeric(38) not null,
fecha timestamp(0) not null,
calificacion numeric not null,
minutos numeric(38) not null,
status numeric(38) not null,
baprobado numeric(1) not null
) server  options(schema 'PPPT', table 'EVALPERSONA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table evalpersonapregunta (
idpersonaevaluacion numeric(38) not null,
idpregunta numeric(38) not null,
idseccion numeric(38) not null,
idopcion numeric(38) not null
) server  options(schema 'PPPT', table 'EVALPERSONAPREGUNTA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table evalpregunta (
idseccion numeric(38) not null,
idpregunta numeric(38) not null
) server  options(schema 'PPPT', table 'EVALPREGUNTA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table evalpuesto (
idpuesto numeric(38) not null,
idevaluacion numeric(38) not null
) server  options(schema 'PPPT', table 'EVALPUESTO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table evalseccion (
idseccion numeric(38) not null,
seccion varchar(100) not null,
idevaluacion numeric(38) not null,
numpreguntas numeric(38) not null,
pesoseccion numeric(38) not null,
maxminutos numeric(38) not null,
idtema numeric(38) not null,
idcompetencia numeric(38) not null,
nivel numeric(38) not null,
ordenseccion numeric(38) not null,
bshownombre numeric(1) not null,
bshowintro numeric(1) not null,
introduccion varchar(4000)
) server  options(schema 'PPPT', table 'EVALSECCION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table evaluacion (
idevaluacion numeric(38) not null,
evaluacion varchar(100) not null,
idempresa numeric(38) not null,
mincalificacion numeric(38) not null,
maxminutos numeric(38) not null,
activa numeric(1) not null,
ordenpreguntas numeric(38) not null,
modopreguntas numeric(38) not null,
modocalificacion numeric(38) not null,
navegacion numeric(38) not null,
bmustanswer numeric(1) not null,
bshowcal numeric(1) not null,
brevision numeric(1) not null,
bshowintro numeric(1) not null,
introduccion varchar(4000)
) server  options(schema 'PPPT', table 'EVALUACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table exp_catalogo (
idcatalogo numeric(38) not null,
catalogo varchar(50) not null,
id varchar(50) not null,
nombre varchar(50) not null
) server  options(schema 'PPPT', table 'EXP_CATALOGO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table exp_tablas (
idcatalogo numeric(38) not null,
tipo numeric(38) not null,
tabla varchar(50) not null,
id varchar(50) not null
) server  options(schema 'PPPT', table 'EXP_TABLAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table grupo360 (
idgrupo numeric(38) not null,
tipo numeric(38),
tipoevaluacion numeric(38),
perfil numeric(38),
pesojefe numeric(38),
pesopares numeric(38),
pesosubordinados numeric(38),
pesoclientes numeric(38),
status numeric(38),
fecha timestamp(0),
nombre varchar(50),
nivel numeric(38),
pesoclientesexternos numeric(38),
pesoautoevaluacion numeric(38)
) server  options(schema 'PPPT', table 'GRUPO360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table grupocompetenciaevaluador360 (
idgrupo numeric(38) not null,
tipoentidad numeric(38) not null,
idcompetencia numeric(38) not null,
nivel numeric(38) not null
) server  options(schema 'PPPT', table 'GRUPOCOMPETENCIAEVALUADOR360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table grupoentidad360 (
idgrupoentidad numeric(38) not null,
idgrupo numeric(38),
identidad numeric(38),
peso numeric(38),
tipoentidad numeric(38),
status numeric(38),
idrelacion numeric(38)
) server  options(schema 'PPPT', table 'GRUPOENTIDAD360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table grupoentidadestadisticas360 (
idgrupo numeric(38) not null,
tipoentidad numeric(38) not null,
idcompetencia numeric(38) not null,
idpersonal numeric(38) not null,
desvstd numeric not null,
moda numeric not null,
media numeric not null
) server  options(schema 'PPPT', table 'GRUPOENTIDADESTADISTICAS360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table grupoentidadpregunta360 (
idgrupoentidad numeric(38) not null,
idevaluado numeric(38) not null,
idpregunta numeric(38) not null,
respuesta varchar(4000) not null
) server  options(schema 'PPPT', table 'GRUPOENTIDADPREGUNTA360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table grupoentidadrelacion360 (
idgrupoentidadeval numeric(38) not null,
idgrupoentidadpar numeric(38) not null
) server  options(schema 'PPPT', table 'GRUPOENTIDADRELACION360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table hhempresa (
idempresa numeric(38) not null,
empresa varchar(255) not null,
contacto varchar(255),
emailcontacto varchar(50),
tel varchar(50),
notas varchar(4000)
) server  options(schema 'PPPT', table 'HHEMPRESA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table hhpersonalfechas (
idpersonal numeric(38) not null,
fecharegistro timestamp(0),
fechaupdate timestamp(0)
) server  options(schema 'PPPT', table 'HHPERSONALFECHAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table human (
idreporte numeric(38) not null,
idpersonal numeric(38),
idpuesto numeric(38),
cd varchar(50),
ci varchar(50),
cs varchar(50),
cc varchar(50),
cv varchar(50),
ccor varchar(50),
ha varchar(50),
hl varchar(50),
hi varchar(50),
hv varchar(50),
hcor varchar(50),
ld varchar(50),
lm varchar(50),
la varchar(50),
lt varchar(50),
lcor varchar(50),
vt varchar(50),
ve varchar(50),
va varchar(50),
vs varchar(50),
vp varchar(50),
vr varchar(50),
vcor varchar(50),
win numeric(38),
wco numeric(38),
war numeric(38),
wse numeric(38),
wre numeric(38),
wvo numeric(38),
wcl numeric(38),
wfi numeric(38),
wdi numeric(38),
wor numeric(38),
wcm numeric(38),
wci numeric(38),
t1 varchar(50),
t2 varchar(50),
t3 varchar(50),
t4 varchar(50),
t5 varchar(50),
t6 varchar(50),
t7 varchar(50),
t8 varchar(50),
t9 varchar(50),
t10 varchar(50),
tci varchar(50),
tca varchar(50)
) server  options(schema 'PPPT', table 'HUMAN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table idiomas (
idpersonal numeric(38) not null,
idioma varchar(50) not null,
dominio numeric,
cursos varchar(50)
) server  options(schema 'PPPT', table 'IDIOMAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table interpretacion (
idinterpretacion numeric(38) not null,
idprueba numeric(38),
patron varchar(10),
nombre varchar(50),
tipo numeric(38),
interpretacion varchar(4000)
) server  options(schema 'PPPT', table 'INTERPRETACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table int_competencias (
idcompetencia numeric(38) not null,
competencia varchar(50)
) server  options(schema 'PPPT', table 'INT_COMPETENCIAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table int_interpretacion (
idcompetencia numeric(38) not null,
idprueba numeric(38) not null,
resultado varchar(10) not null,
interpretacion varchar(4000)
) server  options(schema 'PPPT', table 'INT_INTERPRETACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table it_interpretacion (
ci numeric(38) not null,
interpretacion varchar(100),
interpretacionppp varchar(50),
interpretacioncorta varchar(50)
) server  options(schema 'PPPT', table 'IT_INTERPRETACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table it_puntajes (
puntaje numeric(38) not null,
ci numeric(38)
) server  options(schema 'PPPT', table 'IT_PUNTAJES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table laboral (
idpersonal numeric(38) not null,
empresa varchar(50),
giro varchar(50),
domicilio varchar(50),
telefono varchar(50),
puesto varchar(50),
funcion numeric(38),
jefeinmediato varchar(50),
sueldo numeric,
sueldof numeric,
de timestamp(0) not null,
a timestamp(0)
) server  options(schema 'PPPT', table 'LABORAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table matrizcompetencias (
idcompetencia numeric(38) not null,
idprueba numeric(38) not null,
dominancia varchar(10) not null
) server  options(schema 'PPPT', table 'MATRIZCOMPETENCIAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table nivelperfil (
idnivel numeric(38) not null,
nivel varchar(255) not null,
minimo numeric not null,
maximo numeric not null
) server  options(schema 'PPPT', table 'NIVELPERFIL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table nivelperfilcompetencia (
idempresa numeric(38) not null,
idnivel numeric(38) not null,
idcompetencia numeric(38) not null
) server  options(schema 'PPPT', table 'NIVELPERFILCOMPETENCIA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personadimension (
idpersonal numeric(38),
iddimension numeric(38),
idprueba numeric(38),
valor numeric
) server  options(schema 'PPPT', table 'PERSONADIMENSION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personal (
idpersonal numeric(38) not null,
clave varchar(15),
apellidopaterno varchar(50),
apellidomaterno varchar(50),
nombres varchar(50),
nombre varchar(50),
referenciado varchar(50),
ultimaevaluacion timestamp(0),
sueldopretendido numeric,
curp varchar(50),
sexo numeric(38),
edocivil numeric(38),
dob timestamp(0),
puesto numeric(38),
area varchar(50),
rfc varchar(50),
imss varchar(50),
calle varchar(50),
numero varchar(50),
edificio varchar(50),
depto varchar(50),
colonia varchar(50),
ciudad varchar(50),
estado varchar(50),
cp varchar(50),
tel1 varchar(50),
tel2 varchar(50),
lugarnac varchar(50),
nacionalidad varchar(50),
padre varchar(50),
telpadre varchar(50),
edadpadre timestamp(0),
ocupacionpadre varchar(50),
vivepadre numeric(38),
madre varchar(50),
telmadre varchar(50),
edadmadre timestamp(0),
ocupacionmadre varchar(50),
vivemadre numeric(38),
conyuge varchar(50),
telconyuge varchar(50),
edadconyuge timestamp(0),
ocupacionconyuge varchar(50),
viveconyuge numeric(38),
viajar numeric(38),
residencia numeric(38),
diestro numeric(38),
idarea numeric(38),
prefijo varchar(15),
folio numeric(38),
email varchar(50),
idsucursal numeric(38),
idexterno numeric(38)
) server  options(schema 'PPPT', table 'PERSONAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalareainteres (
idpersonal numeric(38) not null,
idareainteres numeric(38) not null
) server  options(schema 'PPPT', table 'PERSONALAREAINTERES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalcompetencias (
idpersonal numeric(38) not null,
idcompetencia numeric(38) not null,
valor0 numeric not null,
valor1 numeric not null,
valor2 numeric not null,
porcentaje0 numeric,
porcentaje1 numeric,
porcentaje2 numeric
) server  options(schema 'PPPT', table 'PERSONALCOMPETENCIAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalcontador (
id numeric(38) not null,
contador numeric(38),
incremento numeric(38),
crc varchar(25),
fecha timestamp(0)
) server  options(schema 'PPPT', table 'PERSONALCONTADOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalcontadorx (
id numeric(38),
contador numeric(38),
incremento numeric(38),
crc varchar(25),
fecha timestamp(0)
) server  options(schema 'PPPT', table 'PERSONALCONTADORX', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalevaluacion360 (
idpersonal numeric(38) not null,
idgrupo numeric(38) not null,
idgrupoentidad numeric(38) not null,
idcompetencia numeric(38) not null,
jefe numeric(38),
pares numeric(38),
subordinados numeric(38),
clientes numeric(38),
clientesexternos numeric(38),
autoevaluacion numeric(38),
idconducta numeric(38) not null
) server  options(schema 'PPPT', table 'PERSONALEVALUACION360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalevaluaciones (
idpersonal numeric(38) not null,
cd numeric,
ci numeric,
cs numeric,
cc numeric,
cd0 numeric,
ci0 numeric,
cs0 numeric,
cc0 numeric,
cd1 numeric,
ci1 numeric,
cs1 numeric,
cc1 numeric,
cd2 numeric,
ci2 numeric,
cs2 numeric,
cc2 numeric,
vt numeric,
ve numeric,
va numeric,
vs numeric,
vp numeric,
vr numeric,
ha numeric,
hl numeric,
hi numeric,
hv numeric,
lad numeric,
lda numeric,
ltm numeric,
lmt numeric,
t1 numeric,
t2 numeric,
t3 numeric,
t4 numeric,
t5 numeric,
t6 numeric,
t7 numeric,
t8 numeric,
t9 numeric,
t10 numeric,
t11 numeric,
tci numeric,
winf numeric,
wcom numeric,
wari numeric,
wsem numeric,
wret numeric,
wvoc numeric,
wcla numeric,
wfig numeric,
wcub numeric,
wdib numeric,
wobj numeric,
wciv numeric,
wcie numeric,
wcit numeric,
vj numeric
) server  options(schema 'PPPT', table 'PERSONALEVALUACIONES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalexpfuncional (
idpersonal numeric(38) not null,
idexpfuncional numeric(38) not null
) server  options(schema 'PPPT', table 'PERSONALEXPFUNCIONAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalhabilidad (
idpersonal numeric(38) not null,
idhabilidad numeric(38) not null,
dominio numeric,
comentario varchar(250)
) server  options(schema 'PPPT', table 'PERSONALHABILIDAD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalhh (
idpersonal numeric(38) not null,
idedocivil numeric(38),
tel3 varchar(50),
tel4 varchar(50),
idpais numeric(38),
idciudad numeric(38),
idestado numeric(38),
sbm numeric,
bono numeric,
aguinaldo numeric,
reparto numeric,
fondoahorro numeric,
gastoscol numeric,
vacaciones numeric,
primavac numeric,
valesdesp numeric,
otros numeric,
acciones numeric(1),
segurovida numeric(1),
seguroac numeric(1),
segurogm numeric(1),
automovil numeric(1),
automovilma varchar(50),
opcioncompra numeric(1),
gastosauto numeric(1),
fecharegistro timestamp(0),
idformacontacto numeric(38),
gastosv numeric,
sueldodeseado numeric(38),
idcalificativo numeric(38),
habilidades varchar(4000),
notaspersonales varchar(4000),
tlqqcynsdp varchar(4000) not null
) server  options(schema 'PPPT', table 'PERSONALHH', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalhijos (
idhijo numeric(38) not null,
idpersonal numeric(38),
nombre varchar(50),
sexo numeric(38),
dob timestamp(0),
ocupacion varchar(50)
) server  options(schema 'PPPT', table 'PERSONALHIJOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalho (
idpersonal numeric(38) not null,
idpregunta numeric(38) not null,
respuesta numeric(38)
) server  options(schema 'PPPT', table 'PERSONALHO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalinactivo (
idpersonal numeric(38) not null,
fecha timestamp(0)
) server  options(schema 'PPPT', table 'PERSONALINACTIVO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalinterpretacion (
idpersonal numeric(38),
idprueba numeric(38),
idinterpretacion1 numeric(38),
idinterpretacion2 numeric(38),
idinterpretacion3 numeric(38),
idinterpretacion4 numeric(38),
idinterpretacion5 numeric(38),
idinterpretacion6 numeric(38)
) server  options(schema 'PPPT', table 'PERSONALINTERPRETACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalopciones (
idpersonal numeric(38) not null,
idopcion numeric(38) not null,
fecha timestamp(0) not null,
valor numeric(38)
) server  options(schema 'PPPT', table 'PERSONALOPCIONES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalpassword (
idprefijo numeric(38) not null,
folio numeric(38) not null,
"password" varchar(50)
) server  options(schema 'PPPT', table 'PERSONALPASSWORD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalpruebaho (
idpersonal numeric(38) not null,
idprueba numeric(38) not null,
resultado numeric(38),
status numeric(38)
) server  options(schema 'PPPT', table 'PERSONALPRUEBAHO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalpruebapermiso (
idpersonal numeric(38) not null,
idprueba numeric(38) not null
) server  options(schema 'PPPT', table 'PERSONALPRUEBAPERMISO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalpruebas (
idpersonal numeric(38) not null,
idprueba numeric(38) not null,
fecha timestamp(0),
resultado numeric(38),
observaciones varchar(4000)
) server  options(schema 'PPPT', table 'PERSONALPRUEBAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalpruebasnotas (
idpersonal numeric(38) not null,
idprueba numeric(38) not null,
notas varchar(4000)
) server  options(schema 'PPPT', table 'PERSONALPRUEBASNOTAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personalresultado (
idpersonal numeric(38) not null,
idresultado numeric(38) not null,
fecha timestamp(0) not null,
valor numeric
) server  options(schema 'PPPT', table 'PERSONALRESULTADO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personanotas (
idpersona numeric(38),
notas varchar(4000)
) server  options(schema 'PPPT', table 'PERSONANOTAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personapruebah (
idpersonal numeric(38) not null,
idprueba numeric(38) not null,
fecha timestamp(0) not null,
resultados varchar(255)
) server  options(schema 'PPPT', table 'PERSONAPRUEBAH', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table personavalor (
idpersonal numeric(38),
idpregunta numeric(38),
idasunto numeric(38),
valor numeric(38)
) server  options(schema 'PPPT', table 'PERSONAVALOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table plan_table (
statement_id varchar(30),
timestamp timestamp(0),
remarks varchar(80),
operation varchar(30),
options varchar(255),
object_node varchar(128),
object_owner varchar(30),
object_name varchar(30),
object_instance numeric(38),
object_type varchar(30),
optimizer varchar(255),
search_columns numeric,
id numeric(38),
parent_id numeric(38),
position numeric(38),
cost numeric(38),
cardinality numeric(38),
bytes numeric(38),
other_tag varchar(255),
partition_start varchar(255),
partition_stop varchar(255),
partition_id numeric(38),
other text,
distribution varchar(30),
cpu_cost numeric(38),
io_cost numeric(38),
temp_space numeric(38),
access_predicates varchar(4000),
filter_predicates varchar(4000)
) server  options(schema 'PPPT', table 'PLAN_TABLE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table pppajusteoffice (
idprueba numeric(38) not null,
idnivel numeric(38) not null,
porcentaje numeric not null
) server  options(schema 'PPPT', table 'PPPAJUSTEOFFICE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table pppcatalogo (
idcatalogo numeric(38) not null,
catalogo varchar(50) not null,
activo numeric(1),
secuencia numeric(38),
tabla varchar(50),
idfield varchar(50),
nomfield varchar(50),
nomlen numeric(38) not null,
location varchar(250),
descripcion varchar(250),
relacionnoborra varchar(250),
idcatrel numeric(38),
relfield varchar(50),
porempresa numeric(1),
compartir numeric(1),
modempresa numeric(1),
modpersona numeric(1)
) server  options(schema 'PPPT', table 'PPPCATALOGO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table pppempresa (
idempresa numeric(38) not null,
empresa varchar(100)
) server  options(schema 'PPPT', table 'PPPEMPRESA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table pppempresaprueba (
idempresa numeric(38) not null,
idprueba numeric(38) not null,
activa numeric(1)
) server  options(schema 'PPPT', table 'PPPEMPRESAPRUEBA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table pppescalaoffice (
idprueba numeric(38) not null,
tema numeric(38) not null,
nivel numeric(38) not null,
minimo numeric(38) not null,
maximo numeric(38) not null
) server  options(schema 'PPPT', table 'PPPESCALAOFFICE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table pppinfo (
idinfo numeric(38),
valor varchar(255)
) server  options(schema 'PPPT', table 'PPPINFO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table prefijo (
idprefijo numeric(38) not null,
prefijo varchar(15),
numeros numeric(38),
automatico numeric(38)
) server  options(schema 'PPPT', table 'PREFIJO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table pregunta (
idpregunta numeric(38),
pregunta varchar(255),
orden numeric(38),
iddimension numeric(38)
) server  options(schema 'PPPT', table 'PREGUNTA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table preguntas360 (
idpregunta numeric(38) not null,
pregunta varchar(255) not null,
evaluadores varchar(50)
) server  options(schema 'PPPT', table 'PREGUNTAS360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table pruebas (
idprueba numeric(38) not null,
prueba varchar(50),
bincluye numeric(1),
bpondera numeric(1),
bperfila numeric(1),
binterpreta numeric(1),
secuencia numeric(38),
activa numeric(1),
descripcion varchar(4000),
bautoservicio numeric(1)
) server  options(schema 'PPPT', table 'PRUEBAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table pruebastitulos (
idprueba numeric(38) not null,
valor varchar(50) not null,
titulo varchar(255)
) server  options(schema 'PPPT', table 'PRUEBASTITULOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestoactividad360 (
idpuestoactividad numeric(38) not null,
idpuesto numeric(38),
nombre varchar(255),
peso numeric(38),
actividad varchar(4000),
idpuestoobjetivo numeric(38)
) server  options(schema 'PPPT', table 'PUESTOACTIVIDAD360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestocompetencia360 (
idpuesto numeric(38) not null,
idcompetencia numeric(38) not null,
peso numeric(38),
idpuestoactividad numeric(38) not null,
idpuestocompetencia numeric(38) not null
) server  options(schema 'PPPT', table 'PUESTOCOMPETENCIA360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestoconducta360 (
idpuestoconducta numeric(38) not null,
idpuesto numeric(38) not null,
idconducta numeric(38) not null,
peso numeric(38) not null,
idpuestocompetencia numeric(38) not null
) server  options(schema 'PPPT', table 'PUESTOCONDUCTA360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestoescolaridad (
idpuesto numeric(38) not null,
idescolaridad numeric(38) not null,
peso numeric(38)
) server  options(schema 'PPPT', table 'PUESTOESCOLARIDAD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestoespecialidad (
idpuesto numeric(38) not null,
idescolaridad numeric(38) not null,
idespecialidad numeric(38) not null,
peso numeric(38)
) server  options(schema 'PPPT', table 'PUESTOESPECIALIDAD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestoevaluacion (
idpuesto numeric(38) not null,
cd numeric,
ci numeric,
cs numeric,
cc numeric,
vt numeric,
ve numeric,
va numeric,
vs numeric,
vp numeric,
vr numeric,
ha numeric,
hl numeric,
hi numeric,
hv numeric,
lad numeric,
lda numeric,
ltm numeric,
lmt numeric,
t1 numeric,
t2 numeric,
t3 numeric,
t4 numeric,
t5 numeric,
t6 numeric,
t7 numeric,
t8 numeric,
t9 numeric,
t10 numeric,
t11 numeric,
tci numeric,
winf numeric,
wcom numeric,
wari numeric,
wsem numeric,
wret numeric,
wvoc numeric,
wcla numeric,
wfig numeric,
wcub numeric,
wdib numeric,
wobj numeric,
wciv numeric,
wcie numeric,
wcit numeric,
vj numeric
) server  options(schema 'PPPT', table 'PUESTOEVALUACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestoexperiencia (
idpuesto numeric(38) not null,
idexperiencia numeric(38) not null,
peso numeric(38)
) server  options(schema 'PPPT', table 'PUESTOEXPERIENCIA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestointerpretacion (
idpuesto numeric(38),
idprueba numeric(38),
idinterpretacion1 numeric(38),
idinterpretacion2 numeric(38),
idinterpretacion3 numeric(38),
idinterpretacion4 numeric(38),
idinterpretacion5 numeric(38),
idinterpretacion6 numeric(38)
) server  options(schema 'PPPT', table 'PUESTOINTERPRETACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestoobjetivo360 (
idpuestoobjetivo numeric(38) not null,
idpuesto numeric(38),
nombre varchar(255),
peso numeric(38),
indicador numeric,
objetivo varchar(4000)
) server  options(schema 'PPPT', table 'PUESTOOBJETIVO360', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestopruebasgeneral (
idpuesto numeric(38) not null,
idprueba numeric(38) not null,
peso numeric(38)
) server  options(schema 'PPPT', table 'PUESTOPRUEBASGENERAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestopsicometria (
idpuesto numeric(38) not null,
idcompetencia numeric(38) not null,
nivel numeric(38) not null
) server  options(schema 'PPPT', table 'PUESTOPSICOMETRIA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestos (
idpuesto numeric(38) not null,
puesto varchar(150),
nivel numeric(38),
idempresa numeric(38),
bateria numeric(1),
idnivel numeric(38),
notaperfil varchar(4000)
) server  options(schema 'PPPT', table 'PUESTOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestosopciones (
idpuesto numeric(38) not null,
idprueba numeric(38) not null,
idopcion numeric(38) not null,
valor numeric(38)
) server  options(schema 'PPPT', table 'PUESTOSOPCIONES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestospruebas (
idpuestoprueba numeric(38) not null,
idpuesto numeric(38) not null,
idprueba numeric(38) not null,
peso numeric,
observaciones varchar(4000),
aux numeric(38),
opciones varchar(255),
resultado varchar(255),
auxiliar varchar(255),
bdirecto numeric(1)
) server  options(schema 'PPPT', table 'PUESTOSPRUEBAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table puestosresultados (
idpuesto numeric(38) not null,
idprueba numeric(38) not null,
idresultado numeric(38) not null,
valor numeric,
valoraux numeric
) server  options(schema 'PPPT', table 'PUESTOSRESULTADOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table rescleaver (
idpersona numeric(38),
pagina numeric(38),
m1 numeric(38),
m2 numeric(38),
m3 numeric(38),
m4 numeric(38),
m5 numeric(38),
m6 numeric(38),
l1 numeric(38),
l2 numeric(38),
l3 numeric(38),
l4 numeric(38),
l5 numeric(38),
l6 numeric(38),
status numeric(38)
) server  options(schema 'PPPT', table 'RESCLEAVER', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table reseq (
idpersonal numeric(38) not null,
fecha timestamp(0) not null,
status numeric(38),
res1 numeric(38),
res2 numeric(38),
res3 numeric(38),
res4 numeric(38),
res5 numeric(38),
res6 numeric(38),
res7 numeric(38),
res8 numeric(38),
res9 numeric(38),
res10 numeric(38),
res11 numeric(38),
res12 numeric(38),
res13 numeric(38),
res14 numeric(38),
res15 numeric(38),
res16 numeric(38),
res17 numeric(38),
res18 numeric(38),
res19 numeric(38),
res20 numeric(38),
res21 numeric(38)
) server  options(schema 'PPPT', table 'RESEQ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table resherrmann (
idpersona numeric(38),
valores varchar(60),
status numeric(38)
) server  options(schema 'PPPT', table 'RESHERRMANN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table resintrac (
idpersonal numeric(38) not null,
serie1 numeric,
serie2 numeric,
serie3 numeric,
serie4 numeric,
serie5 numeric,
serie6 numeric,
serie7 numeric,
serie8 numeric,
serie9 numeric,
ci numeric(38),
status numeric(38)
) server  options(schema 'PPPT', table 'RESINTRAC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table reslidsit (
idpersonal numeric(38) not null,
respuestas varchar(17),
resultados varchar(20),
status numeric(38)
) server  options(schema 'PPPT', table 'RESLIDSIT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table reslifo (
idpersona numeric(38),
val1 varchar(4),
val2 varchar(4),
val3 varchar(4),
val4 varchar(4),
val5 varchar(4),
val6 varchar(4),
val7 varchar(4),
val8 varchar(4),
val9 varchar(4),
val10 varchar(4),
val11 varchar(4),
val12 varchar(4),
val13 varchar(4),
val14 varchar(4),
val15 varchar(4),
val16 varchar(4),
val17 varchar(4),
val18 varchar(4),
status numeric(38)
) server  options(schema 'PPPT', table 'RESLIFO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table resoffice (
idpersonal numeric(38) not null,
idprueba numeric(38) not null,
fecha timestamp(0) not null,
calificaciones varchar(100) not null,
tiempos varchar(100) not null,
status numeric(38) not null
) server  options(schema 'PPPT', table 'RESOFFICE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table resortografia (
idpersona numeric(38) not null,
aciertos numeric(38),
respuestas varchar(80),
status numeric(38)
) server  options(schema 'PPPT', table 'RESORTOGRAFIA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table resppv (
idpersona numeric(38),
aciertos numeric(38),
respuestas varchar(87),
status numeric(38)
) server  options(schema 'PPPT', table 'RESPPV', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table restherman (
idpersona numeric(38),
serie_i varchar(16),
serie_ii varchar(11),
serie_iii varchar(30),
serie_iv varchar(36),
serie_v_1 numeric,
serie_v_2 numeric,
serie_v_3 numeric,
serie_v_4 numeric,
serie_v_5 numeric,
serie_v_6 numeric,
serie_v_7 numeric,
serie_v_8 numeric,
serie_v_9 numeric,
serie_v_10 numeric,
serie_v_11 numeric,
serie_v_12 numeric,
serie_vi varchar(20),
serie_vii varchar(20),
serie_viii varchar(17),
serie_ix varchar(18),
serie_x_1a varchar(10),
serie_x_1b varchar(10),
serie_x_2a varchar(10),
serie_x_2b varchar(10),
serie_x_3a varchar(10),
serie_x_3b varchar(10),
serie_x_4a varchar(10),
serie_x_4b varchar(10),
serie_x_5a varchar(10),
serie_x_5b varchar(10),
serie_x_6a varchar(10),
serie_x_6b varchar(10),
serie_x_7a varchar(10),
serie_x_7b varchar(10),
serie_x_8a varchar(10),
serie_x_8b varchar(10),
serie_x_9a varchar(10),
serie_x_9b varchar(10),
serie_x_10a varchar(10),
serie_x_10b varchar(10),
serie_x_11a varchar(10),
serie_x_11b varchar(10),
status numeric(38)
) server  options(schema 'PPPT', table 'RESTHERMAN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table resttc (
idpersonal numeric(38) not null,
idprueba numeric(38) not null,
fecha timestamp(0) not null,
respuestas varchar(150) not null,
resultados varchar(150) not null,
status numeric(38) not null,
tiempos varchar(4000) not null
) server  options(schema 'PPPT', table 'RESTTC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table resultadosingles (
idpersonal numeric(38) not null,
aciertos numeric(38),
status numeric(38)
) server  options(schema 'PPPT', table 'RESULTADOSINGLES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table resvalores (
idpersona numeric(38),
reactivo numeric(38),
val1 numeric(38),
val2 numeric(38),
val3 numeric(38),
val4 numeric(38),
val5 numeric(38),
val6 numeric(38),
val7 numeric(38),
status numeric(38)
) server  options(schema 'PPPT', table 'RESVALORES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table reswais (
idpersona numeric(38),
a varchar(29),
b varchar(14),
c varchar(14),
d varchar(13),
e varchar(4),
f varchar(40),
g numeric(38),
h varchar(21),
i varchar(20),
j varchar(16),
k varchar(8),
status numeric(38)
) server  options(schema 'PPPT', table 'RESWAIS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table sexo (
idsexo numeric(38) not null,
sexo varchar(50)
) server  options(schema 'PPPT', table 'SEXO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table sino (
idsino numeric(38) not null,
sino varchar(50)
) server  options(schema 'PPPT', table 'SINO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table testhabop (
idpregunta numeric(38) not null,
prueba numeric(38),
orden numeric(38),
pregunta varchar(255),
opcion1 varchar(255),
opcion2 varchar(255),
opcion3 varchar(255),
opcion4 varchar(255),
correcta numeric(38)
) server  options(schema 'PPPT', table 'TESTHABOP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table testingles (
idpregunta numeric(38) not null,
seccion numeric(38),
orden numeric(38),
idplanteamiento numeric(38),
pregunta varchar(255),
opcion1 varchar(255),
opcion2 varchar(255),
opcion3 varchar(255),
opcion4 varchar(255),
correcta numeric(38)
) server  options(schema 'PPPT', table 'TESTINGLES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table testplanteamiento (
idplanteamiento numeric(38) not null,
planteamiento varchar(4000)
) server  options(schema 'PPPT', table 'TESTPLANTEAMIENTO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table ttccompetencia (
idcompetencia numeric(38) not null,
competencia varchar(150) not null,
definicion varchar(4000) not null,
secuencia numeric(38) not null,
idprueba numeric(38) not null
) server  options(schema 'PPPT', table 'TTCCOMPETENCIA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table ttcestenes (
idprueba numeric(38) not null,
calificacion numeric(38) not null,
minpuntos numeric(38) not null,
maxpuntos numeric(38) not null,
idcompetencia numeric(38) not null
) server  options(schema 'PPPT', table 'TTCESTENES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table ttcopcion (
idopcion numeric(38) not null,
opcion varchar(255) not null,
puntaje numeric(38) not null,
secuencia numeric(38) not null,
idpregunta numeric(38) not null
) server  options(schema 'PPPT', table 'TTCOPCION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table ttcpregunta (
idpregunta numeric(38) not null,
pregunta varchar(4000) not null,
idcompetencia numeric(38) not null,
secuencia numeric(38) not null
) server  options(schema 'PPPT', table 'TTCPREGUNTA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = pppt,oracle,dmap_extension,public;
create foreign  table wais (
tipo numeric(38) not null,
maximo numeric not null,
v17 numeric,
v19 numeric,
v24 numeric,
v34 numeric,
v44 numeric,
v54 numeric,
v64 numeric,
v69 numeric,
v74 numeric,
v999 numeric
) server  options(schema 'PPPT', table 'WAIS', readonly 'true');
