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
,p_default_application_id=>112
,p_default_id_offset=>190743259397771592
,p_default_owner=>'ADCS'
);
end;
/
 
prompt APPLICATION 112 - TRANSPORTE
--
-- Application Export:
--   Application:     112
--   Name:            TRANSPORTE
--   Date and Time:   16:52 Tuesday June 14, 2022
--   Exported By:     PABLOC
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 39
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     211687171918188
--

begin
null;
end;
/
prompt --application/pages/delete_00039
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>39);
end;
/
prompt --application/pages/page_00039
begin
wwv_flow_api.create_page(
 p_id=>39
,p_user_interface_id=>wwv_flow_api.id(272783645693805599)
,p_name=>unistr('TRAI215 - Env\00EDo de Neum\00E1tico')
,p_alias=>unistr('TRAI215-ENV\00CDO-DE-NEUM\00C1TICO')
,p_step_title=>unistr('TRAI215 - Env\00EDo de Neum\00E1tico')
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.selectorItem{transform: scale(1.5);}',
'.cursor{cursor:pointer;}'))
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'PABLOC'
,p_last_upd_yyyymmddhh24miss=>'20220614161452'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(672573123976362039)
,p_plug_name=>'Baja para desecho'
,p_region_name=>'dialogBaja'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400'
,p_plug_template=>wwv_flow_api.id(272748566194805548)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P39_DEP_BAJA is not null and',
':P39_DEP_RECAPADO is not null and',
':P39_DEP_PROV_RECAP is not null'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(674585629539649103)
,p_plug_name=>unistr('TRAI215 - Env\00EDo de Neum\00E1tico')
,p_region_template_options=>'#DEFAULT#:t-Region--accent4:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(272750052041805549)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P39_DEP_BAJA is not null and',
':P39_DEP_RECAPADO is not null and',
':P39_DEP_PROV_RECAP is not null'))
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(674586068498649105)
,p_plug_name=>'Resultados'
,p_region_name=>'contentResult'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(272749554854805549)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select t.trec_art cod_art,',
'       a.art_desc descripcion,',
'       t.trec_serie serie,',
'       t.trec_fecha fecha,',
'       APEX_ITEM.CHECKBOX2(p_idx => 1, ',
'                           p_value => t.trec_art||'':''||t.trec_serie,',
'                           p_attributes => ''class="my_value selectorItem cursor"''',
'                          ) seleccionar,',
'       '''' RECAPAR,',
'       '''' DESECHAR',
'from tal_stk_neu_recapar t',
'inner join stk_articulo a on (a.art_codigo = t.trec_art)',
'where t.trec_estado = ''P'' -- pendiente envio',
'and  t.trec_empr = to_number(:P_EMPRESA)',
'and  (:P39_SERIE is null or :P39_SERIE = t.trec_serie)',
'and   (trunc(t.trec_fecha) between to_date(:P39_DESDE, ''dd/mm/yyyy'') and to_date(:P39_HASTA, ''dd/mm/yyyy''));'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P39_DESDE,P39_HASTA,P39_SERIE'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P39_DEP_BAJA is not null and',
':P39_DEP_RECAPADO is not null and',
':P39_DEP_PROV_RECAP is not null'))
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Resultados'
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
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(672571620336362024)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_help=>'N'
,p_download_formats=>'CSV:EMAIL:PDF'
,p_download_filename=>'Lista Resultados'
,p_owner=>'PABLOC'
,p_internal_uid=>672571620336362024
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(672571740574362025)
,p_db_column_name=>'COD_ART'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Cod Art'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(672571883717362026)
,p_db_column_name=>'DESCRIPCION'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('Descripci\00F3n')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(672571921365362027)
,p_db_column_name=>'SERIE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Serie'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(672572018293362028)
,p_db_column_name=>'FECHA'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Fecha'
,p_allow_hide=>'N'
,p_column_type=>'DATE'
,p_format_mask=>'dd/mm/yyyy'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(672572145379362029)
,p_db_column_name=>'SELECCIONAR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Seleccionar'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
,p_display_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_display_condition=>'PDF'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(674699281134523738)
,p_db_column_name=>'RECAPAR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Recapar'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'PDF'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(674699315944523739)
,p_db_column_name=>'DESECHAR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Desechar'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'PDF'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(674596244777685652)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6745963'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>15
,p_report_columns=>'COD_ART:DESCRIPCION:SERIE:FECHA:SELECCIONAR:RECAPAR:DESECHAR'
,p_sort_column_1=>'FECHA'
,p_sort_direction_1=>'DESC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(674695807223523704)
,p_plug_name=>'{dummy}'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(272740119552805541)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(674695925439523705)
,p_plug_name=>unistr('Informaci\00F3n')
,p_region_template_options=>'#DEFAULT#:t-Alert--wizard:t-Alert--defaultIcons:t-Alert--warning'
,p_plug_template=>wwv_flow_api.id(272738251600805537)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'Es necesario que se habilite en la empresa, sucursal el Departamento de Baja, Recapado y su proveedor correspondiente'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P39_DEP_BAJA is null or',
':P39_DEP_RECAPADO is null or',
':P39_DEP_PROV_RECAP is null'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(674696025813523706)
,p_plug_name=>'Enviar Servicio'
,p_region_name=>'contentEnvioSrv'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400'
,p_plug_template=>wwv_flow_api.id(272748566194805548)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(672573550990362043)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(672573123976362039)
,p_button_name=>'BAJA_ACEPTAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(272772790858805575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aceptar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(674696690384523712)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(674696025813523706)
,p_button_name=>'ES_ACEPTAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(272772790858805575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aceptar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(674699449057523740)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(674586068498649105)
,p_button_name=>'DESCARGAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(272772936069805576)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Descargar Reporte'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-file-text'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(672572897159362036)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(674586068498649105)
,p_button_name=>'DAR_DE_BAJA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--warning'
,p_button_template_id=>wwv_flow_api.id(272772790858805575)
,p_button_image_alt=>'Dar De Baja'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(672572732423362035)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(674586068498649105)
,p_button_name=>'ENVIAR_SERVICIO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success'
,p_button_template_id=>wwv_flow_api.id(272772790858805575)
,p_button_image_alt=>'Enviar Servicio'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(672572213761362030)
,p_name=>'P39_SERIE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(674585629539649103)
,p_prompt=>'Serie'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with d as',
'(',
'select k.trec_serie a',
'from tal_stk_neu_recapar k',
'where k.trec_estado = ''P'' --> P: Pendiente Envio',
'group by k.trec_serie',
')',
'select d.a, d.a r',
'from d'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Todos'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(272772293307805573)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_show_quick_picks=>'Y'
,p_quick_pick_label_01=>'Todos'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(672572363462362031)
,p_name=>'P39_DESDE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(674585629539649103)
,p_use_cache_before_default=>'NO'
,p_item_default=>'current_date - 45'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Desde'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(272772293307805573)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(672572467455362032)
,p_name=>'P39_HASTA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(674585629539649103)
,p_use_cache_before_default=>'NO'
,p_item_default=>'current_date'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Hasta'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(272772293307805573)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(672573257468362040)
,p_name=>'P39_BAJA_OBS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(672573123976362039)
,p_prompt=>unistr('Observaci\00F3n')
,p_display_as=>'NATIVE_AUTO_COMPLETE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select b.tsb_obs',
'from tal_stk_baja_neu b',
'group by b.tsb_obs'))
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(256749739875571849)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'CONTAINS_IGNORE'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(672573941682362047)
,p_name=>'P39_BAJA_ERROR'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(672573123976362039)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(674695508840523701)
,p_name=>'P39_DEP_BAJA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(674695807223523704)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(674695698830523702)
,p_name=>'P39_DEP_RECAPADO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(674695807223523704)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(674695745820523703)
,p_name=>'P39_DEP_PROV_RECAP'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(674695807223523704)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(674696218933523708)
,p_name=>'P39_ES_FECHA_DOC'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(674696025813523706)
,p_item_default=>'current_date'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Fecha Documento'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(256749739875571849)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(674696371825523709)
,p_name=>'P39_ES_PROVEEDOR'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(674696025813523706)
,p_prompt=>'Proveedor'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_PROVEEDOR'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select F.PROV_CODIGO||''-''||F.PROV_RAZON_SOCIAL as display_value, F.PROV_CODIGO as return_value',
'  from FIN_PROVEEDOR F',
' WHERE F.PROV_EMPR = :P_EMPRESA',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(256749739875571849)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
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
 p_id=>wwv_flow_api.id(674696408033523710)
,p_name=>'P39_ES_OBS'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(674696025813523706)
,p_prompt=>unistr('Observaci\00F3n')
,p_display_as=>'NATIVE_AUTO_COMPLETE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.ter_obs d',
'from tal_env_recapado r',
'where r.ter_obs is not null',
'group by r.ter_obs;'))
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(256749739875571849)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'CONTAINS_IGNORE'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(674696922339523715)
,p_name=>'P39_SEND'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(674695807223523704)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(674697722245523723)
,p_name=>'P39_EV_ERROR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(674696025813523706)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(672572514727362033)
,p_name=>'refresh region'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P39_SERIE,P39_DESDE,P39_HASTA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(672572631033362034)
,p_event_id=>wwv_flow_api.id(672572514727362033)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(674586068498649105)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(672573313287362041)
,p_name=>'Open region Baja Obs'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(672572897159362036)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(674697418587523720)
,p_event_id=>wwv_flow_api.id(672573313287362041)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.clearErrors();',
'apex.theme.openRegion(''dialogBaja'');',
unistr('apex.item(''P39_BAJA_OBS'').setValue(''Baja Neum\00E1tico'');'),
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(672574006824362048)
,p_name=>'Show or hide error'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P39_BAJA_ERROR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(672574128959362049)
,p_event_id=>wwv_flow_api.id(672574006824362048)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.clearErrors();',
'',
'let error = apex.item(''P39_BAJA_ERROR'');',
'',
'if (error.isEmpty()){',
'    apex.region(''contentResult'').refresh();',
'    apex.theme.closeRegion(''dialogBaja'');',
'    apex.item(''P39_SEND'').setValue('''');',
'}else{',
'    apex.message.showErrors([',
'    {',
'        type:       "error",',
'        location:   [ "inline" ],',
'        pageItem:   "P39_BAJA_OBS",',
'        message:    error.getValue(),',
'        unsafe:     false',
'    }',
'    ]);',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(674697044450523716)
,p_name=>'Set Data'
,p_event_sequence=>50
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.my_value'
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'#contentResult'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(674697163623523717)
,p_event_id=>wwv_flow_api.id(674697044450523716)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var serieId = "";',
'',
'$(''.my_value:checked'').each(function(){',
'    serieId+= $(this).val() + '','';',
'});',
'',
'$("#contentResult").prop("checked", false);',
'',
'serieId = serieId.substring(0, serieId.length-1);',
'',
'apex.item(''P39_SEND'').setValue(serieId);'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(674697238260523718)
,p_name=>'aceptar dar de baja'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(672573550990362043)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(674697321641523719)
,p_event_id=>wwv_flow_api.id(674697238260523718)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    trai215.envio_articulo(',
'       in_data    => :P39_SEND,',
'       in_tipo    => ''D'', -- D: Desecho',
'       in_obs     => :P39_BAJA_OBS,',
'       in_empresa => :P_EMPRESA,',
'       in_suc     => :P_SUCURSAL,',
'       in_user    => :APP_USER',
'    );',
'    ',
'    :P39_BAJA_ERROR := null;',
'exception',
'when others then',
'  :P39_BAJA_ERROR := replace(sqlerrm, ''ORA-20000:'', '''');',
'end;'))
,p_attribute_02=>'P39_SEND,P39_BAJA_OBS'
,p_attribute_03=>'P39_BAJA_ERROR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(674697582393523721)
,p_name=>'Open region Envio proveedor'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(672572732423362035)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(674697654258523722)
,p_event_id=>wwv_flow_api.id(674697582393523721)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.clearErrors();',
'apex.theme.openRegion(''contentEnvioSrv'');',
'apex.item(''P39_ES_NRO_DOC'').setValue('''');',
'apex.item(''P39_ES_PROVEEDOR'').setValue('''');',
unistr('apex.item(''P39_ES_OBS'').setValue(''Env\00EDo a Recapado'');')))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(674698030033523726)
,p_name=>'enviar a servicio'
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(674696690384523712)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'!apex.item(''P39_ES_FECHA_DOC'').isEmpty() &&',
'!apex.item(''P39_ES_PROVEEDOR'').isEmpty() &&',
'!apex.item(''P39_ES_OBS'').isEmpty()'))
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(674698144577523727)
,p_event_id=>wwv_flow_api.id(674698030033523726)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    trai215.envio_articulo(',
'        in_data    => :P39_SEND,',
'        in_tipo    => ''R'', --> Recapado',
'        in_fecha   => :P39_ES_FECHA_DOC,',
'        in_prov    => :P39_ES_PROVEEDOR,',
'        in_obs     => :P39_ES_OBS,',
'        in_empresa => :P_EMPRESA,',
'        in_suc     => :P_SUCURSAL,',
'        in_user    => :APP_USER',
'    );',
'    :P39_EV_ERROR := null;',
'exception when others then :P39_EV_ERROR:= replace(sqlerrm, ''ORA-20000:'', '''');',
'end;'))
,p_attribute_02=>'P39_EV_ERROR,P39_ES_FECHA_DOC,P39_ES_PROVEEDOR,P39_ES_OBS,P39_SEND'
,p_attribute_03=>'P39_EV_ERROR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(674698330857523729)
,p_event_id=>wwv_flow_api.id(674698030033523726)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.clearErrors();',
'',
'var errors = [];',
'',
'var fechaDoc = apex.item(''P39_ES_FECHA_DOC'');',
'var prov = apex.item(''P39_ES_PROVEEDOR'');',
'var obs = apex.item(''P39_ES_OBS'');',
'',
'if (fechaDoc.isEmpty()) {',
'    errors.push({',
'        type: "error",',
'        location: ["inline"],',
'        pageItem: "P39_ES_FECHA_DOC",',
'        message: "Complete la fecha",',
'        unsafe: false',
'    });',
'}',
'if (prov.isEmpty()) {',
'    errors.push({',
'        type: "error",',
'        location: ["inline"],',
'        pageItem: "P39_ES_PROVEEDOR",',
'        message: "Seleccione el proveedor",',
'        unsafe: false',
'    });',
'}',
'if (obs.isEmpty()) {',
'    errors.push({',
'        type: "error",',
'        location: ["inline"],',
'        pageItem: "P39_ES_OBS",',
unistr('        message: "Complete la observaci\00F3n",'),
'        unsafe: false',
'    });',
'}',
'',
'apex.message.showErrors(errors);'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(674698961240523735)
,p_name=>'ES Show or view errors'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P39_EV_ERROR'
,p_condition_element=>'P39_EV_ERROR'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(674699093436523736)
,p_event_id=>wwv_flow_api.id(674698961240523735)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.clearErrors();',
'apex.theme.closeRegion(''contentEnvioSrv'');',
'apex.region(''contentResult'').refresh();',
'apex.item(''P39_SEND'').setValue('''');'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(674699155075523737)
,p_event_id=>wwv_flow_api.id(674698961240523735)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.clearErrors();',
'apex.message.showErrors([{',
'        type: "error",',
'        location: ["page"],',
'        message: apex.item(''P39_EV_ERROR'').getValue(),',
'        unsafe: false',
'}]);'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(674699572591523741)
,p_name=>'Dowload document'
,p_event_sequence=>100
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(674699449057523740)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(674699630336523742)
,p_event_id=>wwv_flow_api.id(674699572591523741)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.navigation.redirect ( "f?p=&APP_ID.:39:&APP_SESSION.:PDF::::" );'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(672574285608362050)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'getDataIni'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'trai215.get_data_dep(',
'  in_empresa         => :P_EMPRESA,',
'  in_suc             => :P_SUCURSAL,',
'  out_dep_baja       => :P39_DEP_BAJA,',
'  out_dep_recapado   => :P39_DEP_RECAPADO,',
'  out_dep_prov_recap => :P39_DEP_PROV_RECAP',
');',
''))
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
