create or replace procedure usrdrc.dercorp_esc_sema_pkg_set_asunto_pr (pinidempresa numeric, pinidflex numeric, pstidmetarow numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstasunto varchar(3000);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if (pinidflex = 17) then
lstasunto:= 'Poderes Generales';
elsif (pinidflex = 18) then
lstasunto:= 'Poderes Especiales';
elsif (pinidflex = 20) then
lstasunto:= 'Reforma Total de Estatutos';
elsif (pinidflex = 21) then
lstasunto:= 'Reforma Parcial de Estatutos';
elsif (pinidflex = 22) then
lstasunto:= 'Transformacin';
elsif (pinidflex = 23) then
lstasunto:= 'Aprobacin de Ejercicio Social';
elsif (pinidflex = 27) then
lstasunto:= 'Escrituras Otros';
elsif (pinidflex = 28) then
lstasunto:= 'Acta Otros';
elsif (pinidflex = 29) then
lstasunto:= 'Aumento de Capital';
elsif (pinidflex = 30) then
lstasunto:= 'Contrato';
elsif (pinidflex = 31) then
lstasunto:= 'Decreto de Dividendos';
elsif (pinidflex = 32) then
lstasunto:= 'Disminucin de Capital';
elsif (pinidflex = 33) then
lstasunto:= 'Escisin';
elsif (pinidflex = 34) then
lstasunto:= 'Fusin';
elsif (pinidflex = 35) then
lstasunto:= 'Sesin de Consejo';
elsif (pinidflex = 41) then
lstasunto:= 'Comits';
end if;
update dercorp_metatbl_tab set val_c149 = lstasunto
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;end;
$body$
language plpgsql
;
