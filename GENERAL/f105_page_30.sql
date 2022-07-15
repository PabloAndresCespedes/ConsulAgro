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
,p_default_application_id=>105
,p_default_id_offset=>0
,p_default_owner=>'ADCS'
);
end;
/
 
prompt APPLICATION 105 - SISTEMA GENERAL
--
-- Application Export:
--   Application:     105
--   Name:            SISTEMA GENERAL
--   Date and Time:   13:59 Viernes Julio 15, 2022
--   Exported By:     PABLOC
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 30
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     211687171918188
--

begin
null;
end;
/
prompt --application/pages/delete_00030
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>30);
end;
/
prompt --application/pages/page_00030
begin
wwv_flow_api.create_page(
 p_id=>30
,p_user_interface_id=>wwv_flow_api.id(12932509144876455)
,p_name=>'Operadores Externos Cargos'
,p_alias=>'OPERADORES-EXTERNOS-CARGOS'
,p_page_mode=>'MODAL'
,p_step_title=>'Operadores Externos Cargos'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'60%'
,p_last_updated_by=>'PABLOC'
,p_last_upd_yyyymmddhh24miss=>'20220715133241'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(698703098256357378)
,p_plug_name=>'Operadores Externos Cargos'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(12898485531876360)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'GEN_OPERADOR_EXT_CARGOS'
,p_query_where=>'OPER_EXT_ID = :P30_OPERADOR_EXTERNO'
,p_include_rowid_column=>true
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P30_OPERADOR_EXTERNO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_page_header=>'Operadores Externos Cargos'
,p_plug_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul>',
'    <li>Solo puede existir 1 cargo del Operador por empresa, es igual que el de la ficha</li>',
'</ul>'))
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(686031591348089427)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(686031691020089428)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(698704213597357391)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(698705341174357485)
,p_name=>'OPER_EXT_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OPER_EXT_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P30_OPERADOR_EXTERNO'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(698705912494357486)
,p_name=>'EMPR_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMPR_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Empresa'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_is_required=>true
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select g.empr_razon_social d,',
'       g.empr_codigo r       ',
'from gen_empresa g'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_lov_null_text=>'%'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(698706533768357487)
,p_name=>'CARGO_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CARGO_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Cargo'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
,p_is_required=>true
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.car_codigo||''-''||p.car_desc d,',
'       p.car_codigo r   ',
'from per_cargo p',
'where p.car_empr=:EMPR_ID'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_lov_null_text=>'%'
,p_lov_cascade_parent_items=>'EMPR_ID'
,p_ajax_items_to_submit=>'EMPR_ID'
,p_ajax_optimize_refresh=>true
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(698703532431357385)
,p_internal_uid=>698703532431357385
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
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
,p_enable_mail_download=>true
,p_fixed_header=>'REGION'
,p_fixed_header_max_height=>300
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(698703969907357387)
,p_interactive_grid_id=>wwv_flow_api.id(698703532431357385)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(698704044257357389)
,p_report_id=>wwv_flow_api.id(698703969907357387)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(698704668457357394)
,p_view_id=>wwv_flow_api.id(698704044257357389)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(698704213597357391)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(698705750235357486)
,p_view_id=>wwv_flow_api.id(698704044257357389)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(698705341174357485)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(698706313930357487)
,p_view_id=>wwv_flow_api.id(698704044257357389)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(698705912494357486)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(698706959519357488)
,p_view_id=>wwv_flow_api.id(698704044257357389)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(698706533768357487)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(698716802061367393)
,p_view_id=>wwv_flow_api.id(698704044257357389)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(686031591348089427)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(686031429979089426)
,p_name=>'P30_OPERADOR_EXTERNO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(698703098256357378)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(686031736999089429)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(698703098256357378)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>unistr('Operadores Externos Cargos: Guardar Datos de Cuadr\00EDcula Interactiva')
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_process_error_message=>'#SQLERRM_TEXT#'
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
