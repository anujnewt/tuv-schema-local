-- dmap_object_gen_tag : type : type name : FECXC.fecxc_divxperiodo_pkg_t_in_list_tab
set search_path = fecxc,oracle,dmap_extension,public;
create type FECXC.fecxc_divxperiodo_pkg_t_in_list_tab as (t_in_list_tab varchar(4000)[]);
/*===============================================================
file name : fecxc_divxperiodo_pkg_pkb
nombre del m?dulo     : fecxc
created date          : 4-ene-2013
author(s)             : iv?n casta?eda loeza
short description     : este paquete contiene los procedures y funciones
necesarias para el llenado de la tabla
fecxc_divxperiodo_tab utilizada para la generaci?n del
reporte de division por periodo
procedures contains   :
fecxc_fill_divxperiodo_pr,
fecxc_fill_divxperiodo_disc_pr
fecxc_fill_divxperiodo_disc_fn,
fecxc_get_months_fn,
fecxc_get_cardinal_fn,
fecxc_get_groupname_fn,
fecxc_get_monthname_fn,
in_list
related documents   : an?lisis y dise?o funcional
=============================================================== */;
