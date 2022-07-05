create or replace procedure PER_TABLERO_JSA(in_fecha date := null) is
 l_fecha date := nvl(in_fecha, sysdate);
 
 co_hilagro   constant number := 1; 
 co_transagro constant number := 1;
begin
 -- cuando es semanal inserta solo SEMANA dejando en NULL MES
 -- cuando es mensual inserta MES dejando en NULL semana  

------------------PRIMERAMENTE ESTARIA GUARDANDO TODO LO QUE ES MENSUAL
  IF TRUNC(l_fecha) = LAST_DAY (TRUNC(l_fecha)) THEN
------------------------------------------HISTORICO DE EMPLEADO
  insert into per_empleado_hist
        (empl_legajo, empl_nombre, empl_dir, empl_localidad, empl_tel, empl_est_civil, empl_sexo, empl_grup_sang, empl_fec_nac, empl_nacionalidad,
         empl_doc_ident, empl_prof, empl_situacion, empl_instruccion, empl_observa, empl_ape, empl_ruc, empl_fec_ingreso, empl_categ, empl_forma_pago,
         empl_grupo_pago, empl_cargo, empl_empresa, empl_sucursal, empl_departamento, empl_situacion_ips, empl_paga_ips, empl_nro_seg_social,
         empl_salario_base, empl_salario_ips, empl_sal_basi_real, empl_plus_objetivo, empl_plus_fijo, empl_ind_anticipos, empl_precio_hnormal,
         empl_precio_hextra, empl_precio_hnocturna, empl_precio_hdomingo, empl_situacion_escolar, empl_obj_hmes, empl_fec_salida, empl_motivo_salida,
         empl_hora_entrada, empl_hora_salida, empl_hora_sab_entrada, empl_hora_sab_salida, empl_hora_dom_entrada, empl_hora_dom_salida, empl_turno,
         empl_fec_emis_cert, empl_codigo_acceso, empl_calc_hr_ext, empl_tiempo_alm, empl_desc_tiemp_alm, empl_tipo_salario, empl_imp_hora_n_d,
         empl_imp_hora_n_n, empl_imp_hora_e_d, empl_imp_hora_e_n, empl_imp_hora_df_d, empl_imp_hora_df_n, empl_codigo_prov, empl_imp_hora_e_m,
         empl_bco_pago, empl_nro_cta, empl_mon_pago, empl_cod_operador, empl_paga_irp, empl_porc_irp, empl_email_o365,
         empl_nro_corp, empl_nro_casillero, empl_vto_periodo_prueba, empl_tipo_seguro, empl_entidad_seguro, empl_inicio_seguro, empl_venc_seguro,
          empl_costo_seguro, empl_nro_casillero_alfa, empl_doc_area_eeb, empl_doc_area_em, empl_doc_area_adm, empl_doc_area_uni, empl_doc_area_ei,
          empl_doc_area_mies, empl_ph_adm, empl_ph_mies, empl_ph_ei, empl_ph_eeb, empl_ph_em, empl_ph_of, empl_doc_area_of, empl_departamento_sec,
          empl_departamento_terc, empl_cod_reloj, empl_cod_cliente, empl_contratado_por, empl_marc_comis_sist, empl_tipo_comis, empl_area_organi,
          empl_mot_desv, empl_fac_desv, empl_tipo_desv, empl_mar_inducc, empl_tipo_cont, empl_nombre_ad, empl_nro_mtess, empl_cons_marc,
          empl_marc_entrada, empl_marc_salida, empl_eval_des_marc, empl_ind_hora_extra, empl_grup_comis, empl_cob_efectivo, empl_codigo_chofer,
          empl_codigo_cli, empl_ind_imp_contrato, empl_login, empl_zafra, empl_imp_plus_salarial, empl_cons_marc_tab, empl_cod_postulante,
          empl_tipo_trabajador, empl_marc_sist, empl_incluye_tvc, empl_marc_sabado,
          mes,
          area_desc,
          semana,
          anho)
  select empl_legajo, empl_nombre, empl_dir, empl_localidad, empl_tel, empl_est_civil, empl_sexo, empl_grup_sang, empl_fec_nac, empl_nacionalidad,
         empl_doc_ident, empl_prof, empl_situacion, empl_instruccion, empl_observa, empl_ape, empl_ruc, empl_fec_ingreso, empl_categ, empl_forma_pago,
         empl_grupo_pago, empl_cargo, empl_empresa, empl_sucursal, empl_departamento, empl_situacion_ips, empl_paga_ips, empl_nro_seg_social,
         empl_salario_base, empl_salario_ips, empl_sal_basi_real, empl_plus_objetivo, empl_plus_fijo, empl_ind_anticipos, empl_precio_hnormal,
         empl_precio_hextra, empl_precio_hnocturna, empl_precio_hdomingo, empl_situacion_escolar, empl_obj_hmes, empl_fec_salida, empl_motivo_salida,
         empl_hora_entrada, empl_hora_salida, empl_hora_sab_entrada, empl_hora_sab_salida, empl_hora_dom_entrada, empl_hora_dom_salida, empl_turno,
          empl_fec_emis_cert, empl_codigo_acceso, empl_calc_hr_ext, empl_tiempo_alm, empl_desc_tiemp_alm, empl_tipo_salario, empl_imp_hora_n_d,
          empl_imp_hora_n_n, empl_imp_hora_e_d, empl_imp_hora_e_n, empl_imp_hora_df_d, empl_imp_hora_df_n, empl_codigo_prov, empl_imp_hora_e_m,
          empl_bco_pago, empl_nro_cta, empl_mon_pago, empl_cod_operador, empl_paga_irp, empl_porc_irp, empl_email_o365,
          empl_nro_corp, empl_nro_casillero, empl_vto_periodo_prueba, empl_tipo_seguro, empl_entidad_seguro, empl_inicio_seguro, empl_venc_seguro,
           empl_costo_seguro, empl_nro_casillero_alfa, empl_doc_area_eeb, empl_doc_area_em, empl_doc_area_adm, empl_doc_area_uni, empl_doc_area_ei,
           empl_doc_area_mies, empl_ph_adm, empl_ph_mies, empl_ph_ei, empl_ph_eeb, empl_ph_em, empl_ph_of, empl_doc_area_of, empl_departamento_sec,
           empl_departamento_terc, empl_cod_reloj, empl_cod_cliente, empl_contratado_por, empl_marc_comis_sist, empl_tipo_comis, empl_area_organi,
           empl_mot_desv, empl_fac_desv, empl_tipo_desv, empl_mar_inducc, empl_tipo_cont, empl_nombre_ad, empl_nro_mtess, empl_cons_marc,
           empl_marc_entrada, empl_marc_salida, empl_eval_des_marc, empl_ind_hora_extra, empl_grup_comis, empl_cob_efectivo, empl_codigo_chofer,
           empl_codigo_cli, empl_ind_imp_contrato, empl_login, empl_zafra, empl_imp_plus_salarial, empl_cons_marc_tab, empl_cod_postulante,
           empl_tipo_trabajador, empl_marc_sist, empl_incluye_tvc, empl_marc_sabado,
           TO_CHAR(TRUNC(l_fecha), 'MM'),
           CASE
                WHEN EMPL_SUCURSAL = 2 THEN
                                 'CDA'
                 WHEN EMPL_DEPARTAMENTO = 1 and (EMPL_AREA_ORGANI not in (8,9) and empl_cargo <> 1)  THEN
                                 'ADM'
                WHEN  EMPL_AREA_ORGANI =8  or  empl_cargo = 1 THEN
                                 'CAPITAL HUMANO'        
                 WHEN  EMPL_AREA_ORGANI =9  then
                                 'GERENCIA DE TI'         
                WHEN (EMPL_DEPARTAMENTO IN(14,22,2,38) OR EMPL_SUCURSAL NOT IN (1,2)) THEN
                                'COMERCIAL'
               ELSE
                               'INDUSTRIAL'
                END,
           null, --SEMANA no
           TO_CHAR(TRUNC(l_fecha), 'YYYY')
           from per_empleado
           where empl_empresa IN (co_hilagro, co_transagro);

  -------------------------------------------HISTORICO DE SELECCION DE PERSONAL

  insert into per_seleccion_personal_hist
        (selper_solici, selper_postul, seleper_empr, seleper_requis_puntaje, seleper_requis_accion, seleper_requis_obs,
        seleper_requis_oper, seleper_requis_estado, seleper_requis_fecha, seleper_perf_accion, seleper_perf_obs,
        seleper_perf_oper, seleper_perf_estado, seleper_perf_fecha, seleper_pres_puntaje, seleper_pres_accion,
        seleper_pres_obs, seleper_pres_oper, seleper_pres_estado, seleper_pres_fecha, seleper_ref_puntaje, seleper_ref_accion,
        seleper_ref_obs, seleper_ref_oper, seleper_ref_estado, seleper_ref_fecha, seleper_ear_puntaje, seleper_ear_accion,
        seleper_ear_obs, seleper_ear_oper, seleper_ear_estado, seleper_ear_fecha, seleper_ear_area_ref, seleper_ees_accion,
        seleper_ees_obs, seleper_ees_oper, seleper_ees_estado, seleper_ees_fecha, seleper_estado_gral, seleper_fecha_estado_gral,
        seleper_etapa_decis_gral, seleper_requis_consid, seleper_ear_operador_enc, seleper_ees_operador_enc, seleper_ear_salar_pro,
        seleper_ees_salar_acord,
        mes,
        semana,
        anho)
  select selper_solici, selper_postul, seleper_empr, seleper_requis_puntaje, seleper_requis_accion, seleper_requis_obs,
         seleper_requis_oper, seleper_requis_estado, seleper_requis_fecha, seleper_perf_accion, seleper_perf_obs,
         seleper_perf_oper, seleper_perf_estado, seleper_perf_fecha, seleper_pres_puntaje, seleper_pres_accion,
         seleper_pres_obs, seleper_pres_oper, seleper_pres_estado, seleper_pres_fecha, seleper_ref_puntaje, seleper_ref_accion,
         seleper_ref_obs, seleper_ref_oper, seleper_ref_estado, seleper_ref_fecha, seleper_ear_puntaje, seleper_ear_accion,
         seleper_ear_obs, seleper_ear_oper, seleper_ear_estado, seleper_ear_fecha, seleper_ear_area_ref, seleper_ees_accion,
         seleper_ees_obs, seleper_ees_oper, seleper_ees_estado, seleper_ees_fecha, seleper_estado_gral, seleper_fecha_estado_gral,
         seleper_etapa_decis_gral, seleper_requis_consid, seleper_ear_operador_enc, seleper_ees_operador_enc, seleper_ear_salar_pro,
         seleper_ees_salar_acord,
         TO_CHAR(TRUNC(l_fecha), 'MM'),
         null, --SEMANA no
         TO_CHAR(TRUNC(l_fecha), 'YYYY')
  from per_seleccion_personal
  WHERE seleper_empr IN (co_hilagro, co_transagro);


  -------------------------------------------HISTORICO DE SOLICITUD DE PERSONAL
insert into per_solicitud_personal_hist
      (solper_clave, solper_empr, solper_fecha_sol, solper_operador_sol, solper_nivel_urgencia, solper_area, solper_cargo,
       solper_cant, solper_estado_aprob, solper_operador_aprob, solper_fecha_aprob, solper_estado_final, solper_obser_aprob,
       solper_obser_sol, solper_tipo_cont, solper_tipo_selec, solper_tipo_contratacion, solper_tipo_dotac, solper_zafra,
       solper_zafra_empl, solper_cont_empl, solper_recontratacion,
       mes,
       anho,
       semana,
       SOLPER_VAC_CUBIERTA,
       SOLPER_SUCURSAL,
       SOLPER_FECHA_CIERRE)
select solper_clave, solper_empr, solper_fecha_sol, solper_operador_sol, solper_nivel_urgencia, solper_area, solper_cargo,
       solper_cant, solper_estado_aprob, solper_operador_aprob, solper_fecha_aprob, solper_estado_final, solper_obser_aprob,
       solper_obser_sol, solper_tipo_cont, solper_tipo_selec, solper_tipo_contratacion, solper_tipo_dotac, solper_zafra,
       solper_zafra_empl, solper_cont_empl, NULL,
       TO_CHAR(TRUNC(l_fecha), 'MM'),
       TO_CHAR(TRUNC(l_fecha), 'YYYY'),
       null, --SEMANA no
       SOLPER_VAC_CUBIERTA,
       SOLPER_SUCURSAL,
       SOLPER_FECHA_CIERRE
       from per_solicitud_personal
       WHERE solper_empr IN (co_hilagro, co_transagro);

   -------------------------------------------HISTORICO DE ENTREVISTA DE PERSONAL
      insert into per_entrevista_personal_hist
            (entper_entrevista, entper_postul, entper_empr, entper_requis_puntaje, entper_requis_accion, entper_requis_obs,
             entper_requis_oper, entper_requis_estado, entper_requis_fecha, entper_perf_accion, entper_perf_obs, entper_perf_oper,
             entper_perf_estado, entper_perf_fecha, entper_pres_puntaje, entper_pres_accion, entper_pres_obs, entper_pres_oper,
             entper_pres_estado, entper_pres_fecha, entper_ref_puntaje, entper_ref_accion, entper_ref_obs, entper_ref_oper,
             entper_ref_estado, entper_ref_fecha, entper_ear_puntaje, entper_ear_accion, entper_ear_obs, entper_ear_oper,
             entper_ear_estado, entper_ear_fecha, entper_ear_area_ref, entper_ees_accion, entper_ees_obs, entper_ees_oper,
             entper_ees_estado, entper_ees_fecha, entper_estado_gral, entper_fecha_estado_gral, entper_etapa_decis_gral,
             entper_requis_consid, entper_ear_operador_enc, entper_ees_operador_enc, entper_ear_salar_pro, entper_ees_salar_acord,
             mes,
             semana,
             anho)
      select entper_entrevista, entper_postul, entper_empr, entper_requis_puntaje, entper_requis_accion, entper_requis_obs,
             entper_requis_oper, entper_requis_estado, entper_requis_fecha, entper_perf_accion, entper_perf_obs, entper_perf_oper,
             entper_perf_estado, entper_perf_fecha, entper_pres_puntaje, entper_pres_accion, entper_pres_obs, entper_pres_oper,
             entper_pres_estado, entper_pres_fecha, entper_ref_puntaje, entper_ref_accion, entper_ref_obs, entper_ref_oper,
             entper_ref_estado, entper_ref_fecha, entper_ear_puntaje, entper_ear_accion, entper_ear_obs, entper_ear_oper,
             entper_ear_estado, entper_ear_fecha, entper_ear_area_ref, entper_ees_accion, entper_ees_obs, entper_ees_oper,
             entper_ees_estado, entper_ees_fecha, entper_estado_gral, entper_fecha_estado_gral, entper_etapa_decis_gral,
             entper_requis_consid, entper_ear_operador_enc, entper_ees_operador_enc, entper_ear_salar_pro, entper_ees_salar_acord,
             TO_CHAR(TRUNC(l_fecha), 'MM'),
             null, --SEMANA no
             TO_CHAR(TRUNC(l_fecha), 'YYYY')
       from per_entrevista_personal
      WHERE entper_empr IN (co_hilagro, co_transagro);



       insert into per_entrevista_post_hist
         (per_ent_codigo, per_ent_postulante, per_ent_empr, per_ent_cargo_ral, per_ent_fecha,
          mes,
          semana,
          anho)
      select per_ent_codigo, per_ent_postulante, per_ent_empr, per_ent_cargo_ral, per_ent_fecha,
          TO_CHAR(TRUNC(l_fecha), 'MM'),
          null, --SEMANA no
          TO_CHAR(TRUNC(l_fecha), 'YYYY')
       from per_entrevista_post
       WHERE per_ent_empr IN (co_hilagro, co_transagro);

  END IF ; --> FIN MENSUAL


  -- INSERTA LO DE LA SEMANA
  IF TO_CHAR(l_fecha, 'DAY', 'NLS_DATE_LANGUAGE=SPANISH') LIKE 'D%'
  THEN

------------------------------------------HISTORICO DE EMPLEADO
  insert into per_empleado_hist
        (empl_legajo, empl_nombre, empl_dir, empl_localidad, empl_tel, empl_est_civil, empl_sexo, empl_grup_sang, empl_fec_nac, empl_nacionalidad,
         empl_doc_ident, empl_prof, empl_situacion, empl_instruccion, empl_observa, empl_ape, empl_ruc, empl_fec_ingreso, empl_categ, empl_forma_pago,
         empl_grupo_pago, empl_cargo, empl_empresa, empl_sucursal, empl_departamento, empl_situacion_ips, empl_paga_ips, empl_nro_seg_social,
         empl_salario_base, empl_salario_ips, empl_sal_basi_real, empl_plus_objetivo, empl_plus_fijo, empl_ind_anticipos, empl_precio_hnormal,
         empl_precio_hextra, empl_precio_hnocturna, empl_precio_hdomingo, empl_situacion_escolar, empl_obj_hmes, empl_fec_salida, empl_motivo_salida,
         empl_hora_entrada, empl_hora_salida, empl_hora_sab_entrada, empl_hora_sab_salida, empl_hora_dom_entrada, empl_hora_dom_salida, empl_turno,
         empl_fec_emis_cert, empl_codigo_acceso, empl_calc_hr_ext, empl_tiempo_alm, empl_desc_tiemp_alm, empl_tipo_salario, empl_imp_hora_n_d,
         empl_imp_hora_n_n, empl_imp_hora_e_d, empl_imp_hora_e_n, empl_imp_hora_df_d, empl_imp_hora_df_n, empl_codigo_prov, empl_imp_hora_e_m,
         empl_bco_pago, empl_nro_cta, empl_mon_pago, empl_cod_operador, empl_paga_irp, empl_porc_irp, empl_email_o365,
         empl_nro_corp, empl_nro_casillero, empl_vto_periodo_prueba, empl_tipo_seguro, empl_entidad_seguro, empl_inicio_seguro, empl_venc_seguro,
          empl_costo_seguro, empl_nro_casillero_alfa, empl_doc_area_eeb, empl_doc_area_em, empl_doc_area_adm, empl_doc_area_uni, empl_doc_area_ei,
          empl_doc_area_mies, empl_ph_adm, empl_ph_mies, empl_ph_ei, empl_ph_eeb, empl_ph_em, empl_ph_of, empl_doc_area_of, empl_departamento_sec,
          empl_departamento_terc, empl_cod_reloj, empl_cod_cliente, empl_contratado_por, empl_marc_comis_sist, empl_tipo_comis, empl_area_organi,
          empl_mot_desv, empl_fac_desv, empl_tipo_desv, empl_mar_inducc, empl_tipo_cont, empl_nombre_ad, empl_nro_mtess, empl_cons_marc,
          empl_marc_entrada, empl_marc_salida, empl_eval_des_marc, empl_ind_hora_extra, empl_grup_comis, empl_cob_efectivo, empl_codigo_chofer,
          empl_codigo_cli, empl_ind_imp_contrato, empl_login, empl_zafra, empl_imp_plus_salarial, empl_cons_marc_tab, empl_cod_postulante,
          empl_tipo_trabajador, empl_marc_sist, empl_incluye_tvc, empl_marc_sabado,
          mes,
          area_desc,
          semana,
          anho)
  select empl_legajo, empl_nombre, empl_dir, empl_localidad, empl_tel, empl_est_civil, empl_sexo, empl_grup_sang, empl_fec_nac, empl_nacionalidad,
         empl_doc_ident, empl_prof, empl_situacion, empl_instruccion, empl_observa, empl_ape, empl_ruc, empl_fec_ingreso, empl_categ, empl_forma_pago,
         empl_grupo_pago, empl_cargo, empl_empresa, empl_sucursal, empl_departamento, empl_situacion_ips, empl_paga_ips, empl_nro_seg_social,
         empl_salario_base, empl_salario_ips, empl_sal_basi_real, empl_plus_objetivo, empl_plus_fijo, empl_ind_anticipos, empl_precio_hnormal,
         empl_precio_hextra, empl_precio_hnocturna, empl_precio_hdomingo, empl_situacion_escolar, empl_obj_hmes, empl_fec_salida, empl_motivo_salida,
         empl_hora_entrada, empl_hora_salida, empl_hora_sab_entrada, empl_hora_sab_salida, empl_hora_dom_entrada, empl_hora_dom_salida, empl_turno,
          empl_fec_emis_cert, empl_codigo_acceso, empl_calc_hr_ext, empl_tiempo_alm, empl_desc_tiemp_alm, empl_tipo_salario, empl_imp_hora_n_d,
          empl_imp_hora_n_n, empl_imp_hora_e_d, empl_imp_hora_e_n, empl_imp_hora_df_d, empl_imp_hora_df_n, empl_codigo_prov, empl_imp_hora_e_m,
          empl_bco_pago, empl_nro_cta, empl_mon_pago, empl_cod_operador, empl_paga_irp, empl_porc_irp, empl_email_o365,
          empl_nro_corp, empl_nro_casillero, empl_vto_periodo_prueba, empl_tipo_seguro, empl_entidad_seguro, empl_inicio_seguro, empl_venc_seguro,
           empl_costo_seguro, empl_nro_casillero_alfa, empl_doc_area_eeb, empl_doc_area_em, empl_doc_area_adm, empl_doc_area_uni, empl_doc_area_ei,
           empl_doc_area_mies, empl_ph_adm, empl_ph_mies, empl_ph_ei, empl_ph_eeb, empl_ph_em, empl_ph_of, empl_doc_area_of, empl_departamento_sec,
           empl_departamento_terc, empl_cod_reloj, empl_cod_cliente, empl_contratado_por, empl_marc_comis_sist, empl_tipo_comis, empl_area_organi,
           empl_mot_desv, empl_fac_desv, empl_tipo_desv, empl_mar_inducc, empl_tipo_cont, empl_nombre_ad, empl_nro_mtess, empl_cons_marc,
           empl_marc_entrada, empl_marc_salida, empl_eval_des_marc, empl_ind_hora_extra, empl_grup_comis, empl_cob_efectivo, empl_codigo_chofer,
           empl_codigo_cli, empl_ind_imp_contrato, empl_login, empl_zafra, empl_imp_plus_salarial, empl_cons_marc_tab, empl_cod_postulante,
           empl_tipo_trabajador, empl_marc_sist, empl_incluye_tvc, empl_marc_sabado,
           null, --MES no
           CASE
                WHEN EMPL_SUCURSAL = 2 THEN
                                 'CDA'
                 WHEN EMPL_DEPARTAMENTO = 1 and (EMPL_AREA_ORGANI not in (9,8) and empl_cargo <> 1)  THEN
                                 'ADM'
                WHEN  EMPL_AREA_ORGANI =8  or  empl_cargo = 1 THEN
                                 'CAPITAL HUMANO'   
                WHEN  EMPL_AREA_ORGANI =9  then
                                 'GERENCIA DE TI'                  
                WHEN (EMPL_DEPARTAMENTO IN(14,22,2,38) OR EMPL_SUCURSAL NOT IN (1,2)) THEN
                                'COMERCIAL'
               ELSE
                               'INDUSTRIAL'
                END,
           TO_CHAR(TRUNC(l_fecha), 'IW'),
           TO_CHAR(TRUNC(l_fecha), 'YYYY')
           from per_empleado
           where empl_empresa IN (co_hilagro, co_transagro);

  -------------------------------------------HISTORICO DE SELECCION DE PERSONAL

  insert into per_seleccion_personal_hist
        (selper_solici, selper_postul, seleper_empr, seleper_requis_puntaje, seleper_requis_accion, seleper_requis_obs,
        seleper_requis_oper, seleper_requis_estado, seleper_requis_fecha, seleper_perf_accion, seleper_perf_obs,
        seleper_perf_oper, seleper_perf_estado, seleper_perf_fecha, seleper_pres_puntaje, seleper_pres_accion,
        seleper_pres_obs, seleper_pres_oper, seleper_pres_estado, seleper_pres_fecha, seleper_ref_puntaje, seleper_ref_accion,
        seleper_ref_obs, seleper_ref_oper, seleper_ref_estado, seleper_ref_fecha, seleper_ear_puntaje, seleper_ear_accion,
        seleper_ear_obs, seleper_ear_oper, seleper_ear_estado, seleper_ear_fecha, seleper_ear_area_ref, seleper_ees_accion,
        seleper_ees_obs, seleper_ees_oper, seleper_ees_estado, seleper_ees_fecha, seleper_estado_gral, seleper_fecha_estado_gral,
        seleper_etapa_decis_gral, seleper_requis_consid, seleper_ear_operador_enc, seleper_ees_operador_enc, seleper_ear_salar_pro,
        seleper_ees_salar_acord,
        mes,
        semana,
        anho)
  select selper_solici, selper_postul, seleper_empr, seleper_requis_puntaje, seleper_requis_accion, seleper_requis_obs,
         seleper_requis_oper, seleper_requis_estado, seleper_requis_fecha, seleper_perf_accion, seleper_perf_obs,
         seleper_perf_oper, seleper_perf_estado, seleper_perf_fecha, seleper_pres_puntaje, seleper_pres_accion,
         seleper_pres_obs, seleper_pres_oper, seleper_pres_estado, seleper_pres_fecha, seleper_ref_puntaje, seleper_ref_accion,
         seleper_ref_obs, seleper_ref_oper, seleper_ref_estado, seleper_ref_fecha, seleper_ear_puntaje, seleper_ear_accion,
         seleper_ear_obs, seleper_ear_oper, seleper_ear_estado, seleper_ear_fecha, seleper_ear_area_ref, seleper_ees_accion,
         seleper_ees_obs, seleper_ees_oper, seleper_ees_estado, seleper_ees_fecha, seleper_estado_gral, seleper_fecha_estado_gral,
         seleper_etapa_decis_gral, seleper_requis_consid, seleper_ear_operador_enc, seleper_ees_operador_enc, seleper_ear_salar_pro,
         seleper_ees_salar_acord,
         null, --MES no
         TO_CHAR(TRUNC(l_fecha), 'IW'),
         TO_CHAR(TRUNC(l_fecha), 'YYYY')
  from per_seleccion_personal
  WHERE seleper_empr IN (co_hilagro, co_transagro);


  -------------------------------------------HISTORICO DE SOLICITUD DE PERSONAL
insert into per_solicitud_personal_hist
      (solper_clave, solper_empr, solper_fecha_sol, solper_operador_sol, solper_nivel_urgencia, solper_area, solper_cargo,
       solper_cant, solper_estado_aprob, solper_operador_aprob, solper_fecha_aprob, solper_estado_final, solper_obser_aprob,
       solper_obser_sol, solper_tipo_cont, solper_tipo_selec, solper_tipo_contratacion, solper_tipo_dotac, solper_zafra,
       solper_zafra_empl, solper_cont_empl, solper_recontratacion,
       mes,
       anho,
       semana,
       SOLPER_VAC_CUBIERTA,
       SOLPER_SUCURSAL,
       SOLPER_FECHA_CIERRE)
select solper_clave, solper_empr, solper_fecha_sol, solper_operador_sol, solper_nivel_urgencia, solper_area, solper_cargo,
       solper_cant, solper_estado_aprob, solper_operador_aprob, solper_fecha_aprob, solper_estado_final, solper_obser_aprob,
       solper_obser_sol, solper_tipo_cont, solper_tipo_selec, solper_tipo_contratacion, solper_tipo_dotac, solper_zafra,
       solper_zafra_empl, solper_cont_empl, NULL,
       null, --MES no
       TO_CHAR(TRUNC(l_fecha), 'YYYY'),
       TO_CHAR(TRUNC(l_fecha), 'IW'),
       SOLPER_VAC_CUBIERTA,
       SOLPER_SUCURSAL,
       SOLPER_FECHA_CIERRE
       from per_solicitud_personal
       WHERE solper_empr IN (co_hilagro, co_transagro);

   -------------------------------------------HISTORICO DE ENTREVISTA DE PERSONAL
      insert into per_entrevista_personal_hist
            (entper_entrevista, entper_postul, entper_empr, entper_requis_puntaje, entper_requis_accion, entper_requis_obs,
             entper_requis_oper, entper_requis_estado, entper_requis_fecha, entper_perf_accion, entper_perf_obs, entper_perf_oper,
             entper_perf_estado, entper_perf_fecha, entper_pres_puntaje, entper_pres_accion, entper_pres_obs, entper_pres_oper,
             entper_pres_estado, entper_pres_fecha, entper_ref_puntaje, entper_ref_accion, entper_ref_obs, entper_ref_oper,
             entper_ref_estado, entper_ref_fecha, entper_ear_puntaje, entper_ear_accion, entper_ear_obs, entper_ear_oper,
             entper_ear_estado, entper_ear_fecha, entper_ear_area_ref, entper_ees_accion, entper_ees_obs, entper_ees_oper,
             entper_ees_estado, entper_ees_fecha, entper_estado_gral, entper_fecha_estado_gral, entper_etapa_decis_gral,
             entper_requis_consid, entper_ear_operador_enc, entper_ees_operador_enc, entper_ear_salar_pro, entper_ees_salar_acord,
             mes,
             semana,
             anho)
      select entper_entrevista, entper_postul, entper_empr, entper_requis_puntaje, entper_requis_accion, entper_requis_obs,
             entper_requis_oper, entper_requis_estado, entper_requis_fecha, entper_perf_accion, entper_perf_obs, entper_perf_oper,
             entper_perf_estado, entper_perf_fecha, entper_pres_puntaje, entper_pres_accion, entper_pres_obs, entper_pres_oper,
             entper_pres_estado, entper_pres_fecha, entper_ref_puntaje, entper_ref_accion, entper_ref_obs, entper_ref_oper,
             entper_ref_estado, entper_ref_fecha, entper_ear_puntaje, entper_ear_accion, entper_ear_obs, entper_ear_oper,
             entper_ear_estado, entper_ear_fecha, entper_ear_area_ref, entper_ees_accion, entper_ees_obs, entper_ees_oper,
             entper_ees_estado, entper_ees_fecha, entper_estado_gral, entper_fecha_estado_gral, entper_etapa_decis_gral,
             entper_requis_consid, entper_ear_operador_enc, entper_ees_operador_enc, entper_ear_salar_pro, entper_ees_salar_acord,
             null,--MES no
             TO_CHAR(TRUNC(l_fecha), 'IW'),
             TO_CHAR(TRUNC(l_fecha), 'YYYY')
       from per_entrevista_personal
      WHERE entper_empr IN (co_hilagro, co_transagro);

      insert into per_entrevista_post_hist
         (per_ent_codigo, per_ent_postulante, per_ent_empr, per_ent_cargo_ral, per_ent_fecha,
          mes,
          semana,
          anho)
      select per_ent_codigo, per_ent_postulante, per_ent_empr, per_ent_cargo_ral, per_ent_fecha,
          null, --MES no
          TO_CHAR(TRUNC(l_fecha), 'IW'),
          TO_CHAR(TRUNC(l_fecha), 'YYYY')
      from per_entrevista_post
      WHERE per_ent_empr IN (co_hilagro, co_transagro);

  END if; --> INSERTA DE LA SEMANA

end PER_TABLERO_JSA;
/
