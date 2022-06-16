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
,p_default_application_id=>106
,p_default_id_offset=>0
,p_default_owner=>'ADCS'
);
end;
/
 
prompt APPLICATION 106 - COMPRAS
--
-- Application Export:
--   Application:     106
--   Name:            COMPRAS
--   Date and Time:   11:57 Thursday June 16, 2022
--   Exported By:     PABLOC
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 25
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     211687171918188
--

begin
null;
end;
/
prompt --application/pages/delete_00025
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>25);
end;
/
prompt --application/pages/page_00025
begin
wwv_flow_api.create_page(
 p_id=>25
,p_user_interface_id=>wwv_flow_api.id(10106524426416981)
,p_name=>unistr('COMM001 COMM201 - Configuraci\00F3n del Sistema New Version')
,p_alias=>unistr('COMM001-CONFIGURACI\00D3N-DEL-SISTEMA')
,p_step_title=>unistr('Configuraci\00F3n del Sistema')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'PABLOC'
,p_last_upd_yyyymmddhh24miss=>'20220616114122'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(677269377722672233)
,p_plug_name=>unistr('&P25_CODE_PROGRAM.-Configuraci\00F3n de Sistema')
,p_region_template_options=>'#DEFAULT#:t-Region--accent4:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(10072930774416931)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.conf_ind_integrar_stk int_stock,',
'       c.conf_ind_integrar_prd int_produccion,',
'       c.conf_ind_integrar_act int_activo_fijo,',
'       c.conf_conc_merc        mecaderia,',
'       c.conf_conc_merc_rem    mercaderia_remision,',
'       c.conf_conc_ot          ot_proceso,',
'       c.conf_conc_act         activo_fijo,',
'       c.conf_conc_impu        iva_diez,',
'       c.conf_conc_impu_5      iva_cinco,',
'       c.conf_conc_dev_merc    dev_mercaderias,',
'       c.conf_conc_dev_ot      dev_ot,',
'       c.conf_conc_dev_impu    dev_iva_diez,',
'       c.conf_conc_dev_impu_5  dev_iva_cinco,',
'       c.conf_conc_merc_imagro ganado,',
'       c.conf_conc_iva_imagro  iva_imagro,',
'       c.conf_tmov_bonif_dcto_rec      tmov_desc_bonif_rec,',
'       c.conf_tmov_canc_bonif_dcto_rec tmov_canc_desc_bonif_rec,',
'       c.conf_conc_bonif               bonificaciones_rec,',
'       c.conf_conc_dcto                descuentos_rec,',
'       c.conf_ind_ctaco_stk_clas       cta_co_articulos,',
'       c.conf_importe_dif_factped      importe_dif_fac_ped,',
'       c.conf_empr',
'from com_configuracion_tmp c --> EN PRODUCCION SE DEBE USAR com_configuracion',
';'))
,p_is_editable=>true
,p_edit_operations=>'u'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(676772733156314047)
,p_plug_name=>'{A}'
,p_parent_plug_id=>wwv_flow_api.id(677269377722672233)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(10062998285416923)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_column=>2
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(676772809808314048)
,p_plug_name=>'{B}'
,p_parent_plug_id=>wwv_flow_api.id(677269377722672233)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(10062998285416923)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(677269771127672235)
,p_plug_name=>'Detalle'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(10072433587416931)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT D.COMDV_CARACT LINEA_DE_NEGOCIO',
'      ,D.COMDV_DB     RECIBIDAS,',
'       D.COMDV_CR     EMITIDAS,',
'       D.COMDV_EMPR,',
'       D.ROWID',
'  FROM COM_CONF_DEV_TMP D',
'   WHERE COMDV_EMPR = :P_EMPRESA;'))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'2'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Detalle'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(677465001274939506)
,p_name=>'LINEA_DE_NEGOCIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LINEA_DE_NEGOCIO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Linea De Negocio'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_is_required=>true
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.cat_codigo||''-''||c.cat_denom d,',
'       c.cat_codigo r',
'from com_categ_factura c',
'where c.cat_empr = 2'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_lov_null_text=>'Ninguno'
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
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(677465186742939507)
,p_name=>'RECIBIDAS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIBIDAS'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Recibidas'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(30301458664070783)
,p_lov_display_extra=>true
,p_lov_display_null=>true
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
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(677465220648939508)
,p_name=>'EMITIDAS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMITIDAS'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Emitidas'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(30301458664070783)
,p_lov_display_extra=>true
,p_lov_display_null=>true
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
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(677465389967939509)
,p_name=>'COMDV_EMPR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMDV_EMPR'
,p_data_type=>'NUMBER'
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
 p_id=>wwv_flow_api.id(677465484439939510)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>70
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(677464946366939505)
,p_internal_uid=>677464946366939505
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(677527867630999692)
,p_interactive_grid_id=>wwv_flow_api.id(677464946366939505)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(677527947874999692)
,p_report_id=>wwv_flow_api.id(677527867630999692)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(677528411372999694)
,p_view_id=>wwv_flow_api.id(677527947874999692)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(677465001274939506)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>329.375
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(677528922931999699)
,p_view_id=>wwv_flow_api.id(677527947874999692)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(677465186742939507)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>372.042
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(677529461509999703)
,p_view_id=>wwv_flow_api.id(677527947874999692)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(677465220648939508)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>487.0003740234375
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(677529906506999709)
,p_view_id=>wwv_flow_api.id(677527947874999692)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(677465389967939509)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(677530401087999713)
,p_view_id=>wwv_flow_api.id(677527947874999692)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(677465484439939510)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(677464874063939504)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(677269377722672233)
,p_button_name=>'GUARDAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(10095814802416958)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Guardar Cambios Cabecera'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_icon_css_classes=>'fa-save'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676770494964314024)
,p_name=>'P25_INT_STOCK'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(676772733156314047)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>'Integrar con Stock'
,p_source=>'INT_STOCK'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'SI_NO_S_N'
,p_lov=>'.'||wwv_flow_api.id(677379139319846673)||'.'
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676770585466314025)
,p_name=>'P25_INT_PRODUCCION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(676772733156314047)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>unistr('Integrar con Producci\00F3n')
,p_source=>'INT_PRODUCCION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'SI_NO_S_N'
,p_lov=>'.'||wwv_flow_api.id(677379139319846673)||'.'
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676770656053314026)
,p_name=>'P25_INT_ACTIVO_FIJO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(676772733156314047)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>'Integrar con Activo Fijo'
,p_source=>'INT_ACTIVO_FIJO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'SI_NO_S_N'
,p_lov=>'.'||wwv_flow_api.id(677379139319846673)||'.'
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676770715858314027)
,p_name=>'P25_MECADERIA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(676772733156314047)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>unistr('Concepto Mecader\00EDa')
,p_source=>'MECADERIA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CONCEPTO_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.FCON_CODIGO || '' - '' || T.FCON_DESC A, T.FCON_CLAVE B',
'  FROM FIN_CONCEPTO T',
' WHERE FCON_EMPR = :P_EMPRESA',
'ORDER BY T.FCON_CODIGO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676770882081314028)
,p_name=>'P25_OT_PROCESO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(676772733156314047)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>'Concepto  OT en Proceso'
,p_source=>'OT_PROCESO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CONCEPTO_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.FCON_CODIGO || '' - '' || T.FCON_DESC A, T.FCON_CLAVE B',
'  FROM FIN_CONCEPTO T',
' WHERE FCON_EMPR = :P_EMPRESA',
'ORDER BY T.FCON_CODIGO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676770951149314029)
,p_name=>'P25_ACTIVO_FIJO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(676772733156314047)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>'Concepto  Activo Fijo'
,p_source=>'ACTIVO_FIJO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CONCEPTO_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.FCON_CODIGO || '' - '' || T.FCON_DESC A, T.FCON_CLAVE B',
'  FROM FIN_CONCEPTO T',
' WHERE FCON_EMPR = :P_EMPRESA',
'ORDER BY T.FCON_CODIGO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676771068091314030)
,p_name=>'P25_IVA_DIEZ'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(676772733156314047)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>'Concepto IVA 10%'
,p_source=>'IVA_DIEZ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CONCEPTO_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.FCON_CODIGO || '' - '' || T.FCON_DESC A, T.FCON_CLAVE B',
'  FROM FIN_CONCEPTO T',
' WHERE FCON_EMPR = :P_EMPRESA',
'ORDER BY T.FCON_CODIGO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676771148933314031)
,p_name=>'P25_IVA_CINCO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(676772733156314047)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>'Concepto IVA 5%'
,p_source=>'IVA_CINCO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CONCEPTO_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.FCON_CODIGO || '' - '' || T.FCON_DESC A, T.FCON_CLAVE B',
'  FROM FIN_CONCEPTO T',
' WHERE FCON_EMPR = :P_EMPRESA',
'ORDER BY T.FCON_CODIGO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676771289527314032)
,p_name=>'P25_DEV_MERCADERIAS'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(676772733156314047)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>unistr('Concepto Devoluci\00F3n Mercader\00EDas')
,p_source=>'DEV_MERCADERIAS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CONCEPTO_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.FCON_CODIGO || '' - '' || T.FCON_DESC A, T.FCON_CLAVE B',
'  FROM FIN_CONCEPTO T',
' WHERE FCON_EMPR = :P_EMPRESA',
'ORDER BY T.FCON_CODIGO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676771312916314033)
,p_name=>'P25_DEV_OT'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(676772809808314048)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>unistr('Concepto devoluci\00F3n OT en proceso')
,p_source=>'DEV_OT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CONCEPTO_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.FCON_CODIGO || '' - '' || T.FCON_DESC A, T.FCON_CLAVE B',
'  FROM FIN_CONCEPTO T',
' WHERE FCON_EMPR = :P_EMPRESA',
'ORDER BY T.FCON_CODIGO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676771443918314034)
,p_name=>'P25_DEV_IVA_DIEZ'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(676772809808314048)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>unistr('Concepto devoluci\00F3n IVA 10%')
,p_source=>'DEV_IVA_DIEZ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CONCEPTO_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.FCON_CODIGO || '' - '' || T.FCON_DESC A, T.FCON_CLAVE B',
'  FROM FIN_CONCEPTO T',
' WHERE FCON_EMPR = :P_EMPRESA',
'ORDER BY T.FCON_CODIGO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676771508864314035)
,p_name=>'P25_DEV_IVA_CINCO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(676772809808314048)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>unistr('Concepto devoluci\00F3n IVA 5%')
,p_source=>'DEV_IVA_CINCO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CONCEPTO_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.FCON_CODIGO || '' - '' || T.FCON_DESC A, T.FCON_CLAVE B',
'  FROM FIN_CONCEPTO T',
' WHERE FCON_EMPR = :P_EMPRESA',
'ORDER BY T.FCON_CODIGO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676771668872314036)
,p_name=>'P25_GANADO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(676772809808314048)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>'Concepto Ganado'
,p_source=>'GANADO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CONCEPTO_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.FCON_CODIGO || '' - '' || T.FCON_DESC A, T.FCON_CLAVE B',
'  FROM FIN_CONCEPTO T',
' WHERE FCON_EMPR = :P_EMPRESA',
'ORDER BY T.FCON_CODIGO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_display_when=>'P_EMPRESA'
,p_display_when2=>'2'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676771759706314037)
,p_name=>'P25_IVA_IMAGRO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(676772809808314048)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>'Concepto IVA IMAGRO'
,p_source=>'IVA_IMAGRO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CONCEPTO_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.FCON_CODIGO || '' - '' || T.FCON_DESC A, T.FCON_CLAVE B',
'  FROM FIN_CONCEPTO T',
' WHERE FCON_EMPR = :P_EMPRESA',
'ORDER BY T.FCON_CODIGO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_display_when=>'P_EMPRESA'
,p_display_when2=>'2'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676771803698314038)
,p_name=>'P25_TMOV_DESC_BONIF_REC'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(676772809808314048)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>'Tmov Desc Bonif Rec'
,p_source=>'TMOV_DESC_BONIF_REC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_TIPO_MOVIMIENTO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select tmov_codigo||'' - ''||tmov_desc, tmov_codigo ',
'  from gen_tipo_mov ',
' WHERE TMOV_EMPR = :P_EMPRESA  ',
'  order by 1;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676771903271314039)
,p_name=>'P25_TMOV_CANC_DESC_BONIF_REC'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(676772809808314048)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>'Tmov Canc Desc Bonif Rec'
,p_source=>'TMOV_CANC_DESC_BONIF_REC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_TIPO_MOVIMIENTO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select tmov_codigo||'' - ''||tmov_desc, tmov_codigo ',
'  from gen_tipo_mov ',
' WHERE TMOV_EMPR = :P_EMPRESA  ',
'  order by 1;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676772092581314040)
,p_name=>'P25_BONIFICACIONES_REC'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(676772809808314048)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>'Concepto Bonificaciones Rec'
,p_source=>'BONIFICACIONES_REC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CONCEPTO_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.FCON_CODIGO || '' - '' || T.FCON_DESC A, T.FCON_CLAVE B',
'  FROM FIN_CONCEPTO T',
' WHERE FCON_EMPR = :P_EMPRESA',
'ORDER BY T.FCON_CODIGO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676772144429314041)
,p_name=>'P25_DESCUENTOS_REC'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(676772809808314048)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>'Concepto  Descuentos Rec'
,p_source=>'DESCUENTOS_REC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CONCEPTO_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.FCON_CODIGO || '' - '' || T.FCON_DESC A, T.FCON_CLAVE B',
'  FROM FIN_CONCEPTO T',
' WHERE FCON_EMPR = :P_EMPRESA',
'ORDER BY T.FCON_CODIGO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676772290306314042)
,p_name=>'P25_CTA_CO_ARTICULOS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(676772733156314047)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>'Tomar las CtaCo de Ctas. de Articulos'
,p_source=>'CTA_CO_ARTICULOS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'SI_NO_S_N'
,p_lov=>'.'||wwv_flow_api.id(677379139319846673)||'.'
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676772306574314043)
,p_name=>'P25_IMPORTE_DIF_FAC_PED'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(676772809808314048)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>'Importe Dif Fac/Ped'
,p_source=>'IMPORTE_DIF_FAC_PED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'u-bold'
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_attribute_03=>'center'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676772433433314044)
,p_name=>'P25_CONF_EMPR'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(677269377722672233)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_source=>'CONF_EMPR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676772923518314049)
,p_name=>'P25_MERCADERIA_REMISION'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(676772733156314047)
,p_item_source_plug_id=>wwv_flow_api.id(677269377722672233)
,p_prompt=>unistr('Concepto Mercader\00EDas Rem')
,p_source=>'MERCADERIA_REMISION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CONCEPTO_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.FCON_CODIGO || '' - '' || T.FCON_DESC A, T.FCON_CLAVE B',
'  FROM FIN_CONCEPTO T',
' WHERE FCON_EMPR = :P_EMPRESA',
'ORDER BY T.FCON_CODIGO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_display_when=>'P_EMPRESA'
,p_display_when2=>'2'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_field_template=>wwv_flow_api.id(10095172040416955)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(676773096567314050)
,p_name=>'P25_CODE_PROGRAM'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(677269377722672233)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(676772693042314046)
,p_computation_sequence=>10
,p_computation_item=>'P25_CONF_EMPR'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>':P_EMPRESA'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(677464526367939501)
,p_computation_sequence=>20
,p_computation_item=>'P25_CODE_PROGRAM'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P_EMPRESA = 1 then',
'  return ''COMM001'';',
'else',
'  return ''COMM201'';',
'end if;'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(677464645865939502)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(677269377722672233)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>unistr('Process form &P25_CODE_PROGRAM.-Configuraci\00F3n de Sistema')
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(677465797481939513)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(677269771127672235)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Detalle - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(676770376767314023)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(677269377722672233)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form COMM001 - Configuraci\00F3n del Sistema New Version')
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
