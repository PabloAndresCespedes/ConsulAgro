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
--   Date and Time:   10:49 Saturday June 25, 2022
--   Exported By:     PABLOC
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 158
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     211687171918188
--

begin
null;
end;
/
prompt --application/pages/delete_00158
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>158);
end;
/
prompt --application/pages/page_00158
begin
wwv_flow_api.create_page(
 p_id=>158
,p_user_interface_id=>wwv_flow_api.id(116263539932678213)
,p_name=>'FINI053- Cancel document'
,p_alias=>'FINI053-CANCELL-DOC'
,p_step_title=>unistr('FINI053- Cancelaci\00F3n de documentos')
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var lSpinner$;'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.selectorItem{transform: scale(1.5);}',
'.cursor{cursor:pointer;}'))
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'PABLOC'
,p_last_upd_yyyymmddhh24miss=>'20220625103948'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(680406194289347453)
,p_plug_name=>'Filtros'
,p_icon_css_classes=>'fa-filter'
,p_region_template_options=>'#DEFAULT#:t-Region--showIcon:t-Region--accent4:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(119469003339420663)
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>9
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(680406523903347456)
,p_plug_name=>unistr('Notas de Cr\00E9dito/ Adelantos Recibidas')
,p_region_name=>'NCR_REC'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(119469003339420663)
,p_plug_display_sequence=>90
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'    c.c001 doc_nro_doc,',
'    c.c002 doc_fec_doc,',
'    c.c003 doc_suc,',
'    c.c004 cuo_fec_vto,',
'    to_number(c.c005) cuo_imp_mon,',
'    to_number(c.c006) cuo_saldo_mon,',
'    to_number(c.c007) cuo_saldo_loc,',
'    c.c008 cuo_clave_doc,',
'    c.c009 doc_mon,',
'    c.c010 mon_dec_imp,',
'    c.c011 mon_dec_tasa,',
'    c.c012 mon_simbolo,',
'    c.c013 mon_tasa_vta,',
unistr('    -- solo edita el tag HTML agregando un atributo de CHECKED, para que indique al usuario que est\00E1 seleccionado'),
'    case when c.c001 = :P158_NCR_DOC_SELECT then ',
'       replace(c.c015, ''cursor"'', ''cursor" CHECKED'')',
'    else',
'    c.c015',
'    end seleccionar',
'from apex_collections c',
'where c.collection_name = ''NC_RECIBIDO'''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P158_NCR_DOC_SELECT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>unistr('Notas de Cr\00E9dito/ Adelantos Recibidas')
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
 p_id=>wwv_flow_api.id(681433451486168903)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'Sin registros'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'PABLOC'
,p_internal_uid=>681433451486168903
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681643249635043933)
,p_db_column_name=>'CUO_CLAVE_DOC'
,p_display_order=>10
,p_column_identifier=>'U'
,p_column_label=>'Cuota'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681642562786043926)
,p_db_column_name=>'DOC_NRO_DOC'
,p_display_order=>20
,p_column_identifier=>'N'
,p_column_label=>'Documento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681642656697043927)
,p_db_column_name=>'DOC_FEC_DOC'
,p_display_order=>30
,p_column_identifier=>'O'
,p_column_label=>unistr('Emisi\00F3n')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681642857206043929)
,p_db_column_name=>'CUO_FEC_VTO'
,p_display_order=>40
,p_column_identifier=>'Q'
,p_column_label=>'Venc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681642798882043928)
,p_db_column_name=>'DOC_SUC'
,p_display_order=>50
,p_column_identifier=>'P'
,p_column_label=>'Suc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681434649839168915)
,p_db_column_name=>'MON_SIMBOLO'
,p_display_order=>60
,p_column_identifier=>'L'
,p_column_label=>'Mon'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681643363134043934)
,p_db_column_name=>'DOC_MON'
,p_display_order=>100
,p_column_identifier=>'V'
,p_column_label=>'Doc Mon'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681643400724043935)
,p_db_column_name=>'MON_DEC_IMP'
,p_display_order=>110
,p_column_identifier=>'W'
,p_column_label=>'Mon Dec Imp'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681643527728043936)
,p_db_column_name=>'MON_DEC_TASA'
,p_display_order=>120
,p_column_identifier=>'X'
,p_column_label=>'Mon Dec Tasa'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681643682481043937)
,p_db_column_name=>'MON_TASA_VTA'
,p_display_order=>130
,p_column_identifier=>'Y'
,p_column_label=>'Mon Tasa Vta'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(682111854409099710)
,p_db_column_name=>'CUO_IMP_MON'
,p_display_order=>140
,p_column_identifier=>'Z'
,p_column_label=>'Importe'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(682111935805099711)
,p_db_column_name=>'CUO_SALDO_MON'
,p_display_order=>150
,p_column_identifier=>'AA'
,p_column_label=>'Saldo Mon'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(682112016609099712)
,p_db_column_name=>'CUO_SALDO_LOC'
,p_display_order=>160
,p_column_identifier=>'AB'
,p_column_label=>'Saldo Loc'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(682112747482099719)
,p_db_column_name=>'SELECCIONAR'
,p_display_order=>170
,p_column_identifier=>'AC'
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
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(681449012195252101)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6814491'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'CUO_CLAVE_DOC:DOC_NRO_DOC:DOC_FEC_DOC:CUO_FEC_VTO:DOC_SUC:MON_SIMBOLO:CUO_IMP_MON:CUO_SALDO_LOC:CUO_SALDO_MON::SELECCIONAR'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(680406946128347456)
,p_plug_name=>unistr('Notas de Cr\00E9ditos Emitidas / Adelanto Cliente')
,p_region_name=>'NCR_EMI'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(119469003339420663)
,p_plug_display_sequence=>110
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'    c.c001 doc_nro_doc,',
'    c.c002 doc_fec_doc,',
'    c.c003 doc_suc,',
'    c.c004 cuo_fec_vto,',
'    to_number(c.c005) cuo_imp_mon,',
'    to_number(c.c006) cuo_saldo_mon,',
'    to_number(c.c007) cuo_saldo_loc,',
'    c.c008 cuo_clave_doc,',
'    c.c009 doc_mon,',
'    to_number(c.c010) mon_dec_imp,',
'    to_number(c.c011) mon_dec_tasa,',
'    c.c012 mon_simbolo,',
'    c.c013 mon_tasa_vta,',
'    c.c014 doc_clave_scli,',
unistr('    -- solo edita el tag HTML agregando un atributo de CHECKED, para que indique al usuario que est\00E1 seleccionado'),
'    case when c.c001 = :P158_NC_DOC_SELECT then ',
'       replace(c.c015, ''cursor"'', ''cursor" CHECKED'')',
'    else',
'    c.c015',
'    end seleccionar',
'from apex_collections c',
'where c.collection_name = ''NC_EMISION'''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P158_NC_DOC_SELECT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>unistr('Notas de Cr\00E9ditos Emitidas / Adelanto Cliente')
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
 p_id=>wwv_flow_api.id(681435348444168922)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'Sin Registros'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'PABLOC'
,p_internal_uid=>681435348444168922
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681640605716043907)
,p_db_column_name=>'DOC_CLAVE_SCLI'
,p_display_order=>20
,p_column_identifier=>'AA'
,p_column_label=>'Doc Clave Scli'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681640278778043903)
,p_db_column_name=>'DOC_MON'
,p_display_order=>30
,p_column_identifier=>'W'
,p_column_label=>'Doc Mon'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681640578042043906)
,p_db_column_name=>'MON_TASA_VTA'
,p_display_order=>60
,p_column_identifier=>'Z'
,p_column_label=>'Mon Tasa Vta'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681733855018287236)
,p_db_column_name=>'MON_DEC_IMP'
,p_display_order=>70
,p_column_identifier=>'AE'
,p_column_label=>'Mon Dec Imp'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681733906433287237)
,p_db_column_name=>'MON_DEC_TASA'
,p_display_order=>80
,p_column_identifier=>'AF'
,p_column_label=>'Mon Dec Tasa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681478845331657245)
,p_db_column_name=>'DOC_NRO_DOC'
,p_display_order=>90
,p_column_identifier=>'O'
,p_column_label=>'Documento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681478981118657246)
,p_db_column_name=>'DOC_FEC_DOC'
,p_display_order=>100
,p_column_identifier=>'P'
,p_column_label=>unistr('Emisi\00F3n')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681479179314657248)
,p_db_column_name=>'CUO_FEC_VTO'
,p_display_order=>110
,p_column_identifier=>'R'
,p_column_label=>'Venc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681479052310657247)
,p_db_column_name=>'DOC_SUC'
,p_display_order=>120
,p_column_identifier=>'Q'
,p_column_label=>'Suc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681436543183168934)
,p_db_column_name=>'MON_SIMBOLO'
,p_display_order=>130
,p_column_identifier=>'L'
,p_column_label=>'Mon'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681640153318043902)
,p_db_column_name=>'CUO_CLAVE_DOC'
,p_display_order=>140
,p_column_identifier=>'V'
,p_column_label=>'Cuota'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681730507220287203)
,p_db_column_name=>'SELECCIONAR'
,p_display_order=>150
,p_column_identifier=>'AB'
,p_column_label=>'Seleccionar'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681733608865287234)
,p_db_column_name=>'CUO_SALDO_MON'
,p_display_order=>170
,p_column_identifier=>'AC'
,p_column_label=>'Saldo Mon'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681733763187287235)
,p_db_column_name=>'CUO_SALDO_LOC'
,p_display_order=>180
,p_column_identifier=>'AD'
,p_column_label=>'Saldo Loc'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681734008393287238)
,p_db_column_name=>'CUO_IMP_MON'
,p_display_order=>190
,p_column_identifier=>'AG'
,p_column_label=>'Importe'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(681466224286381720)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6814663'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'CUO_CLAVE_DOC:DOC_NRO_DOC:DOC_FEC_DOC:CUO_FEC_VTO:DOC_SUC:MON_SIMBOLO:CUO_IMP_MON:CUO_SALDO_LOC:CUO_SALDO_MON:SELECCIONAR:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(681437364305168942)
,p_plug_name=>'Facturas/Not. Deb. Recibidas'
,p_region_name=>'FACT_REC'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(119469003339420663)
,p_plug_display_sequence=>100
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'    c.c001 doc_nro_doc,',
'    c.c002 doc_fec_doc,',
'    c.c003 doc_suc,',
'    c.c004 cuo_fec_vto,',
'    to_number(c.c005) cuo_imp_mon,',
'    to_number(c.c006) cuo_saldo_mon,',
'    to_number(c.c007) cuo_saldo_loc,',
'    c.c008 cuo_clave_doc,',
'    c.c009 doc_mon,',
'    c.c010 mon_dec_imp,',
'    c.c011 mon_dec_tasa,',
'    c.c012 mon_simbolo,',
'    c.c013 mon_tasa_vta,',
unistr('    -- solo edita el tag HTML agregando un atributo de CHECKED, para que indique al usuario que est\00E1 seleccionado'),
'    case when c.c001 = :P158_FCR_DOC_SELECT then ',
'       replace(c.c015, ''cursor"'', ''cursor" CHECKED'')',
'    else',
'     c.c015',
'    end seleccionar',
'from apex_collections c',
'where c.collection_name = ''FC_RECIBIDO'''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P158_FCR_DOC_SELECT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Facturas/Not. Deb. Recibidas'
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
 p_id=>wwv_flow_api.id(681437460011168943)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'Sin Registros'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'PABLOC'
,p_internal_uid=>681437460011168943
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681644530317043946)
,p_db_column_name=>'DOC_MON'
,p_display_order=>10
,p_column_identifier=>'V'
,p_column_label=>'Mon'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681644630613043947)
,p_db_column_name=>'MON_DEC_IMP'
,p_display_order=>20
,p_column_identifier=>'W'
,p_column_label=>'Mon Dec Imp'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681644728901043948)
,p_db_column_name=>'MON_DEC_TASA'
,p_display_order=>30
,p_column_identifier=>'X'
,p_column_label=>'Mon Dec Tasa'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681644842903043949)
,p_db_column_name=>'MON_TASA_VTA'
,p_display_order=>40
,p_column_identifier=>'Y'
,p_column_label=>'Mon Tasa Vta'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681644420068043945)
,p_db_column_name=>'CUO_CLAVE_DOC'
,p_display_order=>50
,p_column_identifier=>'U'
,p_column_label=>'Cuota'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681643796326043938)
,p_db_column_name=>'DOC_NRO_DOC'
,p_display_order=>60
,p_column_identifier=>'N'
,p_column_label=>'Documento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681643823340043939)
,p_db_column_name=>'DOC_FEC_DOC'
,p_display_order=>70
,p_column_identifier=>'O'
,p_column_label=>unistr('Emisi\00F3n')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681644017914043941)
,p_db_column_name=>'CUO_FEC_VTO'
,p_display_order=>80
,p_column_identifier=>'Q'
,p_column_label=>'Venc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681643945793043940)
,p_db_column_name=>'DOC_SUC'
,p_display_order=>90
,p_column_identifier=>'P'
,p_column_label=>'Suc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681474856489657205)
,p_db_column_name=>'MON_SIMBOLO'
,p_display_order=>100
,p_column_identifier=>'L'
,p_column_label=>'Mon'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(682112143710099713)
,p_db_column_name=>'CUO_IMP_MON'
,p_display_order=>110
,p_column_identifier=>'Z'
,p_column_label=>'Importe'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(682112268121099714)
,p_db_column_name=>'CUO_SALDO_MON'
,p_display_order=>120
,p_column_identifier=>'AA'
,p_column_label=>'Saldo Mon'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(682112325466099715)
,p_db_column_name=>'CUO_SALDO_LOC'
,p_display_order=>130
,p_column_identifier=>'AB'
,p_column_label=>'Saldo Loc'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(682114055819099732)
,p_db_column_name=>'SELECCIONAR'
,p_display_order=>140
,p_column_identifier=>'AC'
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
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(681505004045747717)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6815051'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'CUO_CLAVE_DOC:DOC_NRO_DOC:DOC_FEC_DOC:CUO_FEC_VTO:DOC_SUC:MON_SIMBOLO:CUO_IMP_MON:CUO_SALDO_LOC:CUO_SALDO_MON::SELECCIONAR'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(681475604596657213)
,p_plug_name=>unistr('Facturas Emitidas / Notas D\00E9bito')
,p_region_name=>'FACT_EMI'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(119469003339420663)
,p_plug_display_sequence=>120
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'    c.c001 doc_nro_doc,',
'    c.c002 doc_fec_doc,',
'    c.c003 doc_suc,',
'    c.c004 cuo_fec_vto,',
'    to_number(c.c005) cuo_imp_mon,',
'    to_number(c.c006) cuo_saldo_mon,',
'    to_number(c.c007) cuo_saldo_loc,',
'    c.c008 cuo_clave_doc,',
'    c.c009 doc_mon,',
'    c.c010 mon_dec_imp,',
'    c.c011 mon_dec_tasa,',
'    c.c012 mon_simbolo,',
'    c.c013 mon_tasa_vta,',
'    c.c014 doc_clave_scli,',
unistr('    -- solo edita el tag HTML agregando un atributo de CHECKED, para que indique al usuario que est\00E1 seleccionado'),
'    case when c.c001 = :P158_FC_DOC_SELECT then ',
'       replace(c.c015, ''cursor"'', ''cursor" CHECKED'')',
'    else',
'     c.c015',
'    end seleccionar',
'from apex_collections c',
'where c.collection_name = ''FC_EMISION'''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P158_FC_DOC_SELECT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>unistr('Facturas Emitidas / Notas D\00E9bito')
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
 p_id=>wwv_flow_api.id(681475732354657214)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'Sin Registros'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'PABLOC'
,p_internal_uid=>681475732354657214
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681642114261043922)
,p_db_column_name=>'MON_DEC_IMP'
,p_display_order=>10
,p_column_identifier=>'X'
,p_column_label=>'Mon Dec Imp'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681642211089043923)
,p_db_column_name=>'MON_DEC_TASA'
,p_display_order=>20
,p_column_identifier=>'Y'
,p_column_label=>'Mon Dec Tasa'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681642324088043924)
,p_db_column_name=>'MON_TASA_VTA'
,p_display_order=>30
,p_column_identifier=>'Z'
,p_column_label=>'Mon Tasa Vta'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681642463904043925)
,p_db_column_name=>'DOC_CLAVE_SCLI'
,p_display_order=>40
,p_column_identifier=>'AA'
,p_column_label=>'Doc Clave Scli'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681642017785043921)
,p_db_column_name=>'DOC_MON'
,p_display_order=>50
,p_column_identifier=>'W'
,p_column_label=>'Doc Mon'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681641263294043913)
,p_db_column_name=>'DOC_NRO_DOC'
,p_display_order=>60
,p_column_identifier=>'O'
,p_column_label=>'Documento'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681641356531043914)
,p_db_column_name=>'DOC_FEC_DOC'
,p_display_order=>70
,p_column_identifier=>'P'
,p_column_label=>unistr('Emisi\00F3n')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681641567836043916)
,p_db_column_name=>'CUO_FEC_VTO'
,p_display_order=>80
,p_column_identifier=>'R'
,p_column_label=>'Venc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681641441241043915)
,p_db_column_name=>'DOC_SUC'
,p_display_order=>90
,p_column_identifier=>'Q'
,p_column_label=>'Suc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681476930011657226)
,p_db_column_name=>'MON_SIMBOLO'
,p_display_order=>100
,p_column_identifier=>'L'
,p_column_label=>'Mon'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681641981328043920)
,p_db_column_name=>'CUO_CLAVE_DOC'
,p_display_order=>140
,p_column_identifier=>'V'
,p_column_label=>'Cuota'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681730670401287204)
,p_db_column_name=>'SELECCIONAR'
,p_display_order=>150
,p_column_identifier=>'AB'
,p_column_label=>'Seleccionar'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681734113658287239)
,p_db_column_name=>'CUO_IMP_MON'
,p_display_order=>160
,p_column_identifier=>'AC'
,p_column_label=>'Importe'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681734280527287240)
,p_db_column_name=>'CUO_SALDO_MON'
,p_display_order=>170
,p_column_identifier=>'AD'
,p_column_label=>'Saldo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(681734392147287241)
,p_db_column_name=>'CUO_SALDO_LOC'
,p_display_order=>180
,p_column_identifier=>'AE'
,p_column_label=>'Saldo Loc'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(681505698690747731)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6815057'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'CUO_CLAVE_DOC:DOC_NRO_DOC:DOC_FEC_DOC:CUO_FEC_VTO:DOC_SUC:MON_SIMBOLO:CUO_IMP_MON:CUO_SALDO_MON:CUO_SALDO_LOC:SELECCIONAR:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(681478285173657239)
,p_plug_name=>'Detalle y totales'
,p_region_template_options=>'#DEFAULT#:t-Region--accent14:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(119469003339420663)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(681640961889043910)
,p_plug_name=>'{errorMsg}'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(119448057137420653)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(681735244538287250)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(681478285173657239)
,p_button_name=>'CONFIRM'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--success:t-Button--stretch:t-Button--padTop'
,p_button_template_id=>wwv_flow_api.id(119514454130420685)
,p_button_image_alt=>'Confirmar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(679345725988094246)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(680406194289347453)
,p_button_name=>'F_CONSULTAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(119514454130420685)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Consultar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'u-pullRight'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(681732885802287226)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(680406946128347456)
,p_button_name=>'RESET_NC_EMIT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--warning'
,p_button_template_id=>wwv_flow_api.id(119514454130420685)
,p_button_image_alt=>'Borrar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(681733292843287230)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(681475604596657213)
,p_button_name=>'RESET_FC_EMIT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--warning'
,p_button_template_id=>wwv_flow_api.id(119514454130420685)
,p_button_image_alt=>'Borrar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(682114146258099733)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(680406523903347456)
,p_button_name=>'RESET_NCR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--warning'
,p_button_template_id=>wwv_flow_api.id(119514454130420685)
,p_button_image_alt=>'Borrar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(682114522373099737)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(681437364305168942)
,p_button_name=>'RESET_FCR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--warning'
,p_button_template_id=>wwv_flow_api.id(119514454130420685)
,p_button_image_alt=>'Borrar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(679343404536094223)
,p_name=>'P158_F_FECHA_OPERACION'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(680406194289347453)
,p_item_default=>'current_date'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>unistr('Fecha Operaci\00F3n')
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(119514174466420685)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(679343539337094224)
,p_name=>'P158_F_TIPO_MOV'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(680406194289347453)
,p_prompt=>'Tipo Movimiento'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select tmov_codigo ||'' - ''||tmov_desc d,',
'       tmov_codigo r',
'from gen_tipo_mov',
'where tmov_empr= :p_empresa',
'and tmov_codigo in',
'(',
'    select f.conf_recibo_cncr_rec',
'    from fin_configuracion f ',
'    where f.conf_empr = :p_empresa',
'    union all',
'    select f.conf_recibo_cncr_emit',
'    from fin_configuracion f ',
'    where f.conf_empr = :p_empresa',
'    union all',
'    select f.conf_recibo_cadcli_emit',
'    from fin_configuracion f ',
'    where f.conf_empr = :p_empresa',
'    union all',
'    select f.conf_recibo_cadpro_rec',
'    from fin_configuracion f ',
'    where f.conf_empr = :p_empresa',
')',
'order by 1'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(119514174466420685)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(679343605935094225)
,p_name=>'P158_F_PROVEEDOR'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(680406194289347453)
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
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(119514024289420685)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(679343743711094226)
,p_name=>'P158_F_MONEDA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(680406194289347453)
,p_prompt=>'Moneda'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_MONEDA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select MON_DESC as display_value, MON_CODIGO as return_value ',
'  from GEN_MONEDA',
' where mon_empr = :p_empresa ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(119514174466420685)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(679344593777094234)
,p_name=>'P158_F_CLIENTE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(680406194289347453)
,p_prompt=>'Cliente'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CLIENTES_FINI'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cli_codigo || '' - ''||cli_nom, cli_codigo',
'  from fin_cliente, fin_cli_empresa',
' where cli_codigo = clem_cli',
'   and clem_empr = :p_empresa',
'   AND CLI_EMPR = CLEM_EMPR',
'   and cli_est_cli <> ''I''',
' order by 1',
''))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(119514024289420685)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_08=>'650'
,p_attribute_09=>'650'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(679344622794094235)
,p_name=>'P158_IND_ER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(680406194289347453)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(681478374924657240)
,p_name=>'P158_DT_TOTAL_NC'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(681478285173657239)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Total Nota Cr\00E9dito/Adel.')
,p_source=>'0'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(119514036831420685)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(681478425705657241)
,p_name=>'P158_DT_DOCUMENTO_NC'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(681478285173657239)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Documento NC/Adelanto'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(119514036831420685)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(681478647496657243)
,p_name=>'P158_DT_DOCUMENTO_FC'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(681478285173657239)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Documento Factura/Not. Deb.'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(119514036831420685)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(681478750054657244)
,p_name=>'P158_DT_TOTAL_FC'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(681478285173657239)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Total Factura/Not. Deb.'
,p_source=>'0'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(119514036831420685)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(681641018435043911)
,p_name=>'P158_ERROR_TEXT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(681640961889043910)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(681730904452287207)
,p_name=>'P158_NC_DOC_SELECT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(680406946128347456)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(681731056363287208)
,p_name=>'P158_NC_MONTO_SELECT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(680406946128347456)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(681731380193287211)
,p_name=>'P158_FC_DOC_SELECT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(681475604596657213)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(681731490536287212)
,p_name=>'P158_FC_MONTO_SELECT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(681475604596657213)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(682110926261099701)
,p_name=>'P158_ERROR_CONFIRM'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(681478285173657239)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(682112584187099717)
,p_name=>'P158_NCR_DOC_SELECT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(680406523903347456)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(682112649755099718)
,p_name=>'P158_NCR_MONTO_SELECT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(680406523903347456)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(682113392241099725)
,p_name=>'P158_FCR_DOC_SELECT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(681437364305168942)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(682113442063099726)
,p_name=>'P158_FCR_MONTO_SELECT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(681437364305168942)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(679344842556094237)
,p_name=>'get ind ER'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P158_F_TIPO_MOV'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(679344999004094238)
,p_event_id=>wwv_flow_api.id(679344842556094237)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P158_IND_ER := fini053.get_tipo_mov_er(in_tipo_mov => :P158_F_TIPO_MOV, in_empresa => :p_empresa);'
,p_attribute_02=>'P158_F_TIPO_MOV'
,p_attribute_03=>'P158_IND_ER'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(681644963658043950)
,p_name=>'get data'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(679345725988094246)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681732615454287224)
,p_event_id=>wwv_flow_api.id(681644963658043950)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'lSpinner$ = apex.util.showSpinner( $( "body" ) )'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681641170195043912)
,p_event_id=>wwv_flow_api.id(681644963658043950)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    fini053.generate_query(',
'      in_fecha_op  => :P158_F_FECHA_OPERACION,',
'      in_cliente   => :P158_F_CLIENTE,',
'      in_proveedor => :P158_F_PROVEEDOR,',
'      in_tipo_mov  => :P158_F_TIPO_MOV,',
'      in_mnd       => :P158_F_MONEDA,',
'      in_empresa   => :P_EMPRESA,',
'      in_suc       => :P_SUCURSAL,',
'      in_ind_er    => :P158_IND_ER,',
'      in_user      => :app_user,',
'      out_error    => :P158_ERROR_TEXT',
'    );',
'end;'))
,p_attribute_02=>'P158_F_FECHA_OPERACION,P158_F_CLIENTE,P158_F_PROVEEDOR,P158_F_TIPO_MOV,P158_F_MONEDA,P_EMPRESA,P158_IND_ER,P_SUCURSAL'
,p_attribute_03=>'P158_ERROR_TEXT'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681731787672287215)
,p_event_id=>wwv_flow_api.id(681644963658043950)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P158_NC_DOC_SELECT,P158_FC_DOC_SELECT,P158_NC_MONTO_SELECT,P158_FC_MONTO_SELECT,P158_NCR_DOC_SELECT,P158_NCR_MONTO_SELECT,P158_FCR_DOC_SELECT,P158_FCR_MONTO_SELECT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(679345240730094241)
,p_name=>'change type mov'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P158_IND_ER'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(679345855541094247)
,p_event_id=>wwv_flow_api.id(679345240730094241)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let iProv = apex.item(''P158_F_PROVEEDOR'');',
'let iCli  = apex.item(''P158_F_CLIENTE'');',
'let regRec  = [''FACT_REC'', ''NCR_REC''];',
'let regEmit = [''FACT_EMI'', ''NCR_EMI''];',
'/*',
'  E: Emitidos',
'  R: Recibidos',
'  I: Indefinido || nulo',
'*/',
'function indTipo (indD) {',
'  var optionInd = {',
'    ''E'': function () {',
'      iProv.hide();',
'      iProv.setValue('''', '''', true);  ',
'      iCli.show();',
'      $x_Show(regEmit);',
'      $x_Hide(regRec);',
'    },',
'    ''R'': function () {',
'      iCli.hide();',
'      iCli.setValue('''', '''', true);',
'      iProv.show();',
'      $x_Show(regRec);',
'      $x_Hide(regEmit);',
'    },',
'    ''I'': function () {',
'      iProv.hide();',
'      iCli.hide();',
'      iCli.setValue('''', '''', true);',
'      iProv.setValue('''', '''', true);',
'      $x_Hide(regEmit.concat(regRec));',
'    }',
'  };',
'  return (optionInd[indD] || optionInd[''I''])();',
'}',
'',
'var actionInd = indTipo( apex.item(''P158_IND_ER'').getValue() );',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(681731197253287209)
,p_name=>'refresh region CHECKED'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P158_NC_DOC_SELECT'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681731214821287210)
,p_event_id=>wwv_flow_api.id(681731197253287209)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(680406946128347456)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681734486722287242)
,p_event_id=>wwv_flow_api.id(681731197253287209)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.item(''P158_DT_DOCUMENTO_NC'').setValue($v(''P158_NC_DOC_SELECT''))'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(682112888922099720)
,p_name=>'refresh region CHECKED NCR'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P158_NCR_DOC_SELECT'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682112943323099721)
,p_event_id=>wwv_flow_api.id(682112888922099720)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(680406523903347456)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682113089560099722)
,p_event_id=>wwv_flow_api.id(682112888922099720)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.item(''P158_DT_DOCUMENTO_NC'').setValue($v(''P158_NCR_DOC_SELECT''))'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(681731520889287213)
,p_name=>'Refresh region FC'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P158_FC_DOC_SELECT'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681734904857287247)
,p_event_id=>wwv_flow_api.id(681731520889287213)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.item(''P158_DT_DOCUMENTO_FC'').setValue($v(''P158_FC_DOC_SELECT''))'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681731693657287214)
,p_event_id=>wwv_flow_api.id(681731520889287213)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(681475604596657213)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(682113542084099727)
,p_name=>'Refresh region FCR'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P158_FCR_DOC_SELECT'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682113699748099728)
,p_event_id=>wwv_flow_api.id(682113542084099727)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(681437364305168942)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682113763488099729)
,p_event_id=>wwv_flow_api.id(682113542084099727)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.item(''P158_DT_DOCUMENTO_FC'').setValue($v(''P158_FCR_DOC_SELECT''))'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(681731895261287216)
,p_name=>'show or view error Refresh'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P158_ERROR_TEXT'
,p_condition_element=>'P158_ERROR_TEXT'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'NO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681731973033287217)
,p_event_id=>wwv_flow_api.id(681731895261287216)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.clearErrors();',
'lSpinner$.remove();',
'',
'let error = apex.item(''P158_ERROR_TEXT'');',
'let indER = apex.item(''P158_IND_ER'').getValue();',
'',
'if(error.isEmpty() || error.getValue()){ ',
'    if(indER == ''E''){',
'        apex.region(''FACT_EMI'').refresh();',
'        apex.region(''NCR_EMI'').refresh();',
'    }else if(indER == ''R''){',
'        apex.region(''FACT_REC'').refresh();',
'        apex.region(''NCR_REC'').refresh();',
'    }',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681732763266287225)
,p_event_id=>wwv_flow_api.id(681731895261287216)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'lSpinner$.remove();'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681732571229287223)
,p_event_id=>wwv_flow_api.id(681731895261287216)
,p_event_result=>'FALSE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'DANGER'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'5000'
,p_attribute_05=>'TOP'
,p_attribute_06=>'JSSTRING'
,p_attribute_08=>'slideUp'
,p_attribute_09=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var msg = apex.item(''P158_ERROR_TEXT'').getValue();',
'return msg;'))
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(681732977388287227)
,p_name=>'reset NC EMIT'
,p_event_sequence=>100
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(681732885802287226)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681733027503287228)
,p_event_id=>wwv_flow_api.id(681732977388287227)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P158_NC_DOC_SELECT,P158_NC_MONTO_SELECT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681733196641287229)
,p_event_id=>wwv_flow_api.id(681732977388287227)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(680406946128347456)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(681733325242287231)
,p_name=>'reset FC EMIT'
,p_event_sequence=>110
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(681733292843287230)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681733403344287232)
,p_event_id=>wwv_flow_api.id(681733325242287231)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P158_FC_DOC_SELECT,P158_DT_TOTAL_FC'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681733543197287233)
,p_event_id=>wwv_flow_api.id(681733325242287231)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(681475604596657213)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(681734503988287243)
,p_name=>'set value Total Region NC'
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P158_NC_MONTO_SELECT'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681734672487287244)
,p_event_id=>wwv_flow_api.id(681734503988287243)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let iTotal = ''P158_DT_TOTAL_NC'';',
'',
'apex.item(iTotal).setValue($v(''P158_NC_MONTO_SELECT''));',
'',
'$(''#''+iTotal).autoNumeric(''update'',{mDec:2});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(682113162359099723)
,p_name=>'set value Total Region NCR'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P158_NCR_MONTO_SELECT'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682113240734099724)
,p_event_id=>wwv_flow_api.id(682113162359099723)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let iTotal = ''P158_DT_TOTAL_NC'';',
'',
'apex.item(iTotal).setValue($v(''P158_NCR_MONTO_SELECT''));',
'',
'$(''#''+iTotal).autoNumeric(''update'',{mDec:2});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(681734798643287245)
,p_name=>'set value Total Region FC'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P158_FC_MONTO_SELECT'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(681734852881287246)
,p_event_id=>wwv_flow_api.id(681734798643287245)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let iTotal = ''P158_DT_TOTAL_FC'';',
'',
'apex.item(iTotal).setValue($v(''P158_FC_MONTO_SELECT''));',
'',
'$(''#''+iTotal).autoNumeric(''update'',{mDec:2});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(682113800801099730)
,p_name=>'set value Total Region FCR'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P158_FCR_MONTO_SELECT'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682113920734099731)
,p_event_id=>wwv_flow_api.id(682113800801099730)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let iTotal = ''P158_DT_TOTAL_FC'';',
'',
'apex.item(iTotal).setValue($v(''P158_FCR_MONTO_SELECT''));',
'',
'$(''#''+iTotal).autoNumeric(''update'',{mDec:2});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(682111081800099702)
,p_name=>'Confirm cancelation'
,p_event_sequence=>160
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(681735244538287250)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682111789346099709)
,p_event_id=>wwv_flow_api.id(682111081800099702)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'lSpinner$ = apex.util.showSpinner( $( "body" ) )'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682111121902099703)
,p_event_id=>wwv_flow_api.id(682111081800099702)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    fini053.confirm(in_user => :app_user);',
'    ',
'    :P158_ERROR_CONFIRM := null;',
'exception',
'    when others then',
'        :P158_ERROR_CONFIRM := replace(sqlerrm, ''ORA-20000:'', '''');',
'end;'))
,p_attribute_03=>'P158_ERROR_CONFIRM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(682111216873099704)
,p_name=>'refresh region Detail'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P158_ERROR_CONFIRM'
,p_condition_element=>'P158_ERROR_CONFIRM'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682111388875099705)
,p_event_id=>wwv_flow_api.id(682111216873099704)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.clearErrors();',
'lSpinner$.remove();',
'',
'let error = apex.item(''P158_ERROR_TEXT'');',
'let indER = apex.item(''P158_IND_ER'').getValue();',
'',
'if(error.isEmpty() || error.getValue()){ ',
'    if(indER == ''E''){',
'        apex.region(''FACT_EMI'').refresh();',
'        apex.region(''NCR_EMI'').refresh();',
'    }else if(indER == ''R''){',
'        apex.region(''FACT_REC'').refresh();',
'        apex.region(''NCR_REC'').refresh();',
'    }',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682111520392099707)
,p_event_id=>wwv_flow_api.id(682111216873099704)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'lSpinner$.remove();'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682111633241099708)
,p_event_id=>wwv_flow_api.id(682111216873099704)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'DANGER'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'5000'
,p_attribute_05=>'TOP'
,p_attribute_06=>'JSSTRING'
,p_attribute_08=>'slideUp'
,p_attribute_09=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var msg = apex.item(''P158_ERROR_CONFIRM'').getValue();',
'return msg;'))
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(682114286109099734)
,p_name=>'reset NCR'
,p_event_sequence=>180
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(682114146258099733)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682114373737099735)
,p_event_id=>wwv_flow_api.id(682114286109099734)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P158_NCR_DOC_SELECT,P158_NCR_MONTO_SELECT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682114421475099736)
,p_event_id=>wwv_flow_api.id(682114286109099734)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(680406523903347456)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(682114692417099738)
,p_name=>'reset FCR'
,p_event_sequence=>190
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(682114522373099737)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682114731663099739)
,p_event_id=>wwv_flow_api.id(682114692417099738)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P158_FCR_DOC_SELECT,P158_FCR_MONTO_SELECT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(682114859093099740)
,p_event_id=>wwv_flow_api.id(682114692417099738)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(681437364305168942)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(681730466321287202)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'clear data collections'
,p_process_sql_clob=>'APEX_COLLECTION.DELETE_ALL_COLLECTIONS_SESSION;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CONFIRM'
,p_process_when_type=>'REQUEST_NOT_EQUAL_CONDITION'
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
