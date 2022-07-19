create or replace trigger per_empleado_aud_interna
  after insert or update or delete
  on PER_EMPLEADO 
  for each row
  -- Author  : @PabloACespedes \(^u^)/
  -- Created : 19/07/2022 11:07:44
  -- TRG DE AUDITORIA
declare
  l_operacion varchar2(3);
  l_user      varchar2(200);
  l_terminal  varchar2(255);
begin
  <<get_terminal>>
  begin
    select rtrim(machine)||'.'||osuser
      into l_terminal
      from v$session
      where audsid = userenv('sessionid');
  exception
    when others then
      raise_application_error( -20000, sqlerrm );
  end get_terminal;
  
  l_user := nvl(sys_context('APEX$SESSION','APP_USER'),user);

  if inserting or updating then
    case when inserting then
       l_operacion := 'INS';
    else
       l_operacion := 'UPD';
    end case;

    insert into PER_EMPLEADO_jn(jn_user,
                                jn_datetime,
                                jn_operation,
                                jn_terminal,
                                empl_legajo,
                                empl_nombre,
                                empl_dir,
                                empl_localidad,
                                empl_tel,
                                empl_est_civil,
                                empl_sexo,
                                empl_grup_sang,
                                empl_fec_nac,
                                empl_nacionalidad,
                                empl_doc_ident,
                                empl_prof,
                                empl_situacion,
                                empl_instruccion,
                                empl_observa,
                                empl_ape,
                                empl_ruc,
                                empl_fec_ingreso,
                                empl_categ,
                                empl_forma_pago,
                                empl_grupo_pago,
                                empl_cargo,
                                empl_empresa,
                                empl_sucursal,
                                empl_departamento,
                                empl_situacion_ips,
                                empl_paga_ips,
                                empl_nro_seg_social,
                                empl_salario_base,
                                empl_salario_ips,
                                empl_sal_basi_real,
                                empl_plus_objetivo,
                                empl_plus_fijo,
                                empl_ind_anticipos,
                                empl_precio_hnormal,
                                empl_precio_hextra,
                                empl_precio_hnocturna,
                                empl_precio_hdomingo,
                                empl_situacion_escolar,
                                empl_obj_hmes,
                                empl_fec_salida,
                                empl_motivo_salida,
                                empl_hora_entrada,
                                empl_hora_salida,
                                empl_hora_sab_entrada,
                                empl_hora_sab_salida,
                                empl_hora_dom_entrada,
                                empl_hora_dom_salida,
                                empl_turno,
                                empl_fec_emis_cert,
                                empl_codigo_acceso,
                                empl_calc_hr_ext,
                                empl_tiempo_alm,
                                empl_desc_tiemp_alm,
                                empl_tipo_salario,
                                empl_imp_hora_n_d,
                                empl_imp_hora_n_n,
                                empl_imp_hora_e_d,
                                empl_imp_hora_e_n,
                                empl_imp_hora_df_d,
                                empl_imp_hora_df_n,
                                empl_codigo_prov,
                                empl_imp_hora_e_m,
                                empl_bco_pago,
                                empl_nro_cta,
                                empl_mon_pago,
                                empl_cod_operador,
                                empl_paga_irp,
                                empl_porc_irp,
                                empl_email_o365,
                                empl_nro_corp,
                                empl_nro_casillero,
                                empl_vto_periodo_prueba,
                                empl_tipo_seguro,
                                empl_entidad_seguro,
                                empl_inicio_seguro,
                                empl_venc_seguro,
                                empl_costo_seguro,
                                empl_nro_casillero_alfa,
                                empl_doc_area_eeb,
                                empl_doc_area_em,
                                empl_doc_area_adm,
                                empl_doc_area_uni,
                                empl_doc_area_ei,
                                empl_doc_area_mies,
                                empl_ph_adm,
                                empl_ph_mies,
                                empl_ph_ei,
                                empl_ph_eeb,
                                empl_ph_em,
                                empl_ph_of,
                                empl_doc_area_of,
                                empl_departamento_sec,
                                empl_departamento_terc,
                                empl_cod_reloj,
                                empl_cod_cliente,
                                empl_contratado_por,
                                empl_marc_comis_sist,
                                empl_tipo_comis,
                                empl_area_organi,
                                empl_mot_desv,
                                empl_fac_desv,
                                empl_tipo_desv,
                                empl_mar_inducc,
                                empl_tipo_cont,
                                empl_nombre_ad,
                                empl_nro_mtess,
                                empl_cons_marc,
                                empl_marc_entrada,
                                empl_marc_salida,
                                empl_eval_des_marc,
                                empl_ind_hora_extra,
                                empl_grup_comis,
                                empl_cob_efectivo,
                                empl_codigo_chofer,
                                empl_codigo_cli,
                                empl_ind_imp_contrato,
                                empl_login,
                                empl_zafra,
                                empl_imp_plus_salarial,
                                empl_cons_marc_tab,
                                empl_cod_postulante,
                                empl_tipo_trabajador,
                                empl_marc_sist,
                                empl_incluye_tvc,
                                empl_marc_sabado,
                                empl_marc_almuerzo,
                                empl_ctaco_aguinaldo,
                                empl_ctaco_aporte,
                                empl_v_contacto,
                                empl_v_nro_cel,
                                empl_limite_cred,
                                empl_chek_lim_cd,
                                empl_porcentaje,
                                empl_ind_com_trans,
                                empl_ind_viatico,
                                empl_monto_viatico,
                                empl_termino_cont)
                                values(l_user,
                                current_date,
                                l_operacion,
                                l_terminal,
                                :new.empl_legajo,
                                :new.empl_nombre,
                                :new.empl_dir,
                                :new.empl_localidad,
                                :new.empl_tel,
                                :new.empl_est_civil,
                                :new.empl_sexo,
                                :new.empl_grup_sang,
                                :new.empl_fec_nac,
                                :new.empl_nacionalidad,
                                :new.empl_doc_ident,
                                :new.empl_prof,
                                :new.empl_situacion,
                                :new.empl_instruccion,
                                :new.empl_observa,
                                :new.empl_ape,
                                :new.empl_ruc,
                                :new.empl_fec_ingreso,
                                :new.empl_categ,
                                :new.empl_forma_pago,
                                :new.empl_grupo_pago,
                                :new.empl_cargo,
                                :new.empl_empresa,
                                :new.empl_sucursal,
                                :new.empl_departamento,
                                :new.empl_situacion_ips,
                                :new.empl_paga_ips,
                                :new.empl_nro_seg_social,
                                :new.empl_salario_base,
                                :new.empl_salario_ips,
                                :new.empl_sal_basi_real,
                                :new.empl_plus_objetivo,
                                :new.empl_plus_fijo,
                                :new.empl_ind_anticipos,
                                :new.empl_precio_hnormal,
                                :new.empl_precio_hextra,
                                :new.empl_precio_hnocturna,
                                :new.empl_precio_hdomingo,
                                :new.empl_situacion_escolar,
                                :new.empl_obj_hmes,
                                :new.empl_fec_salida,
                                :new.empl_motivo_salida,
                                :new.empl_hora_entrada,
                                :new.empl_hora_salida,
                                :new.empl_hora_sab_entrada,
                                :new.empl_hora_sab_salida,
                                :new.empl_hora_dom_entrada,
                                :new.empl_hora_dom_salida,
                                :new.empl_turno,
                                :new.empl_fec_emis_cert,
                                :new.empl_codigo_acceso,
                                :new.empl_calc_hr_ext,
                                :new.empl_tiempo_alm,
                                :new.empl_desc_tiemp_alm,
                                :new.empl_tipo_salario,
                                :new.empl_imp_hora_n_d,
                                :new.empl_imp_hora_n_n,
                                :new.empl_imp_hora_e_d,
                                :new.empl_imp_hora_e_n,
                                :new.empl_imp_hora_df_d,
                                :new.empl_imp_hora_df_n,
                                :new.empl_codigo_prov,
                                :new.empl_imp_hora_e_m,
                                :new.empl_bco_pago,
                                :new.empl_nro_cta,
                                :new.empl_mon_pago,
                                :new.empl_cod_operador,
                                :new.empl_paga_irp,
                                :new.empl_porc_irp,
                                :new.empl_email_o365,
                                :new.empl_nro_corp,
                                :new.empl_nro_casillero,
                                :new.empl_vto_periodo_prueba,
                                :new.empl_tipo_seguro,
                                :new.empl_entidad_seguro,
                                :new.empl_inicio_seguro,
                                :new.empl_venc_seguro,
                                :new.empl_costo_seguro,
                                :new.empl_nro_casillero_alfa,
                                :new.empl_doc_area_eeb,
                                :new.empl_doc_area_em,
                                :new.empl_doc_area_adm,
                                :new.empl_doc_area_uni,
                                :new.empl_doc_area_ei,
                                :new.empl_doc_area_mies,
                                :new.empl_ph_adm,
                                :new.empl_ph_mies,
                                :new.empl_ph_ei,
                                :new.empl_ph_eeb,
                                :new.empl_ph_em,
                                :new.empl_ph_of,
                                :new.empl_doc_area_of,
                                :new.empl_departamento_sec,
                                :new.empl_departamento_terc,
                                :new.empl_cod_reloj,
                                :new.empl_cod_cliente,
                                :new.empl_contratado_por,
                                :new.empl_marc_comis_sist,
                                :new.empl_tipo_comis,
                                :new.empl_area_organi,
                                :new.empl_mot_desv,
                                :new.empl_fac_desv,
                                :new.empl_tipo_desv,
                                :new.empl_mar_inducc,
                                :new.empl_tipo_cont,
                                :new.empl_nombre_ad,
                                :new.empl_nro_mtess,
                                :new.empl_cons_marc,
                                :new.empl_marc_entrada,
                                :new.empl_marc_salida,
                                :new.empl_eval_des_marc,
                                :new.empl_ind_hora_extra,
                                :new.empl_grup_comis,
                                :new.empl_cob_efectivo,
                                :new.empl_codigo_chofer,
                                :new.empl_codigo_cli,
                                :new.empl_ind_imp_contrato,
                                :new.empl_login,
                                :new.empl_zafra,
                                :new.empl_imp_plus_salarial,
                                :new.empl_cons_marc_tab,
                                :new.empl_cod_postulante,
                                :new.empl_tipo_trabajador,
                                :new.empl_marc_sist,
                                :new.empl_incluye_tvc,
                                :new.empl_marc_sabado,
                                :new.empl_marc_almuerzo,
                                :new.empl_ctaco_aguinaldo,
                                :new.empl_ctaco_aporte,
                                :new.empl_v_contacto,
                                :new.empl_v_nro_cel,
                                :new.empl_limite_cred,
                                :new.empl_chek_lim_cd,
                                :new.empl_porcentaje,
                                :new.empl_ind_com_trans,
                                :new.empl_ind_viatico,
                                :new.empl_monto_viatico,
                                :new.empl_termino_cont);

   elsif deleting then
      l_operacion := 'DEL';
      insert into PER_EMPLEADO_jn(jn_user,
                                jn_datetime,
                                jn_operation,
                                jn_terminal,
                                empl_legajo,
                                empl_nombre,
                                empl_dir,
                                empl_localidad,
                                empl_tel,
                                empl_est_civil,
                                empl_sexo,
                                empl_grup_sang,
                                empl_fec_nac,
                                empl_nacionalidad,
                                empl_doc_ident,
                                empl_prof,
                                empl_situacion,
                                empl_instruccion,
                                empl_observa,
                                empl_ape,
                                empl_ruc,
                                empl_fec_ingreso,
                                empl_categ,
                                empl_forma_pago,
                                empl_grupo_pago,
                                empl_cargo,
                                empl_empresa,
                                empl_sucursal,
                                empl_departamento,
                                empl_situacion_ips,
                                empl_paga_ips,
                                empl_nro_seg_social,
                                empl_salario_base,
                                empl_salario_ips,
                                empl_sal_basi_real,
                                empl_plus_objetivo,
                                empl_plus_fijo,
                                empl_ind_anticipos,
                                empl_precio_hnormal,
                                empl_precio_hextra,
                                empl_precio_hnocturna,
                                empl_precio_hdomingo,
                                empl_situacion_escolar,
                                empl_obj_hmes,
                                empl_fec_salida,
                                empl_motivo_salida,
                                empl_hora_entrada,
                                empl_hora_salida,
                                empl_hora_sab_entrada,
                                empl_hora_sab_salida,
                                empl_hora_dom_entrada,
                                empl_hora_dom_salida,
                                empl_turno,
                                empl_fec_emis_cert,
                                empl_codigo_acceso,
                                empl_calc_hr_ext,
                                empl_tiempo_alm,
                                empl_desc_tiemp_alm,
                                empl_tipo_salario,
                                empl_imp_hora_n_d,
                                empl_imp_hora_n_n,
                                empl_imp_hora_e_d,
                                empl_imp_hora_e_n,
                                empl_imp_hora_df_d,
                                empl_imp_hora_df_n,
                                empl_codigo_prov,
                                empl_imp_hora_e_m,
                                empl_bco_pago,
                                empl_nro_cta,
                                empl_mon_pago,
                                empl_cod_operador,
                                empl_paga_irp,
                                empl_porc_irp,
                                empl_email_o365,
                                empl_nro_corp,
                                empl_nro_casillero,
                                empl_vto_periodo_prueba,
                                empl_tipo_seguro,
                                empl_entidad_seguro,
                                empl_inicio_seguro,
                                empl_venc_seguro,
                                empl_costo_seguro,
                                empl_nro_casillero_alfa,
                                empl_doc_area_eeb,
                                empl_doc_area_em,
                                empl_doc_area_adm,
                                empl_doc_area_uni,
                                empl_doc_area_ei,
                                empl_doc_area_mies,
                                empl_ph_adm,
                                empl_ph_mies,
                                empl_ph_ei,
                                empl_ph_eeb,
                                empl_ph_em,
                                empl_ph_of,
                                empl_doc_area_of,
                                empl_departamento_sec,
                                empl_departamento_terc,
                                empl_cod_reloj,
                                empl_cod_cliente,
                                empl_contratado_por,
                                empl_marc_comis_sist,
                                empl_tipo_comis,
                                empl_area_organi,
                                empl_mot_desv,
                                empl_fac_desv,
                                empl_tipo_desv,
                                empl_mar_inducc,
                                empl_tipo_cont,
                                empl_nombre_ad,
                                empl_nro_mtess,
                                empl_cons_marc,
                                empl_marc_entrada,
                                empl_marc_salida,
                                empl_eval_des_marc,
                                empl_ind_hora_extra,
                                empl_grup_comis,
                                empl_cob_efectivo,
                                empl_codigo_chofer,
                                empl_codigo_cli,
                                empl_ind_imp_contrato,
                                empl_login,
                                empl_zafra,
                                empl_imp_plus_salarial,
                                empl_cons_marc_tab,
                                empl_cod_postulante,
                                empl_tipo_trabajador,
                                empl_marc_sist,
                                empl_incluye_tvc,
                                empl_marc_sabado,
                                empl_marc_almuerzo,
                                empl_ctaco_aguinaldo,
                                empl_ctaco_aporte,
                                empl_v_contacto,
                                empl_v_nro_cel,
                                empl_limite_cred,
                                empl_chek_lim_cd,
                                empl_porcentaje,
                                empl_ind_com_trans,
                                empl_ind_viatico,
                                empl_monto_viatico,
                                empl_termino_cont)
                                values(l_user,
                                current_date,
                                l_operacion,
                                l_terminal,
                                :old.empl_legajo,
                                :old.empl_nombre,
                                :old.empl_dir,
                                :old.empl_localidad,
                                :old.empl_tel,
                                :old.empl_est_civil,
                                :old.empl_sexo,
                                :old.empl_grup_sang,
                                :old.empl_fec_nac,
                                :old.empl_nacionalidad,
                                :old.empl_doc_ident,
                                :old.empl_prof,
                                :old.empl_situacion,
                                :old.empl_instruccion,
                                :old.empl_observa,
                                :old.empl_ape,
                                :old.empl_ruc,
                                :old.empl_fec_ingreso,
                                :old.empl_categ,
                                :old.empl_forma_pago,
                                :old.empl_grupo_pago,
                                :old.empl_cargo,
                                :old.empl_empresa,
                                :old.empl_sucursal,
                                :old.empl_departamento,
                                :old.empl_situacion_ips,
                                :old.empl_paga_ips,
                                :old.empl_nro_seg_social,
                                :old.empl_salario_base,
                                :old.empl_salario_ips,
                                :old.empl_sal_basi_real,
                                :old.empl_plus_objetivo,
                                :old.empl_plus_fijo,
                                :old.empl_ind_anticipos,
                                :old.empl_precio_hnormal,
                                :old.empl_precio_hextra,
                                :old.empl_precio_hnocturna,
                                :old.empl_precio_hdomingo,
                                :old.empl_situacion_escolar,
                                :old.empl_obj_hmes,
                                :old.empl_fec_salida,
                                :old.empl_motivo_salida,
                                :old.empl_hora_entrada,
                                :old.empl_hora_salida,
                                :old.empl_hora_sab_entrada,
                                :old.empl_hora_sab_salida,
                                :old.empl_hora_dom_entrada,
                                :old.empl_hora_dom_salida,
                                :old.empl_turno,
                                :old.empl_fec_emis_cert,
                                :old.empl_codigo_acceso,
                                :old.empl_calc_hr_ext,
                                :old.empl_tiempo_alm,
                                :old.empl_desc_tiemp_alm,
                                :old.empl_tipo_salario,
                                :old.empl_imp_hora_n_d,
                                :old.empl_imp_hora_n_n,
                                :old.empl_imp_hora_e_d,
                                :old.empl_imp_hora_e_n,
                                :old.empl_imp_hora_df_d,
                                :old.empl_imp_hora_df_n,
                                :old.empl_codigo_prov,
                                :old.empl_imp_hora_e_m,
                                :old.empl_bco_pago,
                                :old.empl_nro_cta,
                                :old.empl_mon_pago,
                                :old.empl_cod_operador,
                                :old.empl_paga_irp,
                                :old.empl_porc_irp,
                                :old.empl_email_o365,
                                :old.empl_nro_corp,
                                :old.empl_nro_casillero,
                                :old.empl_vto_periodo_prueba,
                                :old.empl_tipo_seguro,
                                :old.empl_entidad_seguro,
                                :old.empl_inicio_seguro,
                                :old.empl_venc_seguro,
                                :old.empl_costo_seguro,
                                :old.empl_nro_casillero_alfa,
                                :old.empl_doc_area_eeb,
                                :old.empl_doc_area_em,
                                :old.empl_doc_area_adm,
                                :old.empl_doc_area_uni,
                                :old.empl_doc_area_ei,
                                :old.empl_doc_area_mies,
                                :old.empl_ph_adm,
                                :old.empl_ph_mies,
                                :old.empl_ph_ei,
                                :old.empl_ph_eeb,
                                :old.empl_ph_em,
                                :old.empl_ph_of,
                                :old.empl_doc_area_of,
                                :old.empl_departamento_sec,
                                :old.empl_departamento_terc,
                                :old.empl_cod_reloj,
                                :old.empl_cod_cliente,
                                :old.empl_contratado_por,
                                :old.empl_marc_comis_sist,
                                :old.empl_tipo_comis,
                                :old.empl_area_organi,
                                :old.empl_mot_desv,
                                :old.empl_fac_desv,
                                :old.empl_tipo_desv,
                                :old.empl_mar_inducc,
                                :old.empl_tipo_cont,
                                :old.empl_nombre_ad,
                                :old.empl_nro_mtess,
                                :old.empl_cons_marc,
                                :old.empl_marc_entrada,
                                :old.empl_marc_salida,
                                :old.empl_eval_des_marc,
                                :old.empl_ind_hora_extra,
                                :old.empl_grup_comis,
                                :old.empl_cob_efectivo,
                                :old.empl_codigo_chofer,
                                :old.empl_codigo_cli,
                                :old.empl_ind_imp_contrato,
                                :old.empl_login,
                                :old.empl_zafra,
                                :old.empl_imp_plus_salarial,
                                :old.empl_cons_marc_tab,
                                :old.empl_cod_postulante,
                                :old.empl_tipo_trabajador,
                                :old.empl_marc_sist,
                                :old.empl_incluye_tvc,
                                :old.empl_marc_sabado,
                                :old.empl_marc_almuerzo,
                                :old.empl_ctaco_aguinaldo,
                                :old.empl_ctaco_aporte,
                                :old.empl_v_contacto,
                                :old.empl_v_nro_cel,
                                :old.empl_limite_cred,
                                :old.empl_chek_lim_cd,
                                :old.empl_porcentaje,
                                :old.empl_ind_com_trans,
                                :old.empl_ind_viatico,
                                :old.empl_monto_viatico,
                                :old.empl_termino_cont);
   end if;
end per_empleado_aud_interna;
/
