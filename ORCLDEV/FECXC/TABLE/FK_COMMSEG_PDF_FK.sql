-- dmap_object_gen_tag : type : index name : fk_commseg_pdf_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index fk_commseg_pdf_fk on fecxc_det_comm_seg_pdf (id_formato_pdf, id_usuario);
