prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_200100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2020.03.31'
,p_release=>'20.1.0.00.13'
,p_default_workspace_id=>2933390818164287
,p_default_application_id=>126
,p_default_id_offset=>145839418339142959
,p_default_owner=>'ADCS'
);
end;
/
 
prompt APPLICATION 126 - INFORMES GERENCIALES Y CONTABILIDAD UNIFICADOS
--
-- Application Export:
--   Application:     126
--   Name:            INFORMES GERENCIALES Y CONTABILIDAD UNIFICADOS
--   Date and Time:   13:10 Friday July 8, 2022
--   Exported By:     PABLOC
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 2645
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     211687171918188
--

begin
null;
end;
/
prompt --application/pages/delete_02645
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>2645);
end;
/
prompt --application/pages/page_02645
begin
wwv_flow_api.create_page(
 p_id=>2645
,p_user_interface_id=>wwv_flow_api.id(107533786434814543)
,p_name=>'SIGM016- CONFIGURAR CUENTAS PROVISION AGUINALDOS'
,p_step_title=>'SIGM016- CONFIGURAR CUENTAS PROVISION AGUINALDOS'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'PABLOC'
,p_last_upd_yyyymmddhh24miss=>'20220708130913'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(138652011969952675)
,p_plug_name=>'SIGM016'
,p_region_template_options=>'#DEFAULT#:t-Region--accent15:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(107567304844814577)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(138652572320952681)
,p_plug_name=>'GRILLA_DML'
,p_parent_plug_id=>wwv_flow_api.id(138652011969952675)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(107567876673814577)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CN.ROWID  ,',
'       C2.CTAC_DESC  DESC_PROV,',
'       C2.CTAC_NRO  NRO_PROV, ',
'       cn.PROVA_ITEM,',
'       CN.PROVA_CUENTA,',
'       C1.CTAC_DESC  DESC_CUENTA,',
'       C1.CTAC_NRO  NRO_CUENTA',
'  FROM CNT_CONF_PROV_AGUINALDO CN, ',
'       CNT_CUENTA C1, ',
'       CNT_CUENTA C2',
' WHERE CN.PROVA_CUENTA = C1.CTAC_CLAVE',
'   AND CN.PROVA_EMPR   = C1.CTAC_EMPR',
'   AND CN.PROVA_CUENTA_PROV = C2.CTAC_CLAVE',
'   AND CN.PROVA_EMPR        = C2.CTAC_EMPR',
'   AND CN.PROVA_CCOSTO      = :P2645_CENTRO_COSTO',
'   AND CN.PROVA_EMPR        = :P_EMPRESA'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P2645_CENTRO_COSTO,P_EMPRESA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(138654305740952698)
,p_name=>'DESC_PROV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DESC_PROV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(138654364481952699)
,p_name=>'NRO_PROV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NRO_PROV'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Cuenta de Provision '
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>true
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(74087884224950220)
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(138654452867952700)
,p_name=>'DESC_CUENTA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DESC_CUENTA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(138654616354952701)
,p_name=>'NRO_CUENTA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NRO_CUENTA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Cuenta Contable'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>true
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(74087884224950220)
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(138654656919952702)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(138654779442952703)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(138654925545952704)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(138656134983952716)
,p_name=>'PROVA_ITEM'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROVA_ITEM'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(138656199340952717)
,p_name=>'PROVA_CUENTA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROVA_CUENTA'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(138652669556952682)
,p_internal_uid=>207063026519848013
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_formats=>'CSV:HTML'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(144531926502118531)
,p_interactive_grid_id=>wwv_flow_api.id(138652669556952682)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(144532031389118532)
,p_report_id=>wwv_flow_api.id(144531926502118531)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(144569578267452161)
,p_view_id=>wwv_flow_api.id(144532031389118532)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(138654305740952698)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(144570051863452164)
,p_view_id=>wwv_flow_api.id(144532031389118532)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(138654364481952699)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(144570564959452166)
,p_view_id=>wwv_flow_api.id(144532031389118532)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(138654452867952700)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(144571096722452167)
,p_view_id=>wwv_flow_api.id(144532031389118532)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(138654616354952701)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(144583783917495491)
,p_view_id=>wwv_flow_api.id(144532031389118532)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(138654656919952702)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(144585048379496298)
,p_view_id=>wwv_flow_api.id(144532031389118532)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(138654779442952703)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(144723198828468114)
,p_view_id=>wwv_flow_api.id(144532031389118532)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(138656134983952716)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>56
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(144723792372468116)
,p_view_id=>wwv_flow_api.id(144532031389118532)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(138656199340952717)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(138655891236952714)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(138652011969952675)
,p_button_name=>'CANCELAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(107544444376814557)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138653498255952690)
,p_name=>'P2645_CENTRO_COSTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(138652011969952675)
,p_prompt=>'Centro Costo : '
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CCOSTO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CCO_DESC || ''-'' || CCO_CODIGO AS display_value,',
'       CCO_CODIGO return_value',
'  FROM CNT_CCOSTO',
' WHERE CCO_EMPR = :P_EMPRESA',
' ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(107544997227814558)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET_FILTER'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138653581207952691)
,p_name=>'P2645_CCOSTE_DESC'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(138652011969952675)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(107544997227814558)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138653723020952692)
,p_name=>'taer_desc'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P2645_CENTRO_COSTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138653768478952693)
,p_event_id=>wwv_flow_api.id(138653723020952692)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P2645_CCOSTE_DESC'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CCO_DESC',
'FROM CNT_CCOSTO',
'WHERE CCO_EMPR = :P_EMPRESA',
'and CCO_CODIGO = :P2645_CENTRO_COSTO'))
,p_attribute_07=>'P2645_CENTRO_COSTO'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138653862696952694)
,p_event_id=>wwv_flow_api.id(138653723020952692)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(138652572320952681)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(686030030930089412)
,p_name=>'submit page'
,p_event_sequence=>50
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(138652572320952681)
,p_bind_type=>'bind'
,p_bind_event_type=>'NATIVE_IG|REGION TYPE|interactivegridsave'
,p_da_event_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'**@PabloACespedes 08.07.2022 11:39am**',
unistr('- Hace submit porque no actualizan los registros, en base a los items en sesi\00F3n')))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(686030155158089413)
,p_event_id=>wwv_flow_api.id(686030030930089412)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(686030204014089414)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(138652572320952681)
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'process data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sigm016.crud_prov(',
'  in_empresa      => to_number(:P_EMPRESA),',
'  in_action       => :APEX$ROW_STATUS, -- C U D: create update delete',
'  in_centro_costo => :P2645_CENTRO_COSTO,',
'  in_nro_prov     => :NRO_PROV,',
'  in_nro_cuenta   => :NRO_CUENTA,',
'  in_item         => :PROVA_ITEM',
');'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
