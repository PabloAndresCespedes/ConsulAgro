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
,p_default_application_id=>100
,p_default_id_offset=>102801135605236656
,p_default_owner=>'ADCS'
);
end;
/
 
prompt APPLICATION 100 - FINANZAS
--
-- Application Export:
--   Application:     100
--   Name:            FINANZAS
--   Date and Time:   09:40 Saturday July 9, 2022
--   Exported By:     PABLOC
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 135
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     211687171918188
--

begin
null;
end;
/
prompt --application/pages/delete_00135
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>135);
end;
/
prompt --application/pages/page_00135
begin
wwv_flow_api.create_page(
 p_id=>135
,p_user_interface_id=>wwv_flow_api.id(116263539932678213)
,p_name=>'FINC015-EXTRACTO DE CUENTA DE PROVEEDORES'
,p_step_title=>'FINC015-EXTRACTO DE CUENTA DE PROVEEDORES'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(128775575080687187)
,p_step_template=>wwv_flow_api.id(119440621989420647)
,p_page_template_options=>'#DEFAULT#'
,p_browser_cache=>'N'
,p_last_updated_by=>'PABLOC'
,p_last_upd_yyyymmddhh24miss=>'20220709093253'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(131545389722888004)
,p_plug_name=>'EXTRACTO'
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody:t-Form--slimPadding:t-Form--large:t-Form--stretchInputs:t-Form--leftLabels'
,p_plug_template=>wwv_flow_api.id(119469003339420663)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(129812410035407903)
,p_plug_name=>'detalle'
,p_parent_plug_id=>wwv_flow_api.id(131545389722888004)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(119467875788420662)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DOC_NRO_DOC,',
'       DOC_CLAVE,',
'       DOC_CLAVE_FIN_TA,',
'       TOT_COMPROB,',
'       CUO_IMP_MON,',
'       DOC_FEC_DOC,',
'       CUO_FEC_VTO,',
'       PAG_FEC_PAGO,',
'       PAG_IMP_MON,',
'       CUO_SALDO_MON,',
'       TMOV_IND_DBCR_CTA,',
'       TMOV_ABREV,',
'       NRO_PAG,',
'       DOC_OBS OBSERVACION,',
'       SESSION_ID,',
'       EMPR,',
'       USUARIO , ',
'       DECODE(DOC_CLAVE_FIN_TA, NULL, NULL, ''TRANSAGRO'') IND_TRANSAGRO,',
'       NULL IMAGEN',
'  FROM FIN_FINC015_TEMP_2',
'    WHERE SESSION_ID = :APP_SESSION ',
'  AND USUARIO = :APP_USER ',
'  AND NVL(:P135_IND_QUERY, ''N'') = ''S'';',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P135_IND_QUERY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'LEGAL'
,p_prn_width=>320
,p_prn_height=>355
,p_prn_orientation=>'VERTICAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Times'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Times'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Times'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'11'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Times'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'8'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(129812528606407904)
,p_max_row_count=>'1000000'
,p_allow_save_rpt_public=>'Y'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_display_row_count=>'Y'
,p_report_list_mode=>'TABS'
,p_fixed_header=>'NONE'
,p_show_detail_link=>'N'
,p_show_rows_per_page=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_download_filename=>'Extracto_proveedores'
,p_owner=>'APERALTA'
,p_internal_uid=>41633118211099434
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(103129263090073115)
,p_db_column_name=>'DOC_NRO_DOC'
,p_display_order=>10
,p_column_identifier=>'EL'
,p_column_label=>'Nro. Comprobante'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(103129700094073115)
,p_db_column_name=>'TMOV_ABREV'
,p_display_order=>20
,p_column_identifier=>'EM'
,p_column_label=>'Tipo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(103130078834073116)
,p_db_column_name=>'DOC_FEC_DOC'
,p_display_order=>30
,p_column_identifier=>'EN'
,p_column_label=>'Fec. Comprobante'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(103130440670073116)
,p_db_column_name=>'CUO_FEC_VTO'
,p_display_order=>40
,p_column_identifier=>'EO'
,p_column_label=>'Fec. Vencimiento'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(103130839444073117)
,p_db_column_name=>'TOT_COMPROB'
,p_display_order=>50
,p_column_identifier=>'EP'
,p_column_label=>'Total Comprobante'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(103131657113073117)
,p_db_column_name=>'NRO_PAG'
,p_display_order=>70
,p_column_identifier=>'ER'
,p_column_label=>'Nro. Pago'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(103132032603073118)
,p_db_column_name=>'PAG_FEC_PAGO'
,p_display_order=>80
,p_column_identifier=>'ES'
,p_column_label=>'Fec. Pago'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(103132417009073118)
,p_db_column_name=>'CUO_IMP_MON'
,p_display_order=>90
,p_column_identifier=>'ET'
,p_column_label=>'Monto Cuota'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(103132837435073119)
,p_db_column_name=>'PAG_IMP_MON'
,p_display_order=>100
,p_column_identifier=>'EU'
,p_column_label=>'Monto Pago'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(103133215652073119)
,p_db_column_name=>'CUO_SALDO_MON'
,p_display_order=>110
,p_column_identifier=>'EV'
,p_column_label=>'Monto Saldo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(103133672613073119)
,p_db_column_name=>'DOC_CLAVE'
,p_display_order=>120
,p_column_identifier=>'EW'
,p_column_label=>'Doc clave'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(103134061621073120)
,p_db_column_name=>'TMOV_IND_DBCR_CTA'
,p_display_order=>140
,p_column_identifier=>'EY'
,p_column_label=>'Tmov ind dbcr cta'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(103134490289073120)
,p_db_column_name=>'IND_TRANSAGRO'
,p_display_order=>150
,p_column_identifier=>'EZ'
,p_column_label=>'Ind. Sist. Transagro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(134804259446034341)
,p_db_column_name=>'DOC_CLAVE_FIN_TA'
,p_display_order=>160
,p_column_identifier=>'FB'
,p_column_label=>'Doc Clave Fin Ta'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(134804442358034343)
,p_db_column_name=>'SESSION_ID'
,p_display_order=>180
,p_column_identifier=>'FD'
,p_column_label=>'Session Id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(134804518792034344)
,p_db_column_name=>'EMPR'
,p_display_order=>190
,p_column_identifier=>'FE'
,p_column_label=>'Empr'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(134804630653034345)
,p_db_column_name=>'USUARIO'
,p_display_order=>200
,p_column_identifier=>'FF'
,p_column_label=>'Usuario'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(134804852214034347)
,p_db_column_name=>'IMAGEN'
,p_display_order=>220
,p_column_identifier=>'FH'
,p_column_label=>'Imagen'
,p_column_link=>'f?p=&APP_ID.:3006:&SESSION.::&DEBUG.:RP:P3006_CLAVE_EMPRESA,P3006_CLAVE_FACTURA:#EMPR#,#DOC_CLAVE#'
,p_column_linktext=>'<img src="#WORKSPACE_IMAGES#icono_imagen.jpg" class="apex-edit-view" alt="">'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(238860194605809847)
,p_db_column_name=>'OBSERVACION'
,p_display_order=>230
,p_column_identifier=>'FI'
,p_column_label=>unistr('Observaci\00F3n')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(130607359077908323)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'149558'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>100000
,p_report_columns=>'DOC_NRO_DOC:TMOV_ABREV:DOC_FEC_DOC:CUO_FEC_VTO:TOT_COMPROB:OBSERVACION:NRO_PAG:PAG_FEC_PAGO:CUO_IMP_MON:PAG_IMP_MON:CUO_SALDO_MON:IMAGEN:'
,p_break_on=>'TMOV_ABREV:0:0:0:0:0'
,p_break_enabled_on=>'0:0:0:0:0'
,p_sum_columns_on_break=>'CUO_SALDO_MON:PAG_IMP_MON:CUO_IMP_MON:TOT_COMPROB'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(239165687030059631)
,p_report_id=>wwv_flow_api.id(130607359077908323)
,p_name=>'Desde Sistema Transagro'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'IND_TRANSAGRO'
,p_operator=>'is not null'
,p_condition_sql=>' (case when ("IND_TRANSAGRO" is not null) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME#'
,p_enabled=>'N'
,p_highlight_sequence=>10
,p_row_bg_color=>'#FFFF99'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(129814013690407919)
,p_plug_name=>'Extracto de Proveedor'
,p_parent_plug_id=>wwv_flow_api.id(131545389722888004)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--leftLabels'
,p_plug_template=>wwv_flow_api.id(119469003339420663)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>9
,p_plug_display_column=>1
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(131545251398888003)
,p_plug_name=>'TOTALES'
,p_parent_plug_id=>wwv_flow_api.id(131545389722888004)
,p_region_template_options=>'#DEFAULT#:t-Region--accent7:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--leftLabels'
,p_plug_template=>wwv_flow_api.id(119469003339420663)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_column=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(103136316550073124)
,p_button_sequence=>150
,p_button_plug_id=>wwv_flow_api.id(129814013690407919)
,p_button_name=>'Cancelar'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(119514564106420685)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cancelar'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-minus-circle'
,p_grid_new_row=>'Y'
,p_grid_column_span=>3
,p_grid_column=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(103136743681073125)
,p_button_sequence=>160
,p_button_plug_id=>wwv_flow_api.id(129814013690407919)
,p_button_name=>'Refrescar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(119514564106420685)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Refrescar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
,p_grid_new_row=>'N'
,p_grid_column_span=>3
,p_grid_column=>5
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(109313448738839052)
,p_button_sequence=>170
,p_button_plug_id=>wwv_flow_api.id(129814013690407919)
,p_button_name=>'Reporte'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(119514564106420685)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Reporte'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-file-pdf-o'
,p_grid_new_row=>'N'
,p_grid_column_span=>3
,p_grid_column=>10
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166927431986260122)
,p_button_sequence=>180
,p_button_plug_id=>wwv_flow_api.id(129814013690407919)
,p_button_name=>'EXCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(119514564106420685)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Excel'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-file-excel-o'
,p_grid_new_row=>'N'
,p_grid_column_span=>3
,p_grid_column=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(103137133608073126)
,p_name=>'P135_PROVEEDOR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(129814013690407919)
,p_prompt=>'Proveedor'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_PROVEEDORES'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'PROV_CODIGO||'' - ''|| PROV_RAZON_SOCIAL||'' - ''||PROV_RUC RAZON_SOCIAL ,',
'PROV_CODIGO CODIGO ',
'',
'FROM FIN_PROVEEDOR P ',
'WHERE P.PROV_EMPR=:P_EMPRESA',
'AND P.PROV_EST_PROV = ''A''',
'ORDER BY 1 ASC'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_colspan=>3
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(119514174466420685)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET_FILTER'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(103137562185073127)
,p_name=>'P135_PROV_RAZON_SOCIAL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(129814013690407919)
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(119514024289420685)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(103137986017073127)
,p_name=>'P135_TELEFONO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(129814013690407919)
,p_prompt=>'Telefono'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(119514024289420685)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(103138319185073128)
,p_name=>'P135_PROV_CONTACTO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(129814013690407919)
,p_prompt=>'Contacto'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_colspan=>7
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(119514024289420685)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(103138711990073128)
,p_name=>'P135_FECHA_VENCIMIENTO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(129814013690407919)
,p_prompt=>'Fec. Vencimiento'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>3
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(119514024289420685)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(103139143924073129)
,p_name=>'P135_MONEDA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(129814013690407919)
,p_prompt=>'Moneda'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_MONEDA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select MON_DESC as display_value, MON_CODIGO as return_value ',
'  from GEN_MONEDA',
' where mon_empr = :p_empresa ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_colspan=>3
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(119514174466420685)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET_FILTER'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(103139518814073129)
,p_name=>'P135_MONEDA_DESC'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(129814013690407919)
,p_prompt=>'Moneda desc'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(119514024289420685)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(103139967675073129)
,p_name=>'P135_IND_SALDO_CERO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(129814013690407919)
,p_prompt=>'Saldo Cero'
,p_display_as=>'NATIVE_YES_NO'
,p_colspan=>3
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(119514024289420685)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'CUSTOM'
,p_attribute_02=>'S'
,p_attribute_03=>'SI'
,p_attribute_04=>'N'
,p_attribute_05=>'NO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(103140390639073130)
,p_name=>'P135_TIPO_ORDEN'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(129814013690407919)
,p_item_default=>'D'
,p_prompt=>'Tipo de Orden'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC:Documento;D,Fecha;F'
,p_colspan=>3
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(119514174466420685)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(103140796428073130)
,p_name=>'P135_IND_QUERY'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(129814013690407919)
,p_use_cache_before_default=>'NO'
,p_item_default=>'N'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(103141418399073131)
,p_name=>'P135_TOTAL_SALDO_PROV'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(131545251398888003)
,p_use_cache_before_default=>'NO'
,p_item_default=>'0'
,p_prompt=>'Total Imp. Saldo:'
,p_format_mask=>'999G999G999G999G990D00'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(119514036831420685)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(103141852326073132)
,p_name=>'P135_TOTAL_CUOTA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(131545251398888003)
,p_use_cache_before_default=>'NO'
,p_item_default=>'0'
,p_prompt=>'Total Comprobante:'
,p_format_mask=>'999G999G999G999G990D00'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(119514036831420685)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(103142249515073132)
,p_name=>'P135_TOTAL_PAGO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(131545251398888003)
,p_use_cache_before_default=>'NO'
,p_item_default=>'0'
,p_prompt=>'Total Imp. Pago:'
,p_format_mask=>'999G999G999G999G990D00'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(119514036831420685)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(109313764155839055)
,p_name=>'P135_NOMBRE_REPORTE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(129814013690407919)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(109313908303839056)
,p_name=>'P135_PARAMETROS'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(129814013690407919)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(207819945020822528)
,p_name=>'P135_IND_VER_OBS'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(129814013690407919)
,p_prompt=>'Ver Obs.'
,p_display_as=>'NATIVE_YES_NO'
,p_colspan=>3
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_display_when=>'P_EMPRESA'
,p_display_when2=>'2'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_field_template=>wwv_flow_api.id(119514024289420685)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'CUSTOM'
,p_attribute_02=>'S'
,p_attribute_03=>'SI'
,p_attribute_04=>'N'
,p_attribute_05=>'NO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(686030450812089416)
,p_name=>'P135_DESDE'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(129814013690407919)
,p_prompt=>'Filtrar Desde'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>3
,p_grid_column=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(119514024289420685)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(103142645311073136)
,p_name=>'accion_validar_proveedor'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P135_PROVEEDOR'
,p_condition_element=>'P135_PROVEEDOR'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103143205566073137)
,p_event_id=>wwv_flow_api.id(103142645311073136)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'null;',
':P135_PROV_RAZON_SOCIAL:=null;',
':P135_TELEFONO :=null; ',
':P135_PROV_CONTACTO:=null;'))
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103143673906073138)
,p_event_id=>wwv_flow_api.id(103142645311073136)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
' IF :P135_PROVEEDOR IS NOT NULL THEN ',
'',
'  SELECT PROV_RAZON_SOCIAL, PROV_TEL, nvl(PROV_PERS_CONTACTO,''NINGUNO'')',
'  INTO   :P135_PROV_RAZON_SOCIAL, :P135_telefono, :P135_PROV_CONTACTO',
'  FROM   FIN_PROVEEDOR',
'  WHERE  PROV_CODIGO = :P135_PROVEEDOR',
'    AND  PROV_EMPR =  :P_EMPRESA;',
' ',
' ELSE ',
'  RAISE_APPLICATION_ERROR(-20002,''Ingrese un Proveedor!'');',
'',
' END IF;',
'EXCEPTION',
'    WHEN NO_DATA_FOUND THEN',
'  RAISE_APPLICATION_ERROR(-20001,''Proveedor Inexistente!'');',
' end;'))
,p_attribute_02=>'P135_PROVEEDOR'
,p_attribute_03=>'P135_PROV_RAZON_SOCIAL,P135_TELEFONO,P135_PROV_CONTACTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103144186269073138)
,p_event_id=>wwv_flow_api.id(103142645311073136)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P135_FECHA_VENCIMIENTO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(103144518417073138)
,p_name=>'accion_validar_moneda'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P135_MONEDA'
,p_condition_element=>'P135_MONEDA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103145101142073139)
,p_event_id=>wwv_flow_api.id(103144518417073138)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
' IF :P135_MONEDA IS NOT NULL THEN ',
' ',
'    SELECT MON_DESC  INTO   :P135_MONEDA_DESC',
'      FROM GEN_MONEDA',
'     WHERE MON_CODIGO = :P135_MONEDA',
'       AND MON_EMPR = :P_EMPRESA;',
' ',
' end if;',
'',
'EXCEPTION',
'    WHEN NO_DATA_FOUND THEN',
'  RAISE_APPLICATION_ERROR(-20001,''Moneda Inexistente!'');',
'',
'end;'))
,p_attribute_02=>'P135_MONEDA'
,p_attribute_03=>'P135_MONEDA_DESC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103145556058073139)
,p_event_id=>wwv_flow_api.id(103144518417073138)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P135_IND_SALDO_CERO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103146051114073140)
,p_event_id=>wwv_flow_api.id(103144518417073138)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'  :P135_MONEDA_DESC:=null;'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(103146381661073140)
,p_name=>'pp_validar_fecha_vencimiento'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P135_FECHA_VENCIMIENTO'
,p_condition_element=>'P135_FECHA_VENCIMIENTO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103146848908073141)
,p_event_id=>wwv_flow_api.id(103146381661073140)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P135_MONEDA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(103148124110073142)
,p_name=>'next_item_tipo_orden'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P135_TIPO_ORDEN'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103148655191073142)
,p_event_id=>wwv_flow_api.id(103148124110073142)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(103136743681073125)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(103149040651073142)
,p_name=>'next_item_saldo_cero'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P135_IND_SALDO_CERO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103149531035073143)
,p_event_id=>wwv_flow_api.id(103149040651073142)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P135_IND_VER_OBS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(103149990971073143)
,p_name=>'refrescar_consulta'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(103136743681073125)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103150414646073144)
,p_event_id=>wwv_flow_api.id(103149990971073143)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    FINC015.PP_CARGA_CONSULTA_CUO(:P_EMPRESA , ',
'                                :P135_MONEDA,',
'                                :P135_PROVEEDOR,',
'                                TO_DATE(:P135_FECHA_VENCIMIENTO,''DD/MM/YYYY''),',
'                                :P135_IND_SALDO_CERO,',
'                                :P135_TIPO_ORDEN, ',
'                                :P135_TOTAL_CUOTA,',
'                                :P135_TOTAL_PAGO,',
'                                :P135_TOTAL_SALDO_PROV,',
'                                :APP_SESSION ,',
'                                :APP_USER,',
'                                 :P135_DESDE',
'                                 ); ',
' :P135_IND_QUERY:=''S'';',
'',
''))
,p_attribute_02=>'P135_PROVEEDOR,P135_MONEDA,P135_FECHA_VENCIMIENTO,P135_IND_SALDO_CERO,P135_TIPO_ORDEN,P135_IND_QUERY,P135_DESDE'
,p_attribute_03=>'P135_TOTAL_PAGO,P135_TOTAL_SALDO_PROV,P135_TOTAL_CUOTA,P135_IND_QUERY'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103150936740073144)
,p_event_id=>wwv_flow_api.id(103149990971073143)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(129812410035407903)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(109314389853839061)
,p_event_id=>wwv_flow_api.id(103149990971073143)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(109313448738839052)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166927688923260124)
,p_event_id=>wwv_flow_api.id(103149990971073143)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166927431986260122)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(103151375959073145)
,p_name=>'accion_cancelar'
,p_event_sequence=>100
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(103136316550073124)
,p_condition_element=>'P135_IND_QUERY'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'XXXX'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103151821311073145)
,p_event_id=>wwv_flow_api.id(103151375959073145)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P135_IND_QUERY:=''N'';'
,p_attribute_02=>'P135_IND_QUERY'
,p_attribute_03=>'P135_IND_QUERY'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103152388601073146)
,p_event_id=>wwv_flow_api.id(103151375959073145)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(129812410035407903)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103152813702073146)
,p_event_id=>wwv_flow_api.id(103151375959073145)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P135_PROVEEDOR,   P135_FECHA_VENCIMIENTO,    P135_MONEDA_DESC,    P135_MONEDA,  P135_TOTAL_SALDO_PROV,  P135_PROV_RAZON_SOCIAL,   P135_TOTAL_CUOTA,    P135_TELEFONO,    P135_TOTAL_PAGO,    P135_PROV_CONTACTO,     P135_IND_SALDO_CERO,     P135_TIPO_OR'
||'DEN'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(103153363855073147)
,p_event_id=>wwv_flow_api.id(103151375959073145)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P135_PROVEEDOR'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(106705216616260589)
,p_name=>'asignar_valor_query'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P135_PROVEEDOR'
,p_condition_element=>'P135_PROVEEDOR'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(106705384001260590)
,p_event_id=>wwv_flow_api.id(106705216616260589)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P135_IND_QUERY'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(106706388944260600)
,p_name=>'asignar_valor_query_1'
,p_event_sequence=>120
,p_condition_element=>'P135_PROVEEDOR'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(106706479095260601)
,p_event_id=>wwv_flow_api.id(106706388944260600)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P135_IND_QUERY'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(106707056478260607)
,p_event_id=>wwv_flow_api.id(106706388944260600)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(129812410035407903)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(109314537326839062)
,p_event_id=>wwv_flow_api.id(106706388944260600)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(109313448738839052)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166927519897260123)
,p_event_id=>wwv_flow_api.id(106706388944260600)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166927431986260122)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(106705878020260595)
,p_name=>'ASIGNAR_FOCO_PROVEEDOR'
,p_event_sequence=>130
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(106705928504260596)
,p_event_id=>wwv_flow_api.id(106705878020260595)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P135_PROVEEDOR'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(107445139048463896)
,p_name=>'get_excell'
,p_event_sequence=>140
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'document'
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_AT.FRT.GPV_IR_TO_MSEXCEL|DYNAMIC ACTION|ondownloadxlsx'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(107445266475463897)
,p_event_id=>wwv_flow_api.id(107445139048463896)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_AT.FRT.GPV_IR_TO_MSEXCEL'
,p_attribute_01=>'1000'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(109313573954839053)
,p_name=>'llamar_reporte'
,p_event_sequence=>150
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(109313448738839052)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(109313728441839054)
,p_event_id=>wwv_flow_api.id(109313573954839053)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'finc015.PP_LLAMAR_REPORT(:P_EMPRESA  ,',
'                          :P135_MONEDA  ,',
'                           :P135_PROVEEDOR,',
'                           :P135_FECHA_VENCIMIENTO  ,',
'                            :P135_IND_SALDO_CERO  ,',
'                            NVL(:P135_IND_VER_OBS,''N''),',
'                            :P135_TIPO_ORDEN   ,',
'                            :P_SUCURSAL  ,',
'                            :S_DESC_SUCURSAL ,',
'                            :P135_PROV_RAZON_SOCIAL  ,',
'                             :P135_MONEDA_DESC  ,',
'                            :P135_TELEFONO  ,',
'                            :P135_PROV_CONTACTO ,',
'                            :P135_TOTAL_SALDO_PROV  ,',
'                            :APP_USER,',
'                            :APP_SESSION ,',
'                        :P135_NOMBRE_REPORTE,',
'                        :P135_PARAMETROS) ;',
'--RAISE_APPLICATION_ERROR(-20003, :P135_PARAMETROS);',
''))
,p_attribute_02=>'P135_IND_VER_OBS,P_EMPRESA,P135_MONEDA,P135_PROVEEDOR,P135_FECHA_VENCIMIENTO,P135_IND_SALDO_CERO,P135_TIPO_ORDEN,P_SUCURSAL,S_DESC_SUCURSAL,P135_PROV_RAZON_SOCIAL,P135_MONEDA_DESC,P135_TELEFONO,P135_PROV_CONTACTO,P135_TOTAL_SALDO_PROV'
,p_attribute_03=>'P135_NOMBRE_REPORTE,P135_PARAMETROS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(109314042878839058)
,p_event_id=>wwv_flow_api.id(109313573954839053)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:var myWindow = window.open(''f?p=&APP_ID.:3010:&SESSION.::::::'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166927710050260125)
,p_name=>'llamar_excel'
,p_event_sequence=>160
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166927431986260122)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168602146938864734)
,p_event_id=>wwv_flow_api.id(166927710050260125)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_AT.FRT.GPV_IR_TO_MSEXCEL'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(129812410035407903)
,p_attribute_01=>'1000'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(207820036912822529)
,p_name=>'Next_item_orden'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P135_IND_VER_OBS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(207820190546822530)
,p_event_id=>wwv_flow_api.id(207820036912822529)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P135_TIPO_ORDEN'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(110434013369452479)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'BORRAR_ESTADO'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(103136316550073124)
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
