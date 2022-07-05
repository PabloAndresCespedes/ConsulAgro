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
,p_default_application_id=>103
,p_default_id_offset=>11642113274976466203
,p_default_owner=>'ADCS'
);
end;
/
 
prompt APPLICATION 103 - RECURSOS HUMANOS
--
-- Application Export:
--   Application:     103
--   Name:            RECURSOS HUMANOS
--   Date and Time:   11:13 Tuesday July 5, 2022
--   Exported By:     PABLOC
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 3528
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     211687171918188
--

begin
null;
end;
/
prompt --application/pages/delete_03528
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>3528);
end;
/
prompt --application/pages/page_03528
begin
wwv_flow_api.create_page(
 p_id=>3528
,p_user_interface_id=>wwv_flow_api.id(11101499539877346277)
,p_name=>'PERL051-TABLERO DE CAPITAL HUMANO -J.S.A'
,p_step_title=>'PERL051-TABLERO DE CAPITAL HUMANO -J.S.A'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#wwvFlowForm > div:nth-child(15){',
'    width: 1200px !important;',
'}',
'',
'td[headers="EDITARR"] {',
'  overflow: visible;',
'   font-weight: bold;',
'     font-size:130%;',
'  line-height: 3rem;',
'}',
'td[headers="CHICO"] {',
'  overflow: visible;',
'   font-weight: bold;',
'  line-height: 0.5rem;',
'}',
'td[headers="EDITARR2"] {',
'  overflow: visible;',
'   font-weight: bold;',
'     font-size:120%;',
'  line-height: 1.8rem;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'PABLOC'
,p_last_upd_yyyymmddhh24miss=>'20220705094910'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10982579091552464459)
,p_plug_name=>'ROTACION POR CARGO'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>300
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10982579046441464458)
,p_plug_name=>'ROTACION CARGO'
,p_parent_plug_id=>wwv_flow_api.id(10982579091552464459)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>8
,p_plug_display_column=>4
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    SELECT  0 ORDEN,''INDICADOR'' DETALLE, C014 MES1, C015 MES2, C016 MES3, ''A'' PINTAR, 0 COD_DPTO_AREA, 0 COD_SUC, 0 DPTO',
'     FROM APEX_COLLECTIONS F',
'     WHERE COLLECTION_NAME = ''IND_ROTACION_CARGO''',
'   GROUP BY C014, C015, C016',
' UNION ALL ',
' SELECT  0 ORDEN ,''INDICE DE ROTACION'' DETALLE,  ',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C005), 0))) / DECODE(SUM(NVL(TO_NUMBER(C006), 0)), 0,1,SUM(NVL(TO_NUMBER(C006), 0)))))* 100,2),''990d99'')||''%'' MES1,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C007), 0))) /DECODE(SUM(NVL(TO_NUMBER(C008), 0)), 0,  1, SUM(NVL(TO_NUMBER(C008), 0)))))* 100,2),''990d99'')||''%'' MES2,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C009), 0)) ) / DECODE(SUM(NVL(TO_NUMBER(C010), 0)), 0,1,SUM(NVL(TO_NUMBER(C010), 0))))) * 100, 2),''990d99'')||''%'' MES3,',
'                   ''B'' PINTAR,',
'                    0 NUEVAS_AREAS,',
'                    0 COD_SUC,',
'                    0 DPTO',
'     FROM APEX_COLLECTIONS F',
'     WHERE COLLECTION_NAME = ''IND_ROTACION_CARGO''',
'',
'UNION ALL',
'',
'SELECT   -----------------SUCURSAL',
'                   TO_NUMBER(C003) ORDEN,',
'                   C024 DETALLE,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C005), 0)) ) /DECODE(SUM(NVL(TO_NUMBER(C006), 0)),0,1,SUM(NVL(TO_NUMBER(C006), 0))))) * 100,2),''990d99'')||''%'' MES1,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C007), 0))) /DECODE(SUM(NVL(TO_NUMBER(C008), 0)), 0,1,SUM(NVL(TO_NUMBER(C008), 0))))) * 100,2),''990d99'')||''%'' MES2,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C009), 0)) ) /DECODE(SUM(NVL(TO_NUMBER(C010), 0)),0, 1,sUM(NVL(TO_NUMBER(C010), 0))))) * 100, 2),''990d99'')||''%'' MES3,',
'                   ''C'' PINTAR,',
'                   TO_NUMBER(C019) NUEVAS_AREAS,',
'                   TO_NUMBER(C019) COD_SUC,',
'                   0 DPTO',
'     FROM APEX_COLLECTIONS F',
'     WHERE COLLECTION_NAME = ''IND_ROTACION_CARGO''',
'     GROUP BY C003, C024, TO_NUMBER(C019)',
'     ',
'UNION ALL',
'SELECT   ----DEPARTAMENTO',
'                   TO_NUMBER(C003) ORDEN,',
'                   C013 DETALLE,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C005), 0)) ) /DECODE(SUM(NVL(TO_NUMBER(C006), 0)),0,1,SUM(NVL(TO_NUMBER(C006), 0))))) * 100,2),''990d99'')||''%'' MES1,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C007), 0))) /DECODE(SUM(NVL(TO_NUMBER(C008), 0)), 0,1,SUM(NVL(TO_NUMBER(C008), 0))))) * 100,2),''990d99'')||''%'' MES2,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C009), 0)) ) /DECODE(SUM(NVL(TO_NUMBER(C010), 0)),0, 1,sUM(NVL(TO_NUMBER(C010), 0))))) * 100, 2),''990d99'')||''%'' MES3,',
'                   ''D'' PINTAR,',
'                   TO_NUMBER(C012) NUEVAS_AREAS,',
'                  TO_NUMBER(C019) COD_SUC,',
'                  TO_NUMBER(C012) NUEVAS_AREAS',
'     FROM APEX_COLLECTIONS F',
'     WHERE COLLECTION_NAME = ''IND_ROTACION_CARGO''',
'     GROUP BY C003, C012, C013,C019',
'UNION ALL',
'  SELECT   ',
'                   TO_NUMBER(C003) ORDEN2,',
'                   C002 DETALLE,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C005), 0)) ) /DECODE(SUM(NVL(TO_NUMBER(C006), 0)),0,1,SUM(NVL(TO_NUMBER(C006), 0))))) * 100,2),''990d99'')||''%'' MES1,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C007), 0)) ) /DECODE(SUM(NVL(TO_NUMBER(C008), 0)),0,1,SUM(NVL(TO_NUMBER(C008), 0)))))* 100,2),''990d99'')||''%'' MES2,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C009), 0)) ) / DECODE(SUM(NVL(TO_NUMBER(C010), 0)),0,1, SUM(NVL(TO_NUMBER(C010), 0))))) * 100, 2),''990d99'')||''%'' MES3,',
'                   ''E'' PINTAR,',
'                   TO_NUMBER(C001) NUEVAS_AREAS,',
'                    TO_NUMBER(C019) COD_SUC,',
'                    TO_NUMBER(C012) DPTO',
'     FROM APEX_COLLECTIONS F',
'     WHERE COLLECTION_NAME = ''IND_ROTACION_CARGO''',
'     GROUP BY C003,C002,C001,C019,C012',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'ROTACION CARGO'
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
 p_id=>wwv_flow_api.id(10982578891870464457)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>659534383106001746
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10982578793076464456)
,p_db_column_name=>'ORDEN'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10982578738173464455)
,p_db_column_name=>'DETALLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Detalle'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10982578616972464454)
,p_db_column_name=>'MES1'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Mes1'
,p_column_link=>'f?p=&APP_ID.:105:&SESSION.::&DEBUG.::P105_MES,P105_CARGO,P105_DEPARTAMENTO,P105_SUCURSAL:1,#COD_DPTO_AREA#,#DPTO#,#COD_SUC#'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10982578526605464453)
,p_db_column_name=>'MES2'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Mes2'
,p_column_link=>'f?p=&APP_ID.:105:&SESSION.::&DEBUG.::P105_CARGO,P105_DEPARTAMENTO,P105_SUCURSAL,P105_MES:#COD_DPTO_AREA#,#DPTO#,#COD_SUC#,2'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10974595148791436302)
,p_db_column_name=>'MES3'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Mes3'
,p_column_link=>'f?p=&APP_ID.:105:&SESSION.::&DEBUG.::P105_MES,P105_DEPARTAMENTO,P105_SUCURSAL,P105_CARGO:3,#DPTO#,#COD_SUC#,#COD_DPTO_AREA#'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10974594992472436301)
,p_db_column_name=>'PINTAR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Pintar'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10974594947003436300)
,p_db_column_name=>'COD_DPTO_AREA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Cod Dpto Area'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10974594866030436299)
,p_db_column_name=>'COD_SUC'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Cod Suc'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10974594701879436298)
,p_db_column_name=>'DPTO'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Dpto'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(10974574907320430805)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6675384'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>100000
,p_report_columns=>'DETALLE:MES1:MES2:MES3:'
,p_sort_column_1=>'COD_SUC'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'DPTO'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'COD_DPTO_AREA'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'PINTAR'
,p_sort_direction_4=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10973461665663978303)
,p_report_id=>wwv_flow_api.id(10974574907320430805)
,p_name=>'DEPARTAMENTO'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'PINTAR'
,p_operator=>'='
,p_expr=>'D'
,p_condition_sql=>' (case when ("PINTAR" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''D''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#E8E8E8'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10973462048910978304)
,p_report_id=>wwv_flow_api.id(10974574907320430805)
,p_name=>'SUCURSAL'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'PINTAR'
,p_operator=>'='
,p_expr=>'C'
,p_condition_sql=>' (case when ("PINTAR" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''C''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#FFF5CE'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10973462461857978304)
,p_report_id=>wwv_flow_api.id(10974574907320430805)
,p_name=>'INDICE ROTACION'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'PINTAR'
,p_operator=>'='
,p_expr=>'B'
,p_condition_sql=>' (case when ("PINTAR" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''B''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#D0F1CC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10973462844321978305)
,p_report_id=>wwv_flow_api.id(10974574907320430805)
,p_name=>'MES'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'PINTAR'
,p_operator=>'='
,p_expr=>'A'
,p_condition_sql=>' (case when ("PINTAR" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''A''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CCE5FF'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10973463248345978306)
,p_report_id=>wwv_flow_api.id(10974574907320430805)
,p_name=>'MES3'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'MES3'
,p_operator=>'!='
,p_expr=>'   0,00%'
,p_condition_sql=>' (case when ("MES3" != #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# != ''   0,00%''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_column_font_color=>'#F44336'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10973463619763978306)
,p_report_id=>wwv_flow_api.id(10974574907320430805)
,p_name=>'MES2'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'MES2'
,p_operator=>'!='
,p_expr=>'   0,00%'
,p_condition_sql=>' (case when ("MES2" != #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# != ''   0,00%''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_column_font_color=>'#F44336'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10973464048493978307)
,p_report_id=>wwv_flow_api.id(10974574907320430805)
,p_name=>'MES1'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'MES1'
,p_operator=>'!='
,p_expr=>'   0,00%'
,p_condition_sql=>' (case when ("MES1" != #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# != ''   0,00%''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_column_font_color=>'#F44336'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11078033790430509560)
,p_plug_name=>'VACANCIAS MES'
,p_region_name=>'VACANCIA'
,p_region_template_options=>'js-dialog-autoheight:js-modal:js-draggable:js-resizable:js-dialog-size720x480:t-Form--large:t-Form--stretchInputs:t-Form--leftLabels'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101534619376346328)
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_04'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'      NRO_SOL, MES_ANHO, ANHO,  FECHA_SOL, OPERADOR_SOL, NIVEL_URGENCIA,',
'       AREA_DESC, CARGO_DESC, TIPO_CONTRATO, TIPO_CONTRATACION, ESTADO_APROB_SOL,',
'       Q_VACANT,OPERADOR_APROB_SOL,FECHA_APROB_SOL, TIPO_SELEC_SOL,',
'       ESTADO_FIN_SOL,DETALLE',
'FROM',
'(SELECT NRO_SOL, MES_ANHO, ANHO,  FECHA_SOL, OPERADOR_SOL, NIVEL_URGENCIA,',
'       AREA_DESC, CARGO_DESC, TIPO_CONTRATO, TIPO_CONTRATACION, ESTADO_APROB_SOL,',
'       Q_VACANT,OPERADOR_APROB_SOL,FECHA_APROB_SOL, TIPO_SELEC_SOL,',
'       ESTADO_FIN_SOL,''VACANCIAS DEL MES'' DETALLE',
'  FROM CUBO_LONDON_PROCESO_SELEC X',
' WHERE FECHA_APROB_SOL <=TO_DATE(:P3528_VAC_FECHA)',
'   AND CASE',
'         WHEN FECHA_APROB_SOL >= TRUNC(TO_DATE(:P3528_VAC_FECHA), ''MM'') AND',
'              FECHA_APROB_SOL <= TO_DATE(:P3528_VAC_FECHA) THEN',
'          Q_VACANT',
'       END IS NOT NULL',
' GROUP BY NRO_SOL, MES_ANHO, ANHO,  FECHA_SOL, OPERADOR_SOL, NIVEL_URGENCIA,',
'          AREA_DESC, CARGO_DESC, TIPO_CONTRATO, TIPO_CONTRATACION, ESTADO_APROB_SOL,',
'          Q_VACANT,OPERADOR_APROB_SOL,FECHA_APROB_SOL, TIPO_SELEC_SOL,',
'          ESTADO_FIN_SOL',
'union all',
'SELECT NRO_SOL, MES_ANHO, ANHO,  FECHA_SOL, OPERADOR_SOL, NIVEL_URGENCIA,',
'       AREA_DESC, CARGO_DESC, TIPO_CONTRATO, TIPO_CONTRATACION, ESTADO_APROB_SOL,',
'       Q_VACANT,OPERADOR_APROB_SOL,FECHA_APROB_SOL, TIPO_SELEC_SOL,',
'       ESTADO_FIN_SOL,''VACANCIAS ACUM.'' DETALLE',
'  FROM CUBO_LONDON_PROCESO_SELEC X',
' where NRO_SOL in',
'       (SELECT decode(a.NRO_SOL, null, b.NRO_SOL, a.NRO_SOL) sol',
'          FROM (SELECT CASE',
'                         WHEN FECHA_APROB_SOL <=',
'                              LAST_DAY(ADD_MONTHS(:P3528_VAC_FECHA, -1)) THEN',
'                          1',
'                       END MES3,',
'                       NRO_SOL',
'                  FROM CUBO_LONDON_PROCESO_SELEC',
'                 WHERE ESTADO_FIN_SOL = ''En Proceso''',
'                   AND FECHA_APROB_SOL <= :P3528_VAC_FECHA',
'                 GROUP BY FECHA_APROB_SOL, Q_VACANT, NRO_SOL) a,',
'               (SELECT case',
'                         WHEN FECHA_APROB_SOL <=',
'                              LAST_DAY(ADD_MONTHS(:P3528_VAC_FECHA, -1)) then',
'                          1',
'                       END MES3,',
'                       NRO_SOL',
'                  FROM CUBO_LONDON_PROCESO_SELEC',
'                 WHERE ESTADO_FIN_SOL = ''En Proceso''',
'                   AND ESTADO_GRAL = ''Contratado''',
'                   AND FECHA_APROB_SOL <= :P3528_VAC_FECHA',
'                 GROUP BY FECHA_APROB_SOL, Q_VACANT, NRO_SOL) b',
'         where A.NRO_SOL = B.NRO_SOL(+)',
'           and nvl(a.mes3, 0) + nvl(b.mes3, 0) = 1)',
' group by NRO_SOL, MES_ANHO, ANHO,  FECHA_SOL, OPERADOR_SOL, NIVEL_URGENCIA,',
'       AREA_DESC, CARGO_DESC, TIPO_CONTRATO, TIPO_CONTRATACION, ESTADO_APROB_SOL,',
'       Q_VACANT,OPERADOR_APROB_SOL,FECHA_APROB_SOL, TIPO_SELEC_SOL,',
'       ESTADO_FIN_SOL)',
'      WHERE DETALLE = :P3528_VAC_TIPO'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_VAC_FECHA,P3528_VAC_TIPO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11078033702889509559)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>130452685472080525
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078033685260509558)
,p_db_column_name=>'NRO_SOL'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Nro Sol'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078033489900509557)
,p_db_column_name=>'MES_ANHO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Mes Anho'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078033418885509556)
,p_db_column_name=>'ANHO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Anho'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078033339757509555)
,p_db_column_name=>'FECHA_SOL'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Fecha Sol'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078033211320509554)
,p_db_column_name=>'OPERADOR_SOL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Operador Sol'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078033150387509553)
,p_db_column_name=>'NIVEL_URGENCIA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Nivel Urgencia'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078033017682509552)
,p_db_column_name=>'AREA_DESC'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Area Desc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078032965972509551)
,p_db_column_name=>'CARGO_DESC'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Cargo Desc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078032829968509550)
,p_db_column_name=>'TIPO_CONTRATO'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Tipo Contrato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078032754469509549)
,p_db_column_name=>'TIPO_CONTRATACION'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Tipo Contratacion'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078032640264509548)
,p_db_column_name=>'ESTADO_APROB_SOL'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Estado Aprob Sol'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078032544803509547)
,p_db_column_name=>'Q_VACANT'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Q Vacant'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078032476120509546)
,p_db_column_name=>'OPERADOR_APROB_SOL'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Operador Aprob Sol'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078032378353509545)
,p_db_column_name=>'FECHA_APROB_SOL'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Fecha Aprob Sol'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078032267632509544)
,p_db_column_name=>'TIPO_SELEC_SOL'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Tipo Selec Sol'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078032122013509543)
,p_db_column_name=>'ESTADO_FIN_SOL'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Estado Fin Sol'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078031233982509534)
,p_db_column_name=>'DETALLE'
,p_display_order=>170
,p_column_identifier=>'R'
,p_column_label=>'Detalle'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11077864868121700373)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1306216'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NRO_SOL:MES_ANHO:ANHO:FECHA_SOL:OPERADOR_SOL:NIVEL_URGENCIA:AREA_DESC:CARGO_DESC:TIPO_CONTRATO:TIPO_CONTRATACION:ESTADO_APROB_SOL:Q_VACANT:OPERADOR_APROB_SOL:FECHA_APROB_SOL:TIPO_SELEC_SOL:ESTADO_FIN_SOL:DETALLE'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11078035960105509581)
,p_plug_name=>'LISTADO TABLERO DE DOTACION '
,p_region_name=>'DOTACION'
,p_region_template_options=>'js-dialog-autoheight:js-modal:js-draggable:js-resizable:js-dialog-size720x480:t-Form--large:t-Form--stretchInputs:t-Form--leftLabels:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(11101534619376346328)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_04'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DEPARTAMENTO,LEGAJO, NOMBRE, SITUACION, INGRESO, SALIDA , DEPARTAMENTO_PERM DEP_PERTENECIENTE,DEPARTAMENTO_ANTERIOR',
'FROM(',
'SELECT  case when :p_empresa = 1 then',
'                CASE',
'                            WHEN DPTO_SUC = 2 THEN',
'                                 ''CDA'' ',
'                           WHEN EMPL_DEPARTAMENTO = 1 and (EMPL_AREA_ORGANI <> 8 and empl_cargo <> 1)  THEN',
'                                 ''ADM''',
'                            WHEN  EMPL_AREA_ORGANI =8  or  empl_cargo = 1 THEN',
'                                 ''CAPITAL HUMANO''   ',
'                            WHEN (DPTO_CODIGO IN(14,22,2) OR DPTO_SUC NOT IN (1,2)) THEN',
'                                ''COMERCIAL''',
'                            ELSE',
'                               ''INDUSTRIAL''',
'                            END',
'      else',
'    dpto_desc',
'    end     DEPARTAMENTO,',
'(CASE',
'WHEN EMPL_SITUACION = ''A'' AND',
'    EMPL_FEC_INGRESO <= :P3528_DET_DOT_FECHA THEN',
'1',
'ELSE',
'0',
'END) + (CASE',
'          WHEN EMPL_SITUACION = ''I'' AND',
'               EMPL_FEC_INGRESO <= :P3528_DET_DOT_FECHA AND',
'               EMPL_FEC_SALIDA > :P3528_DET_DOT_FECHA THEN',
'           1',
'          ELSE',
'           0',
'        END) VALOR,',
'                          ',
'                                      EMPL_FEC_INGRESO INGRESO,',
'                                      EMPL_FEC_SALIDA SALIDA,',
'                                      DECODE(EMPL_SITUACION,''A'',''ACTIVO'', ''INACTIVO'') SITUACION,',
'                                      EMPL_LEGAJO LEGAJO ,',
'                                      EMPL_NOMBRE||'' ''||EMPL_APE NOMBRE, ',
'                                      DPTO_CODIGO||'' - ''||DPTO_DESC DEPARTAMENTO_PERM,',
'                                     (SELECT T.PEREMPDEP_DEPTO',
'                                        FROM PER_EMPLEADO_DEPTO T',
'                                        WHERE T.PEREMPDEP_EMPL = EMPL_LEGAJO',
'                                        AND T.PEREMPDEP_EMPR = 1',
'                                        AND T.PEREMPDEP_FEC =( SELECT MAX(T.PEREMPDEP_FEC)',
'                                        FROM PER_EMPLEADO_DEPTO T',
'                                        WHERE T.PEREMPDEP_EMPL = EMPL_LEGAJO',
'                                        AND T.PEREMPDEP_EMPR = 1',
'                                        AND T.PEREMPDEP_DEPTO <> DPTO_CODIGO )) DEPARTAMENTO_ANTERIOR',
'                    FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO DPTO',
'                   WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO',
'                     AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR',
'                     AND EMPL_CODIGO_PROV <> 0',
'                     AND EMPL_TIPO_CONT <> ''T''',
'                     AND EMPL_FORMA_PAGO <> 0',
'                     --AND NVL(E.MES,SEMANA)||''/''||ANHO = :P3528_MES_ANHO_S',
'                        and ',
'                        case when to_date(:P3528_FECHA_HASTA, ''dd/mm/yyyy'') = last_day(to_date(:P3528_FECHA_HASTA, ''dd/mm/yyyy''))',
'                        or :P3528_OPC_DOTA in (1,2)',
'                        then',
'                          E.MES',
'                         else e.semana',
'                        end||''/''||ANHO = :P3528_MES_ANHO_S',
'                     AND EMPL_EMPRESA = 1',
'      AND EMPL_EMPRESA = :p_empresa',
'UNION',
'SELECT    ''DOTACION TEMPORAL''   DEPARTAMENTO,',
'                            CASE',
'                                       WHEN EMPL_SITUACION = ''A'' AND',
'                                            EMPL_FEC_INGRESO <= :P3528_DET_DOT_FECHA THEN',
'                                        1',
'                                       ELSE',
'                                        0',
'                                     END +CASE',
'                                                  WHEN EMPL_SITUACION = ''I'' AND',
'                                                       EMPL_FEC_INGRESO <= :P3528_DET_DOT_FECHA AND',
'                                                       EMPL_FEC_SALIDA > :P3528_DET_DOT_FECHA THEN',
'                                                   1',
'                                                  ELSE',
'                                                   0',
'                                                END VALOR,',
'                          ',
'                                      EMPL_FEC_INGRESO INGRESO,',
'                                      EMPL_FEC_SALIDA SALIDA,',
'                                      DECODE(EMPL_SITUACION,''A'',''ACTIVO'', ''INACTIVO'') SITUACION,',
'                                      EMPL_LEGAJO LEGAJO ,',
'                                      EMPL_NOMBRE||'' ''||EMPL_APE NOMBRE, ',
'                                      DPTO_CODIGO||'' - ''||DPTO_DESC DEPARTAMENTO_PERM,',
'                                     (SELECT T.PEREMPDEP_DEPTO',
'                                        FROM PER_EMPLEADO_DEPTO T',
'                                        WHERE T.PEREMPDEP_EMPL = EMPL_LEGAJO',
'                                        AND T.PEREMPDEP_EMPR = 1',
'                                        AND T.PEREMPDEP_FEC =( SELECT MAX(T.PEREMPDEP_FEC)',
'                                        FROM PER_EMPLEADO_DEPTO T',
'                                        WHERE T.PEREMPDEP_EMPL = EMPL_LEGAJO',
'                                        AND T.PEREMPDEP_EMPR = 1',
'                                        AND T.PEREMPDEP_DEPTO <> DPTO_CODIGO )',
'                                     ) DEPARTAMENTO_ANTERIOR',
'                    FROM PER_EMPLEADO_HIST E, ',
'                         GEN_DEPARTAMENTO  DPTO',
'                   WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO',
'                     AND E.EMPL_EMPRESA      = DPTO.DPTO_EMPR',
'                     AND EMPL_CODIGO_PROV    <> 0',
'                     AND EMPL_TIPO_CONT = ''T''',
'                     AND EMPL_FORMA_PAGO <> 0',
'                     --AND NVL(E.MES,SEMANA)||''/''||ANHO = :P3528_MES_ANHO_S',
'                        and ',
'                        case when to_date(:P3528_FECHA_HASTA, ''dd/mm/yyyy'') = last_day(to_date(:P3528_FECHA_HASTA, ''dd/mm/yyyy''))',
'                        or :P3528_OPC_DOTA in (1,2)',
'                        then',
'                          E.MES',
'                         else e.semana',
'                        end||''/''||ANHO = :P3528_MES_ANHO_S',
'                     AND EMPL_EMPRESA = 1',
'  AND EMPL_EMPRESA = :p_empresa',
')',
'WHERE DEPARTAMENTO = :P3528_DOT_MES_DEP',
'AND VALOR = 1',
'',
'UNION ALL',
'',
'SELECT DEPARTAMENTO,LEGAJO, NOMBRE, SITUACION, INGRESO, SALIDA , DEPARTAMENTO_PERM, DEPARTAMENTO_ANTERIOR',
'FROM(',
'SELECT  CASE WHEN E.EMPL_AREA_ORGANI IN (4) THEN',
'                             ''ADMINISTRACION''',
'                        WHEN E.EMPL_AREA_ORGANI IN (7) THEN',
'                             ''GRANOS''',
'                        WHEN E.EMPL_AREA_ORGANI IN (6) THEN',
'                             ''INSUMOS''',
'                        WHEN E.EMPL_AREA_ORGANI IN (2) THEN',
'                             ''UNIDADES''',
'                        WHEN E.EMPL_AREA_ORGANI IN (1,3,5) THEN',
'                             ''TRANSPORTE''',
'                        WHEN E.EMPL_AREA_ORGANI IN (8) THEN',
'                             ''REPUESTOS''',
'                        end  DEPARTAMENTO,',
'                            CASE',
'                                       WHEN EMPL_SITUACION = ''A'' AND',
'                                            EMPL_FEC_INGRESO <= :P3528_DET_DOT_FECHA THEN',
'                                        1',
'                                       ELSE',
'                                        0',
'                                     END +CASE',
'                                                  WHEN EMPL_SITUACION = ''I'' AND',
'                                                       EMPL_FEC_INGRESO <= :P3528_DET_DOT_FECHA AND',
'                                                       EMPL_FEC_SALIDA > :P3528_DET_DOT_FECHA THEN',
'                                                   1',
'                                                  ELSE',
'                                                   0',
'                                                END VALOR,',
'                          ',
'                                      EMPL_FEC_INGRESO INGRESO,',
'                                      EMPL_FEC_SALIDA SALIDA,',
'                                      DECODE(EMPL_SITUACION,''A'',''ACTIVO'', ''INACTIVO'') SITUACION,',
'                                      EMPL_LEGAJO LEGAJO ,',
'                                      EMPL_NOMBRE||'' ''||EMPL_APE NOMBRE, ',
'                                      DPTO_CODIGO||'' - ''||DPTO_DESC DEPARTAMENTO_PERM,',
'                                     (SELECT T.PEREMPDEP_DEPTO',
'                                        FROM PER_EMPLEADO_DEPTO T',
'                                        WHERE T.PEREMPDEP_EMPL = EMPL_LEGAJO',
'                                        AND T.PEREMPDEP_EMPR = 2',
'                                        AND T.PEREMPDEP_FEC =( SELECT MAX(T.PEREMPDEP_FEC)',
'                                        FROM PER_EMPLEADO_DEPTO T',
'                                        WHERE T.PEREMPDEP_EMPL = EMPL_LEGAJO',
'                                        AND T.PEREMPDEP_EMPR = 2',
'                                        AND T.PEREMPDEP_DEPTO <> DPTO_CODIGO )) DEPARTAMENTO_ANTERIOR',
'                    FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO DPTO',
'                   WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO',
'                     AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR',
'                     AND EMPL_CODIGO_PROV <> 0',
'                     AND EMPL_FORMA_PAGO <> 0',
'                     --AND NVL(E.MES,SEMANA)||''/''||ANHO = :P3528_MES_ANHO_S',
'                        and ',
'                        case when to_date(:P3528_FECHA_HASTA, ''dd/mm/yyyy'') = last_day(to_date(:P3528_FECHA_HASTA, ''dd/mm/yyyy''))',
'                        or :P3528_OPC_DOTA in (1,2)',
'                        then',
'                          E.MES',
'                         else e.semana',
'                        end||''/''||ANHO = :P3528_MES_ANHO_S',
'                     AND EMPL_EMPRESA = 2',
'      AND EMPL_EMPRESA = :p_empresa',
'UNION',
'SELECT  ''DOTACION TEMPORAL'' DEPARTAMENTO,',
'                            CASE',
'                                       WHEN EMPL_SITUACION = ''A'' AND',
'                                            EMPL_FEC_INGRESO <= :P3528_DET_DOT_FECHA THEN',
'                                        1',
'                                       ELSE',
'                                        0',
'                                     END +CASE',
'                                                  WHEN EMPL_SITUACION = ''I'' AND',
'                                                       EMPL_FEC_INGRESO <= :P3528_DET_DOT_FECHA AND',
'                                                       EMPL_FEC_SALIDA > :P3528_DET_DOT_FECHA THEN',
'                                                   1',
'                                                  ELSE',
'                                                   0',
'                                                END VALOR,',
'                          ',
'                                      EMPL_FEC_INGRESO INGRESO,',
'                                      EMPL_FEC_SALIDA SALIDA,',
'                                      DECODE(EMPL_SITUACION,''A'',''ACTIVO'', ''INACTIVO'') SITUACION,',
'                                      EMPL_LEGAJO LEGAJO ,',
'                                      EMPL_NOMBRE||'' ''||EMPL_APE NOMBRE, ',
'                                      DPTO_CODIGO||'' - ''||DPTO_DESC DEPARTAMENTO_PERM,',
'                                     (SELECT T.PEREMPDEP_DEPTO',
'                                        FROM PER_EMPLEADO_DEPTO T',
'                                        WHERE T.PEREMPDEP_EMPL = EMPL_LEGAJO',
'                                        AND T.PEREMPDEP_EMPR = 2',
'                                        AND T.PEREMPDEP_FEC =( SELECT MAX(T.PEREMPDEP_FEC)',
'                                        FROM PER_EMPLEADO_DEPTO T',
'                                        WHERE T.PEREMPDEP_EMPL = EMPL_LEGAJO',
'                                        AND T.PEREMPDEP_EMPR = 2',
'                                        AND T.PEREMPDEP_DEPTO <> DPTO_CODIGO )) DEPARTAMENTO_ANTERIOR',
'                    FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO DPTO',
'                   WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO',
'                     AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR',
'                     AND EMPL_CODIGO_PROV <> 0',
'                   AND EMPL_TIPO_CONT = ''T''',
'                     AND EMPL_FORMA_PAGO <> 0',
'                     --AND NVL(E.MES,SEMANA)||''/''||ANHO = :P3528_MES_ANHO_S',
'                     and ',
'                        case when to_date(:P3528_FECHA_HASTA, ''dd/mm/yyyy'') = last_day(to_date(:P3528_FECHA_HASTA, ''dd/mm/yyyy''))',
'                        or :P3528_OPC_DOTA in (1,2)',
'                        then',
'                          E.MES',
'                         else e.semana',
'                        end||''/''||ANHO = :P3528_MES_ANHO_S',
'                     AND EMPL_EMPRESA = 2',
'  AND EMPL_EMPRESA = :p_empresa',
')',
'WHERE DEPARTAMENTO = CASE WHEN :P3528_DOT_MES_DEP = ''GERENCIA DE TI'' THEN ''ADMINISTRACION'' ELSE :P3528_DOT_MES_DEP END',
'AND VALOR = 1',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_DOT_MES_DEP,P3528_DET_DOT_FECHA,P3528_MES_ANHO_S,P3528_OPC_DOTA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
end;
/
begin
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11078035635307509578)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>130450753054080506
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078035569214509577)
,p_db_column_name=>'DEPARTAMENTO'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Departamento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078035391041509576)
,p_db_column_name=>'LEGAJO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Legajo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078035334169509575)
,p_db_column_name=>'NOMBRE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Nombre'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078035275542509574)
,p_db_column_name=>'SITUACION'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Situacion'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078035123358509573)
,p_db_column_name=>'INGRESO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Ingreso'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078035046141509572)
,p_db_column_name=>'SALIDA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Salida'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078034934735509571)
,p_db_column_name=>'DEP_PERTENECIENTE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Departamento  Dependiente'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11050776938885288476)
,p_db_column_name=>'DEPARTAMENTO_ANTERIOR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Departamento Anterior'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'RIGHT'
,p_rpt_named_lov=>wwv_flow_api.id(11109078651735878042)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11077993975621338120)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1304925'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>100000
,p_report_columns=>'DEPARTAMENTO:LEGAJO:NOMBRE:SITUACION:INGRESO:SALIDA:DEP_PERTENECIENTE:DEPARTAMENTO_ANTERIOR'
,p_sort_column_1=>'DEP_PERTENECIENTE'
,p_sort_direction_1=>'ASC'
,p_break_on=>'DEP_PERTENECIENTE'
,p_break_enabled_on=>'DEP_PERTENECIENTE'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11078208862074359946)
,p_plug_name=>'LISTADO DE DOTACION POR SUCURSAL'
,p_region_name=>'DOTA_SUC'
,p_region_template_options=>'#DEFAULT#:js-dialog-size600x400'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101534619376346328)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_04'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT LEGAJO, NOMBRE, SITUACION, INGRESO, SALIDA',
'FROM(',
'SELECT DPTO_CODIGO||'' - ''||DECODE(DPTO_CODIGO,29,''P.J.C'',DPTO_DESC) DEPARTAMENTO, ',
'',
'                  TO_CHAR(TO_DATE(:P3528_FECHA_DOT), ''DD/MM/YYYY'')SEMANA_ACT,',
'                       (CASE',
'                             WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= to_date(:P3528_FECHA_DOT) THEN',
'                              1',
'                             ELSE',
'                              0',
'                           END) +',
'                            CASE',
'                                        WHEN EMPL_SITUACION = ''I'' AND EMPL_FEC_INGRESO <= to_date(:P3528_FECHA_DOT) AND',
'                                             EMPL_FEC_SALIDA > to_date(:P3528_FECHA_DOT) THEN',
'                                         1',
'                                        ELSE',
'                                         0',
'                                      END ACT_INAC,',
'                                      EMPL_FEC_INGRESO INGRESO,',
'                                      EMPL_FEC_SALIDA SALIDA,',
'                                      DECODE(EMPL_SITUACION,''A'',''ACTIVO'', ''INACTIVO'') SITUACION,',
'                                      EMPL_LEGAJO LEGAJO ,',
'                                      EMPL_NOMBRE||'' ''||EMPL_APE NOMBRE',
'              FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO DPTO',
'             WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO',
'               AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR',
'               AND EMPL_CODIGO_PROV <> 0',
'               AND EMPL_TIPO_CONT <> ''T''',
'               AND EMPL_FORMA_PAGO <> 0',
'               AND EMPL_EMPRESA = :P_EMPRESA',
'               AND SEMANA ||''/''|| ANHO = TO_CHAR(to_date(:P3528_FECHA_DOT),''IW/YYYY'')',
'               AND DPTO_SUC NOT IN (1,2,8))',
'               WHERE  DEPARTAMENTO = :P3528_DEPARTAMENTO_DOT',
'                 AND ACT_INAC = 1',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_DEPARTAMENTO_DOT,P3528_FECHA_DOT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11078208620447359944)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>130277767914230140
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078208552474359943)
,p_db_column_name=>'LEGAJO'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Legajo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078208393944359942)
,p_db_column_name=>'NOMBRE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nombre'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078208309197359941)
,p_db_column_name=>'SITUACION'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Situacion'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078208192828359940)
,p_db_column_name=>'INGRESO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Ingreso'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11078208172651359939)
,p_db_column_name=>'SALIDA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Salida'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11078056678876585603)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1304298'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'LEGAJO:NOMBRE:SITUACION:INGRESO:SALIDA'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11094948742428347884)
,p_plug_name=>'TABLERO DE CAPITAL HUMANO -J.S.A'
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody:t-Form--large:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11035011882843822962)
,p_plug_name=>'MARCACIONES'
,p_parent_plug_id=>wwv_flow_api.id(11094948742428347884)
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>200
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11033098285051406472)
,p_plug_name=>'marc_graf_punt'
,p_parent_plug_id=>wwv_flow_api.id(11035011882843822962)
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT B.MES, A.DET, A.PORC',
'FROM',
'(SELECT C004||C003 MES, TO_NUMBER(C001) PORC, C002 DET, C005 ORDEN',
'   FROM APEX_collections F',
'   WHERE collection_name = ''MARC_GRAF_PUNTUALIDAD'') A,',
'(SELECT C002||C001 MES, C003 ORDEN',
'   FROM APEX_collections F',
'   WHERE collection_name = ''MARC_FECHA1'' ) B',
'   WHERE B.ORDEN = A.ORDEN (+)',
''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11033098187486406471)
,p_region_id=>wwv_flow_api.id(11033098285051406472)
,p_chart_type=>'bar'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11033098039216406470)
,p_chart_id=>wwv_flow_api.id(11033098187486406471)
,p_seq=>10
,p_name=>'Nuevo'
,p_location=>'REGION_SOURCE'
,p_series_name_column_name=>'DET'
,p_items_value_column_name=>'PORC'
,p_items_label_column_name=>'MES'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11033097931947406469)
,p_chart_id=>wwv_flow_api.id(11033098187486406471)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11033097791653406468)
,p_chart_id=>wwv_flow_api.id(11033098187486406471)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11033273534543569234)
,p_plug_name=>'marc_graf_ause'
,p_parent_plug_id=>wwv_flow_api.id(11035011882843822962)
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>50
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT B.MES, A.DET, A.PORC',
'FROM',
'(SELECT C004||C003 MES, TO_NUMBER(C001) PORC, C002 DET, C005 ORDEN',
'   FROM APEX_collections F',
'   WHERE collection_name = ''MARC_GRAF_ASISTENCIA'') A,',
'(SELECT C002||C001 MES, C003 ORDEN',
'   FROM APEX_collections F',
'   WHERE collection_name = ''MARC_FECHA1'' ) B',
'   WHERE B.ORDEN = A.ORDEN (+)',
''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11033098662967406476)
,p_region_id=>wwv_flow_api.id(11033273534543569234)
,p_chart_type=>'bar'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11033098533992406475)
,p_chart_id=>wwv_flow_api.id(11033098662967406476)
,p_seq=>10
,p_name=>'Nuevo'
,p_location=>'REGION_SOURCE'
,p_series_name_column_name=>'DET'
,p_items_value_column_name=>'PORC'
,p_items_label_column_name=>'MES'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11033098309633406473)
,p_chart_id=>wwv_flow_api.id(11033098662967406476)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11033098438352406474)
,p_chart_id=>wwv_flow_api.id(11033098662967406476)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11033274622533569245)
,p_plug_name=>'MARC_PUNTUALIDAD1'
,p_parent_plug_id=>wwv_flow_api.id(11035011882843822962)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody:margin-top-lg:margin-bottom-lg'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>4
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT C001 ORDEN, C002 DETALLE,  C003 MES1, C004 MES2, C005 MES3',
'                FROM APEX_collections',
'                WHERE collection_name = ''TABLA_ASIS''',
'',
'',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11033274558852569244)
,p_max_row_count=>'1000000'
,p_show_search_bar=>'N'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>175211829509020840
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11033274435610569243)
,p_db_column_name=>'DETALLE'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Detalle'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11033274221728569241)
,p_db_column_name=>'MES1'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Mes1'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11033274139883569240)
,p_db_column_name=>'MES2'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11033274019293569239)
,p_db_column_name=>'MES3'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Mes3'
,p_column_link=>'f?p=&APP_ID.:2590:&SESSION.::&DEBUG.:RP:P2590_AREA,P2590_FECHA,P2590_ORDEN:#ORDEN#,&P3528_FECHA_HASTA.,B'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11033273875839569237)
,p_db_column_name=>'ORDEN'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Orden'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11033239578527401712)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1752469'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DETALLE:MES1:MES2:MES3'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11033237251392393860)
,p_report_id=>wwv_flow_api.id(11033239578527401712)
,p_name=>'PUNTUALIDAD'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'PUNTUALIDAD'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''PUNTUALIDAD''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11033237632359393860)
,p_report_id=>wwv_flow_api.id(11033239578527401712)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'INDICADOR'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B7F0BD'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11035011628453822960)
,p_plug_name=>'MARC_ASISTENCIA1'
,p_parent_plug_id=>wwv_flow_api.id(11035011882843822962)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody:margin-top-lg:margin-bottom-lg'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT C001 ORDEN, C002 DETALLE,  C003 MES1, C004 MES2, C005 MES3',
'                FROM APEX_collections',
'                WHERE collection_name = ''TABLA_PUNT''',
'',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11035009606997822941)
,p_max_row_count=>'1000000'
,p_show_search_bar=>'N'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>173476781363767143
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11035009392731822939)
,p_db_column_name=>'DETALLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Detalle'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11035008937103822934)
,p_db_column_name=>'MES1'
,p_display_order=>40
,p_column_identifier=>'G'
,p_column_label=>'Mes1'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11033278486433569283)
,p_db_column_name=>'MES2'
,p_display_order=>50
,p_column_identifier=>'H'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11033278377508569282)
,p_db_column_name=>'MES3'
,p_display_order=>60
,p_column_identifier=>'I'
,p_column_label=>'Mes3'
,p_column_link=>'f?p=&APP_ID.:2590:&SESSION.::&DEBUG.:RP:P2590_FECHA,P2590_AREA,P2590_ORDEN:&P3528_FECHA_HASTA.,#ORDEN#,A'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11033273960402569238)
,p_db_column_name=>'ORDEN'
,p_display_order=>70
,p_column_identifier=>'J'
,p_column_label=>'Orden'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11033281064557588967)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1752054'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DETALLE:MES1:MES2:MES3'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11033236286158393256)
,p_report_id=>wwv_flow_api.id(11033281064557588967)
,p_name=>'NIVEL DE AUSENTISMO'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'NIVEL DE AUSENTISMO'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''NIVEL DE AUSENTISMO''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11033236654050393256)
,p_report_id=>wwv_flow_api.id(11033281064557588967)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'INDICADOR'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B7F0BD'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11042649345721307150)
,p_plug_name=>'VACANCIA- SELECCION-CONTRATACION'
,p_parent_plug_id=>wwv_flow_api.id(11094948742428347884)
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11040221889380515253)
,p_plug_name=>'GRAF_CONT_MES'
,p_parent_plug_id=>wwv_flow_api.id(11042649345721307150)
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader:t-Region--scrollBody:margin-top-lg:margin-bottom-lg'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>80
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11040221846179515252)
,p_region_id=>wwv_flow_api.id(11040221889380515253)
,p_chart_type=>'bar'
,p_title=>unistr('TIPOS DE CONTRATACI\00D3N - \00C1REA')
,p_height=>'500'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_legend_font_family=>'Arial Black'
,p_legend_font_size=>'10'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11040221788246515251)
,p_chart_id=>wwv_flow_api.id(11040221846179515252)
,p_seq=>10
,p_name=>'CONTRATACION'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT C002 area,',
'C003 MES,C007||''-''||C002 AREA_MES, ',
'C004 TIPO_CONT,  SUM(C006) PORC_CONT',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONTT''',
'     AND C003 IS NOT NULL',
'   GROUP BY c002,C003, C004,c007',
'',
''))
,p_series_name_column_name=>'TIPO_CONT'
,p_items_value_column_name=>'PORC_CONT'
,p_items_label_column_name=>'AREA_MES'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11040221382950515247)
,p_chart_id=>wwv_flow_api.id(11040221846179515252)
,p_seq=>20
,p_name=>'MES'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' SELECT 15 cant, ''1- ''||TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'') MES_1',
'   FROM DUAL',
'   union all',
'SELECT 15 cant, ''2- ''||TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'') MES_2',
'  FROM DUAL',
'  union all',
'SELECT 15 cant, ''3- ''||TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'') MES_3',
'   FROM DUAL',
'   ORDER BY 2 DESC '))
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'MES_1'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11040221679068515250)
,p_chart_id=>wwv_flow_api.id(11040221846179515252)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title_font_family=>'Arial Black'
,p_title_font_style=>'normal'
,p_title_font_size=>'10'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_size=>'8'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11040221505708515249)
,p_chart_id=>wwv_flow_api.id(11040221846179515252)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_title_font_family=>'Arial Black'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_size=>'8'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
end;
/
begin
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11040222897938515263)
,p_plug_name=>'contrataciones_mes'
,p_parent_plug_id=>wwv_flow_api.id(11042649345721307150)
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader:t-Region--scrollBody:margin-top-lg:margin-bottom-lg'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>60
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.orden||'' - ''||A.MES mes, TIPO_CONT, ROUND((TOTAL_CONT*100)/DECODE(NVL(TOTAL,1),0,1,NVL(TOTAL,1))) PORCENTAJE',
'FROM',
'(SELECT C003 MES, C004 TIPO_CONT,  SUM(C001) TOTAL_CONT, decode(c007,3,''a'',2,''b'',1,''c'') orden',
' FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONTT''',
'      AND C003 IS NOT NULL',
'    GROUP BY C003,  C004, decode(C007,3,''a'',2,''b'',1,''c''))A,',
' (SELECT  C003 MES, SUM(C001) TOTAL,  decode(C007,3,''a'',2,''b'',1,''c'') orden',
'  FROM APEX_collections',
' WHERE collection_name = ''SELECCION_CONTT''',
'   AND C003 IS NOT NULL',
'    GROUP BY C003, decode(C007,3,''a'',2,''b'',1,''c'')) B',
'WHERE A.MES = B.MES'))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11040222370623515257)
,p_region_id=>wwv_flow_api.id(11040222897938515263)
,p_chart_type=>'bar'
,p_title=>'TIPO DE CONTRATACIONES DEL MES'
,p_width=>'1000'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'horizontal'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_legend_font_family=>'Arial Black'
,p_legend_font_style=>'normal'
,p_legend_font_size=>'10'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11040222282906515256)
,p_chart_id=>wwv_flow_api.id(11040222370623515257)
,p_seq=>10
,p_name=>'CONTRATACION'
,p_location=>'REGION_SOURCE'
,p_series_name_column_name=>'TIPO_CONT'
,p_items_value_column_name=>'PORCENTAJE'
,p_items_label_column_name=>'MES'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11040222171037515255)
,p_chart_id=>wwv_flow_api.id(11040222370623515257)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'10'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11040222001571515254)
,p_chart_id=>wwv_flow_api.id(11040222370623515257)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_title_font_family=>'Arial Black'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'10'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11040223577000515269)
,p_plug_name=>'selecciones_mes'
,p_parent_plug_id=>wwv_flow_api.id(11042649345721307150)
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader:t-Region--scrollBody:margin-top-lg:margin-bottom-lg'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT A.MES, TIPO_SOL, ROUND((TOTAL_CONT*100)/DECODE(NVL(TOTAL,1),0,1,NVL(TOTAL,1))) PORCENTAJE',
'FROM',
'(SELECT decode(c007,3,''a'',2,''b'',1,''c'')||'' - ''||C003 MES, C004 TIPO_SOL,  SUM(C001) TOTAL_CONT',
' FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_SECTT''',
'      AND C003 IS NOT NULL',
'    GROUP BY C003,  C004, decode(c007,3,''a'',2,''b'',1,''c''))A,',
' (SELECT decode(c007,3,''a'',2,''b'',1,''c'')||'' - ''||C003 MES, SUM(C001) TOTAL',
'  FROM APEX_collections',
' WHERE collection_name = ''SELECCION_SECTT''',
'     AND C003 IS NOT NULL',
'    GROUP BY C003, decode(c007,3,''a'',2,''b'',1,''c'')) B',
'WHERE A.MES(+) = B.MES'))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11040223306516515267)
,p_region_id=>wwv_flow_api.id(11040223577000515269)
,p_chart_type=>'bar'
,p_title=>unistr('TIPO DE SELECCI\00D3N DEL MES')
,p_width=>'1000'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'horizontal'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_legend_font_family=>'Arial Black'
,p_legend_font_style=>'normal'
,p_legend_font_size=>'10'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11040223264997515266)
,p_chart_id=>wwv_flow_api.id(11040223306516515267)
,p_seq=>10
,p_name=>'SELECCION'
,p_location=>'REGION_SOURCE'
,p_series_name_column_name=>'TIPO_SOL'
,p_items_value_column_name=>'PORCENTAJE'
,p_items_label_column_name=>'MES'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11040223044053515264)
,p_chart_id=>wwv_flow_api.id(11040223306516515267)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_title_font_family=>'Arial Black'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'10'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11040223148197515265)
,p_chart_id=>wwv_flow_api.id(11040223306516515267)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title_font_family=>'Arial Black'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'inside'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'10'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11041214999894734034)
,p_plug_name=>'grafico_seleccionv'
,p_parent_plug_id=>wwv_flow_api.id(11042649345721307150)
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader:t-Region--scrollBody:margin-top-lg:margin-bottom-lg'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>70
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT C003, c007||''-''||C002 AREA_MES, C004 TIPO_SOL,  sum(C006) PORC_SELEC',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_SECTT''',
'      AND C003 IS NOT NULL',
'    GROUP BY C003, C002, C004,c007'))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11040224261677515276)
,p_region_id=>wwv_flow_api.id(11041214999894734034)
,p_chart_type=>'combo'
,p_title=>unistr('TIPOS DE SELECCI\00D3N - \00C1REA')
,p_height=>'500'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_legend_font_family=>'Arial Black'
,p_legend_font_size=>'10'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11040224132556515275)
,p_chart_id=>wwv_flow_api.id(11040224261677515276)
,p_seq=>10
,p_name=>'SELECCION'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT C003, c007||''-''||C002 AREA_MES, C004 TIPO_SOL,  sum(C006) PORC_SELEC',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_SECTT''',
'      AND C003 IS NOT NULL',
'    GROUP BY C003, C002, C004,c007'))
,p_series_type=>'bar'
,p_series_name_column_name=>'TIPO_SOL'
,p_items_value_column_name=>'PORC_SELEC'
,p_items_label_column_name=>'AREA_MES'
,p_items_short_desc_column_name=>'C003'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11040223624829515270)
,p_chart_id=>wwv_flow_api.id(11040224261677515276)
,p_seq=>20
,p_name=>'MES'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' SELECT 15 cant, ''1- ''||TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'') MES_1',
'   FROM DUAL',
'   union all',
'SELECT 15 cant, ''2- ''||TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'') MES_2',
'  FROM DUAL',
'  union all',
'SELECT 15 cant, ''3- ''||TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'') MES_3',
'   FROM DUAL',
'   ORDER BY 2 DESC '))
,p_series_type=>'bar'
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'MES_1'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11040224036090515274)
,p_chart_id=>wwv_flow_api.id(11040224261677515276)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title_font_family=>'Arial Black'
,p_title_font_size=>'10'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_size=>'8'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11040223970375515273)
,p_chart_id=>wwv_flow_api.id(11040224261677515276)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_title_font_family=>'Arial Black'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_size=>'8'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11041772222937731357)
,p_plug_name=>'VACANCIA_DEPAR'
,p_parent_plug_id=>wwv_flow_api.id(11042649345721307150)
,p_region_template_options=>'#DEFAULT#:margin-top-lg:margin-bottom-lg'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>4
,p_plug_display_column=>2
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT NVL(SUM(C001),0) VACANCIA ,C002 AREA, C003 MES, c005 orden, c006 area_cod',
'    FROM APEX_collections',
'    WHERE collection_name = ''VAC_DEPARTAMENTO2''',
'    GROUP BY C002, C003, c005   ,c006',
'UNION ALL     ',
'SELECT NULL, NULL,  C003 MES, c005 orden, NULL area_cod',
' FROM APEX_collections',
'WHERE collection_name = ''VAC_DEPARTAMENTO2''',
' GROUP BY C003 , c005  ',
' ORDER BY 3,2'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11041772140634731356)
,p_max_row_count=>'1000000'
,p_show_search_bar=>'N'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>166714247726858728
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11041772047150731355)
,p_db_column_name=>'VACANCIA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Vacancia'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P2253_FECHA,P2253_MES,P2253_AREA:&P3528_FECHA_HASTA.,#ORDEN#,#AREA_COD#'
,p_column_linktext=>'#VACANCIA#'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11041771895268731354)
,p_db_column_name=>'AREA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Area'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11041771826993731353)
,p_db_column_name=>'MES'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Mes'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11041771722331731352)
,p_db_column_name=>'ORDEN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Orden'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11071353399859454214)
,p_db_column_name=>'AREA_COD'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Area Cod'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11041240030455824198)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1672464'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'MES:AREA:VACANCIA::AREA_COD'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'AREA'
,p_sort_direction_2=>'ASC NULLS FIRST'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11041237874579805477)
,p_report_id=>wwv_flow_api.id(11041240030455824198)
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'AREA'
,p_operator=>'is null'
,p_condition_sql=>' (case when ("AREA" is null) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME#'
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11042649228458307149)
,p_plug_name=>'tablero_vacancia'
,p_region_name=>'EDITARR'
,p_parent_plug_id=>wwv_flow_api.id(11042649345721307150)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>9
,p_plug_display_column=>2
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_NUMBER(A.ORDEN) ORDEN1, ',
'       A.DETALLE, ',
'       A.MES1, ',
'       B.MES_1, ',
'       C.C_MES1, ',
'       A.MES2, ',
'       B.MES_2,',
'       C.C_MES2, ',
'       A.MES3, ',
'       B.MES_3,',
'       C.C_MES3',
'FROM',
'(SELECT C001 ORDEN, C002 DETALLE,C003 UM,  C005 MES1, C006 MES2, C007 MES3',
'                FROM APEX_collections',
'                WHERE collection_name = ''VACANCIA_MES'') A,',
'                ',
'(SELECT B.SELECCION, TO_CHAR(MES_1)MES_1, TO_CHAR(MES_2)MES_2, TO_CHAR(MES_3)MES_3, ORDEN',
'FROM ',
'(SELECT C004 SELECCION, SUM(C008) MES_1, SUM(C009) MES_2, SUM(C010) MES_3',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_SECTT''',
'GROUP BY C004) A,',
'(SELECT C001 SELECCION, TO_NUMBER(C002) ORDEN',
'    FROM APEX_collections',
'    WHERE collection_name = ''SEL_SELECCION_DET'') B',
'WHERE B.SELECCION = A.SELECCION(+)) B,',
' ',
'(SELECT B.SELECCION, TO_CHAR(MES1)C_MES1, TO_CHAR(MES2)C_MES2, TO_CHAR(MES3)C_MES3, ORDEN',
'FROM ',
'(SELECT C004 SELECCION, SUM(C008) MES1, SUM(C009) MES2, SUM(C010) MES3',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONTT''',
'GROUP BY C004) A,',
'(SELECT C001 SELECCION, TO_NUMBER(C002) ORDEN',
'    FROM APEX_collections',
'    WHERE collection_name = ''SEL_SELECCION_DET'') B',
'WHERE B.SELECCION = A.SELECCION(+)) C',
'',
'WHERE A.ORDEN = B.ORDEN(+)',
'  AND A.DETALLE = B.SELECCION(+)',
'  AND A.ORDEN = C.ORDEN(+)',
'  AND A.DETALLE = C.SELECCION(+)',
'UNION ALL',
'SELECT 0 ORDEN, ''INDICADORES'' INDICADOR, C001 MES1,  C001 MES_1, C001 C_MES1, C002 MES2, C002 MES_2, C002 C_MES2, C003 MES3, C003 MES_3, C003 C_MES3',
'    FROM APEX_collections',
'    WHERE collection_name = ''FECHA_VSC''',
'UNION ALL',
'SELECT 2 ORDEN1, ''TOTALES'', TO_cHAR(SUM(A.MES1)),  TO_cHAR(SUM(B.MES_1)),TO_cHAR(SUM(C.C_MES1)),TO_cHAR(SUM(A.MES2)),  TO_cHAR(SUM(B.MES_2)),  TO_cHAR(SUM(C.C_MES2)),  TO_cHAR(SUM(A.MES3)),  TO_cHAR(SUM(B.MES_3)),  TO_cHAR(SUM(C.C_MES3))',
'FROM',
'(SELECT C001 ORDEN, C002 DETALLE,C003 UM,  C005 MES1, C006 MES2, C007 MES3',
'                FROM APEX_collections',
'                WHERE collection_name = ''VACANCIA_MES'') A,',
'                ',
'(SELECT B.SELECCION, TO_CHAR(MES_1)MES_1, TO_CHAR(MES_2)MES_2, TO_CHAR(MES_3)MES_3, ORDEN',
'FROM ',
'(SELECT C004 SELECCION, SUM(C008) MES_1, SUM(C009) MES_2, SUM(C010) MES_3',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_SECTT''',
'GROUP BY C004) A,',
'(SELECT C001 SELECCION, TO_NUMBER(C002) ORDEN',
'    FROM APEX_collections',
'    WHERE collection_name = ''SEL_SELECCION_DET'') B',
'WHERE B.SELECCION = A.SELECCION(+)) B,',
' ',
'(SELECT B.SELECCION, TO_CHAR(MES1)C_MES1, TO_CHAR(MES2)C_MES2, TO_CHAR(MES3)C_MES3, ORDEN',
'FROM ',
'(SELECT C004 SELECCION, SUM(C008) MES1, SUM(C009) MES2, SUM(C010) MES3',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONTT''',
'GROUP BY C004) A,',
'(SELECT C001 SELECCION, TO_NUMBER(C002) ORDEN',
'    FROM APEX_collections',
'    WHERE collection_name = ''SEL_SELECCION_DET'') B',
'WHERE B.SELECCION = A.SELECCION(+)) C',
'',
'WHERE A.ORDEN = B.ORDEN(+)',
'  AND A.DETALLE = B.SELECCION(+)',
'  AND A.ORDEN = C.ORDEN(+)',
'  AND A.DETALLE = C.SELECCION(+)',
'',
'    ',
'',
''))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column_group(
 p_id=>wwv_flow_api.id(11041773360186731368)
,p_heading=>'MES1'
);
wwv_flow_api.create_region_column_group(
 p_id=>wwv_flow_api.id(11041773448143731369)
,p_heading=>'MES 2'
);
wwv_flow_api.create_region_column_group(
 p_id=>wwv_flow_api.id(11041773549020731370)
,p_heading=>'MES 3'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11041772905255731364)
,p_name=>'ORDEN1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ORDEN1'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Orden'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>190
,p_value_alignment=>'CENTER'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_static_id=>'EDITARR'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11041773084721731365)
,p_name=>'C_MES3'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'C_MES3'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>unistr('CONTRATACI\00D3N')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(11041773549020731370)
,p_use_group_for=>'HEADING'
,p_attribute_01=>unistr('<span style=\201Dfont-size:150%;font-weight:bold;\201D>&C_MES3.</span>')
,p_link_target=>'f?p=&APP_ID.:2254:&SESSION.::&DEBUG.:RP:P2254_FECHA,P2254_ORDEN,P2254_TIPO,P2254_TIPO_SELEC:&P3528_FECHA_HASTA.,3,&DETALLE.,2'
,p_filter_is_required=>false
,p_static_id=>'EDITARR'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11041773152803731366)
,p_name=>'C_MES2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'C_MES2'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>unistr('CONTRATACI\00D3N')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(11041773448143731369)
,p_use_group_for=>'HEADING'
,p_attribute_01=>unistr('<span style=\201Dfont-size:150%;font-weight:bold;\201D>&C_MES2.</span>')
,p_link_target=>'f?p=&APP_ID.:2254:&SESSION.::&DEBUG.:RP:P2254_FECHA,P2254_ORDEN,P2254_TIPO,P2254_TIPO_SELEC:&P3528_FECHA_HASTA.,2,&DETALLE.,2'
,p_filter_is_required=>false
,p_static_id=>'EDITARR'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11041773240823731367)
,p_name=>'C_MES1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'C_MES1'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>unistr('CONTRATACI\00D3N')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>160
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(11041773360186731368)
,p_use_group_for=>'HEADING'
,p_attribute_01=>unistr('<span style=\201Dfont-size:150%;font-weight:bold;\201D>&C_MES1.</span>')
,p_link_target=>'f?p=&APP_ID.:2254:&SESSION.::&DEBUG.:RP:P2254_FECHA,P2254_ORDEN,P2254_TIPO,P2254_TIPO_SELEC:&P3528_FECHA_HASTA.,1,&DETALLE.,2'
,p_filter_is_required=>false
,p_static_id=>'EDITARR'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11041773636350731371)
,p_name=>'MES3'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MES3'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'VACANCIA'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>150
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(11041773549020731370)
,p_use_group_for=>'HEADING'
,p_attribute_01=>unistr('<span style=\201Dfont-size:150%;font-weight:bold;\201D>&MES3.</span>')
,p_link_target=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.:RP:P2253_FECHA,P2253_MES,P2253_VACANCIA_TIPO,P2253_OPCION_OCUL:&P3528_FECHA_HASTA.,3,&ORDEN1.,B'
,p_filter_is_required=>false
,p_static_id=>'EDITARR'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11041773716513731372)
,p_name=>'MES2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MES2'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'VACANCIA'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(11041773448143731369)
,p_use_group_for=>'HEADING'
,p_attribute_01=>unistr('<span style=\201Dfont-size:150%;font-weight:bold;\201D>&MES2.</span>')
,p_link_target=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.:RP:P2253_MES,P2253_VACANCIA_TIPO,P2253_FECHA,P2253_OPCION_OCUL:2,&ORDEN1.,&P3528_FECHA_HASTA.,B'
,p_filter_is_required=>false
,p_static_id=>'EDITARR'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11041773880835731373)
,p_name=>'MES1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MES1'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'VACANCIA'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(11041773360186731368)
,p_use_group_for=>'HEADING'
,p_attribute_01=>unistr('<span style=\201Dfont-size:150%;font-weight:bold;\201D>&MES1.</span>')
,p_link_target=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.:RP:P2253_FECHA,P2253_MES,P2253_VACANCIA_TIPO,P2253_OPCION_OCUL:&P3528_FECHA_HASTA.,1,&ORDEN1.,B'
,p_filter_is_required=>false
,p_static_id=>'EDITARR'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11041773904610731374)
,p_name=>'DETALLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETALLE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'Detalle'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>120
,p_value_alignment=>'LEFT'
,p_attribute_01=>unistr('<span style=\201Dfont-size:150%;font-weight:bold;\201D>&DETALLE.</span>')
,p_filter_is_required=>false
,p_static_id=>'EDITARR'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11042647716564307134)
,p_name=>'MES_3'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MES_3'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>unistr('SELECCI\00D3N')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(11041773549020731370)
,p_use_group_for=>'HEADING'
,p_attribute_01=>unistr('<span style=\201Dfont-size:150%;font-weight:bold;\201D>&MES_3.</span>')
,p_link_target=>'f?p=&APP_ID.:2254:&SESSION.::&DEBUG.:RP:P2254_FECHA,P2254_ORDEN,P2254_TIPO,P2254_TIPO_SELEC:&P3528_FECHA_HASTA.,3,&DETALLE.,1'
,p_filter_is_required=>false
,p_static_id=>'EDITARR'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11042647869193307135)
,p_name=>'MES_2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MES_2'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>unistr('SELECCI\00D3N')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(11041773448143731369)
,p_use_group_for=>'HEADING'
,p_attribute_01=>unistr('<span style=\201Dfont-size:150%;font-weight:bold;\201D>&MES_2.</span>')
,p_link_target=>'f?p=&APP_ID.:2254:&SESSION.::&DEBUG.:RP:P2254_FECHA,P2254_ORDEN,P2254_TIPO,P2254_TIPO_SELEC:&P3528_FECHA_HASTA.,2,&DETALLE.,1'
,p_filter_is_required=>false
,p_static_id=>'EDITARR'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11042647892079307136)
,p_name=>'MES_1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MES_1'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>unistr('SELECCI\00D3N')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(11041773360186731368)
,p_use_group_for=>'HEADING'
,p_attribute_01=>unistr('<span style=\201Dfont-size:170%;font-weight:bold;\201D>&MES_1.</span>')
,p_link_target=>'f?p=&APP_ID.:2254:&SESSION.::&DEBUG.:RP:P2254_FECHA,P2254_ORDEN,P2254_TIPO,P2254_TIPO_SELEC:&P3528_FECHA_HASTA.,1,&DETALLE.,1'
,p_filter_is_required=>false
,p_static_id=>'EDITARR'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
end;
/
begin
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(11042649041333307147)
,p_internal_uid=>165837347028282937
,p_is_editable=>false
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
 p_id=>wwv_flow_api.id(11041808272815949443)
,p_interactive_grid_id=>wwv_flow_api.id(11042649041333307147)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(11041808091173949443)
,p_report_id=>wwv_flow_api.id(11041808272815949443)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11041638177153255092)
,p_view_id=>wwv_flow_api.id(11041808091173949443)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(11041772905255731364)
,p_is_visible=>false
,p_is_frozen=>false
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11041653785100349400)
,p_view_id=>wwv_flow_api.id(11041808091173949443)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(11041773084721731365)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11041654270173349402)
,p_view_id=>wwv_flow_api.id(11041808091173949443)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(11041773152803731366)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11041654693420349405)
,p_view_id=>wwv_flow_api.id(11041808091173949443)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(11041773240823731367)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11041709093757643539)
,p_view_id=>wwv_flow_api.id(11041808091173949443)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(11041773636350731371)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11041709667281643541)
,p_view_id=>wwv_flow_api.id(11041808091173949443)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(11041773716513731372)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11041710089965643545)
,p_view_id=>wwv_flow_api.id(11041808091173949443)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(11041773880835731373)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11041710645411643547)
,p_view_id=>wwv_flow_api.id(11041808091173949443)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(11041773904610731374)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11041776097513736593)
,p_view_id=>wwv_flow_api.id(11041808091173949443)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(11042647716564307134)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11041776620999736596)
,p_view_id=>wwv_flow_api.id(11041808091173949443)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(11042647869193307135)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11041777152064736599)
,p_view_id=>wwv_flow_api.id(11041808091173949443)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(11042647892079307136)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_highlight(
 p_id=>wwv_flow_api.id(11014801075959847779)
,p_view_id=>wwv_flow_api.id(11041808091173949443)
,p_execution_seq=>5
,p_name=>'INDICADOR'
,p_background_color=>'#9AEAFC'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_api.id(11041773904610731374)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'INDICADORES'
,p_is_enabled=>true
);
wwv_flow_api.create_ig_report_highlight(
 p_id=>wwv_flow_api.id(11014801130657847779)
,p_view_id=>wwv_flow_api.id(11041808091173949443)
,p_execution_seq=>10
,p_name=>'TOTAL'
,p_background_color=>'#CDE3FA'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_api.id(11041773904610731374)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'TOTALES'
,p_is_enabled=>true
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11070240008869042044)
,p_plug_name=>'Cantidad vacancias cubiertas'
,p_parent_plug_id=>wwv_flow_api.id(11042649345721307150)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_cHAR(SUM(A.MES3)) total_vacacion,  TO_cHAR(SUM(C.C_MES3)) vac_cubiertas,TO_cHAR(SUM(A.MES3))-TO_cHAR(SUM(C.C_MES3)) vac_no_cubiertas',
'FROM',
'(SELECT C001 ORDEN, C007 MES3,C002 DETALLE',
'                FROM APEX_collections',
'                WHERE collection_name = ''VACANCIA_MES'') A,',
' ',
'(SELECT B.SELECCION, TO_CHAR(MES3)C_MES3, ORDEN',
'FROM ',
'(SELECT C004 SELECCION, SUM(C010) MES3',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONTT''',
'GROUP BY C004) A,',
'(SELECT C001 SELECCION, TO_NUMBER(C002) ORDEN',
'    FROM APEX_collections',
'    WHERE collection_name = ''SEL_SELECCION_DET'') B',
'WHERE B.SELECCION = A.SELECCION(+)) C',
'',
'WHERE  A.ORDEN = C.ORDEN(+)',
'  AND A.DETALLE = C.SELECCION(+)'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Cantidad vacancias cubiertas'
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
 p_id=>wwv_flow_api.id(11070239862198042043)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_search_bar=>'N'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>278052153801690612
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11070239744106042042)
,p_db_column_name=>'TOTAL_VACACION'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Total Vacacion'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P2253_FECHA,P2253_MES,P2253_ESTADO,P2253_OPCION_OCUL:&P3528_FECHA_HASTA.,3,,D'
,p_column_linktext=>'#TOTAL_VACACION#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11070239676313042041)
,p_db_column_name=>'VAC_CUBIERTAS'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Vac Cubiertas'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.:Y,:P2253_FECHA,P2253_MES,P2253_ESTADO,P2253_OPCION_OCUL:&P3528_FECHA_HASTA.,3,1,D'
,p_column_linktext=>'#VAC_CUBIERTAS#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11070239558666042040)
,p_db_column_name=>'VAC_NO_CUBIERTAS'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Vac No Cubiertas'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P2253_FECHA,P2253_MES,P2253_ESTADO,P2253_OPCION_OCUL:&P3528_FECHA_HASTA.,3,2,D'
,p_column_linktext=>'#VAC_NO_CUBIERTAS#'
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11070129470054690680)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2781626'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TOTAL_VACACION:VAC_CUBIERTAS:VAC_NO_CUBIERTAS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11071356169312454242)
,p_plug_name=>'VACACIAS DEL MES'
,p_parent_plug_id=>wwv_flow_api.id(11042649345721307150)
,p_region_template_options=>'#DEFAULT#:margin-top-lg:margin-bottom-lg'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (SUM(C.C_MES3)) cant,  ''VAC. CUBIERTA'' DETALLE',
'FROM',
'(SELECT C001 ORDEN, C007 MES3,C002 DETALLE',
'                FROM APEX_collections',
'                WHERE collection_name = ''VACANCIA_MES'') A,',
' ',
'(SELECT B.SELECCION, TO_CHAR(MES3)C_MES3, ORDEN',
'FROM ',
'(SELECT C004 SELECCION, SUM(C010) MES3',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONTT''',
'GROUP BY C004) A,',
'(SELECT C001 SELECCION, TO_NUMBER(C002) ORDEN',
'    FROM APEX_collections',
'    WHERE collection_name = ''SEL_SELECCION_DET'') B',
'WHERE B.SELECCION = A.SELECCION(+)) C',
'',
'WHERE  A.ORDEN = C.ORDEN(+)',
'  AND A.DETALLE = C.SELECCION(+)',
'union all',
'SELECT (SUM(A.MES3))-(SUM(C.C_MES3)),  ''VAC. NO CUBIERTA'' DETALLE',
'FROM',
'(SELECT C001 ORDEN, C007 MES3,C002 DETALLE',
'                FROM APEX_collections',
'                WHERE collection_name = ''VACANCIA_MES'') A,',
' ',
'(SELECT B.SELECCION, TO_CHAR(MES3)C_MES3, ORDEN',
'FROM ',
'(SELECT C004 SELECCION, SUM(C010) MES3',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONTT''',
'GROUP BY C004) A,',
'(SELECT C001 SELECCION, TO_NUMBER(C002) ORDEN',
'    FROM APEX_collections',
'    WHERE collection_name = ''SEL_SELECCION_DET'') B',
'WHERE B.SELECCION = A.SELECCION(+)) C',
'',
'WHERE  A.ORDEN = C.ORDEN(+)',
'  AND A.DETALLE = C.SELECCION(+)',
'',
'    ',
''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11071355240283454233)
,p_region_id=>wwv_flow_api.id(11071356169312454242)
,p_chart_type=>'pie'
,p_title=>'VACANCIAS DEL MES'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_value_format_type=>'decimal'
,p_value_decimal_places=>0
,p_value_format_scaling=>'none'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'bottom'
,p_legend_font_family=>'Arial Black'
,p_legend_font_size=>'12'
,p_overview_rendered=>'off'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11071355199370454232)
,p_chart_id=>wwv_flow_api.id(11071355240283454233)
,p_seq=>10
,p_name=>'VACANCIAS DEL MES'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'DETALLE'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11049228020343540832)
,p_plug_name=>'AUSENCIAS'
,p_parent_plug_id=>wwv_flow_api.id(11094948742428347884)
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>210
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11027236695263971350)
,p_plug_name=>'Ausencia_1'
,p_parent_plug_id=>wwv_flow_api.id(11049228020343540832)
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, ESTADO_DESC,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,  ',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO  =''L''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO,ESTADO_DESC,ESTADO'))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11027236563454971349)
,p_region_id=>wwv_flow_api.id(11027236695263971350)
,p_chart_type=>'pie'
,p_title=>'% TIPOS DE AUSENCIAS MES ACTUAL'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_value_format_type=>'decimal'
,p_value_decimal_places=>0
,p_value_format_scaling=>'none'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11027236495073971348)
,p_chart_id=>wwv_flow_api.id(11027236563454971349)
,p_seq=>10
,p_name=>'CANT_LICENCIA'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'CANT_EMPL_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#FFCC00'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035221295512842636)
,p_chart_id=>wwv_flow_api.id(11027236563454971349)
,p_seq=>20
,p_name=>'CANT_REPOSO'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, ESTADO_DESC,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,  ',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''R''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO,ESTADO_DESC,ESTADO'))
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_items_value_column_name=>'CANT_EMPL_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#4CD964'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035221200224842635)
,p_chart_id=>wwv_flow_api.id(11027236563454971349)
,p_seq=>30
,p_name=>'CANT_PERMISO'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, ESTADO_DESC,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,  ',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''P''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO,ESTADO_DESC,ESTADO'))
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_items_value_column_name=>'CANT_EMPL_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#007AFF'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035221018984842634)
,p_chart_id=>wwv_flow_api.id(11027236563454971349)
,p_seq=>40
,p_name=>'CANT_AUSE_JUST'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, ESTADO_DESC,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,  ',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''A''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO,ESTADO_DESC,ESTADO'))
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_items_value_column_name=>'CANT_EMPL_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#FF9500'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035220927439842633)
,p_chart_id=>wwv_flow_api.id(11027236563454971349)
,p_seq=>50
,p_name=>'CANT_AUSE_INJUSTIFICADA'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, ESTADO_DESC,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,  ',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''C''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO,ESTADO_DESC,ESTADO'))
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_items_value_column_name=>'CANT_EMPL_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#5856D6'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035220821289842632)
,p_chart_id=>wwv_flow_api.id(11027236563454971349)
,p_seq=>60
,p_name=>'CANT_SUSPERNCION'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, ESTADO_DESC,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,  ',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''U''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO,ESTADO_DESC,ESTADO'))
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_items_value_column_name=>'CANT_EMPL_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#FF2D55'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11069446911446150796)
,p_chart_id=>wwv_flow_api.id(11027236563454971349)
,p_seq=>70
,p_name=>'CANT_SUSPERNCION_1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, ESTADO_DESC,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,  ',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''Q''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO,ESTADO_DESC,ESTADO'))
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_items_value_column_name=>'CANT_EMPL_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#2EFFD5'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11033661674705094541)
,p_plug_name=>'AUSENCIAS_2_TAB'
,p_region_name=>'EDITARR'
,p_parent_plug_id=>wwv_flow_api.id(11049228020343540832)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*SELECT  MES, COUNT(DISTINCT(LEGAJO)) TOTAL_EMPLEADO, COUNT(DISTINCT(con_ausencia)) CON_AUSENCIA, COUNT(DISTINCT(LEGAJO)) -COUNT(DISTINCT(con_ausencia)) SIN_AUSENCIA',
'FROM(',
'SELECT LEGAJO ,',
'       T.MES || ''/'' || T.ANHO MES,',
'       case when T.ESTADO NOT IN(''S'', ''H'', ''X'', ''D'', ''F'', ''G'',''W'') then',
'                 LEGAJO',
'             else',
'                 null',
'         end  con_ausencia',
'  FROM PERL051_EMPL_MARC_TEMP T',
' where P_SESSION = :APP_SESSION)',
' group by  MES*/',
' ',
' select 1 ORDEN,',
'       ''A'' CODIGO,',
'       ''TIPO_AUSENCIA'' DESCRIPCION,',
'       TO_CHAR(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA),-2), ''MM/YYYY'') MES1,',
'       TO_CHAR(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA),-1), ''MM/YYYY'') MES2,',
'       TO_CHAR(TO_DATE(:P3528_FECHA_HASTA), ''MM/YYYY'') MESE',
'  from dual',
'union all',
'SELECT ORDEN,',
'       CODIGO,',
'       DETALLE,',
'       TO_CHAR(sum(distinct(CANT_MES1)))CANT_MES1,',
'       TO_CHAR(sum(distinct(CANT_MES2)))CANT_MES2,',
'       TO_CHAR(sum(distinct(CANT_MES3)))CANT_MES3',
'  FROM (SELECT',
'       CASE WHEN MES || ''/'' || T.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA),-2), ''MM/YYYY'') THEN',
'         COUNT(DISTINCT(LEGAJO)) OVER(PARTITION BY ESTADO, T.MES, EMPRESA)',
'        END CANT_MES1,',
'        CASE WHEN MES || ''/'' || T.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA),-1), ''MM/YYYY'') THEN',
'         COUNT(DISTINCT(LEGAJO)) OVER(PARTITION BY ESTADO, T.MES, EMPRESA)',
'        END CANT_MES2,',
'        CASE WHEN MES || ''/'' || T.ANHO =TO_CHAR(TO_DATE(:P3528_FECHA_HASTA), ''MM/YYYY'')THEN',
'         COUNT(DISTINCT(LEGAJO)) OVER(PARTITION BY ESTADO, T.MES, EMPRESA)',
'        END CANT_MES3,',
'       ESTADO,',
'       ESTADO_DESC,',
'       T.MES || ''/'' || T.ANHO MES_A',
'  FROM PERL051_EMPL_MARC_TEMP T',
' WHERE T.ESTADO NOT IN (''S'', ''H'', ''X'', ''D'', ''F'', ''G'', ''W'')',
'   AND P_SESSION =  :APP_SESSION )A,',
'    ( SELECT REGEXP_SUBSTR(''AUSENCIA JUSTIFICADA,AUSENCIA INJUSTIFICADA,LICENCIA,PERMISO,REPOSO,SUSPENSION,SUSP. AISLAMIENTO'', ''[^,]+'', 1,   LEVEL) DETALLE,',
'       REGEXP_SUBSTR(''A,C,L,P,R,U,Q'',''[^,]+'', 1, LEVEL) CODIGO,',
'       LEVEL + 1 ORDEN',
'  FROM DUAL',
'CONNECT BY REGEXP_SUBSTR(''AUSENCIA JUSTIFICADA,AUSENCIA INJUSTIFICADA,LICENCIA,PERMISO,REPOSO,SUSPENSION,SUSP. AISLAMIENTO'', ''[^,]+'', 1,LEVEL) IS NOT NULL)D',
'',
'WHERE CODIGO = A.ESTADO(+)',
'   GROUP BY CODIGO,',
'            DETALLE,',
'            ORDEN'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'AUSENCIAS_2_TAB'
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
 p_id=>wwv_flow_api.id(11033156421019196453)
,p_max_row_count=>'1000000'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>92758077811338720
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11027237556239971359)
,p_db_column_name=>'ORDEN'
,p_display_order=>10
,p_column_identifier=>'H'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11027237478480971358)
,p_db_column_name=>'CODIGO'
,p_display_order=>20
,p_column_identifier=>'I'
,p_column_label=>'Codigo'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11027237244383971356)
,p_db_column_name=>'MES1'
,p_display_order=>40
,p_column_identifier=>'K'
,p_column_label=>'Mes'
,p_column_link=>'f?p=&APP_ID.:2261:&SESSION.::&DEBUG.::P2261_MES,P2261_P_SESSION,P2261_TIPO,P2261_FECHA:2,&APP_SESSION.,#CODIGO#,&P3528_FECHA_HASTA.'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11027237121083971355)
,p_db_column_name=>'MES2'
,p_display_order=>50
,p_column_identifier=>'L'
,p_column_label=>'Mes'
,p_column_link=>'f?p=&APP_ID.:2261:&SESSION.::&DEBUG.::P2261_FECHA,P2261_MES,P2261_P_SESSION,P2261_TIPO:&P3528_FECHA_HASTA.,1,&APP_SESSION.,#CODIGO#'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11027237010648971354)
,p_db_column_name=>'MESE'
,p_display_order=>60
,p_column_identifier=>'M'
,p_column_label=>'Mes'
,p_column_link=>'f?p=&APP_ID.:2261:&SESSION.::&DEBUG.::P2261_FECHA,P2261_MES,P2261_P_SESSION,P2261_TIPO:&P3528_FECHA_HASTA.,0,&APP_SESSION.,#CODIGO#'
,p_column_linktext=>'#MESE#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11027236904670971353)
,p_db_column_name=>'DESCRIPCION'
,p_display_order=>70
,p_column_identifier=>'N'
,p_column_label=>'Descripcion'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11033017323504612054)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'928972'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DESCRIPCION:MES1:MES2:MESE:'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11027104737495278412)
,p_report_id=>wwv_flow_api.id(11033017323504612054)
,p_name=>'AUSENCIAS'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'TIPO_AUSENCIA'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''TIPO_AUSENCIA''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#D0F1CC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11033663501530094560)
,p_plug_name=>'Ausencia_1_tab'
,p_parent_plug_id=>wwv_flow_api.id(11049228020343540832)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>80
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL, ESTADO_DESC,ESTADO,round((CANT_DIA_CONCEPTO/CANTIDAD_TOTAL)*100) PORCENTAJE,  TO_CHAR(TO_DATE(&P3528_FECHA_HASTA),''IW'') SEMANA',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO NOT IN (''S'',''H'',''X'',''D'',''F'',''G'',''W'',''T'',''V'')',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'     AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Ausencia_1_tab'
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
end;
/
begin
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11033663248761094557)
,p_max_row_count=>'1000000'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>92251250069440616
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11033154934013196438)
,p_db_column_name=>'ESTADO'
,p_display_order=>20
,p_column_identifier=>'N'
,p_column_label=>'Estado'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11033154843046196437)
,p_db_column_name=>'ESTADO_DESC'
,p_display_order=>30
,p_column_identifier=>'O'
,p_column_label=>'Tipo Ausencia'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11033153496142196423)
,p_db_column_name=>'CANT_EMPL_CONCEPTO'
,p_display_order=>40
,p_column_identifier=>'P'
,p_column_label=>'Cant Empleados'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11031374863697950472)
,p_db_column_name=>'CANT_DIA_CONCEPTO'
,p_display_order=>50
,p_column_identifier=>'Q'
,p_column_label=>'Cant Dia '
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11031374773976950471)
,p_db_column_name=>'CANTIDAD_TOTAL'
,p_display_order=>60
,p_column_identifier=>'R'
,p_column_label=>'Cantidad Total'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11031374572055950469)
,p_db_column_name=>'PORCENTAJE'
,p_display_order=>70
,p_column_identifier=>'S'
,p_column_label=>'Porcentaje'
,p_column_link=>'f?p=&APP_ID.:2261:&SESSION.::&DEBUG.::P2261_FECHA,P2261_P_SESSION,P2261_TIPO,P2261_SEMANA,P2261_MES:&P3528_FECHA_HASTA.,&APP_SESSION.,#ESTADO#,4,0'
,p_column_linktext=>'#PORCENTAJE#'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11027236228507971346)
,p_db_column_name=>'SEMANA'
,p_display_order=>80
,p_column_identifier=>'T'
,p_column_label=>'Semana'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11033640516175928006)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'922740'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ESTADO_DESC:CANT_EMPL_CONCEPTO:PORCENTAJE::SEMANA'
,p_sum_columns_on_break=>'PORCENTAJE:CANTIDAD:CANTIDAD_DIAS:CANT_EMPL_CONCEPTO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11033664437032094569)
,p_plug_name=>'Ausencia_1'
,p_parent_plug_id=>wwv_flow_api.id(11049228020343540832)
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>90
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, ESTADO_DESC,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,  ',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''L''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO,ESTADO_DESC,ESTADO'))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11033663971378094564)
,p_region_id=>wwv_flow_api.id(11033664437032094569)
,p_chart_type=>'pie'
,p_title=>'Cant. dias Tipo Ausencia - Semana'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_value_format_type=>'decimal'
,p_value_decimal_places=>0
,p_value_format_scaling=>'none'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11033663893152094563)
,p_chart_id=>wwv_flow_api.id(11033663971378094564)
,p_seq=>10
,p_name=>'CANT_LICENCIA'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'CANT_EMPL_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#FFCC00'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035220804008842631)
,p_chart_id=>wwv_flow_api.id(11033663971378094564)
,p_seq=>20
,p_name=>'CANT_REPOSO'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, ESTADO_DESC,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,  ',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO = ''R''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO,ESTADO_DESC,ESTADO'))
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_items_value_column_name=>'CANT_EMPL_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#4CD964'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035220683835842630)
,p_chart_id=>wwv_flow_api.id(11033663971378094564)
,p_seq=>30
,p_name=>'CANT_PERMISO'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, ESTADO_DESC,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,  ',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO = ''P''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO,ESTADO_DESC,ESTADO'))
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_items_value_column_name=>'CANT_EMPL_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#007AFF'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035220567794842629)
,p_chart_id=>wwv_flow_api.id(11033663971378094564)
,p_seq=>40
,p_name=>'CANT_AUSE_JUST'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, ESTADO_DESC,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,  ',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO = ''A''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO,ESTADO_DESC,ESTADO'))
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_items_value_column_name=>'CANT_EMPL_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#FF9500'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035220492268842628)
,p_chart_id=>wwv_flow_api.id(11033663971378094564)
,p_seq=>50
,p_name=>'CANT_AUSE_INJUST'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, ESTADO_DESC,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,  ',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO = ''C''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO,ESTADO_DESC,ESTADO'))
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_items_value_column_name=>'CANT_EMPL_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#5856D6'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035220340896842627)
,p_chart_id=>wwv_flow_api.id(11033663971378094564)
,p_seq=>60
,p_name=>'CANT_SUSPENCION'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, ESTADO_DESC,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,  ',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO = ''U''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO,ESTADO_DESC,ESTADO'))
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_items_value_column_name=>'CANT_EMPL_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#FF2D55'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11069446716442150794)
,p_chart_id=>wwv_flow_api.id(11033663971378094564)
,p_seq=>70
,p_name=>'CANT_SUSPENCION_1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, ESTADO_DESC,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,  ',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO = ''Q''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO,ESTADO_DESC,ESTADO'))
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_items_value_column_name=>'CANT_EMPL_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#2EFFD5'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11069445305132150780)
,p_plug_name=>'Ausencias por semana'
,p_parent_plug_id=>wwv_flow_api.id(11049228020343540832)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>120
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 0 ORDEN,',
'        ''A'' ESTADO,',
'       ''INDICADORES'' INDICADORES,',
'      max(CASE',
'         WHEN SEMANA_TAB = 1 THEN',
'          SEMANA',
'       END) SEMANA1,',
'       max(CASE',
'         WHEN SEMANA_TAB = 2 THEN',
'          SEMANA',
'       END) SEMANA2,',
'      max( CASE',
'         WHEN SEMANA_TAB = 3 THEN',
'          SEMANA',
'       END) SEMANA3,',
'       max(CASE',
'         WHEN SEMANA_TAB = 4 THEN',
'          SEMANA',
'       END) SEMANA4',
'',
'  FROM PERL051_EMPL_MARC_TEMP T',
' WHERE T.SEMANA_TAB IS NOT NULL',
'   AND T.P_SESSION = :APP_SESSION',
'   AND SEMANA_TAB IS NOT NULL',
'   AND ESTADO NOT IN (''S'', ''H'', ''X'', ''D'', ''F'', ''G'', ''W'', ''V'') ',
'UNION ALL',
'SELECT  1 ORDEN,',
'      ESTADO,',
'       TIPO_AUSENCIA,',
'       TO_CHAR(ROUND(((SEMANA1/ SUM(SEMANA1) OVER(PARTITION BY 1))*100),2),''990D99'')||''%'' POR_SEM1,',
'       TO_CHAR(ROUND(((SEMANA2/ SUM(SEMANA2) OVER(PARTITION BY 1))*100),2),''990D99'')||''%'' POR_SEM2,',
'       TO_CHAR(ROUND(((SEMANA3/ SUM(SEMANA3) OVER(PARTITION BY 1))*100),2),''990D99'')||''%'' POR_SEM3,',
'       TO_CHAR(ROUND(((SEMANA4/ SUM(SEMANA4) OVER(PARTITION BY 1))*100),2),''990D99'')||''%'' POR_SEM4',
'FROM ',
'(SELECT COUNT(CASE WHEN ESTADO NOT IN (''S'', ''H'', ''X'', ''D'', ''F'', ''G'', ''W'', ''V'') AND SEMANA_TAB = 1 THEN',
'                1',
'             END) SEMANA1,',
'     COUNT(CASE WHEN ESTADO NOT IN (''S'', ''H'', ''X'', ''D'', ''F'', ''G'', ''W'', ''V'') AND  SEMANA_TAB =2 THEN',
'                1',
'             END) SEMANA2,',
'     COUNT(CASE WHEN ESTADO NOT IN (''S'', ''H'', ''X'', ''D'', ''F'', ''G'', ''W'', ''V'') AND  SEMANA_TAB = 3 THEN',
'                1',
'             END) SEMANA3,',
'     COUNT(CASE WHEN ESTADO NOT IN (''S'', ''H'', ''X'', ''D'', ''F'', ''G'', ''W'', ''V'') AND  SEMANA_TAB = 4 THEN',
'                1',
'             END) SEMANA4,',
'       ESTADO,',
'       CASE WHEN ESTADO = ''A'' THEN',
'                 ''AUSENCIA JUSTIFICADA''',
'            WHEN  ESTADO = ''C'' THEN',
'               ''AUSENCIA INJUSTIFICADA''',
'              WHEN  ESTADO = ''L'' THEN',
'                ''LICENCIA''',
'               WHEN  ESTADO = ''P'' THEN',
'                ''PERMISO''',
'                WHEN  ESTADO = ''R'' THEN',
'                ''REPOSO''',
'                WHEN  ESTADO = ''U'' THEN',
'                ''SUSPENSION''',
'                 ',
'                 WHEN  ESTADO = ''Q'' THEN',
'                ''SUSP. AISLAMIENTO''',
'             END TIPO_AUSENCIA',
'  FROM PERL051_EMPL_MARC_TEMP T',
' WHERE T.SEMANA_TAB IS NOT NULL',
'   AND T.P_SESSION = :APP_SESSION',
'   AND SEMANA_TAB IS NOT NULL',
'   AND ESTADO NOT IN (''S'', ''H'', ''X'', ''D'', ''F'', ''G'', ''W'', ''V'')',
'   GROUP BY ESTADO  )A'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Ausencias por semana'
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
 p_id=>wwv_flow_api.id(11069445178344150779)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>572668096632315424
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060115026368206498)
,p_db_column_name=>'ORDEN'
,p_display_order=>10
,p_column_identifier=>'E'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060114972524206497)
,p_db_column_name=>'ESTADO'
,p_display_order=>20
,p_column_identifier=>'F'
,p_column_label=>'Estado'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060114847663206496)
,p_db_column_name=>'INDICADORES'
,p_display_order=>30
,p_column_identifier=>'G'
,p_column_label=>'Indicadores'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060114747011206495)
,p_db_column_name=>'SEMANA1'
,p_display_order=>40
,p_column_identifier=>'H'
,p_column_label=>'Semana'
,p_column_link=>'f?p=&APP_ID.:2261:&SESSION.::&DEBUG.::P2261_FECHA,P2261_MES,P2261_P_SESSION,P2261_SEMANA,P2261_TIPO:&P3528_FECHA_HASTA.,0,&APP_SESSION.,1,#ESTADO#'
,p_column_linktext=>'#SEMANA1#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060114628379206494)
,p_db_column_name=>'SEMANA2'
,p_display_order=>50
,p_column_identifier=>'I'
,p_column_label=>'Semana'
,p_column_link=>'f?p=&APP_ID.:2261:&SESSION.::&DEBUG.::P2261_FECHA,P2261_MES,P2261_P_SESSION,P2261_SEMANA,P2261_TIPO:&P3528_FECHA_HASTA.,0,&APP_SESSION.,2,#ESTADO#'
,p_column_linktext=>'#SEMANA2#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060114498327206493)
,p_db_column_name=>'SEMANA3'
,p_display_order=>60
,p_column_identifier=>'J'
,p_column_label=>'Semana'
,p_column_link=>'f?p=&APP_ID.:2261:&SESSION.::&DEBUG.::P2261_FECHA,P2261_MES,P2261_P_SESSION,P2261_SEMANA,P2261_TIPO:&P3528_FECHA_HASTA.,0,&APP_SESSION.,3,#ESTADO#'
,p_column_linktext=>'#SEMANA3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060114444548206492)
,p_db_column_name=>'SEMANA4'
,p_display_order=>70
,p_column_identifier=>'K'
,p_column_label=>'Semana'
,p_column_link=>'f?p=&APP_ID.:2261:&SESSION.::&DEBUG.::P2261_FECHA,P2261_MES,P2261_P_SESSION,P2261_SEMANA,P2261_TIPO:&P3528_FECHA_HASTA.,0,&APP_SESSION.,4,#ESTADO#'
,p_column_linktext=>'#SEMANA4#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11068750932485401179)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'5733624'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'INDICADORES:SEMANA1:SEMANA2:SEMANA3:SEMANA4:'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11059902784966140313)
,p_report_id=>wwv_flow_api.id(11068750932485401179)
,p_name=>'INDICADORES'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'ORDEN'
,p_operator=>'='
,p_expr=>'0'
,p_condition_sql=>' (case when ("ORDEN" = to_number(#APXWS_EXPR#)) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = #APXWS_EXPR_NUMBER#  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#D0F1CC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11069446513774150792)
,p_plug_name=>'PORCENTAJE AUSENCIA SEMANAL'
,p_parent_plug_id=>wwv_flow_api.id(11049228020343540832)
,p_region_template_options=>'#DEFAULT#:t-Region--noUI:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>110
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (COUNT(CASE',
'               WHEN ESTADO NOT IN (''S'', ''H'', ''X'', ''D'', ''F'', ''G'', ''W'', ''V'') THEN',
'                1',
'             END)/',
'             SUM(COUNT(CASE',
'               WHEN ESTADO NOT IN (''S'', ''H'', ''X'', ''D'', ''F'', ''G'', ''W'', ''V'') THEN',
'                1',
'             END))OVER(PARTITION BY SEMANA)) TOTAL_sEM,',
'       ESTADO,',
'       CASE',
'         WHEN ESTADO = ''A'' THEN',
'          ''AUSENCIA JUSTIFICADA''',
'         WHEN ESTADO = ''C'' THEN',
'          ''AUSENCIA INJUSTIFICADA''',
'         WHEN ESTADO = ''L'' THEN',
'          ''LICENCIA''',
'         WHEN ESTADO = ''P'' THEN',
'          ''PERMISO''',
'         WHEN ESTADO = ''R'' THEN',
'          ''REPOSO''',
'         WHEN ESTADO = ''U'' THEN',
'          ''SUSPENSION''',
'         WHEN ESTADO = ''Q'' THEN',
'          ''SUSP. AISLAMIENTO''',
'       END TIPO_AUSENCIA,',
'       ''SEM:''||SEMANA SEMANA,',
'	   10 Z',
'  FROM PERL051_EMPL_MARC_TEMP T',
' WHERE T.SEMANA_TAB IS NOT NULL',
'   AND T.P_SESSION = :APP_SESSION',
'   AND SEMANA_TAB IS NOT NULL',
'   AND ESTADO NOT IN (''S'', ''H'', ''X'', ''D'', ''F'', ''G'', ''W'', ''V'')',
' GROUP BY ESTADO, SEMANA'))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11069445739311150784)
,p_region_id=>wwv_flow_api.id(11069446513774150792)
,p_chart_type=>'bar'
,p_title=>'PORCENTAJE DE AUSENCIA SEMANAL'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'top'
,p_legend_font_family=>'Arial Black'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11069445642264150783)
,p_chart_id=>wwv_flow_api.id(11069445739311150784)
,p_seq=>10
,p_name=>'GRAFICO_SEMANAL'
,p_location=>'REGION_SOURCE'
,p_series_name_column_name=>'TIPO_AUSENCIA'
,p_items_value_column_name=>'TOTAL_SEM'
,p_items_z_column_name=>'Z'
,p_items_label_column_name=>'SEMANA'
,p_items_short_desc_column_name=>'TIPO_AUSENCIA'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11069445516351150782)
,p_chart_id=>wwv_flow_api.id(11069445739311150784)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_tick_label_font_family=>'Arial Black'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11069445454444150781)
,p_chart_id=>wwv_flow_api.id(11069445739311150784)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'percent'
,p_decimal_places=>1
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_size=>'10'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11095338202003395042)
,p_plug_name=>'AUSENCIA - CANT DIAS MES'
,p_parent_plug_id=>wwv_flow_api.id(11049228020343540832)
,p_region_template_options=>'#DEFAULT#:margin-top-lg:margin-bottom-lg'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>60
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO CANT_EMPLEADO, CANT_DIA_CONCEPTO CANT_DIAS, CANTIDAD_TOTAL, ESTADO_DESC TIPO_AUSENCIA,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO NOT IN (''S'',''H'',''X'',''D'',''F'',''G'',''W'',''T'',''V'', ''C'')',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11095337437726395035)
,p_region_id=>wwv_flow_api.id(11095338202003395042)
,p_chart_type=>'pie'
,p_title=>'Cant. dias Tipo Ausencia - Mes'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_value_format_type=>'decimal'
,p_value_decimal_places=>0
,p_value_format_scaling=>'none'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'bottom'
,p_overview_rendered=>'off'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035222819675842652)
,p_chart_id=>wwv_flow_api.id(11095337437726395035)
,p_seq=>20
,p_name=>'CANT_LICENCIA'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO CANT_EMPLEADO, CANT_DIA_CONCEPTO CANT_DIAS, CANTIDAD_TOTAL, ESTADO_DESC TIPO_AUSENCIA,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO = ''L''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_items_value_column_name=>'CANT_EMPLEADO'
,p_items_label_column_name=>'TIPO_AUSENCIA'
,p_color=>'#FFCC00'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035221959962842643)
,p_chart_id=>wwv_flow_api.id(11095337437726395035)
,p_seq=>30
,p_name=>'CANT_REPOSO'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO CANT_EMPLEADO, CANT_DIA_CONCEPTO CANT_DIAS, CANTIDAD_TOTAL, ESTADO_DESC TIPO_AUSENCIA,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO = ''R''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_items_value_column_name=>'CANT_EMPLEADO'
,p_items_label_column_name=>'TIPO_AUSENCIA'
,p_color=>'#4CD964'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035222415441842647)
,p_chart_id=>wwv_flow_api.id(11095337437726395035)
,p_seq=>40
,p_name=>'CANT_PERMISO'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO CANT_EMPLEADO, CANT_DIA_CONCEPTO CANT_DIAS, CANTIDAD_TOTAL, ESTADO_DESC TIPO_AUSENCIA,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO = ''P''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_items_value_column_name=>'CANT_EMPLEADO'
,p_items_label_column_name=>'TIPO_AUSENCIA'
,p_color=>'#007AFF'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035222309654842646)
,p_chart_id=>wwv_flow_api.id(11095337437726395035)
,p_seq=>50
,p_name=>'CANT_AUSE_JUST'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO CANT_EMPLEADO, CANT_DIA_CONCEPTO CANT_DIAS, CANTIDAD_TOTAL, ESTADO_DESC TIPO_AUSENCIA,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO = ''A''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_items_value_column_name=>'CANT_EMPLEADO'
,p_items_label_column_name=>'TIPO_AUSENCIA'
,p_color=>'#FF9500'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
end;
/
begin
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035222157847842645)
,p_chart_id=>wwv_flow_api.id(11095337437726395035)
,p_seq=>60
,p_name=>'CANT_AUSE_INJUST'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO CANT_EMPLEADO, CANT_DIA_CONCEPTO CANT_DIAS, CANTIDAD_TOTAL, ESTADO_DESC TIPO_AUSENCIA,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''C''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_items_value_column_name=>'CANT_EMPLEADO'
,p_items_label_column_name=>'TIPO_AUSENCIA'
,p_color=>'#5856D6'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035222098446842644)
,p_chart_id=>wwv_flow_api.id(11095337437726395035)
,p_seq=>70
,p_name=>'CANT_SUSP'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO CANT_EMPLEADO, CANT_DIA_CONCEPTO CANT_DIAS, CANTIDAD_TOTAL, ESTADO_DESC TIPO_AUSENCIA,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO  =''U''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_items_value_column_name=>'CANT_EMPLEADO'
,p_items_label_column_name=>'TIPO_AUSENCIA'
,p_color=>'#FF2D55'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11069446597573150793)
,p_chart_id=>wwv_flow_api.id(11095337437726395035)
,p_seq=>80
,p_name=>'CANT_SUSP_1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO CANT_EMPLEADO, CANT_DIA_CONCEPTO CANT_DIAS, CANTIDAD_TOTAL, ESTADO_DESC TIPO_AUSENCIA,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO  =''Q''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_items_value_column_name=>'CANT_EMPLEADO'
,p_items_label_column_name=>'TIPO_AUSENCIA'
,p_color=>'#2EFFD5'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096599317414039910)
,p_plug_name=>'AUSENCIAS - CANTIDAD DIAS'
,p_parent_plug_id=>wwv_flow_api.id(11049228020343540832)
,p_region_template_options=>'#DEFAULT#:margin-top-lg:margin-bottom-lg'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL, ESTADO_DESC,ESTADO,  TO_CHAR(TO_DATE(&P3528_FECHA_HASTA),''IW'') SEMANA',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''L''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'     AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11095339135703395052)
,p_region_id=>wwv_flow_api.id(11096599317414039910)
,p_chart_type=>'pie'
,p_title=>'% TIPOS DE AUSENCIAS  SEMANA'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_value_format_type=>'decimal'
,p_value_decimal_places=>0
,p_value_format_scaling=>'none'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'bottom'
,p_overview_rendered=>'off'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11095339018881395051)
,p_chart_id=>wwv_flow_api.id(11095339135703395052)
,p_seq=>10
,p_name=>'CANT_LICENCIA'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'CANT_DIA_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#FFCC00'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035221883149842642)
,p_chart_id=>wwv_flow_api.id(11095339135703395052)
,p_seq=>20
,p_name=>'CANT_REPOSO'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL, ESTADO_DESC,ESTADO,  TO_CHAR(TO_DATE(&P3528_FECHA_HASTA),''IW'') SEMANA',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''R''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'     AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_items_value_column_name=>'CANT_DIA_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#4CD964'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'ALL'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035221658514842640)
,p_chart_id=>wwv_flow_api.id(11095339135703395052)
,p_seq=>30
,p_name=>'CANT_PERMISO'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL, ESTADO_DESC,ESTADO,  TO_CHAR(TO_DATE(&P3528_FECHA_HASTA),''IW'') SEMANA',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''P''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'     AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_items_value_column_name=>'CANT_DIA_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#007AFF'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'ALL'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035221596873842639)
,p_chart_id=>wwv_flow_api.id(11095339135703395052)
,p_seq=>40
,p_name=>'CANT_AUSE_JUST'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL, ESTADO_DESC,ESTADO,  TO_CHAR(TO_DATE(&P3528_FECHA_HASTA),''IW'') SEMANA',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''A''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'     AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_items_value_column_name=>'CANT_DIA_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#FF9500'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'ALL'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035221428675842638)
,p_chart_id=>wwv_flow_api.id(11095339135703395052)
,p_seq=>50
,p_name=>'CANT_AUSE_INJUST'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL, ESTADO_DESC,ESTADO,  TO_CHAR(TO_DATE(&P3528_FECHA_HASTA),''IW'') SEMANA',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''C''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'     AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_items_value_column_name=>'CANT_DIA_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#5856D6'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'ALL'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11035221402017842637)
,p_chart_id=>wwv_flow_api.id(11095339135703395052)
,p_seq=>60
,p_name=>'CANT_SUSPENCION'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL, ESTADO_DESC,ESTADO,  TO_CHAR(TO_DATE(&P3528_FECHA_HASTA),''IW'') SEMANA',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''U''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'     AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_items_value_column_name=>'CANT_DIA_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#FF2D55'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'ALL'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11069446801993150795)
,p_chart_id=>wwv_flow_api.id(11095339135703395052)
,p_seq=>70
,p_name=>'CANT_SUSPENCION_1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL, ESTADO_DESC,ESTADO,  TO_CHAR(TO_DATE(&P3528_FECHA_HASTA),''IW'') SEMANA',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO =''Q''',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'     AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_items_value_column_name=>'CANT_DIA_CONCEPTO'
,p_items_label_column_name=>'ESTADO_DESC'
,p_color=>'#2EFFD5'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'ALL'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096600206141039918)
,p_plug_name=>'Cant_dias_semana'
,p_parent_plug_id=>wwv_flow_api.id(11049228020343540832)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>100
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL, ESTADO_DESC,ESTADO,  TO_CHAR(TO_DATE(&P3528_FECHA_HASTA),''IW'') SEMANA',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO NOT IN (''S'',''H'',''X'',''D'',''F'',''G'',''W'',''T'',''V'')',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'     AND TO_CHAR(T.FECHA,''IW'')= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Cant_dias_semana'
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
 p_id=>wwv_flow_api.id(11096600113864039917)
,p_max_row_count=>'1000000'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>251691902135692738
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096599971842039916)
,p_db_column_name=>'CANT_EMPL_CONCEPTO'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Cant. Empleado'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096599854212039915)
,p_db_column_name=>'CANT_DIA_CONCEPTO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Cantidad de Dias'
,p_column_link=>'f?p=&APP_ID.:2261:&SESSION.::&DEBUG.::P2261_FECHA,P2261_MES,P2261_P_SESSION,P2261_SEMANA,P2261_TIPO:&P3528_FECHA_HASTA.,0,&APP_SESSION.,4,#ESTADO#'
,p_column_linktext=>'#CANT_DIA_CONCEPTO#'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096599752931039914)
,p_db_column_name=>'CANTIDAD_TOTAL'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Cantidad Total'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096599619058039913)
,p_db_column_name=>'ESTADO_DESC'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Tipo Ausencia'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096599533772039912)
,p_db_column_name=>'ESTADO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Estado'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096599450040039911)
,p_db_column_name=>'SEMANA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Semana'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11095355012586423453)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2529371'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ESTADO_DESC:CANT_EMPL_CONCEPTO:CANT_DIA_CONCEPTO:'
,p_sum_columns_on_break=>'CANT_DIA_CONCEPTO:CANT_EMPL_CONCEPTO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096600243766039919)
,p_plug_name=>'AUSENCIA - CANT DIAS MES'
,p_parent_plug_id=>wwv_flow_api.id(11049228020343540832)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CANT_EMPL_CONCEPTO CANT_EMPLEADO, CANT_DIA_CONCEPTO CANT_DIAS, CANTIDAD_TOTAL, ESTADO_DESC TIPO_AUSENCIA,ESTADO',
'FROM(',
'SELECT ',
'    count(distinct(legajo)) over (partition by ESTADO, empresa) CANT_EMPL_CONCEPTO,',
'    count(legajo)over (partition by ESTADO, empresa) CANT_DIA_CONCEPTO,',
'    COUNT(legajo) OVER(PARTITION BY EMPRESA) CANTIDAD_TOTAL , ESTADO,ESTADO_DESC',
'FROM PERL051_EMPL_MARC_TEMP T',
'WHERE T.ESTADO NOT IN (''S'',''H'',''X'',''D'',''F'',''G'',''W'',''T'',''V'')',
'AND T.MES||''/''||T.ANHO = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND P_SESSION =:APP_SESSION)',
'  GROUP BY CANT_EMPL_CONCEPTO, CANT_DIA_CONCEPTO, CANTIDAD_TOTAL,ESTADO_DESC,ESTADO'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'AUSENCIA - CANT DIAS MES'
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
 p_id=>wwv_flow_api.id(11095338801767395048)
,p_max_row_count=>'1000000'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>252953214232337607
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095338638476395047)
,p_db_column_name=>'CANT_EMPLEADO'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Cant Empleado'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095338596706395046)
,p_db_column_name=>'CANT_DIAS'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Cant Dias'
,p_column_link=>'f?p=&APP_ID.:2261:&SESSION.::&DEBUG.::P2261_FECHA,P2261_MES,P2261_P_SESSION,P2261_TIPO:&P3528_FECHA_HASTA.,0,&APP_SESSION.,#ESTADO#'
,p_column_linktext=>'#CANT_DIAS#'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095338446410395045)
,p_db_column_name=>'CANTIDAD_TOTAL'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Cantidad Total'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095338358352395044)
,p_db_column_name=>'TIPO_AUSENCIA'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Tipo Ausencia'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095338274708395043)
,p_db_column_name=>'ESTADO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Estado'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11095311036645345361)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2529810'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TIPO_AUSENCIA:CANT_EMPLEADO:CANT_DIAS:'
,p_sum_columns_on_break=>'CANT_EMPLEADO:CANT_DIAS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11095207373900361172)
,p_plug_name=>'INDICADORES'
,p_parent_plug_id=>wwv_flow_api.id(11094948742428347884)
,p_region_template_options=>'#DEFAULT#:t-Region--accent5:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'Y'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11095060579332305844)
,p_plug_name=>'DOTACION'
,p_parent_plug_id=>wwv_flow_api.id(11095207373900361172)
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11064175542013160860)
,p_plug_name=>'DOT_NRO1'
,p_parent_plug_id=>wwv_flow_api.id(11095060579332305844)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>50
,p_plug_grid_column_span=>7
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ''DOTACION TEMPORAL'' DESCRIPCION, ''Q'' UM,  TO_CHAR(SUM(c010)-SUM(c002)) PB, TO_CHAR(SUM(c007)-SUM(c003)) MES1, TO_CHAR(SUM(c008)-SUM(c004)) MES2, TO_CHAR(SUM(c009)-SUM(c005)) MES3, ''BC'' ORDEN',
'        FROM APEX_collections',
'       WHERE collection_name = ''DOT_CANTIDAD''',
'       AND C006 <> ''A''',
'UNION ALL',
'SELECT ''DOTACION TOTAL'' DESCRIPCION, ''Q'' UM, TO_CHAR(SUM(c002)) PB, TO_CHAR(SUM(c007)) MES1, TO_CHAR(SUM(c008)) MES2, TO_CHAR(SUM(c009)) MES3, ''B'' ORDEN',
'        FROM APEX_collections',
'       WHERE collection_name = ''DOT_CANTIDAD''',
'       AND C006 <> ''A''',
'UNION ALL',
' SELECT C001 DESCR, ''Q'', c002 PB, c003 MES1, c004 MES2, c005 MES3, c006 ORDEN',
'        FROM APEX_collections',
'       WHERE collection_name = ''DOT_CANTIDAD''',
'       AND C006=''A''',
'UNION ALL',
' SELECT C001 DESCR, ''Q'', c002 PB, c003 MES1, c004 MES2, c005 MES3, c006 ORDEN---c007 MES1, c008 MES2, c009 MES3, c006 ORDEN',
'        FROM APEX_collections',
'       WHERE collection_name = ''DOT_CANTIDAD''',
'       AND C006 NOT IN(''A'')',
'ORDER BY 7'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11064173846135160843)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>144312542226429241
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11064173560266160840)
,p_db_column_name=>'PB'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'PB'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11064173430822160839)
,p_db_column_name=>'MES1'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'MES'
,p_column_link=>'javascript:openModal(''DOTACION''); javascript:$s(''P3528_OPC_DOTA'',''1'');javascript:$s(''P3528_DOT_MES_DEP'',''#DESCRIPCION#'');'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11064173379296160838)
,p_db_column_name=>'MES2'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'MES'
,p_column_link=>'javascript:openModal(''DOTACION''); javascript:$s(''P3528_OPC_DOTA'',''2'');javascript:$s(''P3528_DOT_MES_DEP'',''#DESCRIPCION#'');'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11064173225593160837)
,p_db_column_name=>'MES3'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'MES'
,p_column_link=>'javascript:openModal(''DOTACION''); javascript:$s(''P3528_OPC_DOTA'',''3'');javascript:$s(''P3528_DOT_MES_DEP'',''#DESCRIPCION#'');'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11064173168587160836)
,p_db_column_name=>'ORDEN'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Orden'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11031244484475504336)
,p_db_column_name=>'DESCRIPCION'
,p_display_order=>80
,p_column_identifier=>'J'
,p_column_label=>'Descripcion'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11031244383208504335)
,p_db_column_name=>'UM'
,p_display_order=>90
,p_column_identifier=>'K'
,p_column_label=>'Um'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11063630762469497376)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1448557'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DESCRIPCION:UM:PB:MES1:MES2:MES3:'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(7853157365522759931)
,p_report_id=>wwv_flow_api.id(11063630762469497376)
,p_name=>unistr('DOTACI\00D3N TEMPORAL')
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'DOTACION TEMPORAL'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''DOTACION TEMPORAL''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(7853157746265759932)
,p_report_id=>wwv_flow_api.id(11063630762469497376)
,p_name=>'ORDEN'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'DOTACION TOTAL'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''DOTACION TOTAL''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(7853158145564759932)
,p_report_id=>wwv_flow_api.id(11063630762469497376)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'INDICADOR'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11094948869901347885)
,p_plug_name=>'grafico1-dotacion'
,p_parent_plug_id=>wwv_flow_api.id(11095060579332305844)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>5
,p_plug_display_column=>2
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  C001 DEPARTAMENTO,',
'        TO_NUMBER(c009) VALOR_MES3',
'        FROM APEX_collections',
'       WHERE collection_name = ''DOT_CANTIDAD''',
'   AND C006 <> ''A''',
'',
''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
begin
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11034896376243764495)
,p_region_id=>wwv_flow_api.id(11094948869901347885)
,p_chart_type=>'pie'
,p_title=>unistr('PARTICIPACI\00D3N POR \00C1REA')
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_value_format_scaling=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'bottom'
,p_legend_font_family=>'Arial Black'
,p_legend_font_style=>'normal'
,p_legend_font_size=>'12'
,p_overview_rendered=>'off'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11034896461378764496)
,p_chart_id=>wwv_flow_api.id(11034896376243764495)
,p_seq=>10
,p_name=>'Nuevo'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'VALOR_MES3'
,p_items_label_column_name=>'DEPARTAMENTO'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'ALL'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11095060707721305845)
,p_plug_name=>'TABLA1-DOTACION'
,p_parent_plug_id=>wwv_flow_api.id(11095060579332305844)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ''A'' ORDEN, ''INDICADOR'' DESCRIPCION, ''Q'' UM, ''PB'' ANHO, C002 MES1, C005 MES2, C008 MES3',
'        FROM APEX_collections',
'       WHERE collection_name = ''TAB_DOTACION'' ',
'       GROUP BY C002, C005, C008',
'UNION ALL',
'SELECT ''B'' ORDEN, ''DOTACION'', ''Q'' UM, TOTAL_ANHO, TOTAL_MES1,TOTAL_MES2,TOTAL_MES3',
'',
'FROM',
'       (SELECT C010 TOTAL_MES3',
'        FROM APEX_collections',
'       WHERE collection_name = ''TAB_DOTACION'' ',
'       GROUP BY C004, C007, C010)A,',
'       (SELECT to_char(sum(C002)) TOTAL_ANHO, to_char(sum(C003))TOTAL_MES1,to_char(sum(C004))TOTAL_MES2',
'        FROM APEX_collections',
'       WHERE collection_name = ''TAB_DOTACION1'')B',
'UNION ALL',
'SELECT ORDEN, A.DEPARTAMENTO, ''Q'' UM, B.VALOR_ANHO, B.VALOR_MES1,B.VALOR_MES2,A.VALOR_MES3',
'',
'',
'FROM (SELECT CASE',
'        WHEN C001 = ''ADM'' THEN',
'        ''C''',
'        WHEN C001  = ''INDUSTRIAL'' THEN',
'        ''D''',
'        WHEN C001  = ''CDA'' THEN',
'        ''E''',
'        ELSE',
'        ''F'' END ORDEN,',
'        C001 DEPARTAMENTO,',
'        C009 VALOR_MES3',
'        FROM APEX_collections',
'       WHERE collection_name = ''TAB_DOTACION'')A,',
'(SELECT ',
'        C001 DEPARTAMENTO,',
'        C002 VALOR_ANHO,',
'        C003 VALOR_MES1,',
'        C004 VALOR_MES2',
'        FROM APEX_collections',
'       WHERE collection_name = ''TAB_DOTACION1'')B',
'WHERE A.DEPARTAMENTO = B.DEPARTAMENTO'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11095060831100305846)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_show_search_bar=>'N'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>53856193081054706
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095064935573305887)
,p_db_column_name=>'ORDEN'
,p_display_order=>10
,p_column_identifier=>'AG'
,p_column_label=>'Orden'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095119752707088146)
,p_db_column_name=>'MES1'
,p_display_order=>30
,p_column_identifier=>'AP'
,p_column_label=>'MES'
,p_column_link=>'javascript:openModal(''DOTACION''); javascript:$s(''P3528_OPC_DOTA'',''1'');javascript:$s(''P3528_DOT_MES_DEP'',''\#DESCRIPCION#\'');'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095119983613088148)
,p_db_column_name=>'MES2'
,p_display_order=>50
,p_column_identifier=>'AR'
,p_column_label=>'MES'
,p_column_link=>'javascript:openModal(''DOTACION''); javascript:$s(''P3528_OPC_DOTA'',''2'');javascript:$s(''P3528_DOT_MES_DEP'',''\#DESCRIPCION#\'');'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095120186666088150)
,p_db_column_name=>'MES3'
,p_display_order=>70
,p_column_identifier=>'AT'
,p_column_label=>'MES'
,p_column_link=>'javascript:openModal(''DOTACION''); javascript:$s(''P3528_OPC_DOTA'',''3'');javascript:$s(''P3528_DOT_MES_DEP'',''\#DESCRIPCION#\'');'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095120577829088154)
,p_db_column_name=>'DESCRIPCION'
,p_display_order=>80
,p_column_identifier=>'AX'
,p_column_label=>'DESCRIPCION'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095120659839088155)
,p_db_column_name=>'ANHO'
,p_display_order=>90
,p_column_identifier=>'AY'
,p_column_label=>'PB'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095333524974452590)
,p_db_column_name=>'UM'
,p_display_order=>110
,p_column_identifier=>'BA'
,p_column_label=>'UM'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11095072252626426453)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'538677'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DESCRIPCION:UM:ANHO:MES1:MES2:MES3'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'DEPARTAMENTO'
,p_sort_direction_2=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11095409416076521901)
,p_report_id=>wwv_flow_api.id(11095072252626426453)
,p_name=>'PB'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'ORDEN'
,p_operator=>'='
,p_expr=>'A'
,p_condition_sql=>' (case when ("ORDEN" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''A''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B7F0BD'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11095409764504521904)
,p_report_id=>wwv_flow_api.id(11095072252626426453)
,p_name=>'DOTACION'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'ORDEN'
,p_operator=>'='
,p_expr=>'B'
,p_condition_sql=>' (case when ("ORDEN" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''B''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11095120882452088157)
,p_plug_name=>'grafico2_col_suc'
,p_parent_plug_id=>wwv_flow_api.id(11095060579332305844)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>5
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  C001 DEPARTAMENTO,',
'        C003 ACTUAL,',
'        TO_NUMBER(C004) VALOR_1,',
'        C006 ANTERIOR,',
'        TO_NUMBER(C007) VALOR_2,',
'		 case when C001= ''15 - CONCEPCION'' then',
'                  13',
'             when C001= ''19 - SANTA ROSA'' then',
'                  22',
'             when C001= ''29 - P.J.C'' then',
'                  8',
'             when C001= ''17 - LOMA PLATA'' then  ',
'                  17',
'             when C001= ''32 - ENCARNACION'' then  ',
'               16',
'            when C001= ''35 - CAACUPE'' then',
'             20',
'        end valor_3,',
'        ''PLANTEL IDEAL'' IDEAL',
'        FROM APEX_collections',
'       WHERE collection_name = ''DOT_SEMANA'''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11095122285719088171)
,p_region_id=>wwv_flow_api.id(11095120882452088157)
,p_chart_type=>'bar'
,p_title=>'COLABORADORES EN SUCURSALES (POR SEMANA)'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_legend_font_family=>'Arial Black'
,p_legend_font_size=>'12'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11030477842410338276)
,p_chart_id=>wwv_flow_api.id(11095122285719088171)
,p_seq=>10
,p_name=>'PLANTEL IDEAL'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'VALOR_3'
,p_items_label_column_name=>'DEPARTAMENTO'
,p_color=>'#FFCC00'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'14'
,p_items_label_font_color=>'#000000'
,p_threshold_display=>'onIndicator'
,p_link_target=>'javascript:openModal(''DOTA_SUC''); javascript:$s(''P3528_OPC_DOTACION'',''A'');javascript:$s(''P3528_DEPARTAMENTO_DOT'',''#DEPARTAMENTO#'');'
,p_link_target_type=>'REDIRECT_PAGE'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11095122351457088172)
,p_chart_id=>wwv_flow_api.id(11095122285719088171)
,p_seq=>20
,p_name=>'ANTERIOR'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'VALOR_2'
,p_items_label_column_name=>'DEPARTAMENTO'
,p_color=>'#0A88F7'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'14'
,p_items_label_font_color=>'#000000'
,p_threshold_display=>'onIndicator'
,p_link_target=>'javascript:openModal(''DOTA_SUC''); javascript:$s(''P3528_OPC_DOTACION'',''S'');javascript:$s(''P3528_DEPARTAMENTO_DOT'',''#DEPARTAMENTO#'');'
,p_link_target_type=>'REDIRECT_PAGE'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11095122733714088175)
,p_chart_id=>wwv_flow_api.id(11095122285719088171)
,p_seq=>30
,p_name=>'ACTUAL'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'VALOR_1'
,p_items_label_column_name=>'DEPARTAMENTO'
,p_color=>'#47BD20'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'14'
,p_items_label_font_color=>'#000000'
,p_threshold_display=>'onIndicator'
,p_link_target=>'javascript:openModal(''DOTA_SUC''); javascript:$s(''P3528_OPC_DOTACION'',''A'');javascript:$s(''P3528_DEPARTAMENTO_DOT'',''#DEPARTAMENTO#'');'
,p_link_target_type=>'REDIRECT_PAGE'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11095122591744088174)
,p_chart_id=>wwv_flow_api.id(11095122285719088171)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'12'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11095122536384088173)
,p_chart_id=>wwv_flow_api.id(11095122285719088171)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'8'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11095120976268088158)
,p_plug_name=>'tabla2_col_suc'
,p_parent_plug_id=>wwv_flow_api.id(11095060579332305844)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>60
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'SELECT  C001 DEPARTAMENTO,',
'        C006 IDENTIFICADOR,',
'        TO_NUMBER(C007) VALOR',
'        FROM APEX_collections',
'       WHERE collection_name = ''TAB_DOTACION3''',
'union all',
' SELECT  C001 DEPARTAMENTO,',
'        C003 IDENTIFICADOR,',
'        TO_NUMBER(C004) VALOR',
'        FROM APEX_collections',
'       WHERE collection_name = ''TAB_DOTACION3''',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11095121461476088163)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_show_search_bar=>'N'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>53916823456837023
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095121631856088164)
,p_db_column_name=>'DEPARTAMENTO'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Departamento'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095123054874088179)
,p_db_column_name=>'VALOR'
,p_display_order=>30
,p_column_identifier=>'J'
,p_column_label=>'Valor'
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
,p_format_mask=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095123144881088180)
,p_db_column_name=>'IDENTIFICADOR'
,p_display_order=>40
,p_column_identifier=>'K'
,p_column_label=>unistr('Situaci\00F3n')
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11095164765946071662)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'539602'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DEPARTAMENTO:SEMANA1_1:SEMANA2_2:VALOR:IDENTIFICADOR'
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(11095187708102294794)
,p_report_id=>wwv_flow_api.id(11095164765946071662)
,p_pivot_columns=>'DEPARTAMENTO'
,p_row_columns=>'IDENTIFICADOR'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(11095188094362294795)
,p_pivot_id=>wwv_flow_api.id(11095187708102294794)
,p_display_seq=>1
,p_function_name=>'SUM'
,p_column_name=>'VALOR'
,p_db_column_name=>'PFC1'
,p_column_label=>'Cant.'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11095123295489088181)
,p_plug_name=>'ESTRUCTURA'
,p_parent_plug_id=>wwv_flow_api.id(11095207373900361172)
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11017389204963157962)
,p_plug_name=>unistr('FACTOR PRODUCCI\00D3N VENTA')
,p_parent_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>140
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  C001 DETALLE, c002 MES1, C003 MES2, c004 MES3, c005 PROYECCION,c006 PORCENTAJE, C008 PROYEC_PASADO,C009 VENTAS_PASADO,C010 TOTAL_VENTAS,',
'CASE WHEN C007 = ''C'' THEN ',
'      ''data-style=background-color:#B72E3E;color:#FFFFFF;''',
'     WHEN C007 = ''B''  THEN ',
'     ''data-style=background-color:YELLOW'' ',
'    WHEN C007 = ''A''  THEN ',
'     ''data-style=background-color:#1F7842;color:#FFFFFF;''',
' END css_style,',
' CASE WHEN C011 = ''B'' THEN ',
'      ''data-style=background-color:#B72E3E;color:#FFFFFF;''',
'      WHEN C011 = ''A''  THEN ',
'     ''data-style=background-color:#1F7842;color:#FFFFFF;''',
' END css_style2,',
' CASE WHEN C012 = ''B'' THEN ',
'      ''data-style=background-color:#B72E3E;color:#FFFFFF;''',
'     WHEN C012 = ''A''  THEN ',
'     ''data-style=background-color:#1F7842;color:#FFFFFF;''',
' END css_style3,',
' case when c001 = ''SUCURSAL'' THEN',
'        1',
'      when c001 = ''CENTRAL'' THEN',
'       2',
'     when c001 = ''CDA'' THEN',
'       3',
'     when c001 = ''CONCEPCION'' THEN',
'     4',
'     when c001 = ''LOMA PLATA'' THEN',
'     5',
'     when c001 = ''STA ROSA'' THEN',
'     6',
'     when c001 = ''PEDRO JUAN CABALLERO'' THEN',
'     7',
'      when c001 = ''ENCARNACION'' THEN',
'      8',
'     END ORDEN',
'       ',
'FROM APEX_collections',
'WHERE collection_name = ''DET_SUCURSAL'''))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11017389097544157961)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>191097290817432123
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11017386405779157934)
,p_db_column_name=>'DETALLE'
,p_display_order=>10
,p_column_identifier=>'AA'
,p_column_label=>'Detalle'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11016838020432754883)
,p_db_column_name=>'MES1'
,p_display_order=>20
,p_column_identifier=>'AB'
,p_column_label=>'Mes1'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11016837983911754882)
,p_db_column_name=>'MES2'
,p_display_order=>30
,p_column_identifier=>'AC'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11016837840220754881)
,p_db_column_name=>'MES3'
,p_display_order=>40
,p_column_identifier=>'AD'
,p_column_label=>'Mes3'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11016837718032754880)
,p_db_column_name=>'PROYECCION'
,p_display_order=>50
,p_column_identifier=>'AE'
,p_column_label=>'Proyeccion'
,p_column_html_expression=>'<span #CSS_STYLE#>#PROYECCION#</span>'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11016837612129754879)
,p_db_column_name=>'PORCENTAJE'
,p_display_order=>60
,p_column_identifier=>'AF'
,p_column_label=>'VMA'
,p_column_html_expression=>'<span #CSS_STYLE2#>#PORCENTAJE#</span>'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11016837451722754877)
,p_db_column_name=>'PROYEC_PASADO'
,p_display_order=>80
,p_column_identifier=>'AH'
,p_column_label=>'VIA'
,p_column_html_expression=>'<span #CSS_STYLE3#>#PROYEC_PASADO#</span>'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11016837386053754876)
,p_db_column_name=>'CSS_STYLE'
,p_display_order=>90
,p_column_identifier=>'AI'
,p_column_label=>'Css Style'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11016850231308137405)
,p_db_column_name=>'VENTAS_PASADO'
,p_display_order=>100
,p_column_identifier=>'AJ'
,p_column_label=>'Ventas Pasado'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11016851984112137422)
,p_db_column_name=>'TOTAL_VENTAS'
,p_display_order=>110
,p_column_identifier=>'AK'
,p_column_label=>'Total Ventas'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11024574305751348789)
,p_db_column_name=>'CSS_STYLE2'
,p_display_order=>120
,p_column_identifier=>'AL'
,p_column_label=>'Css Style2'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11024574479142348790)
,p_db_column_name=>'CSS_STYLE3'
,p_display_order=>130
,p_column_identifier=>'AM'
,p_column_label=>'Css Style3'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11034897131701764503)
,p_db_column_name=>'ORDEN'
,p_display_order=>140
,p_column_identifier=>'AN'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11017052560965263948)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1914339'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DETALLE:MES1:MES2:MES3:PROYECCION:PROYEC_PASADO:PORCENTAJE:VENTAS_PASADO:'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11035522125065858196)
,p_report_id=>wwv_flow_api.id(11017052560965263948)
,p_name=>'DETALLE'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'SUCURSAL'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''SUCURSAL''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11028958544517837143)
,p_plug_name=>'factor_prod_vent_kg'
,p_parent_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>130
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT SUC_DESC,   CANTIDAD_KG, A.DOTACION, ROUND(VENTA_GS/DOTACION) FAC_INGRESO,   A.MES_1',
'FROM (  SELECT  C001 DEPARTAMENTO, ',
'              to_number(C002) DOTACION, ',
'              C003 MES,',
'              C004 MES_1',
'        FROM APEX_collections',
'        WHERE collection_name = ''DOTACION_EST12'') A,',
'     (SELECT SUM(C005)    CANTIDAD_KG,',
'             SUM(C006)    VENTA_GS,',
'             C007 SUC_DESC,',
'             C010  MES',
'        FROM APEX_collections',
'        WHERE collection_name = ''DETALLE_VENTA12''',
'         GROUP BY C007, C010)B',
'     WHERE B.SUC_DESC = A.DEPARTAMENTO',
'       AND A.MES =B.MES',
'UNION  ALL',
'SELECT ''TOTAL DOTACION'' DESCRIPCION,   CANTIDAD_KG, A.DOTACION, ROUND(VENTA_GS/DOTACION) FAC_INGRESO,   A.MES_1',
'FROM (  SELECT to_number(SUM(C002)) DOTACION, ',
'               C003 MES,',
'               C004 MES_1',
'        FROM APEX_collections',
'        WHERE collection_name = ''DOTACION_EST12''',
'         GROUP BY C003, C004) A,',
'     (SELECT SUM(C005)    CANTIDAD_KG,',
'             SUM(C006)    VENTA_GS,',
'             C010  MES',
'        FROM APEX_collections',
'        WHERE collection_name = ''DETALLE_VENTA12''',
'         GROUP BY C010)B',
'     WHERE A.MES =B.MES  '))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11028958302275837141)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>179528086085752943
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11028957991813837138)
,p_db_column_name=>'SUC_DESC'
,p_display_order=>30
,p_column_identifier=>'B'
,p_column_label=>'Departamento'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11028957922313837137)
,p_db_column_name=>'DOTACION'
,p_display_order=>40
,p_column_identifier=>'C'
,p_column_label=>'Dotacion'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11028957866896837136)
,p_db_column_name=>'FAC_INGRESO'
,p_display_order=>50
,p_column_identifier=>'D'
,p_column_label=>'Fact. Ingreso'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11028957714803837135)
,p_db_column_name=>'CANTIDAD_KG'
,p_display_order=>60
,p_column_identifier=>'E'
,p_column_label=>'Cantidad Kg'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11028621038711194065)
,p_db_column_name=>'MES_1'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>'Mes'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11026859495972080335)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'VENTA KG'
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'1816269'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_view_mode=>'REPORT'
,p_report_columns=>'SUC_DESC:DOTACION:FAC_INGRESO:CANTIDAD_KG:MES_1:'
,p_sort_column_1=>'SUC_DESC'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
,p_break_on=>'MES_1:0:0:0:0:0'
,p_break_enabled_on=>'MES_1:0:0:0:0:0'
);
end;
/
begin
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11026859123596080332)
,p_report_id=>wwv_flow_api.id(11026859495972080335)
,p_name=>'TOTAL_DOTACION '
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'SUC_DESC'
,p_operator=>'='
,p_expr=>'TOTAL DOTACION'
,p_condition_sql=>' (case when ("SUC_DESC" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''TOTAL DOTACION''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(11026858773212080332)
,p_report_id=>wwv_flow_api.id(11026859495972080335)
,p_pivot_columns=>'MES_1'
,p_row_columns=>'SUC_DESC'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(11026858346128080331)
,p_pivot_id=>wwv_flow_api.id(11026858773212080332)
,p_display_seq=>1
,p_function_name=>'SUM'
,p_column_name=>'CANTIDAD_KG'
,p_db_column_name=>'PFC1'
,p_column_label=>'VENTA KG'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_pivot_sort(
 p_id=>wwv_flow_api.id(11026857903562080330)
,p_pivot_id=>wwv_flow_api.id(11026858773212080332)
,p_sort_seq=>1
,p_sort_column_name=>'SUC_DESC'
,p_sort_direction=>'ASC'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11027714402725495469)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'VENTAS KG'
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'1807720'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'SUC_DESC:DOTACION:FAC_INGRESO:CANTIDAD_KG'
,p_sort_column_1=>'SUC_DESC'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
,p_break_on=>'MES:0:0:0:0:0'
,p_break_enabled_on=>'MES:0:0:0:0:0'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11027714002932495469)
,p_report_id=>wwv_flow_api.id(11027714402725495469)
,p_name=>'TOTAL_DOTACION '
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'SUC_DESC'
,p_operator=>'='
,p_expr=>'TOTAL DOTACION'
,p_condition_sql=>' (case when ("SUC_DESC" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''TOTAL DOTACION''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(11027713676896495468)
,p_report_id=>wwv_flow_api.id(11027714402725495469)
,p_pivot_columns=>'MES'
,p_row_columns=>'SUC_DESC'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(11027713209556495468)
,p_pivot_id=>wwv_flow_api.id(11027713676896495468)
,p_display_seq=>1
,p_function_name=>'SUM'
,p_column_name=>'CANTIDAD_KG'
,p_db_column_name=>'PFC1'
,p_column_label=>'VENTA KG'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11028626123683205675)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'1798603'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_view_mode=>'REPORT'
,p_report_columns=>'SUC_DESC:DOTACION:FAC_INGRESO:CANTIDAD_KG:MES_1:'
,p_sort_column_1=>'SUC_DESC'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
,p_break_on=>'MES_1:0:0:0:0:0'
,p_break_enabled_on=>'MES_1:0:0:0:0:0'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11026861776268083836)
,p_report_id=>wwv_flow_api.id(11028626123683205675)
,p_name=>'TOTAL_DOTACION '
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'SUC_DESC'
,p_operator=>'='
,p_expr=>'TOTAL DOTACION'
,p_condition_sql=>' (case when ("SUC_DESC" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''TOTAL DOTACION''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(11026861351369083836)
,p_report_id=>wwv_flow_api.id(11028626123683205675)
,p_pivot_columns=>'MES'
,p_row_columns=>'SUC_DESC'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(11026860984660083834)
,p_pivot_id=>wwv_flow_api.id(11026861351369083836)
,p_display_seq=>1
,p_function_name=>'SUM'
,p_column_name=>'CANTIDAD_KG'
,p_db_column_name=>'PFC1'
,p_column_label=>'VENTA KG'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_pivot_sort(
 p_id=>wwv_flow_api.id(11026860490007083833)
,p_pivot_id=>wwv_flow_api.id(11026861351369083836)
,p_sort_seq=>1
,p_sort_column_name=>'SUC_DESC'
,p_sort_direction=>'ASC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11028962292053837181)
,p_plug_name=>'factor_prod_venta_gs'
,p_parent_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>110
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT SUC_DESC,   VENTA_GS, A.DOTACION, ROUND(VENTA_GS/DOTACION) FAC_INGRESO,   A.MES_1, DECODE(SUC_DESC,''CDA'',1,''CENTRAL'',2, ''CONCEPCION'',3, ''ENCARNACION'',4, ''LOMA PLATA'',5,''PEDRO JUAN CABALLERO'',6, ''STA ROSA'',7) ORDEN',
'FROM (  SELECT  C001 DEPARTAMENTO, ',
'              to_number(C002) DOTACION, ',
'              C003 MES,',
'              C004 MES_1',
'        FROM APEX_collections',
'        WHERE collection_name = ''DOTACION_EST12'') A,',
'     (SELECT SUM(C005)    CANTIDAD_KG,',
'             SUM(C006)    VENTA_GS,',
'             C007 SUC_DESC,',
'             C010  MES',
'        FROM APEX_collections',
'        WHERE collection_name = ''DETALLE_VENTA12''',
'         GROUP BY C007, C010)B',
'     WHERE B.SUC_DESC = A.DEPARTAMENTO',
'       AND A.MES =B.MES',
'UNION  ALL',
'SELECT ''TOTAL DOTACION'' DESCRIPCION,   VENTA_GS, A.DOTACION, ROUND(VENTA_GS/DOTACION) FAC_INGRESO,   A.MES_1, 8 ORDEN',
'FROM (  SELECT to_number(SUM(C002)) DOTACION, ',
'               C003 MES,',
'               C004 MES_1',
'        FROM APEX_collections',
'        WHERE collection_name = ''DOTACION_EST12''',
'         GROUP BY C003, C004) A,',
'     (SELECT SUM(C005)    CANTIDAD_KG,',
'             SUM(C006)    VENTA_GS,',
'             C010  MES',
'        FROM APEX_collections',
'        WHERE collection_name = ''DETALLE_VENTA12''',
'         GROUP BY C010)B',
'     WHERE A.MES =B.MES'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11028961860572837176)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>179524527788752908
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11028959789763837156)
,p_db_column_name=>'VENTA_GS'
,p_display_order=>30
,p_column_identifier=>'S'
,p_column_label=>'Venta Gs'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11028959660380837154)
,p_db_column_name=>'SUC_DESC'
,p_display_order=>50
,p_column_identifier=>'U'
,p_column_label=>'Departamento'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11028959496203837153)
,p_db_column_name=>'DOTACION'
,p_display_order=>60
,p_column_identifier=>'V'
,p_column_label=>'Dotacion'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11028959444838837152)
,p_db_column_name=>'FAC_INGRESO'
,p_display_order=>70
,p_column_identifier=>'W'
,p_column_label=>'Fact. Ingreso'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11028622514103194080)
,p_db_column_name=>'MES_1'
,p_display_order=>80
,p_column_identifier=>'X'
,p_column_label=>'Mes'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11028621143870194066)
,p_db_column_name=>'ORDEN'
,p_display_order=>90
,p_column_identifier=>'Y'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11027027627574888870)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'VENTAS GS'
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'1814588'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_view_mode=>'REPORT'
,p_report_columns=>'SUC_DESC:VENTA_GS:DOTACION:FAC_INGRESO::MES_1:ORDEN'
,p_sort_column_1=>'SUC_DESC'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
,p_break_on=>'MES_1:0:0:0:0:0'
,p_break_enabled_on=>'MES_1:0:0:0:0:0'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11026871645284251905)
,p_report_id=>wwv_flow_api.id(11027027627574888870)
,p_name=>'TOTAL_DOTAICON'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'SUC_DESC'
,p_operator=>'='
,p_expr=>'TOTAL DOTACION'
,p_condition_sql=>' (case when ("SUC_DESC" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''TOTAL DOTACION''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(11026871273390251904)
,p_report_id=>wwv_flow_api.id(11027027627574888870)
,p_pivot_columns=>'MES_1'
,p_row_columns=>'SUC_DESC'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(11026870828361251903)
,p_pivot_id=>wwv_flow_api.id(11026871273390251904)
,p_display_seq=>1
,p_function_name=>'SUM'
,p_column_name=>'VENTA_GS'
,p_db_column_name=>'PFC1'
,p_column_label=>'VENTAS GS'
,p_format_mask=>'999G999G999G999G999'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_pivot_sort(
 p_id=>wwv_flow_api.id(11026870458524251901)
,p_pivot_id=>wwv_flow_api.id(11026871273390251904)
,p_sort_seq=>1
,p_sort_column_name=>'SUC_DESC'
,p_sort_direction=>'ASC'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11027717020633505949)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'VENTAS MES'
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'1807694'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'SUC_DESC:VENTA_GS:DOTACION:FAC_INGRESO'
,p_sort_column_1=>'SUC_DESC'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
,p_break_on=>'MES:0:0:0:0:0'
,p_break_enabled_on=>'MES:0:0:0:0:0'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11027716680820505946)
,p_report_id=>wwv_flow_api.id(11027717020633505949)
,p_name=>'TOTAL_DOTAICON'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'SUC_DESC'
,p_operator=>'='
,p_expr=>'TOTAL DOTACION'
,p_condition_sql=>' (case when ("SUC_DESC" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''TOTAL DOTACION''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(11027716201011505945)
,p_report_id=>wwv_flow_api.id(11027717020633505949)
,p_pivot_columns=>'MES'
,p_row_columns=>'SUC_DESC'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(11027715869320505945)
,p_pivot_id=>wwv_flow_api.id(11027716201011505945)
,p_display_seq=>1
,p_function_name=>'SUM'
,p_column_name=>'VENTA_GS'
,p_db_column_name=>'PFC1'
,p_column_label=>'ventas mes'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11028799959226811686)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'1796865'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_view_mode=>'REPORT'
,p_report_columns=>'SUC_DESC:VENTA_GS:DOTACION:FAC_INGRESO::MES_1:ORDEN'
,p_sort_column_1=>'SUC_DESC'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
,p_break_on=>'MES_1:0:0:0:0:0'
,p_break_enabled_on=>'MES_1:0:0:0:0:0'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11026875586240288575)
,p_report_id=>wwv_flow_api.id(11028799959226811686)
,p_name=>'TOTAL_DOTAICON'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'SUC_DESC'
,p_operator=>'='
,p_expr=>'TOTAL DOTACION'
,p_condition_sql=>' (case when ("SUC_DESC" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''TOTAL DOTACION''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(11026875156737288570)
,p_report_id=>wwv_flow_api.id(11028799959226811686)
,p_pivot_columns=>'MES_1'
,p_row_columns=>'SUC_DESC'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(11026874718378288569)
,p_pivot_id=>wwv_flow_api.id(11026875156737288570)
,p_display_seq=>1
,p_function_name=>'SUM'
,p_column_name=>'VENTA_GS'
,p_db_column_name=>'PFC1'
,p_column_label=>'VENTAS GS'
,p_format_mask=>'999G999G999G999G999'
,p_display_sum=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11073510799776177577)
,p_plug_name=>'TABLERO_INDUSTRIAL'
,p_parent_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>80
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>5
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 ORDEN,''INDICADOR'' DETALLE, ''UM'' UM, ''PB'' PB, C009 MES1, C010 MES2, C011 MES3',
'FROM APEX_collections',
'WHERE collection_name = ''TABLERO_INDUSTRIAL'' ',
'UNION ALL',
'SELECT 2 ORDEN, ''FACTOR PRODU. KG PROD. DOT. TOTAL'', ''KG/P'', C001, C002, C003, C004',
'FROM APEX_collections',
'WHERE collection_name = ''TABLERO_INDUSTRIAL'' ',
'UNION ALL',
'SELECT 10 ORDEN,''FACTOR PRODU. KG PROD. DOT. IND'',  ''KG/P'', C005, C006, C007, C008',
'FROM APEX_collections',
'WHERE collection_name = ''TABLERO_INDUSTRIAL'' ',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11073510694592177576)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>134975693769412508
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11073510600332177575)
,p_db_column_name=>'ORDEN'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11073509473043177563)
,p_db_column_name=>'UM'
,p_display_order=>20
,p_column_identifier=>'M'
,p_column_label=>'UM'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11073509304742177562)
,p_db_column_name=>'PB'
,p_display_order=>30
,p_column_identifier=>'N'
,p_column_label=>'PB'
,p_column_link=>'f?p=&APP_ID.:2251:&SESSION.::&DEBUG.:RP:P2251_FECHA,P2251_MES,P2251_OPCION:&P3528_FECHA_HASTA.,10,#ORDEN#'
,p_column_linktext=>'#PB#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11073509242893177561)
,p_db_column_name=>'MES1'
,p_display_order=>40
,p_column_identifier=>'O'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2251:&SESSION.::&DEBUG.:RP:P2251_FECHA,P2251_MES,P2251_OPCION:&P3528_FECHA_HASTA.,1,#ORDEN#'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11073509116848177560)
,p_db_column_name=>'MES2'
,p_display_order=>50
,p_column_identifier=>'P'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2251:&SESSION.::&DEBUG.:RP:P2251_FECHA,P2251_MES,P2251_OPCION:&P3528_FECHA_HASTA.,2,#ORDEN#'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11073509068808177559)
,p_db_column_name=>'MES3'
,p_display_order=>60
,p_column_identifier=>'Q'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2251:&SESSION.::&DEBUG.:RP:P2251_FECHA,P2251_MES,P2251_OPCION:&P3528_FECHA_HASTA.,3,#ORDEN#'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11073508925550177558)
,p_db_column_name=>'DETALLE'
,p_display_order=>70
,p_column_identifier=>'R'
,p_column_label=>'DETALLE'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11073115711469853875)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1353707'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DETALLE:UM:PB:MES1:MES2:MES3:'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016766955379661413)
,p_report_id=>wwv_flow_api.id(11073115711469853875)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'INDICADOR'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11078978616223231942)
,p_plug_name=>'FACTOR_PRODUCCION2'
,p_parent_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>100
,p_plug_display_column=>8
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'M.MES, M.DOTACION, M.FACT_PROD, M.PRODUCCION, M.ORDEN, ',
'     CASE WHEN N.CANT_PRO = M.CANT_PRO  and m.orden = 0 THEN',
'     0',
'     WHEN N.CANT_PRO = M.CANT_PRO and m.orden <> 0 THEN',
'      1',
'   WHEN N.CANT_PRO > M.CANT_PRO and m.orden <> 0 THEN',
'   2',
'   WHEN N.CANT_PRO < M.CANT_PRO and m.orden <> 0 THEN',
'   3',
'END OPCION ,',
'CASE WHEN N.CANT_PRO > M.CANT_PRO and m.orden <> 0 THEN ',
'      ''data-style=background-color:#B72E3E;color:#FFFFFF;''',
'     WHEN N.CANT_PRO = M.CANT_PRO and m.orden <> 0 THEN ',
'     ''data-style=background-color:#F8CD71;color:#000000;''',
'    WHEN N.CANT_PRO < M.CANT_PRO and m.orden <> 0 THEN ',
'     ''data-style=background-color:#1F7842;color:#FFFFFF;''',
' END css_style',
'FROM',
'',
'(SELECT A.MES, DOT_MES DOTACION, TO_CHAR(ROUND(B.CANTIDAD/DOT_MES), ''999G999G999G999'') FACT_PROD, TO_CHAR(ROUND(B.CANTIDAD), ''999G999G999G999'')  PRODUCCION , A.ORDEN, B.CANTIDAD CANT_PRO',
'',
'FROM',
'(SELECT TO_NUMBER(C001) DOT_MES, TO_NUMBER(C002) ORDEN, C003 MES',
'FROM APEX_COLLECTIONS ',
'WHERE COLLECTION_NAME = ''DOTACION_INDUSTRIAL''',
'GROUP BY C001, C003, C002) A,',
'(SELECT TO_NUMBER(C001) CANTIDAD, TO_NUMBER(C003) ORDEN, C002 MES',
'FROM APEX_COLLECTIONS ',
'WHERE COLLECTION_NAME = ''FACTOR_PRODUCCION'') B',
'WHERE A.MES = B.MES) M,',
'',
'(SELECT A.MES, DOT_MES DOTACION, TO_CHAR(ROUND(B.CANTIDAD/DOT_MES), ''999G999G999G999'') FACT_PROD, B.CANTIDAD CANT_PRO , A.ORDEN',
'',
'FROM',
'(SELECT TO_NUMBER(C001) DOT_MES, TO_NUMBER(C002) ORDEN, C003 MES',
'FROM APEX_COLLECTIONS ',
'WHERE COLLECTION_NAME = ''DOTACION_INDUSTRIAL''',
' AND C002 = ''1''',
'GROUP BY C001, C003, C002) A,',
'(SELECT TO_NUMBER(C001) CANTIDAD, TO_NUMBER(C003) ORDEN, C002 MES',
'FROM APEX_COLLECTIONS ',
'WHERE COLLECTION_NAME = ''FACTOR_PRODUCCION'') B',
'WHERE A.MES = B.MES) N'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_MES3_DOT,P3528_EST_DIAS_HAB,P3528_EST_DIAS_TRA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11078978585132231941)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>129507803229358143
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11073507913289177548)
,p_db_column_name=>'MES'
,p_display_order=>30
,p_column_identifier=>'AH'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2251:&SESSION.::&DEBUG.:RP:P2251_MES2,P2251_OPCION,P2251_FECHA:#MES#,5,&P3528_FECHA_HASTA.'
,p_column_linktext=>'#MES#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11073507827225177547)
,p_db_column_name=>'DOTACION'
,p_display_order=>40
,p_column_identifier=>'AI'
,p_column_label=>unistr('DOTACI\00D3N')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11073507508312177544)
,p_db_column_name=>'FACT_PROD'
,p_display_order=>50
,p_column_identifier=>'AL'
,p_column_label=>'FACT. PROD.'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11073507403747177543)
,p_db_column_name=>'PRODUCCION'
,p_display_order=>60
,p_column_identifier=>'AM'
,p_column_label=>unistr('PRODUCCI\00D3N')
,p_column_html_expression=>'<span #CSS_STYLE#>#PRODUCCION#</span>'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11073507333045177542)
,p_db_column_name=>'ORDEN'
,p_display_order=>70
,p_column_identifier=>'AN'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11037507491027707150)
,p_db_column_name=>'OPCION'
,p_display_order=>80
,p_column_identifier=>'AO'
,p_column_label=>'Opcion'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11037507459042707149)
,p_db_column_name=>'CSS_STYLE'
,p_display_order=>90
,p_column_identifier=>'AP'
,p_column_label=>'Css Style'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11078881891510377982)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1296045'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'MES:DOTACION:FACT_PROD:PRODUCCION:'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11079219602362575359)
,p_plug_name=>'GRAF_ESTRURA_KG'
,p_parent_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_region_template_options=>'#DEFAULT#:margin-top-lg:margin-bottom-lg'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>60
,p_plug_grid_column_span=>5
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT to_number(c001) total, ''b. ''||C014 MES,1 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(c002) total, ''c. ''||C015 MES,2 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(c012) total, ''d. ''||C016 MES,3 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'',
''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11079219540475575358)
,p_region_id=>wwv_flow_api.id(11079219602362575359)
,p_chart_type=>'combo'
,p_title=>'FACTOR DE INGRESO(KG. VENTA/DOTACION)'
,p_height=>'500'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'bottom'
,p_legend_font_family=>'Arial Black'
,p_legend_font_style=>'normal'
,p_legend_font_size=>'12'
,p_legend_font_color=>'#000000'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11079219429530575357)
,p_chart_id=>wwv_flow_api.id(11079219540475575358)
,p_seq=>10
,p_name=>'MES'
,p_location=>'REGION_SOURCE'
,p_series_type=>'bar'
,p_items_value_column_name=>'TOTAL'
,p_items_label_column_name=>'MES'
,p_color=>'#FFCC00'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_items_label_font_color=>'#000000'
,p_threshold_display=>'onIndicator'
,p_link_target=>'f?p=&APP_ID.:2250:&SESSION.::&DEBUG.:RP:P2250_GRAFICO,P2250_FECHA,P2250_MES,P2250_OPCION:S,&P3528_FECHA_HASTA.,&ORDEN.,2'
,p_link_target_type=>'REDIRECT_PAGE'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11024576947449348815)
,p_chart_id=>wwv_flow_api.id(11079219540475575358)
,p_seq=>20
,p_name=>'OBJ_1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT to_number(0) total, ''f. OBJETIVO'' det,6 orden',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
''))
,p_ajax_items_to_submit=>'P3528_OBJ_KG'
,p_series_type=>'bar'
,p_series_name_column_name=>'ORDEN'
,p_items_value_column_name=>'TOTAL'
,p_items_label_column_name=>'DET'
,p_color=>'#FFCC00'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_items_label_font_color=>'#000000'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11079219312152575356)
,p_chart_id=>wwv_flow_api.id(11079219540475575358)
,p_seq=>30
,p_name=>'OBJ'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*SELECT  TO_NUMBER(:P3528_OBJ_KG) CANT,''f. OBJETIVO'' det,5 orden',
'FROM DUAL',
'*/',
'SELECT TO_NUMBER(:P3528_OBJ_KG) total, ''f. OBJETIVO'' det,5 orden',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' '))
,p_ajax_items_to_submit=>'P3528_OBJ_KG'
,p_series_type=>'bar'
,p_series_name_column_name=>'ORDEN'
,p_items_value_column_name=>'TOTAL'
,p_items_label_column_name=>'DET'
,p_color=>'#4CD964'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_items_label_font_color=>'#000000'
,p_threshold_display=>'onIndicator'
);
end;
/
begin
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11079219224600575355)
,p_chart_id=>wwv_flow_api.id(11079219540475575358)
,p_seq=>40
,p_name=>'PB'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT to_number(c007) total, ''a. PB'' MES,1 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' '))
,p_series_type=>'bar'
,p_items_value_column_name=>'TOTAL'
,p_items_label_column_name=>'MES'
,p_color=>'#FF3B30'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_items_label_font_color=>'#000000'
,p_threshold_display=>'onIndicator'
,p_link_target=>'f?p=&APP_ID.:2250:&SESSION.::&DEBUG.:RP:P2250_FECHA,P2250_GRAFICO,P2250_MES,P2250_OPCION:&P3528_FECHA_HASTA.,S,10,2'
,p_link_target_type=>'REDIRECT_PAGE'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11079219162345575354)
,p_chart_id=>wwv_flow_api.id(11079219540475575358)
,p_seq=>50
,p_name=>'Periodo base'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT to_number(c007) total, ''a. PB'' MES,1 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'union all',
'SELECT to_number(c007) total, ''b. ''||C014 MES,1 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(c007) total,''c. ''||C015 MES ,2',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(c007) total,''d. ''||C016 mes ,3',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(c007) total,''e. PROYECCION'' mes ,4',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(c007) total,''f. OBJETIVO''mes ,3',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'',
''))
,p_series_type=>'line'
,p_items_value_column_name=>'TOTAL'
,p_items_label_column_name=>'MES'
,p_color=>'#FF3B30'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11079218989080575353)
,p_chart_id=>wwv_flow_api.id(11079219540475575358)
,p_seq=>60
,p_name=>'Objetivo'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT to_number(:P3528_OBJ_KG) total, ''a. PB'' MES,1 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'union all',
'SELECT to_number(:P3528_OBJ_KG) total, ''b. ''||C014 MES,1 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(:P3528_OBJ_KG) total,''c. ''||C015 MES ,2',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(:P3528_OBJ_KG) total,''d. ''||C016 mes ,3',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(:P3528_OBJ_KG) total,''e. PROYECCION'' mes ,4',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(:P3528_OBJ_KG) total,''f. OBJETIVO''mes ,3',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
''))
,p_ajax_items_to_submit=>'P3528_OBJ_KG'
,p_series_type=>'line'
,p_items_value_column_name=>'TOTAL'
,p_items_label_column_name=>'MES'
,p_color=>'#4CD964'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'on'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11024574605256348792)
,p_chart_id=>wwv_flow_api.id(11079219540475575358)
,p_seq=>70
,p_name=>'Proyeccion'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'SELECT to_number(c003) total, ''e. PROYECCION'' MES,4 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' '))
,p_series_type=>'bar'
,p_items_value_column_name=>'TOTAL'
,p_items_label_column_name=>'MES'
,p_color=>'#34AADC'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11079218907939575352)
,p_chart_id=>wwv_flow_api.id(11079219540475575358)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'12'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11079218791148575351)
,p_chart_id=>wwv_flow_api.id(11079219540475575358)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11079218697647575350)
,p_chart_id=>wwv_flow_api.id(11079219540475575358)
,p_axis=>'y2'
,p_is_rendered=>'off'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_split_dual_y=>'auto'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11079221995554575383)
,p_plug_name=>'GRAF_ESTRURA_GS'
,p_parent_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_region_template_options=>'#DEFAULT#:margin-top-lg:margin-bottom-lg'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>40
,p_plug_grid_column_span=>5
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT to_number(c004) total, ''b. ''||C014 MES,1 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(c005) total,''c. ''||C015 MES ,2',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(c013) total,''d. ''||C016 mes ,3',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'',
'',
''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11079220611523575369)
,p_region_id=>wwv_flow_api.id(11079221995554575383)
,p_chart_type=>'combo'
,p_title=>unistr('FACTOR INGRESO(VENTA/DOTACI\00D3N)')
,p_height=>'500'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>false
,p_show_group_name=>false
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'bottom'
,p_legend_font_family=>'Arial Black'
,p_legend_font_size=>'12'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11079220489473575368)
,p_chart_id=>wwv_flow_api.id(11079220611523575369)
,p_seq=>10
,p_name=>'MES'
,p_location=>'REGION_SOURCE'
,p_series_type=>'bar'
,p_items_value_column_name=>'TOTAL'
,p_items_label_column_name=>'MES'
,p_color=>'#34AADC'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_items_label_font_color=>'#000000'
,p_threshold_display=>'onIndicator'
,p_link_target=>'f?p=&APP_ID.:2250:&SESSION.::&DEBUG.:RP:P2250_MES,P2250_OPCION,P2250_FECHA,P2250_GRAFICO:&ORDEN.,1,&P3528_FECHA_HASTA.,S'
,p_link_target_type=>'REDIRECT_PAGE'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11079220229176575365)
,p_chart_id=>wwv_flow_api.id(11079220611523575369)
,p_seq=>30
,p_name=>'OBJ'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*SELECT  TO_NUMBER(:P3528_OBJ_GS) CANT,''f. OBJETIVO'' det,6 orden',
'FROM DUAL*/',
'',
'SELECT to_number(0) total,''f. OBJETIVO'' detalle , 2orden',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'/*union all',
'SELECT TO_NUMBER(:P3528_OBJ_GS)-to_number(c013) total,''f. OBJETIVO''  detalle ,1 orden',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' */',
''))
,p_ajax_items_to_submit=>'P3528_OBJ_GS'
,p_series_type=>'bar'
,p_series_name_column_name=>'ORDEN'
,p_items_value_column_name=>'TOTAL'
,p_items_label_column_name=>'DETALLE'
,p_color=>'#34AADC'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_items_label_font_color=>'#000000'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11024576617843348812)
,p_chart_id=>wwv_flow_api.id(11079220611523575369)
,p_seq=>40
,p_name=>'OBJ_1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*SELECT  TO_NUMBER(:P3528_OBJ_GS) CANT,''f. OBJETIVO'' det,6 orden',
'FROM DUAL*/',
'',
'/*SELECT to_number(c013) total,''f. OBJETIVO'' detalle , 2orden',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'/*union all*/',
'SELECT TO_NUMBER(:P3528_OBJ_GS) total,''f. OBJETIVO''  detalle ,1 orden',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
''))
,p_ajax_items_to_submit=>'P3528_OBJ_GS'
,p_series_type=>'bar'
,p_series_name_column_name=>'ORDEN'
,p_items_value_column_name=>'TOTAL'
,p_items_label_column_name=>'DETALLE'
,p_color=>'#4CD964'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_items_label_font_color=>'#000000'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11079220128716575364)
,p_chart_id=>wwv_flow_api.id(11079220611523575369)
,p_seq=>70
,p_name=>'PB'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT to_number(c008) total, ''a. PB'' MES,1 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' '))
,p_series_type=>'bar'
,p_items_value_column_name=>'TOTAL'
,p_items_label_column_name=>'MES'
,p_color=>'#FF3B30'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideBarEdge'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_items_label_font_color=>'#000000'
,p_threshold_display=>'onIndicator'
,p_link_target=>'f?p=&APP_ID.:2250:&SESSION.::&DEBUG.:RP:P2250_MES,P2250_OPCION,P2250_FECHA,P2250_GRAFICO:10,1,&P3528_FECHA_HASTA.,S'
,p_link_target_type=>'REDIRECT_PAGE'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11076687320965251469)
,p_chart_id=>wwv_flow_api.id(11079220611523575369)
,p_seq=>80
,p_name=>'Periodo_base'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT to_number(c008) total, ''a. PB'' MES,1 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'union all',
'SELECT to_number(c008) total, ''b. ''||C014 MES,1 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(c008) total,''c. ''||C015 MES ,2',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(c008) total,''d. ''||C016 mes ,3',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(c008) total,''e. PROYECCION'' mes ,3',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE''',
'UNION ALL',
'SELECT to_number(c008) total,''f. OBJETIVO''mes ,3',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'',
''))
,p_series_type=>'line'
,p_items_value_column_name=>'TOTAL'
,p_items_label_column_name=>'MES'
,p_color=>'#FF3B30'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'f?p=&APP_ID.:2250:&SESSION.::&DEBUG.:RP:P2250_MES,P2250_OPCION,P2250_FECHA,P2250_GRAFICO:10,1,&P3528_FECHA_HASTA.,S'
,p_link_target_type=>'REDIRECT_PAGE'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11076686817655251464)
,p_chart_id=>wwv_flow_api.id(11079220611523575369)
,p_seq=>90
,p_name=>'Objetivo'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT to_number(:P3528_OBJ_GS) total, ''a. PB'' MES,1 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'union all',
'SELECT to_number(:P3528_OBJ_GS) total, ''b. ''||C014 MES,1 ORDEN',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(:P3528_OBJ_GS) total,''c. ''||C015 MES ,2',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(:P3528_OBJ_GS) total,''d. ''||C016 mes ,3',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(:P3528_OBJ_GS) total,''e. PROYECCION''mes ,3',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT to_number(:P3528_OBJ_GS) total,''f. OBJETIVO'' mes ,3',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
''))
,p_ajax_items_to_submit=>'P3528_OBJ_GS'
,p_series_type=>'line'
,p_items_value_column_name=>'TOTAL'
,p_items_label_column_name=>'MES'
,p_color=>'#4CD964'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'on'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11024574493475348791)
,p_chart_id=>wwv_flow_api.id(11079220611523575369)
,p_seq=>100
,p_name=>'Proyeccion'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT to_number(c006) total,''e. PROYECCION'' mes ,4',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
''))
,p_series_type=>'bar'
,p_items_value_column_name=>'TOTAL'
,p_items_label_column_name=>'MES'
,p_color=>'#FFCC00'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11079219712414575360)
,p_chart_id=>wwv_flow_api.id(11079220611523575369)
,p_axis=>'y2'
,p_is_rendered=>'off'
,p_format_type=>'percent'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_split_dual_y=>'auto'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11079220460450575367)
,p_chart_id=>wwv_flow_api.id(11079220611523575369)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'12'
,p_tick_label_font_color=>'#000000'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11079220296423575366)
,p_chart_id=>wwv_flow_api.id(11079220611523575369)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11079898658297912939)
,p_plug_name=>'DEPARTAMENTO_KG'
,p_parent_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>50
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  DECODE(C004, ''ASUNCION'', ''CDA'', ''CASA CENTRAL'', ''CENTRAL'', C004) DEPARTAMENTO, TO_CHAR(C002, ''999G999G999G999G999'') MONTO, C001 DOTACION , TO_CHAR(TO_NUMBER(C002)/ TO_NUMBER(C001),''999G999G999G999G999'') TOTAL,TO_CHAR(C006, ''999G999G999G999G99'
||'9'') OBJETIVO',
'   FROM APEX_collections',
'WHERE collection_name = ''VENTA_DEPART'' ',
'UNION ALL',
'SELECT  ''TOTAL'' DEPARTAMENTO, TO_CHAR(SUM(C002), ''999G999G999G999G999'') MONTO, TO_CHAR(SUM(C001)) DOTACION , TO_CHAR(SUM(TO_NUMBER(C002)/ TO_NUMBER(C001)),''999G999G999G999G999'') TOTAL,TO_CHAR(SUM(C006), ''999G999G999G999G999'') OBJETIVO',
'   FROM APEX_collections',
'WHERE collection_name = ''VENTA_DEPART'' '))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11079898536620912938)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>128587851740677146
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079898470391912937)
,p_db_column_name=>'DEPARTAMENTO'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Departamento'
,p_column_link=>'f?p=&APP_ID.:2250:&SESSION.::&DEBUG.:RP:P2250_TIPO_DATO,P2250_MES,P2250_OPCION,P2250_FECHA,P2250_DEPARTAMENTO:DEP,3,2,&P3528_FECHA_HASTA.,#DEPARTAMENTO#'
,p_column_linktext=>'#DEPARTAMENTO#'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079898325816912936)
,p_db_column_name=>'MONTO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Ventas Kg'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079898202643912935)
,p_db_column_name=>'DOTACION'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Dotacion'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079898137692912934)
,p_db_column_name=>'TOTAL'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Fact. Ing'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11049227342720540825)
,p_db_column_name=>'OBJETIVO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Objetivo'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11079716095272108041)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1287703'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DEPARTAMENTO:MONTO:DOTACION:TOTAL:OBJETIVO'
,p_sort_column_1=>'TOTAL'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11023348358413675707)
,p_report_id=>wwv_flow_api.id(11079716095272108041)
,p_name=>'TOTAL'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DEPARTAMENTO'
,p_operator=>'='
,p_expr=>'TOTAL'
,p_condition_sql=>' (case when ("DEPARTAMENTO" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''TOTAL''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11079900014732912953)
,p_plug_name=>'DEPARTAMENTO_VENTA'
,p_parent_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  DECODE(C004, ''ASUNCION'', ''CDA'', ''CASA CENTRAL'', ''CENTRAL'', C004) DEPARTAMENTO, TO_CHAR(C003, ''999G999G999G999G999'') MONTO, C001 DOTACION , TO_CHAR(TO_NUMBER(C003)/ TO_NUMBER(C001),''999G999G999G999G999'') TOTAL, TO_CHAR(C005,''999G999G999G999G99'
||'9'') OBJETIVO',
'   FROM APEX_collections',
'WHERE collection_name = ''VENTA_DEPART'' ',
'UNION ALL',
'SELECT  ''TOTAL'' DEPARTAMENTO, TO_CHAR(SUM(C003), ''999G999G999G999G999'') MONTO, TO_CHAR(SUM(C001)) DOTACION , TO_CHAR(SUM(TO_NUMBER(C003)/ TO_NUMBER(C001)),''999G999G999G999G999'') TOTAL, TO_CHAR(SUM(C005),''999G999G999G999G999'') OBJETIVO',
'   FROM APEX_collections',
'WHERE collection_name = ''VENTA_DEPART'' '))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11079899895686912952)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>128586492674677132
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079899134878912944)
,p_db_column_name=>'DEPARTAMENTO'
,p_display_order=>10
,p_column_identifier=>'H'
,p_column_label=>'Departamento'
,p_column_link=>'f?p=&APP_ID.:2250:&SESSION.::&DEBUG.:RP:P2250_MES,P2250_FECHA,P2250_OPCION,P2250_DEPARTAMENTO,P2250_TIPO_DATO:3,&P3528_FECHA_HASTA.,1,#DEPARTAMENTO#,DEP'
,p_column_linktext=>'#DEPARTAMENTO#'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079898996816912943)
,p_db_column_name=>'MONTO'
,p_display_order=>20
,p_column_identifier=>'I'
,p_column_label=>'Ventas Gs.'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079898906123912942)
,p_db_column_name=>'DOTACION'
,p_display_order=>30
,p_column_identifier=>'J'
,p_column_label=>'Dotacion'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079898711076912940)
,p_db_column_name=>'TOTAL'
,p_display_order=>40
,p_column_identifier=>'L'
,p_column_label=>'Fact. Ing'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11049227212836540824)
,p_db_column_name=>'OBJETIVO'
,p_display_order=>50
,p_column_identifier=>'M'
,p_column_label=>'Objetivo'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11079736513115331753)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1287499'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DEPARTAMENTO:MONTO:DOTACION:TOTAL:OBJETIVO'
,p_sort_column_1=>'TOTAL'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11023347782632675125)
,p_report_id=>wwv_flow_api.id(11079736513115331753)
,p_name=>'TOTAL'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DEPARTAMENTO'
,p_operator=>'='
,p_expr=>'TOTAL'
,p_condition_sql=>' (case when ("DEPARTAMENTO" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''TOTAL''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11080254929974260949)
,p_plug_name=>'estructura Nuevo'
,p_parent_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>5
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 0 ORDEN, ''INDICADOR'' DESCRIPCION, ''UM'' UM, ''PB'' ANHO, C001 MES1, C002 MES2, C003 MES3, ''TEN'' TEN',
'        FROM APEX_collections',
'       WHERE collection_name = ''FECHA_ESTRUCTURA''',
'UNION ALL',
'SELECT 1 ORDEN, ''FACTOR INGRESO'' DETALLE, ''GS'', TO_CHAR(C008,''999G999G999G999G999'')PB, TO_CHAR(C004, ''999G999G999G999G999'') MES1, TO_CHAR(c005,''999G999G999G999G999'') MES2,  TO_CHAR(c006,''999G999G999G999G999'')MES3, NULL',
'FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' ',
'UNION ALL',
'SELECT 2 ORDEN, ''FACTOR PRODUC. KG DE VENTA'',''KG/P'',TO_CHAR(C007,''999G999G999G999G999'')PB, TO_CHAR(c001,''999G999G999G999G999'')MES1, TO_CHAR(c002,''999G999G999G999G999'')MES2, TO_CHAR(c003,''999G999G999G999G999'')MES3, NULL',
'   FROM APEX_collections',
'WHERE collection_name = ''ESTRUCTURA_DETALLE'' '))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11080254517683260945)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>128231870678329139
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079900927305912962)
,p_db_column_name=>'ORDEN'
,p_display_order=>70
,p_column_identifier=>'J'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079900738825912960)
,p_db_column_name=>'MES1'
,p_display_order=>90
,p_column_identifier=>'L'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2250:&SESSION.::&DEBUG.:RP:P2250_MES,P2250_OPCION,P2250_FECHA:1,#ORDEN#,&P3528_FECHA_HASTA.'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079900650620912959)
,p_db_column_name=>'MES2'
,p_display_order=>100
,p_column_identifier=>'M'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2250:&SESSION.::&DEBUG.:RP:P2250_MES,P2250_OPCION,P2250_FECHA:2,#ORDEN#,&P3528_FECHA_HASTA.'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079900549523912958)
,p_db_column_name=>'MES3'
,p_display_order=>110
,p_column_identifier=>'N'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2250:&SESSION.::&DEBUG.:RP:P2250_MES,P2250_OPCION,P2250_FECHA:3,#ORDEN#,&P3528_FECHA_HASTA.'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079900426149912957)
,p_db_column_name=>'DESCRIPCION'
,p_display_order=>120
,p_column_identifier=>'O'
,p_column_label=>'DESCRIPCION'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079900348848912956)
,p_db_column_name=>'UM'
,p_display_order=>130
,p_column_identifier=>'P'
,p_column_label=>'UM'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079900284759912955)
,p_db_column_name=>'ANHO'
,p_display_order=>140
,p_column_identifier=>'Q'
,p_column_label=>'PB'
,p_column_link=>'f?p=&APP_ID.:2250:&SESSION.::&DEBUG.:RP:P2250_MES,P2250_OPCION,P2250_FECHA:10,#ORDEN#,&P3528_FECHA_HASTA.'
,p_column_linktext=>'#ANHO#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079900158618912954)
,p_db_column_name=>'TEN'
,p_display_order=>150
,p_column_identifier=>'R'
,p_column_label=>'Ten'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11079905290853976287)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1285811'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DESCRIPCION:UM:ANHO:MES1:MES2:MES3:'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016767494972662668)
,p_report_id=>wwv_flow_api.id(11079905290853976287)
,p_name=>'ESTRUCTURA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'INDICADOR'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11095204422399361142)
,p_plug_name=>'VACANCIAS'
,p_parent_plug_id=>wwv_flow_api.id(11095207373900361172)
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10881135667732426716)
,p_plug_name=>'Vacancia Trans1'
,p_parent_plug_id=>wwv_flow_api.id(11095204422399361142)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>110
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ''INDICADOR'' DETALLE,',
'        '''' SUCURSAL,',
'	   C012 VMES1,',
'       C013 VMES2,',
'       C014 VMES3,',
'	   C012 CMES1,',
'       C013 CMES2,',
'       C014 CMES3',
'  FROM APEX_collections',
' WHERE collection_name = ''VACANCIAS_TRANS''',
' GROUP BY C012, C013,C014',
'UNION ALL ',
'SELECT ''Vacancias del mes'',',
'      C015 SUCURSAL,',
'	to_char(sum(case when C011 = 1 then ',
'					   C004',
'					   end)) vac_mes1,',
'	 ',
'	   to_char(sum(case when C011 = 2 then ',
'					   C004',
'					   end)) vac_mes2,',
'	   ',
'',
'	',
'	   to_char(sum(case when C011 = 3 then ',
'				   C004',
'				   end)) vac_mes3,',
'                     to_char(sum(case when C011 = 1 then ',
'								C007',
'				   end)) cub_mes1,',
'                          to_char(sum(case when C011 = 2 then ',
'								C007',
'				   end)) cub_mes2,',
'	 to_char(sum(case when C011 = 3 then ',
'								C007',
'				   end)) cub_mes3',
'  FROM APEX_collections',
' WHERE collection_name = ''VACANCIAS_TRANS''',
' GROUP BY C015',
'',
'',
' ',
'',
' '))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'2'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Vacancia Trans1'
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
 p_id=>wwv_flow_api.id(10881135592365426715)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>467156423634305940
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10881135441195426714)
,p_db_column_name=>'VMES2'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Vacancias'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P225_MT:2'
,p_column_linktext=>'#VMES2#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10881135362020426713)
,p_db_column_name=>'DETALLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Detalle'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10881135254201426712)
,p_db_column_name=>'VMES1'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Vacancias'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P225_MT:1'
,p_column_linktext=>'#VMES1#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10881135211523426711)
,p_db_column_name=>'VMES3'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Vacancias'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P225_MT:3'
,p_column_linktext=>'#VMES3#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10881135019560426710)
,p_db_column_name=>'CMES1'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Vac. Cubiertas'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P225_MT:1'
,p_column_linktext=>'#CMES1#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10881135005198426709)
,p_db_column_name=>'CMES2'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Vac. Cubiertas'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P225_MT:2'
,p_column_linktext=>'#CMES2#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10881134901234426708)
,p_db_column_name=>'CMES3'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Vac. Cubiertas'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P225_MT:3'
,p_column_linktext=>'#CMES3#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10881134766034426707)
,p_db_column_name=>'SUCURSAL'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Sucursal'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_rpt_named_lov=>wwv_flow_api.id(11099036932838026445)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(10878861818616716378)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'4694302'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'SUCURSAL:VMES1:VMES2:VMES3:CMES1:CMES2:CMES3:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10881136231347426722)
,p_plug_name=>'Graf VacTrans1'
,p_parent_plug_id=>wwv_flow_api.id(11095204422399361142)
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>100
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'	(sum(case when C011 = 1 then ',
'					   C004',
'		 when C011 = 2 then ',
'					   C004',
'		 when C011 = 3 then ',
'					   C004',
'					   end)) vac_mes,',
'	 ',
'	  ',
'         (sum(case when C011 = 1 then ',
'								C007',
'			  when C011 = 2 then ',
'								C007',
'			  when C011 = 3 then ',
'								C007',
'				   end)) cub_mes,',
'                   ',
'      case when C011 = 1 then             ',
'                     C012 ',
'             when C011 = 2 then    ',
'       C013 ',
'       ',
'        when C011 =3 then    ',
'       C014 ',
'       end||'' - ''||suc_desc mes , suc_desc SUCURSAL',
'  FROM APEX_collections, GEN_SUCURSAL ',
' WHERE collection_name = ''VACANCIAS_TRANS''',
'  and c011 is not null',
'  AND C015 = SUC_CODIGO',
'  AND SUC_EMPR = :p_empresa',
' group by c014, c012,c013,  c011, suc_desc'))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'2'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(10881136155959426721)
,p_region_id=>wwv_flow_api.id(10881136231347426722)
,p_chart_type=>'bar'
,p_title=>'Vacancias por Sucursal'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_legend_font_family=>'Arial Black'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(10881134638936426706)
,p_chart_id=>wwv_flow_api.id(10881136155959426721)
,p_seq=>30
,p_name=>'Vacancias1'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'VAC_MES'
,p_items_label_column_name=>'MES'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(10881134607823426705)
,p_chart_id=>wwv_flow_api.id(10881136155959426721)
,p_seq=>40
,p_name=>'Vac. Cubiertas'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'CUB_MES'
,p_items_label_column_name=>'MES'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(10881135821492426718)
,p_chart_id=>wwv_flow_api.id(10881136155959426721)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(10881135793781426717)
,p_chart_id=>wwv_flow_api.id(10881136155959426721)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10940134991754563705)
,p_plug_name=>'Vacancia Trans'
,p_parent_plug_id=>wwv_flow_api.id(11095204422399361142)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>90
,p_plug_grid_column_span=>7
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ''INDICADOR'' DETALLE,',
'	   C012 VMES1,',
'       C013 VMES2,',
'       C014 VMES3,',
'	   C012 CMES1,',
'       C013 CMES2,',
'       C014 CMES3',
'  FROM APEX_collections',
' WHERE collection_name = ''VACANCIAS_TRANS''',
' GROUP BY C012, C013,C014',
'UNION ALL ',
'SELECT ''Vacancias del mes'',',
'	to_char(sum(case when C011 = 1 then ',
'					   C004',
'					   end)) vac_mes1,',
'	 ',
'	   to_char(sum(case when C011 = 2 then ',
'					   C004',
'					   end)) vac_mes2,',
'	   ',
'',
'	',
'	   to_char(sum(case when C011 = 3 then ',
'				   C004',
'				   end)) vac_mes3,',
'                     to_char(sum(case when C011 = 1 then ',
'								C007',
'				   end)) cub_mes1,',
'                          to_char(sum(case when C011 = 2 then ',
'								C007',
'				   end)) cub_mes2,',
'	 to_char(sum(case when C011 = 3 then ',
'								C007',
'				   end)) cub_mes3',
'  FROM APEX_collections',
' WHERE collection_name = ''VACANCIAS_TRANS''',
'',
'',
' '))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'2'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Vacancia Trans'
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
 p_id=>wwv_flow_api.id(10933892429607669754)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>414399586392062901
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10933892266551669752)
,p_db_column_name=>'DETALLE'
,p_display_order=>10
,p_column_identifier=>'B'
,p_column_label=>'Detalle'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10933892160573669751)
,p_db_column_name=>'VMES1'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Vacancias'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P225_MT:1'
,p_column_linktext=>'#VMES1#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10933892325377669753)
,p_db_column_name=>'VMES2'
,p_display_order=>40
,p_column_identifier=>'A'
,p_column_label=>'Vacancias'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P225_MT:2'
,p_column_linktext=>'#VMES2#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10933892045665669750)
,p_db_column_name=>'VMES3'
,p_display_order=>50
,p_column_identifier=>'D'
,p_column_label=>'Vacancias'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P225_MT:3'
,p_column_linktext=>'#VMES3#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10933891949206669749)
,p_db_column_name=>'CMES1'
,p_display_order=>60
,p_column_identifier=>'E'
,p_column_label=>'Vac. Cubiertas'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P225_MT:1'
,p_column_linktext=>'#CMES1#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10933891844935669748)
,p_db_column_name=>'CMES2'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>'Vac. Cubiertas'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P225_MT:2'
,p_column_linktext=>'#CMES2#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10933891775022669747)
,p_db_column_name=>'CMES3'
,p_display_order=>80
,p_column_identifier=>'G'
,p_column_label=>'Vac. Cubiertas'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.::P225_MT:3'
,p_column_linktext=>'#CMES3#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(10933563945937411397)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'4147281'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DETALLE:VMES1:VMES2:VMES3:CMES1:CMES2:CMES3'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10933358140885341089)
,p_report_id=>wwv_flow_api.id(10933563945937411397)
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'INDICADOR'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CCE5FF'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10944966537954075412)
,p_plug_name=>'Graf VacTrans'
,p_parent_plug_id=>wwv_flow_api.id(11095204422399361142)
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>70
,p_plug_grid_column_span=>7
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'	(sum(case when C011 = 1 then ',
'					   C004',
'		 when C011 = 2 then ',
'					   C004',
'		 when C011 = 3 then ',
'					   C004',
'					   end)) vac_mes,',
'	 ',
'	  ',
'         (sum(case when C011 = 1 then ',
'								C007',
'			  when C011 = 2 then ',
'								C007',
'			  when C011 = 3 then ',
'								C007',
'				   end)) cub_mes,',
'                   ',
'      case when C011 = 1 then             ',
'                     C012 ',
'             when C011 = 2 then    ',
'       C013 ',
'       ',
'        when C011 =3 then    ',
'       C014 ',
'       end mes ',
'  FROM APEX_collections',
' WHERE collection_name = ''VACANCIAS_TRANS''',
'  and c011 is not null',
' group by c014, c012,c013,  c011',
''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'2'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(10933890966026669739)
,p_region_id=>wwv_flow_api.id(10944966537954075412)
,p_chart_type=>'bar'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_legend_font_family=>'Arial Black'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(10933890907949669738)
,p_chart_id=>wwv_flow_api.id(10933890966026669739)
,p_seq=>10
,p_name=>'Vacancias'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'VAC_MES'
,p_items_label_column_name=>'MES'
,p_color=>'#4CD964'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(10933890602639669735)
,p_chart_id=>wwv_flow_api.id(10933890966026669739)
,p_seq=>20
,p_name=>'Cubiertas'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'CUB_MES'
,p_items_label_column_name=>'MES'
,p_color=>'#34AADC'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(10933890753437669737)
,p_chart_id=>wwv_flow_api.id(10933890966026669739)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(10933890706614669736)
,p_chart_id=>wwv_flow_api.id(10933890966026669739)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11015084667809075545)
,p_plug_name=>'GRAFICO5_VACANCIA'
,p_parent_plug_id=>wwv_flow_api.id(11095204422399361142)
,p_region_template_options=>'#DEFAULT#:margin-top-lg:margin-bottom-lg'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>50
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_NUMBER(C001) VACANCIA,C005||''-''||C002 AREA, C004 ESTADO, C003 MES',
'    FROM APEX_collections',
'    WHERE collection_name = ''VAC_DEPARTAMENTO''',
'',
'',
'    ',
''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11015084547932075544)
,p_region_id=>wwv_flow_api.id(11015084667809075545)
,p_chart_type=>'combo'
,p_title=>'VACANCIAS'
,p_height=>'500'
,p_animation_on_display=>'none'
,p_animation_on_data_change=>'none'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_legend_font_family=>'Arial Black'
,p_legend_font_style=>'normal'
,p_legend_font_size=>'12'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11015084481287075543)
,p_chart_id=>wwv_flow_api.id(11015084547932075544)
,p_seq=>10
,p_name=>'En proceso'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_NUMBER(C001) VACANCIA,C005||''-''||C002 AREA, C004 ESTADO, C003 MES',
'    FROM APEX_collections',
'    WHERE collection_name = ''VAC_DEPARTAMENTO''',
'      AND C004 = ''En Proceso''',
''))
,p_series_type=>'bar'
,p_series_name_column_name=>'ESTADO'
,p_items_value_column_name=>'VACANCIA'
,p_items_label_column_name=>'AREA'
,p_color=>'#34AADC'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11015083918020075538)
,p_chart_id=>wwv_flow_api.id(11015084547932075544)
,p_seq=>20
,p_name=>'Finalizado'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_NUMBER(C001) VACANCIA,C005||''-''||C002 AREA, C004 ESTADO, C003 MES',
'    FROM APEX_collections',
'    WHERE collection_name = ''VAC_DEPARTAMENTO''',
'      AND C004 = ''Finalizado''',
''))
,p_series_type=>'bar'
,p_series_name_column_name=>'ESTADO'
,p_items_value_column_name=>'VACANCIA'
,p_items_label_column_name=>'AREA'
,p_color=>'#3CAF85'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11015083806458075537)
,p_chart_id=>wwv_flow_api.id(11015084547932075544)
,p_seq=>30
,p_name=>'Rechazado'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_NUMBER(C001) VACANCIA,C005||''-''||C002 AREA, C004 ESTADO, C003 MES',
'    FROM APEX_collections',
'    WHERE collection_name = ''VAC_DEPARTAMENTO''',
'      AND C004 = ''Rechazado''',
''))
,p_series_type=>'bar'
,p_series_name_column_name=>'ESTADO'
,p_items_value_column_name=>'VACANCIA'
,p_items_label_column_name=>'AREA'
,p_color=>'#FF3B30'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11015083712735075536)
,p_chart_id=>wwv_flow_api.id(11015084547932075544)
,p_seq=>40
,p_name=>'En espera'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_NUMBER(C001) VACANCIA,C005||''-''||C002 AREA, C004 ESTADO, C003 MES',
'    FROM APEX_collections',
'    WHERE collection_name = ''VAC_DEPARTAMENTO''',
'      AND C004 = ''En Espera''',
''))
,p_series_type=>'bar'
,p_series_name_column_name=>'ESTADO'
,p_items_value_column_name=>'VACANCIA'
,p_items_label_column_name=>'AREA'
,p_color=>'#FFCC00'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11015083610305075535)
,p_chart_id=>wwv_flow_api.id(11015084547932075544)
,p_seq=>50
,p_name=>'En Reclutamiento'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_NUMBER(C001) VACANCIA,C005||''-''||C002 AREA, C004 ESTADO, C003 MES',
'    FROM APEX_collections',
'    WHERE collection_name = ''VAC_DEPARTAMENTO''',
'      AND C004 = ''En Reclutamiento''',
''))
,p_series_type=>'bar'
,p_series_name_column_name=>'ESTADO'
,p_items_value_column_name=>'VACANCIA'
,p_items_label_column_name=>'AREA'
,p_color=>'#5856D6'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
end;
/
begin
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11090754714411216829)
,p_chart_id=>wwv_flow_api.id(11015084547932075544)
,p_seq=>60
,p_name=>'Anulado'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_NUMBER(C001) VACANCIA,C005||''-''||C002 AREA, C004 ESTADO, C003 MES',
'    FROM APEX_collections',
'    WHERE collection_name = ''VAC_DEPARTAMENTO''',
'      AND C004 = ''ANULADO''',
''))
,p_series_type=>'bar'
,p_series_name_column_name=>'ESTADO'
,p_items_value_column_name=>'VACANCIA'
,p_items_label_column_name=>'AREA'
,p_color=>'#57D4BD'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11015084365770075542)
,p_chart_id=>wwv_flow_api.id(11015084547932075544)
,p_seq=>70
,p_name=>'mes'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' SELECT 24 cant, ''1- ''||TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'') MES_1',
'   FROM DUAL',
'   union all',
'SELECT 24 cant, ''2- ''||TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'') MES_2',
'  FROM DUAL',
'  union all',
'SELECT 24 cant, ''3- ''||TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'') MES_3',
'   FROM DUAL',
'   ORDER BY 2 DESC '))
,p_series_type=>'bar'
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'MES_1'
,p_color=>'#87B0CF'
,p_line_style=>'dotted'
,p_line_width=>0
,p_line_type=>'straight'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'on'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11015084025886075539)
,p_chart_id=>wwv_flow_api.id(11015084547932075544)
,p_axis=>'y2'
,p_is_rendered=>'off'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_font_color=>'#5856D6'
,p_split_dual_y=>'auto'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11015084205924075541)
,p_chart_id=>wwv_flow_api.id(11015084547932075544)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title_font_size=>'8'
,p_format_scaling=>'auto'
,p_scaling=>'log'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11015084137392075540)
,p_chart_id=>wwv_flow_api.id(11015084547932075544)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'12'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11095622914100897789)
,p_plug_name=>'TABLA5_VACANCIA'
,p_parent_plug_id=>wwv_flow_api.id(11095204422399361142)
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>5
,p_plug_display_column=>7
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ''INDICADOR'' DETALLE, ''UM'' UM, ''PB'' PB, C007 MES1,C008 MES2,C009 MES3',
'                FROM APEX_collections',
'                WHERE collection_name = ''VACANCIA_1''',
'                AND C009 IS NOT NULL',
'UNION ALL',
'SELECT ''VACANCIAS TOTALES'' DETALLE, C002 UM, TO_CHAR(SUM(C003)) PB, TO_CHAR(SUM(C004)) MES1,TO_CHAR(SUM(C005)) MES2, TO_CHAR(SUM(C006)) MES3',
'                FROM APEX_collections',
'                WHERE collection_name = ''VACANCIA_1''',
'                GROUP BY C002',
'                ',
'UNION ALL',
'SELECT C001 DETALLE,C002 UM, C003 PB, C004 MES1, C005 MES2, C006 MES3',
'                FROM APEX_collections',
'                WHERE collection_name = ''VACANCIA_1''',
'        '))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11095722704101741541)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_show_search_bar=>'N'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>54518066082490401
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095803773873643376)
,p_db_column_name=>'DETALLE'
,p_display_order=>10
,p_column_identifier=>'AD'
,p_column_label=>'DESCRIPCION'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095803917291643377)
,p_db_column_name=>'UM'
,p_display_order=>20
,p_column_identifier=>'AE'
,p_column_label=>'UM'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095803972239643378)
,p_db_column_name=>'PB'
,p_display_order=>30
,p_column_identifier=>'AF'
,p_column_label=>'PB'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095804074626643379)
,p_db_column_name=>'MES1'
,p_display_order=>40
,p_column_identifier=>'AG'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.:RP:P2253_FECHA,P2253_MES,P2253_VACANCIA_TIPO,P2253_OPCION_OCUL:&P3528_FECHA_HASTA.,1,#DETALLE#,A'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095804204965643380)
,p_db_column_name=>'MES2'
,p_display_order=>50
,p_column_identifier=>'AH'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.:RP:P2253_FECHA,P2253_MES,P2253_VACANCIA_TIPO,P2253_OPCION_OCUL:&P3528_FECHA_HASTA.,2,#DETALLE#,A'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11095804240480643381)
,p_db_column_name=>'MES3'
,p_display_order=>60
,p_column_identifier=>'AI'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2253:&SESSION.::&DEBUG.:RP:P2253_FECHA,P2253_MES,P2253_VACANCIA_TIPO,P2253_OPCION_OCUL:&P3528_FECHA_HASTA.,3,#DETALLE#,A'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11095730908503742948)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'545263'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'INDUSTRIALOR_M1:DETALLE:UM:PB:MES1:MES2:MES3'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11063377264283641863)
,p_report_id=>wwv_flow_api.id(11095730908503742948)
,p_name=>'VACANCIA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'INDICADOR'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11063377638593641863)
,p_report_id=>wwv_flow_api.id(11095730908503742948)
,p_name=>'VAC'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'VACANCIAS TOTALES'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''VACANCIAS TOTALES''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11095874358461277845)
,p_plug_name=>'GRAFICO5_VACANCIA_1'
,p_parent_plug_id=>wwv_flow_api.id(11095204422399361142)
,p_region_template_options=>'#DEFAULT#:margin-top-lg:margin-bottom-lg'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>60
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_NUMBER(C001) VACANCIA,C005||''-''||C002 AREA, C004 ESTADO, C003 MES',
'    FROM APEX_collections',
'    WHERE collection_name = ''VAC_DEPARTAMENTO''',
'',
'',
'    ',
''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11095875061324277852)
,p_region_id=>wwv_flow_api.id(11095874358461277845)
,p_chart_type=>'combo'
,p_title=>'VACANCIAS'
,p_height=>'500'
,p_animation_on_display=>'zoom'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_legend_font_family=>'Arial Black'
,p_legend_font_style=>'normal'
,p_legend_font_size=>'12'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11095875138708277853)
,p_chart_id=>wwv_flow_api.id(11095875061324277852)
,p_seq=>10
,p_name=>'Nuevo'
,p_location=>'REGION_SOURCE'
,p_series_type=>'bar'
,p_series_name_column_name=>'ESTADO'
,p_items_value_column_name=>'VACANCIA'
,p_items_label_column_name=>'AREA'
,p_items_short_desc_column_name=>'AREA'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11097798413782052367)
,p_chart_id=>wwv_flow_api.id(11095875061324277852)
,p_seq=>20
,p_name=>'mes'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' SELECT 24 cant, ''1- ''||TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'') MES_1',
'   FROM DUAL',
'   union all',
'SELECT 24 cant, ''2- ''||TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'') MES_2',
'  FROM DUAL',
'  union all',
'SELECT 24 cant, ''3- ''||TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'') MES_3',
'   FROM DUAL',
'   ORDER BY 2 DESC '))
,p_series_type=>'bar'
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'MES_1'
,p_color=>'#87B0CF'
,p_line_style=>'dotted'
,p_line_width=>0
,p_line_type=>'straight'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'on'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11095875260750277854)
,p_chart_id=>wwv_flow_api.id(11095875061324277852)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title_font_size=>'8'
,p_format_scaling=>'auto'
,p_scaling=>'log'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11095875340858277855)
,p_chart_id=>wwv_flow_api.id(11095875061324277852)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'12'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11095875733687277858)
,p_chart_id=>wwv_flow_api.id(11095875061324277852)
,p_axis=>'y2'
,p_is_rendered=>'off'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_font_color=>'#5856D6'
,p_split_dual_y=>'auto'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11104120791781171927)
,p_plug_name=>'TABLA6_VAC'
,p_parent_plug_id=>wwv_flow_api.id(11095204422399361142)
,p_region_template_options=>'#DEFAULT#:t-Form--xlarge:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>30
,p_plug_grid_column_span=>4
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT NVL(SUM(C001),0) VACANCIA ,C002 AREA, C003 MES, c005 orden',
'    FROM APEX_collections',
'    WHERE collection_name = ''VAC_DEPARTAMENTO''',
'    GROUP BY C002, C003, c005   ',
'UNION ALL',
'SELECT NULL, NULL,  C003 MES, c005 orden',
' FROM APEX_collections',
'WHERE collection_name = ''VAC_DEPARTAMENTO''',
' GROUP BY C003 , c005  ',
' ORDER BY 3,2'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11103260418910553475)
,p_max_row_count=>'1000000'
,p_show_search_bar=>'N'
,p_show_detail_link=>'N'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>78747071677721901
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11103260268304553473)
,p_db_column_name=>'AREA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Area'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11103260129707553472)
,p_db_column_name=>'MES'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Mes'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11103259602417553467)
,p_db_column_name=>'VACANCIA'
,p_display_order=>40
,p_column_identifier=>'F'
,p_column_label=>'Vacancia'
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11093322860732731672)
,p_db_column_name=>'ORDEN'
,p_display_order=>50
,p_column_identifier=>'G'
,p_column_label=>'Orden'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11103249448852524559)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'787581'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'MES:AREA:VACANCIA:'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'DESC NULLS FIRST'
,p_sort_column_2=>'MES'
,p_sort_direction_2=>'ASC NULLS FIRST'
,p_sort_column_3=>'AREA'
,p_sort_direction_3=>'DESC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11093160172601456335)
,p_report_id=>wwv_flow_api.id(11103249448852524559)
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'AREA'
,p_operator=>'is null'
,p_condition_sql=>' (case when ("AREA" is null) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME#'
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#A4E5F2'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11095875475084277856)
,p_plug_name=>unistr('Q. SOLICITUDES - SELECCI\00D3N')
,p_parent_plug_id=>wwv_flow_api.id(11095207373900361172)
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11072701657099885758)
,p_plug_name=>'PROCESO_SELECCION'
,p_parent_plug_id=>wwv_flow_api.id(11095875475084277856)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ''INDICADORES'' INDICADOR,''UM''UM ,''PB'' PB, C001 MES1, C002 MES2, C003 MES3,1 ORDEN',
'    FROM APEX_collections',
'    WHERE collection_name = ''FECHA_SELECCION''',
'    UNION ALL',
'SELECT decode(B.SELECCION,''Anticipada'',''Directa'',B.SELECCION)SELECCION, ''Q'', NULL, TO_CHAR(MES1), TO_CHAR(MES2), TO_CHAR(MES3), ORDEN ----pedido de Kleber 07/11/2020',
'FROM ',
'(SELECT C004 SELECCION, SUM(C008) MES1, SUM(C009) MES2, SUM(C010) MES3',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_SECT''',
'GROUP BY C004) A,',
'(SELECT C001 SELECCION, TO_NUMBER(C002) ORDEN',
'    FROM APEX_collections',
'    WHERE collection_name = ''TIPOS_SELECCION'') B',
'WHERE B.SELECCION = A.SELECCION(+)',
'UNION ALL',
'SELECT ''Tipo de Solicitud'', ''Q'', NULL, TO_CHAR(SUM(C008)) MES1, TO_CHAR(SUM(C009)) MES2, TO_CHAR(SUM(C010)) MES3,3',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_SECT''',
'',
'',
'    '))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11072701512084885757)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>135784876276704327
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11072699898755885741)
,p_db_column_name=>'ORDEN'
,p_display_order=>50
,p_column_identifier=>'P'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11072699748850885739)
,p_db_column_name=>'MES1'
,p_display_order=>70
,p_column_identifier=>'R'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2254:&SESSION.::&DEBUG.:RP:P2254_FECHA,P2254_ORDEN,P2254_TIPO,P2254_TIPO_SELEC:&P3528_FECHA_HASTA.,1,#INDICADOR#,1'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11072699656060885738)
,p_db_column_name=>'MES2'
,p_display_order=>80
,p_column_identifier=>'S'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2254:&SESSION.::&DEBUG.:RP:P2254_FECHA,P2254_ORDEN,P2254_TIPO,P2254_TIPO_SELEC:&P3528_FECHA_HASTA.,2,#INDICADOR#,1'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11072699497146885737)
,p_db_column_name=>'MES3'
,p_display_order=>90
,p_column_identifier=>'T'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2254:&SESSION.::&DEBUG.:RP:P2254_FECHA,P2254_ORDEN,P2254_TIPO,P2254_TIPO_SELEC:&P3528_FECHA_HASTA.,3,#INDICADOR#,1'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11072699481640885736)
,p_db_column_name=>'INDICADOR'
,p_display_order=>100
,p_column_identifier=>'U'
,p_column_label=>'INDICADOR'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11072699330227885735)
,p_db_column_name=>'UM'
,p_display_order=>110
,p_column_identifier=>'V'
,p_column_label=>'UM'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11072699278790885734)
,p_db_column_name=>'PB'
,p_display_order=>120
,p_column_identifier=>'W'
,p_column_label=>'PB'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11072566764934338447)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1359197'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'INDICADOR:UM:PB:MES1:MES2:MES3:'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016748062978629997)
,p_report_id=>wwv_flow_api.id(11072566764934338447)
,p_name=>'SOLICITUDES'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'INDICADOR'
,p_operator=>'='
,p_expr=>'Tipo de Solicitud'
,p_condition_sql=>' (case when ("INDICADOR" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''Tipo de Solicitud''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016748304649629997)
,p_report_id=>wwv_flow_api.id(11072566764934338447)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'INDICADOR'
,p_operator=>'='
,p_expr=>'INDICADORES'
,p_condition_sql=>' (case when ("INDICADOR" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADORES''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096130936038143855)
,p_plug_name=>'grafico8_TE'
,p_parent_plug_id=>wwv_flow_api.id(11095875475084277856)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>50
,p_plug_grid_column_span=>4
,p_plug_display_column=>4
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT A.MES, TIPO_SOL, ROUND((TOTAL_CONT*100)/DECODE(NVL(TOTAL,1),0,1,NVL(TOTAL,1)))/100 PORCENTAJE',
'FROM',
'(SELECT decode(c007,3,''a'',2,''b'',1,''c'')||'' - ''||C003 MES, C004 TIPO_SOL,  SUM(C001) TOTAL_CONT',
' FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_SECT''',
'      AND C003 IS NOT NULL',
'    GROUP BY C003,  C004, decode(c007,3,''a'',2,''b'',1,''c''))A,',
' (SELECT decode(c007,3,''a'',2,''b'',1,''c'')||'' - ''||C003 MES, SUM(C001) TOTAL',
'  FROM APEX_collections',
' WHERE collection_name = ''SELECCION_SECT''',
'     AND C003 IS NOT NULL',
'    GROUP BY C003, decode(c007,3,''a'',2,''b'',1,''c'')) B',
'WHERE A.MES = B.MES',
'and tipo_sol = ''Programada'''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11096132226706143868)
,p_region_id=>wwv_flow_api.id(11096130936038143855)
,p_chart_type=>'bar'
,p_title=>unistr('SELECCI\00D3N TE.')
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'horizontal'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_legend_font_family=>'Arial Black'
,p_legend_font_style=>'normal'
,p_legend_font_size=>'12'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11014917906484230985)
,p_chart_id=>wwv_flow_api.id(11096132226706143868)
,p_seq=>10
,p_name=>'Directa'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT A.MES, decode(TIPO_SOL,''Ancitipada'',''Directa'',TIPO_SOL)TIPO_SOL , ROUND((TOTAL_CONT*100)/DECODE(NVL(TOTAL,1),0,1,NVL(TOTAL,1)))/100 PORCENTAJE',
'FROM',
'(SELECT decode(c007,3,''a'',2,''b'',1,''c'')||'' - ''||C003 MES, C004 TIPO_SOL,  SUM(C001) TOTAL_CONT',
' FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_SECT''',
'      AND C003 IS NOT NULL',
'    GROUP BY C003,  C004, decode(c007,3,''a'',2,''b'',1,''c''))A,',
' (SELECT decode(c007,3,''a'',2,''b'',1,''c'')||'' - ''||C003 MES, SUM(C001) TOTAL',
'  FROM APEX_collections',
' WHERE collection_name = ''SELECCION_SECT''',
'     AND C003 IS NOT NULL',
'    GROUP BY C003, decode(c007,3,''a'',2,''b'',1,''c'')) B',
'WHERE A.MES = B.MES',
'and tipo_sol = ''Anticipada'''))
,p_series_name_column_name=>'TIPO_SOL'
,p_items_value_column_name=>'PORCENTAJE'
,p_items_label_column_name=>'MES'
,p_color=>'#FF9500'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11096132257685143869)
,p_chart_id=>wwv_flow_api.id(11096132226706143868)
,p_seq=>20
,p_name=>'Programada'
,p_location=>'REGION_SOURCE'
,p_series_name_column_name=>'TIPO_SOL'
,p_items_value_column_name=>'PORCENTAJE'
,p_items_label_column_name=>'MES'
,p_color=>'#309FDB'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11014917622108230982)
,p_chart_id=>wwv_flow_api.id(11096132226706143868)
,p_seq=>30
,p_name=>'Acumulada'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT A.MES, TIPO_SOL, ROUND((TOTAL_CONT*100)/DECODE(NVL(TOTAL,1),0,1,NVL(TOTAL,1)))/100 PORCENTAJE',
'FROM',
'(SELECT decode(c007,3,''a'',2,''b'',1,''c'')||'' - ''||C003 MES, C004 TIPO_SOL,  SUM(C001) TOTAL_CONT',
' FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_SECT''',
'      AND C003 IS NOT NULL',
'    GROUP BY C003,  C004, decode(c007,3,''a'',2,''b'',1,''c''))A,',
' (SELECT decode(c007,3,''a'',2,''b'',1,''c'')||'' - ''||C003 MES, SUM(C001) TOTAL',
'  FROM APEX_collections',
' WHERE collection_name = ''SELECCION_SECT''',
'     AND C003 IS NOT NULL',
'    GROUP BY C003, decode(c007,3,''a'',2,''b'',1,''c'')) B',
'WHERE A.MES = B.MES',
'and tipo_sol = ''Acumulada'''))
,p_series_name_column_name=>'TIPO_SOL'
,p_items_value_column_name=>'PORCENTAJE'
,p_items_label_column_name=>'MES'
,p_color=>'#3CAF85'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
end;
/
begin
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11096132435359143870)
,p_chart_id=>wwv_flow_api.id(11096132226706143868)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'12'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11096132440963143871)
,p_chart_id=>wwv_flow_api.id(11096132226706143868)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'percent'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'12'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11103476944962559462)
,p_plug_name=>'GRAFICO7_SOLICITUD1'
,p_parent_plug_id=>wwv_flow_api.id(11095875475084277856)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>5
,p_plug_display_column=>2
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11103477049145559463)
,p_region_id=>wwv_flow_api.id(11103476944962559462)
,p_chart_type=>'bar'
,p_title=>unistr('TIPOS DE SELECCI\00D3N')
,p_height=>'700'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'none'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'end'
,p_legend_font_family=>'Arial Black'
,p_legend_font_style=>'normal'
,p_legend_font_size=>'14'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11014917796753230984)
,p_chart_id=>wwv_flow_api.id(11103477049145559463)
,p_seq=>10
,p_name=>'Directa'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT C003, c007||''-''||C002 AREA_MES, decode(C004,''Anticipada'',''Directa'',C004)   TIPO_SOL,  sum(C006) PORC_SELEC',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_SECT''',
'      AND C003 IS NOT NULL',
'      AND C004 = ''Anticipada''',
'    GROUP BY C003, C002, C004,c007',
'    ',
''))
,p_series_name_column_name=>'TIPO_SOL'
,p_items_value_column_name=>'PORC_SELEC'
,p_items_label_column_name=>'AREA_MES'
,p_items_short_desc_column_name=>'AREA_MES'
,p_color=>'#FF9500'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11103477204897559464)
,p_chart_id=>wwv_flow_api.id(11103477049145559463)
,p_seq=>20
,p_name=>'Programada'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT C003, c007||''-''||C002 AREA_MES, C004 TIPO_SOL,  sum(C006) PORC_SELEC',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_SECT''',
'      AND C003 IS NOT NULL',
'      AND C004  = ''Programada''',
'    GROUP BY C003, C002, C004,c007',
'    ',
''))
,p_series_name_column_name=>'TIPO_SOL'
,p_items_value_column_name=>'PORC_SELEC'
,p_items_label_column_name=>'AREA_MES'
,p_items_short_desc_column_name=>'AREA_MES'
,p_color=>'#309FDB'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11014917533835230981)
,p_chart_id=>wwv_flow_api.id(11103477049145559463)
,p_seq=>30
,p_name=>'Acumulada'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT C003, c007||''-''||C002 AREA_MES, C004 TIPO_SOL,  sum(C006) PORC_SELEC',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_SECT''',
'      AND C003 IS NOT NULL',
'      AND C004 = ''Acumulada''',
'    GROUP BY C003, C002, C004,c007',
'    ',
''))
,p_series_name_column_name=>'TIPO_SOL'
,p_items_value_column_name=>'PORC_SELEC'
,p_items_label_column_name=>'AREA_MES'
,p_items_short_desc_column_name=>'AREA_MES'
,p_color=>'#3CAF85'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11103477487954559467)
,p_chart_id=>wwv_flow_api.id(11103477049145559463)
,p_seq=>40
,p_name=>'Mes'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' SELECT 1 cant, ''1- ''||TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'') MES_1',
'   FROM DUAL',
'   union all',
'SELECT 1 cant, ''2- ''||TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'') MES_2',
'  FROM DUAL',
'  union all',
'SELECT 1 cant, ''3- ''||TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'') MES_3',
'   FROM DUAL',
'   ORDER BY 2 DESC '))
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'MES_1'
,p_color=>'#FFFFFF'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11016848054164137383)
,p_chart_id=>wwv_flow_api.id(11103477049145559463)
,p_axis=>'y2'
,p_is_rendered=>'off'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_split_dual_y=>'auto'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11103477310792559465)
,p_chart_id=>wwv_flow_api.id(11103477049145559463)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11103477370593559466)
,p_chart_id=>wwv_flow_api.id(11103477049145559463)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'on'
,p_tick_label_rendered=>'on'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'12'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096132732797143873)
,p_plug_name=>unistr('Q. SOLICITUDES CONTRATACI\00D3N')
,p_parent_plug_id=>wwv_flow_api.id(11095207373900361172)
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11072229740759923755)
,p_plug_name=>'SOLICITUD_CONTRATACION'
,p_parent_plug_id=>wwv_flow_api.id(11096132732797143873)
,p_region_template_options=>'#DEFAULT#:margin-top-lg:margin-bottom-lg'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>30
,p_plug_grid_column_span=>5
,p_plug_display_column=>2
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ''INDICADORES'' INDICADOR,''UM''UM ,''PB'' PB, C001 MES1, C002 MES2, C003 MES3,1 ORDEN',
'    FROM APEX_collections',
'    WHERE collection_name = ''FECHA_CONTRATACION''',
'    UNION ALL',
'SELECT B.SELECCION, ''Q'', NULL, TO_CHAR(MES1), TO_CHAR(MES2), TO_CHAR(MES3), ORDEN',
'FROM ',
'(SELECT C004 SELECCION, SUM(C008) MES1, SUM(C009) MES2, SUM(C010) MES3',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONT''',
'GROUP BY C004) A,',
'(SELECT C001 SELECCION, TO_NUMBER(C002) ORDEN',
'    FROM APEX_collections',
'    WHERE collection_name = ''TIPOS_CONTRATACION'') B',
'WHERE B.SELECCION = A.SELECCION(+)',
'UNION ALL',
unistr('SELECT ''Tipo de Contrataci\00F3n'', ''Q'', NULL, TO_CHAR(SUM(C008)) MES1, TO_CHAR(SUM(C009)) MES2, TO_CHAR(SUM(C010)) MES3,3'),
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONT''',
'',
'    '))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11072229650264923754)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>136256738096666330
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11072229528082923753)
,p_db_column_name=>'INDICADOR'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'INDICADOR'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11072229453436923752)
,p_db_column_name=>'UM'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'UM'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11072229359722923751)
,p_db_column_name=>'PB'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'PB'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11072229237353923750)
,p_db_column_name=>'MES1'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2254:&SESSION.::&DEBUG.:RP:P2254_FECHA,P2254_ORDEN,P2254_TIPO,P2254_TIPO_SELEC:&P3528_FECHA_HASTA.,1,#INDICADOR#,2'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11072229137935923749)
,p_db_column_name=>'MES2'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2254:&SESSION.::&DEBUG.:RP:P2254_FECHA,P2254_ORDEN,P2254_TIPO,P2254_TIPO_SELEC:&P3528_FECHA_HASTA.,2,#INDICADOR#,1'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11072229070201923748)
,p_db_column_name=>'MES3'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2254:&SESSION.::&DEBUG.:RP:P2254_FECHA,P2254_ORDEN,P2254_TIPO,P2254_TIPO_SELEC:&P3528_FECHA_HASTA.,3,#INDICADOR#,2'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11072228972837923747)
,p_db_column_name=>'ORDEN'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11072172965114589176)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1363135'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'INDICADOR:UM:PB:MES1:MES2:MES3:'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016746905569629347)
,p_report_id=>wwv_flow_api.id(11072172965114589176)
,p_name=>'Solicitud'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'INDICADOR'
,p_operator=>'='
,p_expr=>unistr('Tipo de Contrataci\00F3n')
,p_condition_sql=>' (case when ("INDICADOR" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>unistr('#APXWS_COL_NAME# = ''Tipo de Contrataci\00F3n''  ')
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016747323872629347)
,p_report_id=>wwv_flow_api.id(11072172965114589176)
,p_name=>'INDICADORES'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'INDICADOR'
,p_operator=>'='
,p_expr=>'INDICADORES'
,p_condition_sql=>' (case when ("INDICADOR" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADORES''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096134001385143886)
,p_plug_name=>'GRAFICO9_CONTRA'
,p_parent_plug_id=>wwv_flow_api.id(11096132732797143873)
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>60
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT C002 area,',
'C003 MES,C007||''-''||C002 AREA_MES, ',
'C004 TIPO_CONT,  round(SUM(C006)*100) PORC_CONT',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONT''',
'     AND C003 IS NOT NULL',
'          AND C004 = ''Programada''',
'   GROUP BY c002,C003, C004,C007||''-''||C002 ',
'',
''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11096208237346776657)
,p_region_id=>wwv_flow_api.id(11096134001385143886)
,p_chart_type=>'combo'
,p_title=>unistr('TIPOS DE CONTRATACI\00D3N')
,p_height=>'500'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'N'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_legend_font_family=>'Arial Black'
,p_legend_font_style=>'normal'
,p_legend_font_size=>'14'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11014918083337230986)
,p_chart_id=>wwv_flow_api.id(11096208237346776657)
,p_seq=>10
,p_name=>'Directa'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT C002 area,',
'C003 MES,C007||''-''||C002 AREA_MES, ',
'C004 TIPO_CONT,  round(SUM(C006)*100) PORC_CONT',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONT''',
'     AND C003 IS NOT NULL',
'     AND C004 = ''Directa''',
'   GROUP BY c002,C003, C004,C007||''-''||C002 ',
''))
,p_series_type=>'bar'
,p_series_name_column_name=>'TIPO_CONT'
,p_items_value_column_name=>'PORC_CONT'
,p_items_label_column_name=>'AREA_MES'
,p_color=>'#FF9500'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11096208305529776658)
,p_chart_id=>wwv_flow_api.id(11096208237346776657)
,p_seq=>20
,p_name=>'PRogramada'
,p_location=>'REGION_SOURCE'
,p_series_type=>'bar'
,p_series_name_column_name=>'TIPO_CONT'
,p_items_value_column_name=>'PORC_CONT'
,p_items_label_column_name=>'AREA_MES'
,p_color=>'#309FDB'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11014917694211230983)
,p_chart_id=>wwv_flow_api.id(11096208237346776657)
,p_seq=>30
,p_name=>'Acumulada'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT C002 area,',
'C003 MES,C007||''-''||C002 AREA_MES, ',
'C004 TIPO_CONT,  round(SUM(C006)*100) PORC_CONT',
'    FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONT''',
'     AND C003 IS NOT NULL',
'     AND C004 = ''Acumulada''',
'   GROUP BY c002,C003, C004,C007||''-''||C002 ',
''))
,p_series_type=>'bar'
,p_series_name_column_name=>'TIPO_CONT'
,p_items_value_column_name=>'PORC_CONT'
,p_items_label_column_name=>'AREA_MES'
,p_color=>'#3CAF85'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11016847939939137382)
,p_chart_id=>wwv_flow_api.id(11096208237346776657)
,p_seq=>40
,p_name=>'Mes'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' SELECT 0 cant, ''1- ''||TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'') MES_1',
'   FROM DUAL',
'   union all',
'SELECT 0 cant, ''2- ''||TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'') MES_2',
'  FROM DUAL',
'  union all',
'SELECT 0 cant, ''3- ''||TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'') MES_3',
'   FROM DUAL',
'   ORDER BY 2 DESC '))
,p_series_type=>'bar'
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'MES_1'
,p_color=>'#FFFFFF'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11096208401417776659)
,p_chart_id=>wwv_flow_api.id(11096208237346776657)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11096208524553776660)
,p_chart_id=>wwv_flow_api.id(11096208237346776657)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096208608980776661)
,p_plug_name=>'GRAFICO10_TIPO_PROGT_TE'
,p_parent_plug_id=>wwv_flow_api.id(11096132732797143873)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.orden||'' - ''||A.MES mes, TIPO_CONT, ROUND((TOTAL_CONT*100)/DECODE(NVL(TOTAL,1),0,1,NVL(TOTAL,1)))/100 PORCENTAJE',
'FROM',
'(SELECT C003 MES, C004 TIPO_CONT,  SUM(C001) TOTAL_CONT, decode(c007,3,''a'',2,''b'',1,''c'') orden',
' FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONT''',
'      AND C003 IS NOT NULL',
'    GROUP BY C003,  C004, decode(C007,3,''a'',2,''b'',1,''c''))A,',
' (SELECT  C003 MES, SUM(C001) TOTAL,  decode(C007,3,''a'',2,''b'',1,''c'') orden',
'  FROM APEX_collections',
' WHERE collection_name = ''SELECCION_CONT''',
'   AND C003 IS NOT NULL',
'    GROUP BY C003, decode(C007,3,''a'',2,''b'',1,''c'')) B',
'WHERE A.MES = B.MES',
'  and tipo_Cont = ''Programada'''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11096209056525776666)
,p_region_id=>wwv_flow_api.id(11096208608980776661)
,p_chart_type=>'bar'
,p_title=>unistr('CONTRATACI\00D3N TE')
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'horizontal'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_legend_font_family=>'Arial Black'
,p_legend_font_style=>'normal'
,p_legend_font_size=>'12'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11014918181236230987)
,p_chart_id=>wwv_flow_api.id(11096209056525776666)
,p_seq=>10
,p_name=>'Directa'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.orden||'' - ''||A.MES mes, TIPO_CONT, ROUND((TOTAL_CONT*100)/DECODE(NVL(TOTAL,1),0,1,NVL(TOTAL,1)))/100 PORCENTAJE',
'FROM',
'(SELECT C003 MES, C004 TIPO_CONT,  SUM(C001) TOTAL_CONT, decode(c007,3,''a'',2,''b'',1,''c'') orden',
' FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONT''',
'      AND C003 IS NOT NULL',
'    GROUP BY C003,  C004, decode(C007,3,''a'',2,''b'',1,''c''))A,',
' (SELECT  C003 MES, SUM(C001) TOTAL,  decode(C007,3,''a'',2,''b'',1,''c'') orden',
'  FROM APEX_collections',
' WHERE collection_name = ''SELECCION_CONT''',
'   AND C003 IS NOT NULL',
'    GROUP BY C003, decode(C007,3,''a'',2,''b'',1,''c'')) B',
'WHERE A.MES = B.MES',
'and tipo_cont = ''Directa'''))
,p_series_name_column_name=>'TIPO_CONT'
,p_items_value_column_name=>'PORCENTAJE'
,p_items_label_column_name=>'MES'
,p_color=>'#FF9500'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11096209179431776667)
,p_chart_id=>wwv_flow_api.id(11096209056525776666)
,p_seq=>20
,p_name=>'Programada'
,p_location=>'REGION_SOURCE'
,p_series_name_column_name=>'TIPO_CONT'
,p_items_value_column_name=>'PORCENTAJE'
,p_items_label_column_name=>'MES'
,p_color=>'#309FDB'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11014918211541230988)
,p_chart_id=>wwv_flow_api.id(11096209056525776666)
,p_seq=>30
,p_name=>'Acumulada'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.orden||'' - ''||A.MES mes, TIPO_CONT, ROUND((TOTAL_CONT*100)/DECODE(NVL(TOTAL,1),0,1,NVL(TOTAL,1)))/100 PORCENTAJE',
'FROM',
'(SELECT C003 MES, C004 TIPO_CONT,  SUM(C001) TOTAL_CONT, decode(c007,3,''a'',2,''b'',1,''c'') orden',
' FROM APEX_collections',
'    WHERE collection_name = ''SELECCION_CONT''',
'      AND C003 IS NOT NULL',
'    GROUP BY C003,  C004, decode(C007,3,''a'',2,''b'',1,''c''))A,',
' (SELECT  C003 MES, SUM(C001) TOTAL,  decode(C007,3,''a'',2,''b'',1,''c'') orden',
'  FROM APEX_collections',
' WHERE collection_name = ''SELECCION_CONT''',
'   AND C003 IS NOT NULL',
'    GROUP BY C003, decode(C007,3,''a'',2,''b'',1,''c'')) B',
'WHERE A.MES = B.MES',
'and tipo_cont = ''Acumulada'''))
,p_series_name_column_name=>'TIPO_CONT'
,p_items_value_column_name=>'PORCENTAJE'
,p_items_label_column_name=>'MES'
,p_color=>'#3CAF85'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'12'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11096209282712776668)
,p_chart_id=>wwv_flow_api.id(11096209056525776666)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'12'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11096209369395776669)
,p_chart_id=>wwv_flow_api.id(11096209056525776666)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'percent'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'12'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096209796738776673)
,p_plug_name=>'PROCESO R.S&C'
,p_parent_plug_id=>wwv_flow_api.id(11095207373900361172)
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11069734928678375444)
,p_plug_name=>'TABLA10_PROCESO_RSC22'
,p_parent_plug_id=>wwv_flow_api.id(11096209796738776673)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>30
,p_plug_grid_column_span=>4
,p_plug_display_column=>5
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' SELECT ''INDICADOR DE PROCESO DE R,S & C'' DETALLE, NULL UM, ',
'TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'') CANT_MES1,',
'TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'')  CANT_MES2,',
'TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'') CANT_MES3, 0 ORDEN ',
' FROM DUAL ',
'',
'UNION ALL',
'SELECT c001 DETALLE ,''Q'',TO_CHAR(sum(c003)),TO_CHAR(sum(c004)), TO_CHAR(sum(c005)), to_number(c006)',
' FROM APEX_collections',
'    WHERE collection_name = ''ENTREVISTA_PROCESO''',
'    group by c001, c006',
'union all',
'SELECT ''EN FILA'',''Q'',TO_CHAR(sum(c003)),TO_CHAR(sum(c004)), TO_CHAR(sum(c005)),2',
' FROM APEX_collections',
'    WHERE collection_name = ''ENTREVISTA_PROCESO''',
'      and c006 = 3',
'union all',
'SELECT ''EN FILA'',''Q'',TO_CHAR(sum(c003)),TO_CHAR(sum(c004)), TO_CHAR(sum(c005)),5',
' FROM APEX_collections',
'    WHERE collection_name = ''ENTREVISTA_PROCESO''',
'      and c006 = 6',
'union all',
'SELECT ''EN FILA'',''Q'',TO_CHAR(sum(c003)),TO_CHAR(sum(c004)), TO_CHAR(sum(c005)),8',
' FROM APEX_collections',
'    WHERE collection_name = ''ENTREVISTA_PROCESO''',
'      and c006 = 9      ',
' UNION ALL',
' SELECT ''EN FILA'',''Q'',TO_CHAR(sum(c003)),TO_CHAR(sum(c004)), TO_CHAR(sum(c005)),11',
' FROM APEX_collections',
'    WHERE collection_name = ''ENTREVISTA_PROCESO''',
'      and c006 = 12',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_MES_3,P3528_MES_2,P3528_MES_1'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
end;
/
begin
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11069734719781375442)
,p_max_row_count=>'1000000'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>138751668580214642
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11068331493789140173)
,p_db_column_name=>'DETALLE'
,p_display_order=>10
,p_column_identifier=>'K'
,p_column_label=>'Detalle'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11068331412360140172)
,p_db_column_name=>'UM'
,p_display_order=>20
,p_column_identifier=>'L'
,p_column_label=>'Um'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11068331359372140171)
,p_db_column_name=>'CANT_MES1'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2255:&SESSION.::&DEBUG.:RP:P2255_FECHA,P2255_MES,P2255_OPCION:&P3528_FECHA_HASTA.,1,#ORDEN#'
,p_column_linktext=>'#CANT_MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11068331211829140170)
,p_db_column_name=>'CANT_MES2'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2255:&SESSION.::&DEBUG.:RP:P2255_FECHA,P2255_MES,P2255_OPCION:&P3528_FECHA_HASTA.,2,#ORDEN#'
,p_column_linktext=>'#CANT_MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11068331186190140169)
,p_db_column_name=>'CANT_MES3'
,p_display_order=>50
,p_column_identifier=>'O'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2255:&SESSION.::&DEBUG.:RP:P2255_FECHA,P2255_MES,P2255_OPCION:&P3528_FECHA_HASTA.,3,#ORDEN#'
,p_column_linktext=>'#CANT_MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11068330991613140168)
,p_db_column_name=>'ORDEN'
,p_display_order=>60
,p_column_identifier=>'P'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11068324686945132342)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1401618'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DETALLE:UM:CANT_MES1:CANT_MES2:CANT_MES3:'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'TO_NUMBER(C006)'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'C006'
,p_sort_direction_3=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016744445097628594)
,p_report_id=>wwv_flow_api.id(11068324686945132342)
,p_name=>'REFERENCIA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'REFERENCIAS'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''REFERENCIAS''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016744847161628595)
,p_report_id=>wwv_flow_api.id(11068324686945132342)
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'INDICADOR DE PROCESO DE R,S & C'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR DE PROCESO DE R,S & C''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016745197494628596)
,p_report_id=>wwv_flow_api.id(11068324686945132342)
,p_name=>'ENTREVISTA ESPECIAL'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'ENTREVISTA ESPECIAL'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''ENTREVISTA ESPECIAL''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016745685929628596)
,p_report_id=>wwv_flow_api.id(11068324686945132342)
,p_name=>'ENTREVISTA DE AREA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'ENTREVISTA AREA'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''ENTREVISTA AREA''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016745914180628596)
,p_report_id=>wwv_flow_api.id(11068324686945132342)
,p_name=>'EN FILA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'EN FILA'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''EN FILA''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016746377330628598)
,p_report_id=>wwv_flow_api.id(11068324686945132342)
,p_name=>'PRIMERA ENTREVISTA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>' 1RA. ENTREVISTA '
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = '' 1RA. ENTREVISTA ''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11100654110121405928)
,p_plug_name=>'TABLA10_PROCESO_RSC2'
,p_parent_plug_id=>wwv_flow_api.id(11096209796738776673)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>5
,p_plug_display_column=>4
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ORDEN, DETALLE, UM, PB, TO_CHAR(MES1) MES1, TO_CHAR(MES2) MES2, TO_CHAR(MES3) MES3, CASE WHEN ORDEN IN(0,1,4,7,10) THEN ''data-style=background-color:#CDE3FA'' ',
'      WHEN DETALLE = ''EN FILA''THEN ''data-style=background-color:#B5C0C4''  ',
'      END css_stylE',
'FROM',
'(SELECT ORDEN, DETALLE, UM, PB, ',
' case when orden = 1 then',
'        nvl(SUM(CANT_MES1),0)+ NVL(:P3528_MES_1,0)',
'      else',
'       SUM(CANT_MES1)',
'      end mes1,',
' case when orden = 1 then',
'        nvl(SUM(CANT_MES2),0)+ NVL(:P3528_MES_2,0)',
'      else',
'       SUM(CANT_MES2)',
'      end mes2, ',
'  case when orden = 1 then',
'        nvl(SUM(CANT_MES3),0)+ NVL(:P3528_MES_3,0)',
'      else',
'       SUM(CANT_MES3)',
'      end mes3 ',
'-- SUM(CANT_MES1) MES1, ',
'--- SUM(CANT_MES2) MES2, ',
'-- SUM(CANT_MES3)MES3',
'FROM(',
'        SELECT 1 ORDEN, C001 DETALLE, C002 UM, C003 PB, ',
'        CASE WHEN c005= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'')  THEN NVL(TO_NUMBER(C004),0) END CANT_MES1,',
'        CASE WHEN c005= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'')  THEN NVL(TO_NUMBER(C004),0)END CANT_MES2,',
'        CASE WHEN c005= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')  THEN NVL(TO_NUMBER(C004),0) END CANT_MES3',
'         FROM APEX_collections',
'        WHERE collection_name = ''RSC_ENTREV'') ',
'GROUP BY ORDEN, DETALLE, UM, PB',
'UNION ALL',
'SELECT ORDEN, DETALLE, UM, PB, SUM(CANT_MES1), SUM(CANT_MES2), SUM(CANT_MES3)',
'FROM(',
'SELECT 2 ORDEN, ''EN FILA'' DETALLE, ''Q'' UM, NULL PB,',
'        CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'')  THEN SUM(c001) END CANT_MES1,',
'        CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'')  THEN SUM(c001) END CANT_MES2,',
'        CASE WHEN C009= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')  THEN SUM(c001) END CANT_MES3',
' FROM APEX_collections',
'    WHERE collection_name = ''RSC_ENTREVISTA''',
'    GROUP BY C009)',
'GROUP BY ORDEN, DETALLE, UM, PB',
'UNION ALL',
'SELECT ORDEN, DETALLE, UM, PB, SUM(CANT_MES1), SUM(CANT_MES2), SUM(CANT_MES3)',
'FROM(',
'SELECT 3 ORDEN ,C008 DETALLE, ''Q'' UM, NULL PB, ',
'         CASE  WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'')  THEN SUM(c001) END CANT_MES1,',
'         CASE  WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'')  THEN SUM(c001) END CANT_MES2,',
'         CASE  WHEN C009= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')  THEN SUM(c001) END CANT_MES3',
' FROM APEX_collections',
'WHERE collection_name = ''RSC_ENTREVISTA''',
'GROUP BY C009, C008 )',
'GROUP BY ORDEN, DETALLE, UM, PB',
'UNION ALL',
'SELECT ORDEN, DETALLE, UM, PB, SUM(CANT_MES1), SUM(CANT_MES2), SUM(CANT_MES3)',
'FROM(',
'SELECT 4 ORDEN, ''REFERENCIAS'' DETALLE, ''Q'' UM, NULL PB,',
'   CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'')  THEN SUM(C002) END CANT_MES1,',
'   CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'')  THEN SUM(C002) END CANT_MES2,',
'   CASE WHEN C009= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')  THEN  SUM(C002) END CANT_MES3',
'  FROM APEX_collections',
'    WHERE collection_name = ''RSC_ENTREVISTA''',
'    GROUP BY C009)    ',
' GROUP BY ORDEN, DETALLE, UM, PB',
' UNION ALL',
'SELECT ORDEN, DETALLE, UM, PB, SUM(CANT_MES1), SUM(CANT_MES2), SUM(CANT_MES3)',
'FROM(',
'SELECT 5 ORDEN, ''EN FILA'' DETALLE, ''Q'' UM, NULL PB,',
'   CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'')  THEN SUM(C003) END CANT_MES1,',
'   CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'')  THEN SUM(C003)END CANT_MES2,',
'   CASE WHEN C009= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')  THEN SUM(C003)END CANT_MES3',
'  FROM APEX_collections',
'    WHERE collection_name = ''RSC_ENTREVISTA''',
'    GROUP BY C009)    ',
' GROUP BY ORDEN, DETALLE, UM, PB',
' UNION ALL',
'SELECT ORDEN, DETALLE, UM, PB, SUM(CANT_MES1), SUM(CANT_MES2), SUM(CANT_MES3)',
'FROM(',
'SELECT 6 ORDEN ,C008 DETALLE, ''Q'' UM, NULL PB, ',
'        CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'')  THEN SUM(c003) END CANT_MES1,',
'        CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'')  THEN SUM(c003) END CANT_MES2,',
'        CASE WHEN C009= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')  THEN SUM(c003) END CANT_MES3',
' FROM APEX_collections',
'WHERE collection_name = ''RSC_ENTREVISTA''',
'GROUP BY C009, C008 )',
'GROUP BY ORDEN, DETALLE, UM, PB',
'UNION ALL',
'SELECT ORDEN, DETALLE, UM, PB, SUM(CANT_MES1), SUM(CANT_MES2), SUM(CANT_MES3)',
'FROM(',
'SELECT 7 ORDEN, ''ENTREVISTA DE AREA'' DETALLE, ''Q'' UM, NULL PB,',
'   CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'')  THEN SUM(C004) END CANT_MES1,',
'   CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'')  THEN SUM(C004) END CANT_MES2,',
'   CASE WHEN C009= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')  THEN SUM(C004) END CANT_MES3',
'  FROM APEX_collections',
'    WHERE collection_name = ''RSC_ENTREVISTA''',
'    GROUP BY C009)    ',
' GROUP BY ORDEN, DETALLE, UM, PB',
' UNION ALL',
' SELECT ORDEN, DETALLE, UM, PB, SUM(CANT_MES1), SUM(CANT_MES2), SUM(CANT_MES3)',
'FROM(',
'SELECT 8 ORDEN, ''EN FILA'' DETALLE, ''Q'' UM, NULL PB,',
'        CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'')  THEN SUM(c005) END CANT_MES1,',
'        CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'')  THEN SUM(c005) END CANT_MES2,',
'        CASE WHEN C009= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')  THEN SUM(c005) END CANT_MES3',
' FROM APEX_collections',
'    WHERE collection_name = ''RSC_ENTREVISTA''',
'    GROUP BY C009)',
'GROUP BY ORDEN, DETALLE, UM, PB',
'UNION ALL',
'SELECT ORDEN, DETALLE, UM, PB, SUM(CANT_MES1), SUM(CANT_MES2), SUM(CANT_MES3)',
'FROM(',
'SELECT 9 ORDEN ,C008 DETALLE, ''Q'' UM, NULL PB, ',
'        CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'')  THEN SUM(c005) END CANT_MES1,',
'        CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'')  THEN SUM(c005) END CANT_MES2,',
'        CASE WHEN C009= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')  THEN SUM(c005) END CANT_MES3',
' FROM APEX_collections',
'WHERE collection_name = ''RSC_ENTREVISTA''',
'GROUP BY C009, C008 )',
'GROUP BY ORDEN, DETALLE, UM, PB',
'  UNION ALL',
' SELECT ORDEN, DETALLE, UM, PB, SUM(CANT_MES1), SUM(CANT_MES2), SUM(CANT_MES3)',
'FROM(',
'SELECT 10 ORDEN, ''ENTREVISTA ESPECIAL'' DETALLE, ''Q'' UM, NULL PB,',
'        CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'')  THEN SUM(c006) END CANT_MES1,',
'        CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'')  THEN SUM(c006) END CANT_MES2,',
'        CASE WHEN C009= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')  THEN SUM(c006) END CANT_MES3',
' FROM APEX_collections',
'    WHERE collection_name = ''RSC_ENTREVISTA''',
'    GROUP BY C009)',
'GROUP BY ORDEN, DETALLE, UM, PB',
' UNION ALL',
' SELECT ORDEN, DETALLE, UM, PB, SUM(CANT_MES1), SUM(CANT_MES2), SUM(CANT_MES3)',
'FROM(',
'SELECT 11 ORDEN, ''EN FILA'' DETALLE, ''Q'' UM, NULL PB,',
'        CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'')  THEN SUM(c007) END CANT_MES1,',
'        CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'')  THEN SUM(c007) END CANT_MES2,',
'        CASE WHEN C009= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')  THEN SUM(c007) END CANT_MES3',
' FROM APEX_collections',
'    WHERE collection_name = ''RSC_ENTREVISTA''',
'    GROUP BY C009)',
'GROUP BY ORDEN, DETALLE, UM, PB',
'UNION ALL',
'SELECT ORDEN, DETALLE, UM, PB, SUM(CANT_MES1), SUM(CANT_MES2), SUM(CANT_MES3)',
'FROM(',
'SELECT 12 ORDEN ,C008 DETALLE, ''Q'' UM, NULL PB, ',
'        CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'')  THEN SUM(c007) END CANT_MES1,',
'        CASE WHEN C009= TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'')  THEN SUM(c007) END CANT_MES2,',
'        CASE WHEN C009= TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'')  THEN SUM(c007) END CANT_MES3',
' FROM APEX_collections',
'WHERE collection_name = ''RSC_ENTREVISTA''',
'GROUP BY C009, C008 )',
'GROUP BY ORDEN, DETALLE, UM, PB)',
'UNION ALL',
' SELECT 0 ORDEN, ''INDICADOR DE PROCESO DE R,S & C'' DETALLE, NULL UM, NULL PB, ',
'TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -2),''MM/YYYY'') CANT_MES1,',
'TO_CHAR(ADD_MONTHS((:P3528_FECHA_HASTA), -1),''MM/YYYY'')  CANT_MES2,',
'TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'') CANT_MES3, NULL',
' FROM DUAL ',
'ORDER BY ORDEN, DETALLE'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_MES_3,P3528_MES_2,P3528_MES_1'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11100653964364405926)
,p_max_row_count=>'1000000'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>81353526223869450
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11099927531017925275)
,p_db_column_name=>'ORDEN'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_static_id=>'chico'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11099927461980925274)
,p_db_column_name=>'DETALLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Detalle'
,p_column_html_expression=>'<span #CSS_STYLE#>#DETALLE#</span>'
,p_column_type=>'STRING'
,p_static_id=>'chico'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11099927334214925273)
,p_db_column_name=>'UM'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Um'
,p_column_html_expression=>'<span #CSS_STYLE#>#UM#</span>'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'chico'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11099927200239925272)
,p_db_column_name=>'PB'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Pb'
,p_column_html_expression=>'<span #CSS_STYLE#>#PB#</span>'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'chico'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11099925701138925257)
,p_db_column_name=>'CSS_STYLE'
,p_display_order=>80
,p_column_identifier=>'S'
,p_column_label=>'Css Style'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
,p_static_id=>'chico'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11099925612534925256)
,p_db_column_name=>'MES1'
,p_display_order=>90
,p_column_identifier=>'T'
,p_column_label=>'Mes'
,p_column_link=>'f?p=&APP_ID.:2255:&SESSION.::&DEBUG.:RP:P2255_FECHA,P2255_MES,P2255_OPCION:&P3528_FECHA_HASTA.,1,#ORDEN#'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'chico'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11099925585310925255)
,p_db_column_name=>'MES2'
,p_display_order=>100
,p_column_identifier=>'U'
,p_column_label=>'Mes'
,p_column_link=>'f?p=&APP_ID.:2255:&SESSION.::&DEBUG.:RP:P2255_FECHA,P2255_MES,P2255_OPCION:&P3528_FECHA_HASTA.,2,#ORDEN#'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'chico'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11099925390790925254)
,p_db_column_name=>'MES3'
,p_display_order=>110
,p_column_identifier=>'V'
,p_column_label=>'Mes'
,p_column_link=>'f?p=&APP_ID.:2255:&SESSION.::&DEBUG.:RP:P2255_FECHA,P2255_MES,P2255_OPCION:&P3528_FECHA_HASTA.,3,#ORDEN#'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'chico'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11099916690496922664)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'820909'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DETALLE:UM:MES1:MES2:MES3:'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11070953644757316326)
,p_report_id=>wwv_flow_api.id(11099916690496922664)
,p_name=>'REFERENCIAS'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'REFERENCIAS'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''REFERENCIAS''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11070954075056316327)
,p_report_id=>wwv_flow_api.id(11099916690496922664)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'INDICADOR DE PROCESO DE R,S & C'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR DE PROCESO DE R,S & C''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99FF99'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11070954414885316329)
,p_report_id=>wwv_flow_api.id(11099916690496922664)
,p_name=>'ENTREVISTA ESPECIA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'ENTREVISTA ESPECIAL'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''ENTREVISTA ESPECIAL''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11070954812776316330)
,p_report_id=>wwv_flow_api.id(11099916690496922664)
,p_name=>'ENTREVISTA DE AREA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'ENTREVISTA DE AREA'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''ENTREVISTA DE AREA''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11070955283527316331)
,p_report_id=>wwv_flow_api.id(11099916690496922664)
,p_name=>'EN FILA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'EN FILA'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''EN FILA''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11070955667378316333)
,p_report_id=>wwv_flow_api.id(11099916690496922664)
,p_name=>'1RA ENTREVISTA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DETALLE'
,p_operator=>'='
,p_expr=>'1RA. ENTREVISTA'
,p_condition_sql=>' (case when ("DETALLE" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''1RA. ENTREVISTA''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#99CCFF'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096211012115776685)
,p_plug_name=>'INDUCCION'
,p_parent_plug_id=>wwv_flow_api.id(11095207373900361172)
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>80
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096328186764544273)
,p_plug_name=>'TABLA11'
,p_region_name=>'chico'
,p_parent_plug_id=>wwv_flow_api.id(11096211012115776685)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT EMPL_LEGAJO LEGAJO,',
'       EMPL_NOMBRE||'' ''||EMPL_APE EMPLEADO,',
'       EMPL_FEC_INGRESO FECHA_INGRESO,',
'       EMPL_SUCURSAL||'' - ''||SUC_DESC SUCURSAL,',
'       EMPL_CARGO||'' - ''||C.CAR_DESC CARGO,',
'       ''NO'' INDUCCION,',
'       EMPL_TIPO_CONT TIPO_CONTRATO, ',
'       EMPL_CONTRATADO_POR CONTRATADO_POR',
'  FROM PER_EMPLEADO, GEN_SUCURSAL B, PER_CARGO C',
' WHERE EMPL_SUCURSAL = SUC_CODIGO',
'   AND EMPL_EMPRESA = SUC_EMPR',
'   AND EMPL_CARGO = C.CAR_CODIGO',
'   AND EMPL_EMPRESA = C.CAR_EMPR',
'   AND EMPL_EMPRESA = :P_EMPRESA',
'   AND EMPL_FEC_INGRESO >= trunc(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA,''DD/MM/YYYY''), -4), ''MM'')',
'   AND EMPL_MAR_INDUCC = ''N''',
'   AND EMPL_SITUACION = ''A''',
'   AND EMPL_TIPO_CONT <> ''T'''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11096328328771544274)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'Sin resultados'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>55123690752293134
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096329170264544283)
,p_db_column_name=>'LEGAJO'
,p_display_order=>10
,p_column_identifier=>'I'
,p_column_label=>'Legajo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096329305171544284)
,p_db_column_name=>'EMPLEADO'
,p_display_order=>20
,p_column_identifier=>'J'
,p_column_label=>'Empleado'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096329427912544285)
,p_db_column_name=>'FECHA_INGRESO'
,p_display_order=>30
,p_column_identifier=>'K'
,p_column_label=>'Fecha Ingreso'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096329532401544286)
,p_db_column_name=>'SUCURSAL'
,p_display_order=>40
,p_column_identifier=>'L'
,p_column_label=>'Sucursal'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096329628747544287)
,p_db_column_name=>'CARGO'
,p_display_order=>50
,p_column_identifier=>'M'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096329670127544288)
,p_db_column_name=>'INDUCCION'
,p_display_order=>60
,p_column_identifier=>'N'
,p_column_label=>'Induccion'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096329774183544289)
,p_db_column_name=>'TIPO_CONTRATO'
,p_display_order=>70
,p_column_identifier=>'O'
,p_column_label=>'Tipo Contrato'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096329855178544290)
,p_db_column_name=>'CONTRATADO_POR'
,p_display_order=>80
,p_column_identifier=>'P'
,p_column_label=>'Contratado Por'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11096386477307054347)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'551819'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'LEGAJO:EMPLEADO:FECHA_INGRESO:SUCURSAL:CARGO:INDUCCION:TIPO_CONTRATO:CONTRATADO_POR:'
,p_sort_column_1=>'FECHA_INGRESO'
,p_sort_direction_1=>'DESC'
,p_break_on=>'CARGO'
,p_break_enabled_on=>'CARGO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096397677699067742)
,p_plug_name=>'CONTRATACIONES'
,p_parent_plug_id=>wwv_flow_api.id(11095207373900361172)
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>90
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096397788027067743)
,p_plug_name=>'GRAFICO12'
,p_parent_plug_id=>wwv_flow_api.id(11096397677699067742)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>5
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ''a-  PB'' MES_ANHO, ((TO_NUMBER(NVL(C003,0))/DECODE((TO_NUMBER(NVL(C001,0))+TO_NUMBER(NVL(C002,0))),0,1,(TO_NUMBER(NVL(C001,0))+TO_NUMBER(NVL(C002,0)))))) CONT',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATA_ANHO''',
'UNION ALL',
'SELECT ''b-  ''||MES1, MES_TOT1',
'FROM',
'(SELECT C001 MES1',
'FROM APEX_collections',
'WHERE collection_name = ''CONTR_MES'')A,',
'(SELECT ((SUM(C007)/DECODE((SUM(C007)+SUM(C010)+SUM(C014)),0,1,(SUM(C007)+SUM(C010)+SUM(C014))))) MES_TOT1',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATACIONES'')B ',
'UNION ALL',
'SELECT ''c-  ''||MES2, MES_TOT2',
'FROM',
'(SELECT C002 MES2',
'FROM APEX_collections',
'WHERE collection_name = ''CONTR_MES'')A,',
'(SELECT ((SUM(C008)/DECODE((SUM(C008)+SUM(C011)+SUM(C015)),0,1,(SUM(C008)+SUM(C011)+SUM(C015))))) MES_TOT2',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATACIONES'')B   ',
'UNION ALL',
'SELECT ''d-  ''||MES3, MES_TOT3',
'FROM',
'(SELECT C003 MES3',
'FROM APEX_collections',
'WHERE collection_name = ''CONTR_MES'')A,',
'(SELECT ((SUM(C008)/DECODE((SUM(C008)+SUM(C011)+SUM(C015)),0,1,(SUM(C008)+SUM(C011)+SUM(C015))))*100) MES_TOT2, ROUND((SUM(nvl(C009,0))/DECODE((SUM(nvl(C009,0))+SUM(nvl(C012,0))+SUM(nvl(C016,0))),0,1,(SUM(nvl(C009,0))+SUM(nvl(C012,0))+SUM(nvl(C016,0)'
||')))),2) MES_TOT3',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATACIONES'')B ',
'UNION ALL',
'SELECT ''e-  OBJETIVO'',1 FROM DUAL',
''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11096472263849425745)
,p_region_id=>wwv_flow_api.id(11096397788027067743)
,p_chart_type=>'combo'
,p_title=>'CONTRATACIONES CH'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_legend_font_family=>'Arial Black'
,p_legend_font_style=>'normal'
,p_legend_font_size=>'10'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11096472402161425746)
,p_chart_id=>wwv_flow_api.id(11096472263849425745)
,p_seq=>10
,p_name=>'CONTRATACIONES CH'
,p_location=>'REGION_SOURCE'
,p_series_type=>'bar'
,p_items_value_column_name=>'CONT'
,p_items_label_column_name=>'MES_ANHO'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
end;
/
begin
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11096473379774425756)
,p_chart_id=>wwv_flow_api.id(11096472263849425745)
,p_seq=>30
,p_name=>'OBJETIVO'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ''a-  PB'' MES_ANHO, 1 OBJETIVO',
' FROM DUAL',
'UNION ALL',
'SELECT ''b-  ''||C001 MES1, 1 OBJE',
'FROM APEX_collections',
'WHERE collection_name = ''CONTR_MES''',
'UNION ALL',
'SELECT ''c-  ''||C002 MES2, 1 OBJE',
'FROM APEX_collections',
'WHERE collection_name = ''CONTR_MES''',
'UNION ALL',
'SELECT ''d-  ''||C003 MES3, 1 OBJE',
'FROM APEX_collections',
'WHERE collection_name = ''CONTR_MES''',
'UNION ALL',
'SELECT ''e-  OBJETIVO'' MES_ANHO, 1 OBJETIVO',
' FROM DUAL'))
,p_series_type=>'line'
,p_items_value_column_name=>'OBJETIVO'
,p_items_label_column_name=>'MES_ANHO'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11096473620764425758)
,p_chart_id=>wwv_flow_api.id(11096472263849425745)
,p_seq=>40
,p_name=>'PB '
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ''a-  PB'' MES_ANHO, ((TO_NUMBER(NVL(C003,0))/decode(TO_NUMBER(NVL(C001,0))+TO_NUMBER(NVL(C002,0)),0,1,TO_NUMBER(NVL(C001,0))+TO_NUMBER(NVL(C002,0))) )) CONT',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATA_ANHO''',
'UNION ALL',
'SELECT ''b-  ''||MES1, CONT',
'FROM',
'(SELECT C001 MES1',
'FROM APEX_collections',
'WHERE collection_name = ''CONTR_MES'')A,',
'(SELECT ((TO_NUMBER(NVL(C003,0))/ DECODE (TO_NUMBER(NVL(C001,0))+TO_NUMBER(NVL(C002,0)),0,1,TO_NUMBER(NVL(C001,0))+TO_NUMBER(NVL(C002,0)) ) )) CONT',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATA_ANHO'')B ',
'UNION ALL',
'SELECT ''c-  ''||MES2, CONT',
'FROM',
'(SELECT C002 MES2',
'FROM APEX_collections',
'WHERE collection_name = ''CONTR_MES'')A,',
'(SELECT ((TO_NUMBER(NVL(C003,0))/ DECODE (TO_NUMBER(NVL(C001,0))+TO_NUMBER(NVL(C002,0)),0,1,TO_NUMBER(NVL(C001,0))+TO_NUMBER(NVL(C002,0)) ) )) CONT',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATA_ANHO'')B ',
'UNION ALL',
'SELECT ''d-  ''||MES3, CONT',
'FROM',
'(SELECT C003 MES3',
'FROM APEX_collections',
'WHERE collection_name = ''CONTR_MES'')A,',
'(SELECT ((TO_NUMBER(NVL(C003,0))/ DECODE (TO_NUMBER(NVL(C001,0))+TO_NUMBER(NVL(C002,0)),0,1,TO_NUMBER(NVL(C001,0))+TO_NUMBER(NVL(C002,0)) ) )) CONT',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATA_ANHO'')B ',
'UNION ALL',
'SELECT ''e-  OBJETIVO'' MES_ANHO, ((TO_NUMBER(NVL(C003,0))/ DECODE(TO_NUMBER(NVL(C001,0))+TO_NUMBER(NVL(C002,0)),0,1,TO_NUMBER(NVL(C001,0))+TO_NUMBER(NVL(C002,0)) )  )) CONT',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATA_ANHO'''))
,p_series_type=>'line'
,p_items_value_column_name=>'CONT'
,p_items_label_column_name=>'MES_ANHO'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11096472527590425747)
,p_chart_id=>wwv_flow_api.id(11096472263849425745)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title_font_family=>'Arial'
,p_title_font_style=>'normal'
,p_title_font_size=>'12'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'10'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11096472611509425748)
,p_chart_id=>wwv_flow_api.id(11096472263849425745)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'percent'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_font_family=>'Arial'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'10'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096399929727067764)
,p_plug_name=>'TABLA12'
,p_parent_plug_id=>wwv_flow_api.id(11096397677699067742)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>6
,p_plug_display_column=>2
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 0 ORDEN, ''INDICADOR'' DESCRIPCION, ''UM'' UM, ''PB'' PB, ''TEMPORAL'' TEN, C001, C002, C003',
'FROM APEX_collections',
'WHERE collection_name = ''CONTR_MES''',
'UNION ALL',
'SELECT A.ORDEN, ',
'    DESCRIPCION, ',
'    DECODE (A.ORDEN,7,''%'',''Q'') UM,',
'    CASE ',
'    WHEN A.ORDEN <> 7 THEN TO_CHAR(INDE) ',
'    ELSE INDE||'' %''',
'    END ANHO,',
'   CASE WHEN A.ORDEN = 3 THEN',
'   (SELECT TO_CHAR(COUNT(*))',
'        FROM PER_EMPLEADO',
'        WHERE  EMPL_TIPO_CONT = ''T''',
'        AND EMPL_EMPRESA = 1',
'        AND EMPL_FEC_INGRESO <= ADD_MONTHS(SYSDATE,-2) ) ',
'    END TEN,',
'    CASE ',
'    WHEN A.ORDEN <> 7 THEN',
'    TO_CHAR(MES1)',
'    ELSE',
'    MES1||'' %''',
'    END MES1,',
'    CASE ',
'    WHEN A.ORDEN <> 7 THEN',
'    TO_CHAR(MES2)',
'    ELSE',
'    MES2||'' %''',
'    END MES2,',
'    CASE ',
'    WHEN A.ORDEN <> 7 THEN',
'    TO_CHAR(MES3)',
'    ELSE',
'    MES3||'' %''',
'    END MES3',
'FROM',
'(SELECT 1 ORDEN, TO_NUMBER(C005) INDE',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATA_ANHO''',
'UNION ALL',
'SELECT 2 ORDEN, TO_NUMBER(C001) INDE',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATA_ANHO''',
'UNION ALL',
'SELECT 3 ORDEN, TO_NUMBER(C002) TEMPORAL',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATA_ANHO''',
'UNION ALL',
'SELECT 4 ORDEN, TO_NUMBER(C003) TEMPORAL',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATA_ANHO''',
'UNION ALL',
'SELECT 5 ORDEN, TO_NUMBER(C004) TEMPORAL',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATA_ANHO''',
' UNION ALL',
'SELECT 6 ORDEN, 0 TEMPORAL',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATA_ANHO''',
'UNION ALL',
'SELECT 7 ORDEN, TRUNC((TO_NUMBER(C003)/DECODE(TO_NUMBER (nvl(C001,0))+TO_NUMBER(nvl(C002,1)),0,1,TO_NUMBER (nvl(C001,0))+TO_NUMBER(nvl(C002,1))))*100) TEMPORAL',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATA_ANHO'')A,',
'(SELECT 1 ORDEN,''CONTRATACION TOTALES'' DESCRIPCION, SUM(C001)+ SUM(C004) MES1, SUM(C002)+SUM(C005) MES2, SUM(C003)+SUM(C006) MES3',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATACIONES''',
'UNION ALL',
'SELECT 2 ORDEN, ''CONTRATACIONES TIEMPO INDEFINIDO'' DESCRIPCION, SUM(C001) MES1, SUM(C002) MES2, SUM(C003) MES3',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATACIONES''',
' UNION ALL',
' SELECT 3 ORDEN, ''CONTRATACIONES TEMPORALES'' DESCIPCION,SUM(C004) MES1, SUM(C005) MES2, SUM(C006) MES3',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATACIONES''',
' UNION ALL',
' SELECT 4 ORDEN, ''CONTRATACIONES CH'' DESCIPCION,SUM(C007) MES1, SUM(C008) MES2, SUM(C009) MES3',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATACIONES''',
'UNION ALL',
' SELECT 5 ORDEN,''CONTRATACIONES FUERA DE POLITICA'' DESCIPCION,SUM(C010) MES1, SUM(C011) MES2, SUM(C012) MES3',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATACIONES''',
'UNION ALL',
'  SELECT 6 ORDEN,''RE-CONTRATACION'' DESCIPCION,SUM(C014) MES1, SUM(C015) MES2, SUM(C016) MES3',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATACIONES''',
' UNION all',
' SELECT 7 ORDEN, ''% CONTRATACIONES CH'' DESCIPCION, ROUND((SUM(nvl(C007,0))/DECODE((SUM(nvl(C007,0))+SUM(nvl(C010,0))+SUM(nvl(C014,0))),0,1,(SUM(nvl(C007,0))+SUM(nvl(C010,0))+SUM(nvl(C014,0)))))*100) MES1,',
'                                                   ROUND((SUM(nvl(C008,0))/DECODE((SUM(nvl(C008,0))+SUM(nvl(C011,0))+SUM(nvl(C015,0))),0,1,(SUM(nvl(C008,0))+SUM(nvl(C011,0))+SUM(nvl(C015,0)))))*100) MES2, ',
'                                                   ROUND((SUM(nvl(C009,0))/DECODE((SUM(nvl(C009,0))+SUM(nvl(C012,0))+SUM(nvl(C016,0))),0,1,(SUM(nvl(C009,0))+SUM(nvl(C012,0))+SUM(nvl(C016,0)))))*100) MES3',
' FROM APEX_collections',
'WHERE collection_name = ''CONTRATACIONES'')B     ',
'WHERE A.ORDEN = B.ORDEN',
'ORDER BY 1',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11096400130459067766)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>55195492439816626
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096400950903067775)
,p_db_column_name=>'ORDEN'
,p_display_order=>30
,p_column_identifier=>'I'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096401236097067777)
,p_db_column_name=>'DESCRIPCION'
,p_display_order=>40
,p_column_identifier=>'J'
,p_column_label=>'DESCRIPCION'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096402025028067785)
,p_db_column_name=>'UM'
,p_display_order=>50
,p_column_identifier=>'R'
,p_column_label=>'UM'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096402118251067786)
,p_db_column_name=>'PB'
,p_display_order=>60
,p_column_identifier=>'S'
,p_column_label=>'PB'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096402183096067787)
,p_db_column_name=>'C001'
,p_display_order=>70
,p_column_identifier=>'T'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2256:&SESSION.::&DEBUG.:RP:P2256_FECHA,P2256_MES,P2256_ORDEN,P2256_OPCION:&P3528_FECHA_HASTA.,1,#ORDEN#,1'
,p_column_linktext=>'#C001#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096402286506067788)
,p_db_column_name=>'C002'
,p_display_order=>80
,p_column_identifier=>'U'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2256:&SESSION.::&DEBUG.:RP:P2256_FECHA,P2256_MES,P2256_ORDEN,P2256_OPCION:&P3528_FECHA_HASTA.,2,#ORDEN#,1'
,p_column_linktext=>'#C002#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096402405964067789)
,p_db_column_name=>'C003'
,p_display_order=>90
,p_column_identifier=>'V'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2256:&SESSION.::&DEBUG.:RP:P2256_FECHA,P2256_MES,P2256_ORDEN,P2256_OPCION:&P3528_FECHA_HASTA.,3,#ORDEN#,1'
,p_column_linktext=>'#C003#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11071911434247668863)
,p_db_column_name=>'TEN'
,p_display_order=>100
,p_column_identifier=>'W'
,p_column_label=>'Ten'
,p_column_link=>'f?p=&APP_ID.:2256:&SESSION.::&DEBUG.:RP:P2256_OPCION:2'
,p_column_linktext=>'#TEN#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11096441077301083990)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'552365'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DESCRIPCION:UM:PB:TEN:C001:C002:C003:'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016742974999627915)
,p_report_id=>wwv_flow_api.id(11096441077301083990)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'INDICADOR'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016743331123627916)
,p_report_id=>wwv_flow_api.id(11096441077301083990)
,p_name=>'CONTRATACIONES INDEFINISO'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'CONTRATACIONES INDEFINIDOS'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''CONTRATACIONES INDEFINIDOS''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016743755433627916)
,p_report_id=>wwv_flow_api.id(11096441077301083990)
,p_name=>'CONT'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'CONTRATACION TOTALES'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''CONTRATACION TOTALES''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096472818258425750)
,p_plug_name=>'CONTA_MES'
,p_parent_plug_id=>wwv_flow_api.id(11096397677699067742)
,p_region_template_options=>'t-Region--showIcon:t-Region--removeHeader:t-Region--hiddenOverflow:t-Form--slimPadding'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>40
,p_plug_grid_column_span=>9
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT C009 EMPLEADO,',
'       c001 FECHA_INGRESO,',
'       C011 CARGO,',
'       C012 SUCURSAL,',
'       c002 TIPO_CONTRATO,',
'       c004 CONTRATADO_POR,',
'       C006 MES_ANHO,',
'       C005 TIPO_CONT,',
'       TO_CHAR(TO_DATE(C001,''DD/MM/YYYY''),''IW'') SEMANA',
'  FROM APEX_collections',
' WHERE collection_name = ''TAB_CONTRATACIONES''',
'  AND TO_CHAR(TO_DATE(C001,''DD/MM/YYYY''), ''MM/YYYY'') = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA), ''MM/YYYY'')',
'  AND TO_DATE(C001,''DD/MM/YYYY'') <= :P3528_FECHA_HASTA',
'  AND TO_CHAR(TO_DATE(C001,''DD/MM/YYYY''), ''IW/YYYY'')<>TO_CHAR(TO_DATE(:P3528_FECHA_HASTA), ''IW/YYYY'')'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11096472906840425751)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'''NO SE REGISTRARON CONTRATACIONES EN EL MES'''
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>55268268821174611
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096473847595425761)
,p_db_column_name=>'EMPLEADO'
,p_display_order=>20
,p_column_identifier=>'F'
,p_column_label=>'Empleado'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096474316886425765)
,p_db_column_name=>'TIPO_CONTRATO'
,p_display_order=>60
,p_column_identifier=>'J'
,p_column_label=>'Tipo Contrato'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11097648741583523083)
,p_db_column_name=>'SEMANA'
,p_display_order=>90
,p_column_identifier=>'M'
,p_column_label=>'Semana'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11100658160702405968)
,p_db_column_name=>'TIPO_CONT'
,p_display_order=>140
,p_column_identifier=>'R'
,p_column_label=>'Tipo Cont'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11063354987976542252)
,p_db_column_name=>'FECHA_INGRESO'
,p_display_order=>150
,p_column_identifier=>'S'
,p_column_label=>'Fecha Ingreso'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11063354830596542251)
,p_db_column_name=>'CARGO'
,p_display_order=>160
,p_column_identifier=>'T'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_rpt_named_lov=>wwv_flow_api.id(11111334981019860881)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11063354785460542250)
,p_db_column_name=>'SUCURSAL'
,p_display_order=>170
,p_column_identifier=>'U'
,p_column_label=>'Sucursal'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_rpt_named_lov=>wwv_flow_api.id(11099036932838026445)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11063354677264542249)
,p_db_column_name=>'CONTRATADO_POR'
,p_display_order=>180
,p_column_identifier=>'V'
,p_column_label=>'Contratado Por'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11063354512011542248)
,p_db_column_name=>'MES_ANHO'
,p_display_order=>190
,p_column_identifier=>'W'
,p_column_label=>'Mes Anho'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11096491235065514673)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'552866'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPLEADO:FECHA_INGRESO:SUCURSAL:CARGO:TIPO_CONTRATO:CONTRATADO_POR:SEMANA:'
,p_sort_column_1=>'SEMANA'
,p_sort_direction_1=>'DESC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096474647920425769)
,p_plug_name=>'CONT_SEMANA'
,p_parent_plug_id=>wwv_flow_api.id(11096397677699067742)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>50
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT C009 EMPLEADO,',
'       c001 FECHA_INGRESO,',
'       C011 CARGO,',
'       C012 SUCURSAL,',
'       c002 TIPO_CONTRATO,',
'       c004 CONTRATADO_POR,',
'       C006 MES_ANHO,',
'       C005 TIPO_CONT,',
'       TO_CHAR(TO_DATE(C001,''DD/MM/YYYY''),''IW'') SEMANA',
'  FROM APEX_collections',
' WHERE collection_name = ''TAB_CONTRATACIONES''',
'  AND TO_CHAR(TO_DATE(C001,''DD/MM/YYYY''), ''MM/YYYY'') = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA), ''MM/YYYY'')',
'  AND TO_DATE(C001,''DD/MM/YYYY'') <= :P3528_FECHA_HASTA',
'  AND TO_CHAR(TO_DATE(C001,''DD/MM/YYYY''), ''IW/YYYY'')=TO_CHAR(TO_DATE(:P3528_FECHA_HASTA), ''IW/YYYY'')'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11096474852537425771)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'''NO SE REGISTRARON CONTRATACIONES EN LA SEMANA'''
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>55270214518174631
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096475039780425773)
,p_db_column_name=>'EMPLEADO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empleado'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096475475262425777)
,p_db_column_name=>'TIPO_CONTRATO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Tipo Contrato'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11097648731351523082)
,p_db_column_name=>'SEMANA'
,p_display_order=>90
,p_column_identifier=>'J'
,p_column_label=>'Semana'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11100657679905405963)
,p_db_column_name=>'TIPO_CONT'
,p_display_order=>140
,p_column_identifier=>'O'
,p_column_label=>'Tipo Cont'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11063354418499542247)
,p_db_column_name=>'FECHA_INGRESO'
,p_display_order=>150
,p_column_identifier=>'P'
,p_column_label=>'Fecha Ingreso'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11063354304626542246)
,p_db_column_name=>'CARGO'
,p_display_order=>160
,p_column_identifier=>'Q'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_static_id=>'CHICO'
,p_rpt_named_lov=>wwv_flow_api.id(11111334981019860881)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11063354251188542245)
,p_db_column_name=>'SUCURSAL'
,p_display_order=>170
,p_column_identifier=>'R'
,p_column_label=>'Sucursal'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_static_id=>'CHICO'
,p_rpt_named_lov=>wwv_flow_api.id(11099036932838026445)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11063354126282542244)
,p_db_column_name=>'CONTRATADO_POR'
,p_display_order=>180
,p_column_identifier=>'S'
,p_column_label=>'Contratado Por'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11063354055075542243)
,p_db_column_name=>'MES_ANHO'
,p_display_order=>190
,p_column_identifier=>'T'
,p_column_label=>'Mes Anho'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11096518014134848496)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'553134'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPLEADO:FECHA_INGRESO:SUCURSAL:CARGO:TIPO_CONTRATO:CONTRATADO_POR:SEMANA:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096475841536425781)
,p_plug_name=>unistr('DESVINCULACI\00D3N')
,p_parent_plug_id=>wwv_flow_api.id(11095207373900361172)
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>100
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11060915977334426969)
,p_plug_name=>'DESVINC_MES'
,p_parent_plug_id=>wwv_flow_api.id(11096475841536425781)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' SELECT C001 LEGAJO, C002 EMPLEADO, C004 FECHA_SALIDA, C005 SUCURSAL , C006 DEPARTAMENTO, C007 CARGO, C012 MOTIVO_SALIDA,C009 FACTOR_dESVINCULACION, C014 MES, C020 SEMANA',
'FROM APEX_collections',
'WHERE collection_name = ''DESVINC_SALARIO''',
'  AND C014 = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA), ''MM/YYYY'')',
'  AND c019<>TO_CHAR(TO_DATE(:P3528_FECHA_HASTA), ''IW/YYYY'')',
' -- AND c018 = ''I'' ',
'GROUP BY  C001, C002, C005, C006, C007, C004, C012,C009, C014, C020',
'/*SELECT EMPL_LEGAJO LEGAJO,',
'       EMPL_NOMBRE || '' '' || EMPL_APE EMPLEADO,',
'       EMPL_FEC_SALIDA FECHA_SALIDA,',
'       EMPL_SUCURSAL || '' - '' || SUC_DESC SUCURSAL,',
'       EMPL_MOTIVO_SALIDA,',
'       FACDES_DESC,',
'       TO_CHAR(EMPL_FEC_SALIDA, ''IW'') SEMANA,',
'       TO_CHAR(EMPL_FEC_SALIDA, ''MM/YYYY'') MES,',
'       TO_CHAR(EMPL_FEC_SALIDA, ''YYYY'') ANHO,',
'       EMPL_DEPARTAMENTO,',
'       EMPL_CARGO',
'  FROM PER_EMPLEADO, GEN_SUCURSAL B, PER_FACTOR_DESVINCULACION',
' WHERE EMPL_SUCURSAL = SUC_CODIGO(+)',
'   AND EMPL_EMPRESA = SUC_EMPR(+)',
'   AND EMPL_FAC_DESV = FACDES_CLAVE(+)',
'   AND EMPL_EMPRESA = FACDES_EMPR(+)',
'   AND EMPL_EMPRESA = :P_EMPRESA',
'   AND EMPL_SITUACION = ''I''',
'   AND EMPL_TIPO_CONT <> ''T''',
'   AND TO_CHAR(EMPL_FEC_SALIDA, ''MM/YYYY'') =',
'       TO_CHAR(TO_DATE(:P3528_FECHA_HASTA), ''MM/YYYY'')',
'  AND EMPL_FEC_SALIDA <= :P3528_FECHA_HASTA',
'  AND TO_NUMBER(TO_CHAR(EMPL_FEC_SALIDA,''IW''))||TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''YYYY'') NOT IN (SELECT  to_number(C001)||TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''YYYY'') SEMANA',
'                                         FROM APEX_collections',
'                                         WHERE collection_name = ''GRAF_SEMANA''',
'                                          AND C003 = ''1'')*/',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11060915850739426968)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>147570537622163116
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060915732330426967)
,p_db_column_name=>'LEGAJO'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Legajo'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060915619064426966)
,p_db_column_name=>'EMPLEADO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empleado'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060915541595426965)
,p_db_column_name=>'FECHA_SALIDA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Fecha Salida'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060915483281426964)
,p_db_column_name=>'SUCURSAL'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Sucursal'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_static_id=>'CHICO'
,p_rpt_named_lov=>wwv_flow_api.id(11099036932838026445)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060915358308426963)
,p_db_column_name=>'DEPARTAMENTO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Departamento'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_static_id=>'CHICO'
,p_rpt_named_lov=>wwv_flow_api.id(11109078651735878042)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060915252257426962)
,p_db_column_name=>'CARGO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_static_id=>'CHICO'
,p_rpt_named_lov=>wwv_flow_api.id(11111334981019860881)
,p_rpt_show_filter_lov=>'1'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060915169629426961)
,p_db_column_name=>'MOTIVO_SALIDA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Motivo Salida'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060915021087426960)
,p_db_column_name=>'FACTOR_DESVINCULACION'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Factor Desvinculacion'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060914973825426959)
,p_db_column_name=>'MES'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Mes'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11060914847221426958)
,p_db_column_name=>'SEMANA'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Semana'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11060813555343358276)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1476729'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'LEGAJO:EMPLEADO:FECHA_SALIDA:SUCURSAL:DEPARTAMENTO:CARGO:MOTIVO_SALIDA:FACTOR_DESVINCULACION:MES:SEMANA'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096522305430908949)
,p_plug_name=>'DESVINC_SEMANA'
,p_parent_plug_id=>wwv_flow_api.id(11096475841536425781)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' SELECT C001 LEGAJO, C002 EMPLEADO, C004 FECHA_SALIDA, C005 SUCURSAL , C006 DEPARTAMENTO, C007 CARGO, C012 MOTIVO_SALIDA,C009 FACTOR_dESVINCULACION, C014 MES, C020 SEMANA',
'FROM APEX_collections',
'WHERE collection_name = ''DESVINC_SALARIO''',
'  AND C014 = TO_CHAR(TO_DATE(:P3528_FECHA_HASTA), ''MM/YYYY'')',
' --   AND C018 = ''I'' ',
'  AND c019=TO_CHAR(TO_DATE(:P3528_FECHA_HASTA), ''IW/YYYY'')',
'GROUP BY  C001, C002, C005, C006, C007, C004, C012,C009, C014, C020',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA, P_EMPRESA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11096522528638908951)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'''NO SE REGISTRARON DESVINCULACIONES EN LA SEMANA'''
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>55317890619657811
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096522718249908953)
,p_db_column_name=>'EMPLEADO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empleado'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096522818534908954)
,p_db_column_name=>'SUCURSAL'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Sucursal'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_static_id=>'CHICO'
,p_rpt_named_lov=>wwv_flow_api.id(11099036932838026445)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096523247018908959)
,p_db_column_name=>'MES'
,p_display_order=>80
,p_column_identifier=>'F'
,p_column_label=>'Mes'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096523496637908961)
,p_db_column_name=>'MOTIVO_SALIDA'
,p_display_order=>100
,p_column_identifier=>'H'
,p_column_label=>'Motivo Salida'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096523605275908962)
,p_db_column_name=>'FACTOR_DESVINCULACION'
,p_display_order=>110
,p_column_identifier=>'I'
,p_column_label=>unistr('Factor Desvinculaci\00F3n')
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11097648609965523081)
,p_db_column_name=>'SEMANA'
,p_display_order=>120
,p_column_identifier=>'J'
,p_column_label=>'Semana'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11063273678802907234)
,p_db_column_name=>'LEGAJO'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Legajo'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11063203444054433683)
,p_db_column_name=>'FECHA_SALIDA'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Fecha Salida'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11063203288805433682)
,p_db_column_name=>'DEPARTAMENTO'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Departamento'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_static_id=>'CHICO'
,p_rpt_named_lov=>wwv_flow_api.id(11109078651735878042)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11063203258097433681)
,p_db_column_name=>'CARGO'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_static_id=>'CHICO'
,p_rpt_named_lov=>wwv_flow_api.id(11103652664708902034)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11096543830584991501)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'553392'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'LEGAJO:EMPLEADO:SUCURSAL:DEPARTAMENTO:CARGO:FECHA_SALIDA:MOTIVO_SALIDA:FACTOR_DESVINCULACION:SEMANA:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096524015670908966)
,p_plug_name=>'TABLA13_DESV'
,p_parent_plug_id=>wwv_flow_api.id(11096475841536425781)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--large'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>6
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ''INDICADOR'' DESCRIPCION,''UM'' UM, ''PB'' PB,C002 mes1, C004 Mes2, C006 mes3, null orden',
' FROM APEX_collections',
' WHERE collection_name = ''DESVINCULACION_MES''',
'GROUP BY C002,C004,C006',
'UNION ALL',
'SELECT ''DESVINCULACION TOTAL'' DESCRIPCION, NULL UM, PB PB,-- TO_CHAR(ANHO_TOT) PB, ',
'MES1, MES2, MES3,3',
'FROM',
'    (SELECT  ',
'     TO_CHAR(sum(NVL(C001, 0)))mes1, TO_CHAR(sum(NVL(C003,0))) Mes2, TO_CHAR(sum(NVL(C005,0))) mes3,  TO_CHAR(sum(NVL(C013,0)))PB',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'       AND DECODE(C008,NULL,''X'',C008) <> ''Judicial'')A,',
'       (SELECT trunc(count(*)/12) ANHO_TOT',
'      FROM CUBO_EMPLEADO_V_DESV',
'     WHERE EMPL_EMPRESA = 1',
'       AND TO_CHAR(EMPL_FEC_SALIDA, ''YYYY'') = ''2017'') B -- 2017',
'UNION ALL',
'SELECT  ''DESVINCULACION CONTRATO INDEFINIDO'' DESCRIPCION,''Q'' UM,   TO_CHAR(sum(NVL(C013, 0))) PB,',
'     TO_CHAR(sum(NVL(C001, 0)))mes1, TO_CHAR(sum(NVL(C003, 0))) Mes2, TO_CHAR(sum(NVL(C005, 0))) mes3,3',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'       AND DECODE(C008,NULL,''X'',C008)<> ''Judicial''',
'       AND C010 =''I''',
'UNION ALL',
'SELECT  ''DESVINCULACIONES CONTRATO TEMPORAL'' DESCRIPCION, NULL UM, TO_CHAR(sum(NVL(C013, 0))) PB,',
'     TO_CHAR(sum(NVL(C001, 0)))mes1, TO_CHAR(sum(NVL(C003, 0))) Mes2, TO_CHAR(sum(NVL(C005, 0))) mes3,3',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'       AND C008<> ''Judicial''',
'       AND C010 =''T''',
'UNION ALL',
'SELECT C008 DESCRIPCION, ''Q'' UM,  TO_CHAR(sum(NVL(C013, 0))) PB,',
'     TO_CHAR(sum(NVL(C001, 0)))mes1, TO_CHAR(sum(NVL(C003, 0))) Mes2, TO_CHAR(sum(NVL(C005, 0))) mes3,3',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'     AND C008 <> ''Judicial''',
'       AND C010 <>''T'' ',
'       GROUP BY C008',
'UNION ALL',
'SELECT C008 DESCRIPCION, ''Q'' UM,  NVL(C013, 0) PB,',
'     NVL(C001, 0) mes1, NVL(C003, 0) Mes2, NVL(C005, 0) mes3,4',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'     AND C008 = ''Judicial''',
'UNION ALL',
'SELECT ''COSTO DE LIQUIDACION FINAL'' DESCRIPCION, ''Gs.'' UM,  TO_CHAR(sum(NVL(C007, 0)),''999G999G999G999G999'') PB,',
'     TO_CHAR(sum(NVL(C001, 0)),''999G999G999G999G999'')mes1, TO_CHAR(sum(NVL(C003, 0)),''999G999G999G999G999'') Mes2, TO_CHAR(sum(NVL(C005, 0)),''999G999G999G999G999'') mes3,5',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MONTO''',
'UNION ALL',
'SELECT ''Prevision Imnder.-Pre Aviso'' DESCRIPCION,',
'       ''Gs.'' UM,',
'       NULL PB,',
'       TO_CHAR(ROUND(SUM(T.PGTO_IMPORTE) / 12),''999G999G999G999G999'') MES1,',
'       TO_CHAR(ROUND(SUM(T.PGTO_IMPORTE) / 12),''999G999G999G999G999'') MES2,',
'       TO_CHAR(ROUND(SUM(T.PGTO_IMPORTE) / 12),''999G999G999G999G999'') MES3,',
'       6 ORDEN',
'  FROM FAC_LONDON_PRES_GASTO_AN_V T',
' WHERE T.PGTO_ANHO = 2022',
'    AND T.pgto_empr = :P_EMPRESA',
'   AND UPPER(T.CTAC_DESC) LIKE ''%INDEM%'''))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11096524078971908967)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>55319440952657827
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096525045356908977)
,p_db_column_name=>'DESCRIPCION'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>unistr('DESCRIPCI\00D3N')
,p_column_type=>'STRING'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096525202795908978)
,p_db_column_name=>'UM'
,p_display_order=>20
,p_column_identifier=>'K'
,p_column_label=>'UM'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096525268974908979)
,p_db_column_name=>'PB'
,p_display_order=>30
,p_column_identifier=>'L'
,p_column_label=>'PB'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096525358386908980)
,p_db_column_name=>'MES1'
,p_display_order=>40
,p_column_identifier=>'M'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2257:&SESSION.::&DEBUG.:CR,2257:P2257_MES,P2257_FECHA,P2257_OPCION,P2257_ORDEN,P2257_INDICADOR_TEXT:1,\&P3528_FECHA_HASTA.\,\#DESCRIPCION#\,\#ORDEN#\,\#DESCRIPCION#\'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096525440148908981)
,p_db_column_name=>'MES2'
,p_display_order=>50
,p_column_identifier=>'N'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2257:&SESSION.::&DEBUG.:CR,2257:P2257_FECHA,P2257_MES,P2257_OPCION,P2257_ORDEN,P2257_INDICADOR_TEXT:\&P3528_FECHA_HASTA.\,\2\,\#DESCRIPCION#\,\#ORDEN#\,\#DESCRIPCION#\'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096525580920908982)
,p_db_column_name=>'MES3'
,p_display_order=>60
,p_column_identifier=>'O'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2257:&SESSION.::&DEBUG.:CR,2257:P2257_FECHA,P2257_MES,P2257_OPCION,P2257_ORDEN,P2257_INDICADOR_TEXT:\&P3528_FECHA_HASTA.\,\3\,\#DESCRIPCION#\,\#ORDEN#\,\#DESCRIPCION#\'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11070985801977601439)
,p_db_column_name=>'ORDEN'
,p_display_order=>70
,p_column_identifier=>'P'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
,p_static_id=>'EDITARR2'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11096738656614400247)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'555341'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DESCRIPCION:UM:PB:MES1:MES2:MES3:ORDEN'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016738430011626661)
,p_report_id=>wwv_flow_api.id(11096738656614400247)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'INDICADOR'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016738876830626661)
,p_report_id=>wwv_flow_api.id(11096738656614400247)
,p_name=>'GRATIFICACIONES'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'GRATIFICACIONES'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''GRATIFICACIONES''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016739242569626662)
,p_report_id=>wwv_flow_api.id(11096738656614400247)
,p_name=>'DESVINCULACION'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'DESVINCULACION TOTAL'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''DESVINCULACION TOTAL''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016739650921626662)
,p_report_id=>wwv_flow_api.id(11096738656614400247)
,p_name=>'DESVINCULACIONES'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'DESVINCULACION INDEFINIDO'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''DESVINCULACION INDEFINIDO''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016740029667626663)
,p_report_id=>wwv_flow_api.id(11096738656614400247)
,p_name=>'MONTO'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'COSTO DE DESPIDO INJUSTIFICADO'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''COSTO DE DESPIDO INJUSTIFICADO''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096525748141908984)
,p_plug_name=>'GRAFICO13_DESV'
,p_parent_plug_id=>wwv_flow_api.id(11096475841536425781)
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>4
,p_plug_display_column=>2
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = A.MES_ANHO)||'' - ''||A.MES_ANHO MES_ANHO, ((nvl(CANT,0)/decode(TOTAL,0,1,TOTAL))) CANT',
'FROM',
'(SELECT C008 DESCRIPCION,C007 MES_ANHO,TO_NUMBER(C009) CANT, SUM(C009) OVER (PARTITION BY C007 ORDER BY C007) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'       AND C008<> ''Judicial''',
'      -- AND C010 <>''T''',
'       GROUP BY C008, C007,C009) A',
'where a.DESCRIPCION  = ''Despido Injustificado''',
'UNION ALL',
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = B.SEM)||''- SEM ''||B.SEM MES_ANHO, ((nvl(CANT,0)/DECODE(TOTAL,0,1,TOTAL))) cant',
'FROM',
' (SELECT C008 DESCRIPCION, C011 SEMANA,TO_NUMBER(C012) CANT,  SUM(C012) OVER (PARTITION BY C011 ORDER BY C011) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'      AND C008<> ''Judicial''',
'     --  AND C010 <>''T''',
'       GROUP BY C008, C012, C011) A,',
'   (SELECT C001 SEM',
'     FROM APEX_collections',
'     WHERE collection_name = ''GRAF_SEMANA'')B',
' WHERE A.SEMANA(+) = SEM ',
'AND a.DESCRIPCION  = ''Despido Injustificado''',
' ',
''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11096799467564722749)
,p_region_id=>wwv_flow_api.id(11096525748141908984)
,p_chart_type=>'bar'
,p_title=>unistr('DISTRIBUCI\00D3N DE CAUSALES DE DESVINCULACI\00D3N')
,p_height=>'500'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'bottom'
,p_legend_font_family=>'Arial Black'
,p_legend_font_style=>'normal'
,p_legend_font_size=>'12'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11014918373638230989)
,p_chart_id=>wwv_flow_api.id(11096799467564722749)
,p_seq=>10
,p_name=>'Des. Justificado'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = A.MES_ANHO)||'' - ''||A.MES_ANHO MES_ANHO, ((nvl(CANT,0)/decode(TOTAL,0,1,TOTAL))) CANT',
'FROM',
'(SELECT C008 DESCRIPCION,C007 MES_ANHO,TO_NUMBER(C009) CANT, SUM(C009) OVER (PARTITION BY C007 ORDER BY C007) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'       AND C008<> ''Judicial''',
'      -- AND C010 <>''T''',
'       GROUP BY C008, C007,C009) A',
'WHERE DESCRIPCION  = ''Despido Justificado''',
'UNION ALL',
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = B.SEM)||''- SEM ''||B.SEM MES_ANHO, ((nvl(CANT,0)/DECODE(TOTAL,0,1,TOTAL))) cant',
'FROM',
' (SELECT C008 DESCRIPCION, C011 SEMANA,TO_NUMBER(C012) CANT,  SUM(C012) OVER (PARTITION BY C011 ORDER BY C011) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'      AND C008<> ''Judicial''',
'     --  AND C010 <>''T''',
'       GROUP BY C008, C012, C011) A,',
'   (SELECT C001 SEM',
'     FROM APEX_collections',
'     WHERE collection_name = ''GRAF_SEMANA'')B',
' WHERE A.SEMANA(+) = SEM ',
'   AND DESCRIPCION  = ''Despido Justificado'''))
,p_series_name_column_name=>'DESCRIPCION'
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'MES_ANHO'
,p_color=>'#FF9500'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11014918415066230990)
,p_chart_id=>wwv_flow_api.id(11096799467564722749)
,p_seq=>20
,p_name=>'Renuncia Voluntaria'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = A.MES_ANHO)||'' - ''||A.MES_ANHO MES_ANHO, ((nvl(CANT,0)/decode(TOTAL,0,1,TOTAL))) CANT',
'FROM',
'(SELECT C008 DESCRIPCION,C007 MES_ANHO,TO_NUMBER(C009) CANT, SUM(C009) OVER (PARTITION BY C007 ORDER BY C007) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'       AND C008<> ''Judicial''',
'      -- AND C010 <>''T''',
'       GROUP BY C008, C007,C009) A',
'WHERE DESCRIPCION  = ''Renuncia Voluntaria''   ',
'UNION ALL',
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = B.SEM)||''- SEM ''||B.SEM MES_ANHO, ((nvl(CANT,0)/DECODE(TOTAL,0,1,TOTAL))) cant',
'FROM',
' (SELECT C008 DESCRIPCION, C011 SEMANA,TO_NUMBER(C012) CANT,  SUM(C012) OVER (PARTITION BY C011 ORDER BY C011) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'      AND C008<> ''Judicial''',
'     --  AND C010 <>''T''',
'       GROUP BY C008, C012, C011) A,',
'   (SELECT C001 SEM',
'     FROM APEX_collections',
'     WHERE collection_name = ''GRAF_SEMANA'')B',
' WHERE A.SEMANA(+) = SEM ',
'   AND DESCRIPCION  = ''Renuncia Voluntaria'''))
,p_series_name_column_name=>'DESCRIPCION'
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'MES_ANHO'
,p_color=>'#3CAF85'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(10893395376051577938)
,p_chart_id=>wwv_flow_api.id(11096799467564722749)
,p_seq=>30
,p_name=>'Termino de Zafra'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = A.MES_ANHO)||'' - ''||A.MES_ANHO MES_ANHO, ((nvl(CANT,0)/decode(TOTAL,0,1,TOTAL))) CANT',
'FROM',
'(SELECT C008 DESCRIPCION,C007 MES_ANHO,TO_NUMBER(C009) CANT, SUM(C009) OVER (PARTITION BY C007 ORDER BY C007) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'       AND C008<> ''Judicial''',
'      -- AND C010 <>''T''',
'       GROUP BY C008, C007,C009) A',
'WHERE DESCRIPCION  =''Termino de Zafra''',
'UNION ALL',
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = B.SEM)||''- SEM ''||B.SEM MES_ANHO, ((nvl(CANT,0)/DECODE(TOTAL,0,1,TOTAL))) cant',
'FROM',
' (SELECT C008 DESCRIPCION, C011 SEMANA,TO_NUMBER(C012) CANT,  SUM(C012) OVER (PARTITION BY C011 ORDER BY C011) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'      AND C008<> ''Judicial''',
'     --  AND C010 <>''T''',
'       GROUP BY C008, C012, C011) A,',
'   (SELECT C001 SEM',
'     FROM APEX_collections',
'     WHERE collection_name = ''GRAF_SEMANA'')B',
' WHERE A.SEMANA(+) = SEM ',
'   AND DESCRIPCION  = ''Termino de Zafra'''))
,p_series_name_column_name=>'DESCRIPCION'
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'MES_ANHO'
,p_color=>'#B2F7C1'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11014918552325230991)
,p_chart_id=>wwv_flow_api.id(11096799467564722749)
,p_seq=>40
,p_name=>'Termino de Contrato'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = A.MES_ANHO)||'' - ''||A.MES_ANHO MES_ANHO, ((nvl(CANT,0)/decode(TOTAL,0,1,TOTAL))) CANT',
'FROM',
'(SELECT C008 DESCRIPCION,C007 MES_ANHO,TO_NUMBER(C009) CANT, SUM(C009) OVER (PARTITION BY C007 ORDER BY C007) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'       AND C008<> ''Judicial''',
'      -- AND C010 <>''T''',
'       GROUP BY C008, C007,C009) A',
'WHERE DESCRIPCION  = ''Termino de Contrato''  ',
'UNION ALL',
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = B.SEM)||''- SEM ''||B.SEM MES_ANHO, ((nvl(CANT,0)/DECODE(TOTAL,0,1,TOTAL))) cant',
'FROM',
' (SELECT C008 DESCRIPCION, C011 SEMANA,TO_NUMBER(C012) CANT,  SUM(C012) OVER (PARTITION BY C011 ORDER BY C011) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'      AND C008<> ''Judicial''',
'     --  AND C010 <>''T''',
'       GROUP BY C008, C012, C011) A,',
'   (SELECT C001 SEM',
'     FROM APEX_collections',
'     WHERE collection_name = ''GRAF_SEMANA'')B',
' WHERE A.SEMANA(+) = SEM ',
'   AND DESCRIPCION  = ''Termino de Contrato'''))
,p_series_name_column_name=>'DESCRIPCION'
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'MES_ANHO'
,p_color=>'#FFCC00'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11014918606575230992)
,p_chart_id=>wwv_flow_api.id(11096799467564722749)
,p_seq=>50
,p_name=>'Jubilacion'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = A.MES_ANHO)||'' - ''||A.MES_ANHO MES_ANHO, ((nvl(CANT,0)/decode(TOTAL,0,1,TOTAL))) CANT',
'FROM',
'(SELECT C008 DESCRIPCION,C007 MES_ANHO,TO_NUMBER(C009) CANT, SUM(C009) OVER (PARTITION BY C007 ORDER BY C007) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'       AND C008<> ''Judicial''',
'      -- AND C010 <>''T''',
'       GROUP BY C008, C007,C009) A',
' WHERE DESCRIPCION  = ''Jubilacion''       ',
'UNION ALL',
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = B.SEM)||''- SEM ''||B.SEM MES_ANHO, ((nvl(CANT,0)/DECODE(TOTAL,0,1,TOTAL))) cant',
'FROM',
' (SELECT C008 DESCRIPCION, C011 SEMANA,TO_NUMBER(C012) CANT,  SUM(C012) OVER (PARTITION BY C011 ORDER BY C011) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'      AND C008<> ''Judicial''',
'     --  AND C010 <>''T''',
'       GROUP BY C008, C012, C011) A,',
'   (SELECT C001 SEM',
'     FROM APEX_collections',
'     WHERE collection_name = ''GRAF_SEMANA'')B',
' WHERE A.SEMANA(+) = SEM ',
'   AND DESCRIPCION  = ''Jubilacion'''))
,p_series_name_column_name=>'DESCRIPCION'
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'MES_ANHO'
,p_color=>'#007AFF'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11014918761521230993)
,p_chart_id=>wwv_flow_api.id(11096799467564722749)
,p_seq=>60
,p_name=>'Por Muerte'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = A.MES_ANHO)||'' - ''||A.MES_ANHO MES_ANHO, ((nvl(CANT,0)/decode(TOTAL,0,1,TOTAL))) CANT',
'FROM',
'(SELECT C008 DESCRIPCION,C007 MES_ANHO,TO_NUMBER(C009) CANT, SUM(C009) OVER (PARTITION BY C007 ORDER BY C007) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'       AND C008<> ''Judicial''',
'      -- AND C010 <>''T''',
'       GROUP BY C008, C007,C009) A',
'WHERE DESCRIPCION  = ''Por Muerte''       ',
'UNION ALL',
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = B.SEM)||''- SEM ''||B.SEM MES_ANHO, ((nvl(CANT,0)/DECODE(TOTAL,0,1,TOTAL))) cant',
'FROM',
' (SELECT C008 DESCRIPCION, C011 SEMANA,TO_NUMBER(C012) CANT,  SUM(C012) OVER (PARTITION BY C011 ORDER BY C011) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'      AND C008<> ''Judicial''',
'     --  AND C010 <>''T''',
'       GROUP BY C008, C012, C011) A,',
'   (SELECT C001 SEM',
'     FROM APEX_collections',
'     WHERE collection_name = ''GRAF_SEMANA'')B',
' WHERE A.SEMANA(+) = SEM ',
'   AND DESCRIPCION  = ''Por Muerte'''))
,p_series_name_column_name=>'DESCRIPCION'
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'MES_ANHO'
,p_color=>'#5856D6'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
end;
/
begin
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11014918872718230994)
,p_chart_id=>wwv_flow_api.id(11096799467564722749)
,p_seq=>70
,p_name=>'Periodo de Prueba'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = A.MES_ANHO)||'' - ''||A.MES_ANHO MES_ANHO, ((nvl(CANT,0)/decode(TOTAL,0,1,TOTAL))) CANT',
'FROM',
'(SELECT C008 DESCRIPCION,C007 MES_ANHO,TO_NUMBER(C009) CANT, SUM(C009) OVER (PARTITION BY C007 ORDER BY C007) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'       AND C008<> ''Judicial''',
'      -- AND C010 <>''T''',
'       GROUP BY C008, C007,C009) A',
'WHERE DESCRIPCION  = ''Periodo de Prueba''      ',
'UNION ALL',
'SELECT DESCRIPCION, (SELECT  S.C002',
'                     FROM APEX_collections S',
'                     WHERE collection_name = ''ORDEN''',
'                     AND S.C003= 1',
'                      AND S.C001 = B.SEM)||''- SEM ''||B.SEM MES_ANHO, ((nvl(CANT,0)/DECODE(TOTAL,0,1,TOTAL))) cant',
'FROM',
' (SELECT C008 DESCRIPCION, C011 SEMANA,TO_NUMBER(C012) CANT,  SUM(C012) OVER (PARTITION BY C011 ORDER BY C011) TOTAL',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVINCULACION_MES''',
'      AND C008<> ''Judicial''',
'     --  AND C010 <>''T''',
'       GROUP BY C008, C012, C011) A,',
'   (SELECT C001 SEM',
'     FROM APEX_collections',
'     WHERE collection_name = ''GRAF_SEMANA'')B',
' WHERE A.SEMANA(+) = SEM ',
'   AND DESCRIPCION  = ''Periodo de Prueba'''))
,p_series_name_column_name=>'DESCRIPCION'
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'MES_ANHO'
,p_color=>'#9CF0DC'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11096799572118722750)
,p_chart_id=>wwv_flow_api.id(11096799467564722749)
,p_seq=>80
,p_name=>'Desp. Injustificado'
,p_location=>'REGION_SOURCE'
,p_series_name_column_name=>'DESCRIPCION'
,p_items_value_column_name=>'CANT'
,p_items_label_column_name=>'MES_ANHO'
,p_color=>'#309FDB'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11096799819127722752)
,p_chart_id=>wwv_flow_api.id(11096799467564722749)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'percent'
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11096799652721722751)
,p_chart_id=>wwv_flow_api.id(11096799467564722749)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_tick_label_font_family=>'Arial Black'
,p_tick_label_font_style=>'normal'
,p_tick_label_font_size=>'10'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096802792023722782)
,p_plug_name=>unistr('INDICE  DE ROTACI\00D3N')
,p_parent_plug_id=>wwv_flow_api.id(11095207373900361172)
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>120
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10971274607630106685)
,p_plug_name=>unistr('INDICE ROTACI\00D3N SIN PERIODO DE PRUEBA')
,p_parent_plug_id=>wwv_flow_api.id(11096802792023722782)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>90
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 3 ORDEN,',
'      tO_CHAR(ROUND((NVL(DES_MES1,0)/ DECODE(DOT_MES1,0,1,DOT_MES1))*100,1),''990D9'')||''%'' MES1,',
'      tO_CHAR(ROUND((NVL(DES_MES2,0)/ DECODE(DOT_MES2,0,1,DOT_MES2))*100,1),''990D9'')||''%'' MES2,',
'      tO_CHAR(ROUND((NVL(DES_MES3,0)/ DECODE(DOT_MES3,0,1,DOT_MES3))*100,1),''990D9'')||''%'' MES3,',
'     DOT_DPTO_DES, ',
'     DOT_AREA,',
'	 vMES1,vMES2,vMES3',
' FROM',
'  (SELECT COUNT(CASE WHEN C005 = C009 AND C006 =''DOTACION'' THEN',
'        C001',
'      END) DOT_MES1,',
'     COUNT(CASE WHEN C005 = C010 AND C006 =''DOTACION'' THEN',
'        C001',
'      END)  DOT_MES2,',
'     COUNT(CASE WHEN C005 = C011 AND C006 =''DOTACION'' THEN',
'        C001',
'      END) DOT_MES3,',
'      COUNT(CASE WHEN C005 = C009 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END) DES_MES1,',
'     COUNT(CASE WHEN C005 = C010 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END)  DES_MES2,',
'     COUNT(CASE WHEN C005 = C011 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END) DES_MES3,',
'          C003 DOT_DPTO_DES,',
'          C004 DOT_AREA,',
'      C002 DOT_DEPARTAMENTO,',
'      C009 vMES1, C010 vMES2, C011 vMES3',
'     FROM APEX_COLLECTIONS F',
'    WHERE COLLECTION_NAME = ''ROT_NUEVO''',
'    AND C012 <>1',
'    group by  C003,C004,C002, C009, C010, C011)',
'	',
'	UNION ALL',
'SELECT 2 ORDEN,',
'      tO_CHAR(ROUND((NVL(DES_MES1,0)/ DECODE(DOT_MES1,0,1,DOT_MES1))*100,2),''990D999'')||''%'' MES1,',
'      tO_CHAR(ROUND((NVL(DES_MES2,0)/ DECODE(DOT_MES2,0,1,DOT_MES2))*100,2),''990D999'')||''%'' MES2,',
'      tO_CHAR(ROUND((NVL(DES_MES3,0)/ DECODE(DOT_MES3,0,1,DOT_MES3))*100,2),''990D999'')||''%'' MES3,',
'     DOT_AREA DOT_DPTO_DES, ',
'     DOT_AREA,vMES1,vMES2,vMES3',
' FROM',
'  (SELECT COUNT(CASE WHEN C005 = C009 AND C006 =''DOTACION'' THEN',
'        C001',
'      END) DOT_MES1,',
'     COUNT(CASE WHEN C005 = C010 AND C006 =''DOTACION'' THEN',
'        C001',
'      END)  DOT_MES2,',
'     COUNT(CASE WHEN C005 = C011 AND C006 =''DOTACION'' THEN',
'        C001',
'      END) DOT_MES3,',
'      COUNT(CASE WHEN C005 = C009 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END) DES_MES1,',
'     COUNT(CASE WHEN C005 = C010 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END)  DES_MES2,',
'     COUNT(CASE WHEN C005 = C011 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END) DES_MES3,',
'      NULL DOT_DPTO_DES,',
'        C004 DOT_AREA,',
'      NULL DOT_DEPARTAMENTO,',
'   	 C009 vMES1, C010 vMES2, C011 vMES3',
'',
'     FROM APEX_COLLECTIONS F',
'    WHERE COLLECTION_NAME = ''ROT_NUEVO''',
'    AND C012 <>1',
'    group by C004, C009, C010, C011)',
'	UNION ALL',
'	',
'	SELECT 1 ORDEN,',
'    tO_CHAR(ROUND ((NVL(DES_MES1,0)/ DECODE(DOT_MES1,0,1,DOT_MES1))*100,3),''990D999'')||''%'' MES1,',
'    tO_CHAR( ROUND((NVL(DES_MES2,0)/ DECODE(DOT_MES2,0,1,DOT_MES2))*100,3),''990D999'')||''%'' MES2,',
'    tO_CHAR( ROUND((NVL(DES_MES3,0)/ DECODE(DOT_MES3,0,1,DOT_MES3))*100,3),''990D999'')||''%'' MES3,',
'     DOT_AREA DOT_DPTO_DES, ',
'     DOT_AREA, NULL vMES1, NULL vMES2, NULL vMES3',
' FROM',
'  (SELECT COUNT(CASE WHEN C005 = C009 AND C006 =''DOTACION'' THEN',
'        C001',
'      END) DOT_MES1,',
'     COUNT(CASE WHEN C005 = C010 AND C006 =''DOTACION'' THEN',
'        C001',
'      END)  DOT_MES2,',
'     COUNT(CASE WHEN C005 = C011 AND C006 =''DOTACION'' THEN',
'        C001',
'      END) DOT_MES3,',
'      COUNT(CASE WHEN C005 = C009 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END) DES_MES1,',
'     COUNT(CASE WHEN C005 = C010 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END)  DES_MES2,',
'     COUNT(CASE WHEN C005 = C011 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END) DES_MES3,',
'      NULL DOT_DPTO_DES,',
'      '' INDICE DE ROTACION'' DOT_AREA,',
'      NULL DOT_DEPARTAMENTO',
'     FROM APEX_COLLECTIONS F',
'    WHERE COLLECTION_NAME = ''ROT_NUEVO''',
'  	  AND C012 <>1)',
'  UNION ALL',
'  ',
'  SELECT 0 ORDEN, C009 MES1, C010 MES2, C011 MES3, ''INDICADOR'' INDICADOR, '' INDICADOR'',  NULL vMES1, NULL vMES2, NULL vMES3',
'     FROM APEX_COLLECTIONS F',
'    WHERE COLLECTION_NAME = ''ROT_NUEVO''',
'    GROUP BY C009,C010,C011'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>unistr('INDICE ROTACI\00D3N SIN PERIODO DE PRUEBA')
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
 p_id=>wwv_flow_api.id(10971274523013106684)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>670838751963359519
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10971274409130106683)
,p_db_column_name=>'ORDEN'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10971274366326106682)
,p_db_column_name=>'MES1'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Mes1'
,p_column_link=>'f?p=&APP_ID.:30:&SESSION.::&DEBUG.::P30_DEPARTAMENTO,P30_MES,P30_PER_PRUEBA:#DOT_DPTO_DES#,#VMES1#,0'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10971274184605106681)
,p_db_column_name=>'MES2'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Mes2'
,p_column_link=>'f?p=&APP_ID.:30:&SESSION.::&DEBUG.::P30_DEPARTAMENTO,P30_MES,P30_PER_PRUEBA:#DOT_DPTO_DES#,#VMES2#,0'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10971274110919106680)
,p_db_column_name=>'MES3'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Mes3'
,p_column_link=>'f?p=&APP_ID.:30:&SESSION.::&DEBUG.::P30_DEPARTAMENTO,P30_MES,P30_PER_PRUEBA:#DOT_DPTO_DES#,#VMES3#,0'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10971274062219106679)
,p_db_column_name=>'VMES1'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Vmes1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10971273937740106678)
,p_db_column_name=>'VMES2'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Vmes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10971273832410106677)
,p_db_column_name=>'VMES3'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Vmes3'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10971273714030106676)
,p_db_column_name=>'DOT_DPTO_DES'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Dot Dpto Des'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10971273578973106675)
,p_db_column_name=>'DOT_AREA'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Dot Area'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(10971222837013350871)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6708905'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DOT_DPTO_DES:MES1:MES2:MES3:'
,p_sort_column_1=>'DOT_AREA'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'ORDEN'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'DOT_DPTO_DES'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10971217065922306358)
,p_report_id=>wwv_flow_api.id(10971222837013350871)
,p_name=>'AREA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'ORDEN'
,p_operator=>'='
,p_expr=>'2'
,p_condition_sql=>' (case when ("ORDEN" = to_number(#APXWS_EXPR#)) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = #APXWS_EXPR_NUMBER#  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10971217462406306358)
,p_report_id=>wwv_flow_api.id(10971222837013350871)
,p_name=>'INDICE ROTACION'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'ORDEN'
,p_operator=>'='
,p_expr=>'1'
,p_condition_sql=>' (case when ("ORDEN" = to_number(#APXWS_EXPR#)) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = #APXWS_EXPR_NUMBER#  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10971217814653306359)
,p_report_id=>wwv_flow_api.id(10971222837013350871)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'ORDEN'
,p_operator=>'='
,p_expr=>'0'
,p_condition_sql=>' (case when ("ORDEN" = to_number(#APXWS_EXPR#)) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = #APXWS_EXPR_NUMBER#  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10974590498713436256)
,p_plug_name=>'INDICE ROTACION SIN TRASPORTE'
,p_parent_plug_id=>wwv_flow_api.id(11096802792023722782)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>80
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>5
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    SELECT  0 ORDEN,''INDICADOR'' DETALLE, C014 MES1, C015 MES2, C016 MES3, ''A'' PINTAR, NULL COD_DPTO_AREA',
'     FROM APEX_COLLECTIONS F',
'     WHERE COLLECTION_NAME = ''IND_ROTACION_TRANS''',
'   GROUP BY C014, C015, C016',
' UNION ALL ',
' SELECT  0 ORDEN ,''INDICE DE ROTACION'' DETALLE,  ',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C005), 0))) / DECODE(SUM(NVL(TO_NUMBER(C006), 0)), 0,1,SUM(NVL(TO_NUMBER(C006), 0)))))* 100,2),''990d99'')||''%'' MES1,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C007), 0))) /DECODE(SUM(NVL(TO_NUMBER(C008), 0)), 0,  1, SUM(NVL(TO_NUMBER(C008), 0)))))* 100,2),''990d99'')||''%'' MES2,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C009), 0)) ) / DECODE(SUM(NVL(TO_NUMBER(C010), 0)), 0,1,SUM(NVL(TO_NUMBER(C010), 0))))) * 100, 2),''990d99'')||''%'' MES3,',
'                   ''B'' PINTAR,',
'                    NULL NUEVAS_AREAS',
'     FROM APEX_COLLECTIONS F',
'     WHERE COLLECTION_NAME = ''IND_ROTACION_TRANS''',
'	   and c001<> 5',
'',
'UNION ALL',
'',
' SELECT   ',
'                   TO_NUMBER(C003) ORDEN,',
'                   C002 DETALLE,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C005), 0)) ) /DECODE(SUM(NVL(TO_NUMBER(C006), 0)),0,1,SUM(NVL(TO_NUMBER(C006), 0))))) * 100,2),''990d99'')||''%'' MES1,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C007), 0))) /DECODE(SUM(NVL(TO_NUMBER(C008), 0)), 0,1,SUM(NVL(TO_NUMBER(C008), 0))))) * 100,2),''990d99'')||''%'' MES2,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C009), 0)) ) /DECODE(SUM(NVL(TO_NUMBER(C010), 0)),0, 1,sUM(NVL(TO_NUMBER(C010), 0))))) * 100, 2),''990d99'')||''%'' MES3,',
'                   ''C'' PINTAR,',
'                    C001 NUEVAS_AREAS',
'     FROM APEX_COLLECTIONS F',
'     WHERE COLLECTION_NAME = ''IND_ROTACION_TRANS''',
'	 and c001<> 5',
'     GROUP BY C001, C002, C003',
'     UNION ALL ',
'      SELECT   ',
'                   TO_NUMBER(C004) ORDEN2,',
'                   C013 DETALLE,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C005), 0)) ) /DECODE(SUM(NVL(TO_NUMBER(C006), 0)),0,1,SUM(NVL(TO_NUMBER(C006), 0))))) * 100,2),''990d99'')||''%'' MES1,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C007), 0)) ) /DECODE(SUM(NVL(TO_NUMBER(C008), 0)),0,1,SUM(NVL(TO_NUMBER(C008), 0)))))* 100,2),''990d99'')||''%'' MES2,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C009), 0)) ) / DECODE(SUM(NVL(TO_NUMBER(C010), 0)),0,1, SUM(NVL(TO_NUMBER(C010), 0))))) * 100, 2),''990d99'')||''%'' MES3,',
'                   ''D'' PINTAR,',
'                    C012 NUEVAS_AREAS',
'     FROM APEX_COLLECTIONS F',
'     WHERE COLLECTION_NAME = ''IND_ROTACION_TRANS''',
'	 and c001<> 5',
'     GROUP BY C004, C013, C012',
'                    ORDER BY 1, 6'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'2'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'INDICE ROTACION SIN TRASPORTE'
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
 p_id=>wwv_flow_api.id(10974590437775436255)
,p_max_row_count=>'1000000'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>667522837201029948
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10974590343078436254)
,p_db_column_name=>'ORDEN'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10974590260684436253)
,p_db_column_name=>'DETALLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Detalle'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10971276282751106702)
,p_db_column_name=>'MES1'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Mes1'
,p_column_link=>'f?p=&APP_ID.:2258:&SESSION.::&DEBUG.::P2258_ANHO,P2258_DPTO:1,#COD_DPTO_AREA#'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10971276227424106701)
,p_db_column_name=>'MES2'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Mes2'
,p_column_link=>'f?p=&APP_ID.:2258:&SESSION.::&DEBUG.::P2258_ANHO,P2258_DPTO:2,#COD_DPTO_AREA#'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10971276118353106700)
,p_db_column_name=>'MES3'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Mes3'
,p_column_link=>'f?p=&APP_ID.:2258:&SESSION.::&DEBUG.::P2258_ANHO,P2258_DPTO:3,#COD_DPTO_AREA#'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10971276017250106699)
,p_db_column_name=>'PINTAR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Pintar'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10971275936336106698)
,p_db_column_name=>'COD_DPTO_AREA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Cod Dpto Area'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(10971267265834097583)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6708461'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DETALLE:MES1:MES2:MES3:'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10971263412266084870)
,p_report_id=>wwv_flow_api.id(10971267265834097583)
,p_name=>'AREA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'PINTAR'
,p_operator=>'='
,p_expr=>'C'
,p_condition_sql=>' (case when ("PINTAR" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''C''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10971263792741084871)
,p_report_id=>wwv_flow_api.id(10971267265834097583)
,p_name=>'INDICE ROTACION'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'PINTAR'
,p_operator=>'='
,p_expr=>'B'
,p_condition_sql=>' (case when ("PINTAR" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''B''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10971264235576084873)
,p_report_id=>wwv_flow_api.id(10971267265834097583)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'PINTAR'
,p_operator=>'='
,p_expr=>'A'
,p_condition_sql=>' (case when ("PINTAR" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''A''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10998234488301699129)
,p_plug_name=>'INDICE ROTACION GENERAL'
,p_parent_plug_id=>wwv_flow_api.id(11096802792023722782)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>60
,p_plug_grid_column_span=>5
,p_plug_display_column=>2
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    SELECT  0 ORDEN,''INDICADOR'' DETALLE, C014 MES1, C015 MES2, C016 MES3, ''A'' PINTAR, NULL COD_DPTO_AREA',
'     FROM APEX_COLLECTIONS F',
'     WHERE COLLECTION_NAME = ''IND_ROTACION_TRANS''',
'   GROUP BY C014, C015, C016',
' UNION ALL ',
' SELECT  0 ORDEN ,''INDICE DE ROTACION'' DETALLE,  ',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C005), 0))) / DECODE(SUM(NVL(TO_NUMBER(C006), 0)), 0,1,SUM(NVL(TO_NUMBER(C006), 0)))))* 100,2),''990d99'')||''%'' MES1,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C007), 0))) /DECODE(SUM(NVL(TO_NUMBER(C008), 0)), 0,  1, SUM(NVL(TO_NUMBER(C008), 0)))))* 100,2),''990d99'')||''%'' MES2,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C009), 0)) ) / DECODE(SUM(NVL(TO_NUMBER(C010), 0)), 0,1,SUM(NVL(TO_NUMBER(C010), 0))))) * 100, 2),''990d99'')||''%'' MES3,',
'                   ''B'' PINTAR,',
'                    NULL NUEVAS_AREAS',
'     FROM APEX_COLLECTIONS F',
'     WHERE COLLECTION_NAME = ''IND_ROTACION_TRANS''',
'',
'UNION ALL',
'',
' SELECT   ',
'                   TO_NUMBER(C003) ORDEN,',
'                   C002 DETALLE,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C005), 0)) ) /DECODE(SUM(NVL(TO_NUMBER(C006), 0)),0,1,SUM(NVL(TO_NUMBER(C006), 0))))) * 100,2),''990d99'')||''%'' MES1,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C007), 0))) /DECODE(SUM(NVL(TO_NUMBER(C008), 0)), 0,1,SUM(NVL(TO_NUMBER(C008), 0))))) * 100,2),''990d99'')||''%'' MES2,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C009), 0)) ) /DECODE(SUM(NVL(TO_NUMBER(C010), 0)),0, 1,sUM(NVL(TO_NUMBER(C010), 0))))) * 100, 2),''990d99'')||''%'' MES3,',
'                   ''C'' PINTAR,',
'                    C001 NUEVAS_AREAS',
'     FROM APEX_COLLECTIONS F',
'     WHERE COLLECTION_NAME = ''IND_ROTACION_TRANS''',
'     GROUP BY C001, C002, C003',
'     UNION ALL ',
'      SELECT   ',
'                   TO_NUMBER(C004) ORDEN2,',
'                   C013 DETALLE,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C005), 0)) ) /DECODE(SUM(NVL(TO_NUMBER(C006), 0)),0,1,SUM(NVL(TO_NUMBER(C006), 0))))) * 100,2),''990d99'')||''%'' MES1,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C007), 0)) ) /DECODE(SUM(NVL(TO_NUMBER(C008), 0)),0,1,SUM(NVL(TO_NUMBER(C008), 0)))))* 100,2),''990d99'')||''%'' MES2,',
'                   TO_CHAR(ROUND((((SUM(NVL(TO_NUMBER(C009), 0)) ) / DECODE(SUM(NVL(TO_NUMBER(C010), 0)),0,1, SUM(NVL(TO_NUMBER(C010), 0))))) * 100, 2),''990d99'')||''%'' MES3,',
'                   ''D'' PINTAR,',
'                    C012 NUEVAS_AREAS',
'     FROM APEX_COLLECTIONS F',
'     WHERE COLLECTION_NAME = ''IND_ROTACION_TRANS''',
'     GROUP BY C004, C013, C012',
'                    ORDER BY 1, 6'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'2'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'INDICE ROTACION GENERAL'
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
 p_id=>wwv_flow_api.id(10998233560268699120)
,p_max_row_count=>'1000000'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>350058455731033535
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10998233434306699119)
,p_db_column_name=>'ORDEN'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10998233283892699117)
,p_db_column_name=>'DETALLE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Detalle'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10998233149815699116)
,p_db_column_name=>'MES1'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Mes1'
,p_column_link=>'f?p=&APP_ID.:2258:&SESSION.::&DEBUG.::P2258_ANHO,P2258_DPTO:1,#COD_DPTO_AREA#'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10998233111181699115)
,p_db_column_name=>'MES2'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Mes2'
,p_column_link=>'f?p=&APP_ID.:2258:&SESSION.::&DEBUG.::P2258_ANHO,P2258_DPTO:2,#COD_DPTO_AREA#'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10998233010717699114)
,p_db_column_name=>'MES3'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Mes3'
,p_column_link=>'f?p=&APP_ID.:2258:&SESSION.::&DEBUG.::P2258_ANHO,P2258_DPTO:3,#COD_DPTO_AREA#'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10998232853141699113)
,p_db_column_name=>'PINTAR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Pintar'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10998232681450699111)
,p_db_column_name=>'COD_DPTO_AREA'
,p_display_order=>80
,p_column_identifier=>'I'
,p_column_label=>'Cod Dpto Area'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(10948023328309297814)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'4002687'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>100000
,p_report_columns=>'DETALLE:MES1:MES2:MES3:'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10971264846530086529)
,p_report_id=>wwv_flow_api.id(10948023328309297814)
,p_name=>'C'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'PINTAR'
,p_operator=>'='
,p_expr=>'C'
,p_condition_sql=>' (case when ("PINTAR" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''C''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
end;
/
begin
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10971265236068086529)
,p_report_id=>wwv_flow_api.id(10948023328309297814)
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'PINTAR'
,p_operator=>'='
,p_expr=>'B'
,p_condition_sql=>' (case when ("PINTAR" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''B''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(10971265664986086530)
,p_report_id=>wwv_flow_api.id(10948023328309297814)
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'PINTAR'
,p_operator=>'='
,p_expr=>'A'
,p_condition_sql=>' (case when ("PINTAR" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''A''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11014919384910230999)
,p_plug_name=>'TAB_INDICE1'
,p_parent_plug_id=>wwv_flow_api.id(11096802792023722782)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 0 ORDEN, ''INDICADOR'', ''UM'' UM, ''PB'' PB, C002 MES1, C004 MES2, C006 MES3, ''2021'' anho, ''INTERANUAL'' interanual',
'     FROM APEX_collections',
'     WHERE collection_name = ''DOTACION_INDICE''',
'     GROUP BY C002, C004, C006',
'UNION ALL',
'',
'select 0 ORDEN, ''INDICE DE ROTACION'' DESCRIPCION, ''%'' UM, to_char(PB,''9990D9'')||'' %'', to_char(round((mes1/decode(mes_1,0,1,mes_1))*100,1),''9990D9'')||'' %'' mes1,   to_char(round((mes2/decode(mes_2,0,1,mes_2))*100,1),''9990D9'')||'' %'' mes2,  ',
'to_char(round((mes3/decode(mes_3,0,1,mes_3))*100,1),''9990D9'')||'' %'' mes3,',
'to_char(nvl(round((des_anho/decode(dot_anho,0,1,dot_anho))*100,1),0),''9990D9'')||'' %'' anho,',
'to_char(nvl(round((INT_DESV/decode(INT_DOT,0,1,INT_DOT))*100,1),0),''9990D9'')||'' %'' inter',
'from',
'(SELECT  sum(C001) mes1,sum(C003) mes2, sum(C005) mes3',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVIN_INDICE'')a,',
'(SELECT  sum(C003) mes_1,sum(C005) mes_2, sum(C007) mes_3',
'     FROM APEX_collections',
'     WHERE collection_name = ''DOTACION_INDICE'') b,',
'(SELECT C003 PB',
'         FROM APEX_collections',
'         WHERE collection_name = ''PB_INDICE''',
'         group by C003)C,',
' (SELECT NVL(SUM(C003),0) des_anho, NVL(SUM(C004),0) dot_anho',
'         FROM APEX_collections',
'         WHERE collection_name = ''DOT_ANHO'')d,     ',
'  (SELECT NVL(SUM(C004),0) INT_DESV, NVL(SUM(C003),0) INT_DOT',
'         FROM APEX_collections',
'         WHERE collection_name = ''INTER_ANUAL'')E           ',
'UNION ALL',
'SELECT TO_NUMBER(COD_ORDEN), DESCRIPCION, ''%'' UM, to_char(TOTAL_PB,''9990D9'')||'' %'' PB, to_char( ROUND((SUM(MES_1DES)/decode(SUM(MES1_DO),0,1,SUM(MES1_DO)))*100,1),''9990D9'')||'' %'' MES1, to_char(ROUND((SUM(MES_2DES)/decode(SUM(MES2_DO),0,1,SUM(MES2_DO)'
||'))*100,1),''9990D9'')||'' %'' MES2, ',
'to_char(ROUND((SUM(MES_3DES)/decode(SUM(MES3_DO),0,1,SUM(MES3_DO)))*100,1),''9990D9'')||'' %'' MES3, TO_CHAR(POR_ANHO, ''9990D9'')||'' %''  POR_ANHO, INTER_POR',
'FROM ',
'(SELECT A. DEPARTAMENTO, A.MES1_DO, B.MES_1DES, A.MES2_DO,B.MES_2DES, A.MES3_DO, B.MES_3DES, COD_DEPART',
'FROM',
'    (SELECT  NVL(sum(C003),0) MES1_DO,  NVL(sum(C005),0) MES2_DO,  NVL(sum(C007),0) MES3_DO, c001 DEPARTAMENTO',
'         FROM APEX_collections',
'         WHERE collection_name = ''DOTACION_INDICE''',
'         group by c001) A,',
'    (SELECT   NVL(sum(C001),0) MES_1DES,  NVL(sum(C003),0) MES_2DES,  NVL(sum(C005),0) MES_3DES, c011 DEPARTAMENTO, (C014) COD_DEPART',
'         FROM APEX_collections',
'         WHERE collection_name = ''DESVIN_INDICE''',
'         group by c011, C014) B',
'    WHERE A.DEPARTAMENTO = B.DEPARTAMENTO) A,',
'(SELECT   C001 DESCRIPCION,C002 COD_ORDEN, C003 COD_DEP',
'     FROM APEX_collections',
'     WHERE collection_name = ''DEPARTAMENTO_INDICE'')B,',
' (SELECT TO_NUMBER(C006) CODIGO, c002 TOTAL_PB',
'         FROM APEX_collections',
'         WHERE collection_name = ''PB_INDICE''',
'        AND C001 =1 ) C,',
'   (SELECT TO_NUMBER(C006) CODIGOE, nvl(TO_NUMBER(C005),0) POR_ANHO',
'         FROM APEX_collections',
'         WHERE collection_name = ''DOT_ANHO'')  D  ,   ',
'    (SELECT TO_NUMBER(C006) int_CODIGO, TO_CHAR(nvl((NVL(C004,0)/DECODE(NVL(C003,0),0,1,NVL(C003,0))*100),0), ''990D9'')||''%''  INTER_POR',
'         FROM APEX_collections',
'         WHERE collection_name = ''INTER_ANUAL'')  E            ',
'        ',
'WHERE B.COD_ORDEN = A.COD_DEPART  ',
'  AND B.COD_ORDEN = D.CODIGOE(+)',
'  AND b.COD_ORDEN = c.CODIGO(+)',
'  AND B.COD_ORDEN = e.int_CODIGO  (+)',
'GROUP BY TO_NUMBER(COD_ORDEN), DESCRIPCION,TOTAL_PB,POR_ANHO,INTER_POR',
'UNION ALL',
'SELECT COD_DEPATA2, DESCRIPCION, ''%'' UM, to_char(TOTAL_PB,''9990D9'')||'' %'' PB,  MES1,MES2,MES3, PORC_ANHO,INTER_POR',
'FROM ',
'(SELECT A.COD_DEPART DE, TO_CHAR((B.MES_1DES/NVL(A.MES1_DO,1))*100, ''990D9'') MES1,TO_CHAR((B.MES_2DES/NVL(A.MES2_DO,1))*100, ''990D9'') MES2, TO_CHAR((B.MES_3DES/NVL(A.MES3_DO,1))*100, ''990D9'') MES3, A.COD_DEPART',
'                FROM',
'                (SELECT  NVL(sum(C003),1) MES1_DO,  NVL(sum(C005),1) MES2_DO,  NVL(sum(C007),1) MES3_DO, C008 COD_DEPART',
'                     FROM APEX_collections',
'                     WHERE collection_name = ''DOTACION_INDICE''',
'                     group by C008) A,',
'                (SELECT   NVL(sum(C001),0) MES_1DES,  NVL(sum(C003),0) MES_2DES,  NVL(sum(C005),0) MES_3DES, (C013) COD_DEPART',
'                     FROM APEX_collections',
'                     WHERE collection_name = ''DESVIN_INDICE''',
'                     group by C013) B',
'                WHERE A.COD_DEPART = B.COD_DEPART) A,',
'(SELECT C004 DESCRIPCION,',
'       TO_NUMBER(C005)COD_DEPATA2,',
'       C003 COD_DEPARTAMENTO',
'     FROM APEX_collections',
'     WHERE collection_name = ''DEPARTAMENTO_INDICE''',
'   --  AND C003 <>1',
') B,',
'    ',
'    (SELECT TO_NUMBER(C001) CODIGO, c002 TOTAL_PB',
'         FROM APEX_collections',
'         WHERE collection_name = ''PB_INDICE''',
'        AND C001 <>1 ) C,',
'        ',
'     (SELECT C001 AREA, TO_CHAR(NVL(SUM(C003),0)/DECODE(NVL(SUM(C004),0),0,1,NVL(SUM(C004),0))*100, ''990D9'')||''%''  PORC_ANHO ',
'         FROM APEX_collections',
'         WHERE collection_name = ''DOT_ANHO''',
'          GROUP BY C001)  D ,',
' (SELECT C005 INT_AREA, TO_CHAR(NVL(SUM(C004),0)/DECODE(NVL(SUM(C003),0),0,1,NVL(SUM(C003),0))*100, ''990D9'')||''%''  INTER_POR ',
'         FROM APEX_collections',
'         WHERE collection_name = ''INTER_ANUAL''',
'          GROUP BY C005)  E ',
'         ',
' WHERE A.COD_DEPART = B.DESCRIPCION',
'   AND B.COD_DEPATA2 = C.CODIGO',
'   AND A.COD_DEPART = D.AREA',
'   AND A.COD_DEPART = E.INT_AREA',
' GROUP BY COD_DEPATA2, DESCRIPCION, TOTAL_PB,MES1,MES2,MES3,PORC_ANHO,INTER_POR'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_plug_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('@PabloACespedes, se cambi\00F3 por solicitur de Capital Humano, reuni\00F3n 08/06/2022 (Roman),'),
unistr('Condici\00F3n anterior, que EMPRESA_ID = 1')))
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11014919436223231000)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>193954344092948220
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11014919513681231001)
,p_db_column_name=>'MES1'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2258:&SESSION.::&DEBUG.:RP:P2258_FECHA,P2258_COD_DEPARTAMENTO,P2258_MES:&P3528_FECHA_HASTA.,#ORDEN#,1'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11014919688438231102)
,p_db_column_name=>'MES2'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2258:&SESSION.::&DEBUG.:RP:P2258_FECHA,P2258_COD_DEPARTAMENTO,P2258_MES:&P3528_FECHA_HASTA.,#ORDEN#,2'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11014919732114231103)
,p_db_column_name=>'MES3'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2258:&SESSION.::&DEBUG.:RP:P2258_FECHA,P2258_COD_DEPARTAMENTO,P2258_MES:&P3528_FECHA_HASTA.,#ORDEN#,3'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11014919836711231104)
,p_db_column_name=>'ORDEN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11014919936141231105)
,p_db_column_name=>'PB'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'PB'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11014920081589231106)
,p_db_column_name=>'''INDICADOR'''
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'DESCRIPCION'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11014920181631231107)
,p_db_column_name=>'UM'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'UM'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11014920281153231108)
,p_db_column_name=>'ANHO'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'ANHO'
,p_column_link=>'f?p=&APP_ID.:2260:&SESSION.::&DEBUG.:RP:P2260_DEPARTAMENTO,P2260_FECHA:#ORDEN#,&P3528_FECHA_HASTA.'
,p_column_linktext=>'#ANHO#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11014920326798231109)
,p_db_column_name=>'INTERANUAL'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'INTERANUAL'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11015470540350134593)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1945055'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>100
,p_report_columns=>'''INDICADOR'':UM:PB:MES1:MES2:MES3:ANHO:INTERANUAL:'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11015482268365617119)
,p_report_id=>wwv_flow_api.id(11015470540350134593)
,p_name=>'ADM'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'''INDICADOR'''
,p_operator=>'='
,p_expr=>'ADM'
,p_condition_sql=>' (case when ("''INDICADOR''" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''ADM''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11015482674008617121)
,p_report_id=>wwv_flow_api.id(11015470540350134593)
,p_name=>'CDA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'''INDICADOR'''
,p_operator=>'='
,p_expr=>'CDA'
,p_condition_sql=>' (case when ("''INDICADOR''" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''CDA''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11015483040235617122)
,p_report_id=>wwv_flow_api.id(11015470540350134593)
,p_name=>'COMERCIAL'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'''INDICADOR'''
,p_operator=>'='
,p_expr=>'COMERCIAL'
,p_condition_sql=>' (case when ("''INDICADOR''" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''COMERCIAL''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11015483400636617123)
,p_report_id=>wwv_flow_api.id(11015470540350134593)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'''INDICADOR'''
,p_operator=>'='
,p_expr=>'INDICADOR'
,p_condition_sql=>' (case when ("''INDICADOR''" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11015483795820617125)
,p_report_id=>wwv_flow_api.id(11015470540350134593)
,p_name=>'INDICE ROTACION'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'''INDICADOR'''
,p_operator=>'='
,p_expr=>'INDICE DE ROTACION'
,p_condition_sql=>' (case when ("''INDICADOR''" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICE DE ROTACION''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11015484220036617126)
,p_report_id=>wwv_flow_api.id(11015470540350134593)
,p_name=>'INDUSTRIAL'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'''INDICADOR'''
,p_operator=>'='
,p_expr=>'INDUSTRIAL'
,p_condition_sql=>' (case when ("''INDICADOR''" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDUSTRIAL''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11041218942899734073)
,p_plug_name=>'IND_ROTA_RANGO_ANT'
,p_parent_plug_id=>wwv_flow_api.id(11096802792023722782)
,p_region_template_options=>'#DEFAULT#:margin-top-lg:margin-bottom-lg'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>7
,p_plug_display_column=>4
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT COD_DEP CODIGO, DEPARTAMENTO,SUM(MES1)MES1, SUM(MES2)MES2, SUM(MES3)MES3, SUM(MES4)MES4, SUM(MES5)MES5',
'FROM',
'(SELECT  CASE WHEN C022 = ''1'' THEN',
'            1',
'          END MES1,',
'         CASE WHEN C022 = ''2'' THEN',
'            1',
'          END MES2, ',
'          CASE WHEN C022 = ''3'' THEN',
'            1',
'          END MES3, ',
'            CASE WHEN C022 = ''4'' THEN',
'            1',
'          END MES4,',
'        CASE WHEN C022 = ''5'' THEN',
'            1',
'          END MES5,',
' TO_NUMBER(C023) COD_DEP, C024 DEPARTAMENTO',
'FROM APEX_collections',
'WHERE collection_name = ''IND_ROTACION'')',
'GROUP BY COD_DEP,DEPARTAMENTO',
'UNION ALL',
'SELECT 0 , ''TOTALES MES ''||TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'') DE, SUM(MES1)MES1, SUM(MES2)MES2, SUM(MES3)MES3, SUM(MES4)MES4, SUM(MES5)MES5',
'FROM',
'(SELECT  CASE WHEN C022 = ''1'' THEN',
'            1',
'          END MES1,',
'         CASE WHEN C022 = ''2'' THEN',
'            1',
'          END MES2, ',
'          CASE WHEN C022 = ''3'' THEN',
'            1',
'          END MES3, ',
'            CASE WHEN C022 = ''4'' THEN',
'            1',
'          END MES4,',
'        CASE WHEN C022 = ''5'' THEN',
'            1',
'          END MES5',
'FROM APEX_collections',
'WHERE collection_name = ''IND_ROTACION'')'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
);
wwv_flow_api.create_region_column_group(
 p_id=>wwv_flow_api.id(11041215341834734037)
,p_heading=>unistr('ROTACI\00D3N POR RANGO DE ANTIG\00DCEDAD')
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11040220788037515241)
,p_name=>'CODIGO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CODIGO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Codigo'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>80
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11040220907963515243)
,p_name=>'DEPARTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DEPARTAMENTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'Departamento'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_api.id(11041215341834734037)
,p_use_group_for=>'BOTH'
,p_attribute_01=>unistr('<span style=\201Dfont-size:200%;font-weight:bold;\201D>&DEPARTAMENTO.</span>')
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11041215396469734038)
,p_name=>'MES5'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MES5'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'Mas de tres meses '
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(11041215341834734037)
,p_use_group_for=>'BOTH'
,p_attribute_01=>unistr('<span style=\201Dfont-size:200%;font-weight:bold;\201D>&MES5.</span>')
,p_link_target=>'f?p=&APP_ID.:2556:&SESSION.::&DEBUG.:RP:P2556_ORDEN,P2556_AREA:5,&CODIGO.'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11041215534423734039)
,p_name=>'MES4'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MES4'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'Tres meses'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(11041215341834734037)
,p_use_group_for=>'BOTH'
,p_attribute_01=>unistr('<span style=\201Dfont-size:200%;font-weight:bold;\201D>&MES4.</span>')
,p_link_target=>'f?p=&APP_ID.:2556:&SESSION.::&DEBUG.:RP:P2556_ORDEN,P2556_AREA:4,&CODIGO.'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11041215623579734040)
,p_name=>'MES3'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MES3'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'Menos de tres meses'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>30
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(11041215341834734037)
,p_use_group_for=>'BOTH'
,p_attribute_01=>unistr('<span style=\201Dfont-size:200%;font-weight:bold;\201D>&MES3.</span>')
,p_link_target=>'f?p=&APP_ID.:2556:&SESSION.::&DEBUG.:RP:P2556_ORDEN,P2556_AREA:3,&CODIGO.'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11041215743373734041)
,p_name=>'MES2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MES2'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'Menos de dos meses'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(11041215341834734037)
,p_use_group_for=>'BOTH'
,p_attribute_01=>unistr('<span style=\201Dfont-size:200%;font-weight:bold;\201D>&MES2.</span>')
,p_link_target=>'f?p=&APP_ID.:2556:&SESSION.::&DEBUG.:RP:P2556_ORDEN,P2556_AREA:2,&CODIGO.'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(11041215853731734042)
,p_name=>'MES1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MES1'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'Menos de un mes'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>10
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_api.id(11041215341834734037)
,p_use_group_for=>'BOTH'
,p_attribute_01=>unistr('<span style=\201Dfont-size:200%;font-weight:bold;\201D>&MES1.</span>')
,p_link_target=>'f?p=&APP_ID.:2556:&SESSION.::&DEBUG.:RP:P2556_ORDEN,P2556_AREA:1,&CODIGO.'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(11041215903538734043)
,p_internal_uid=>167270484822856041
,p_is_editable=>false
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
,p_download_formats=>'CSV:HTML'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(11040247616577665494)
,p_interactive_grid_id=>wwv_flow_api.id(11041215903538734043)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(11040247496786665494)
,p_report_id=>wwv_flow_api.id(11040247616577665494)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11014731067071951086)
,p_view_id=>wwv_flow_api.id(11040247496786665494)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(11040220788037515241)
,p_is_visible=>false
,p_is_frozen=>false
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11039922298135845504)
,p_view_id=>wwv_flow_api.id(11040247496786665494)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(11040220907963515243)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11040244616582665479)
,p_view_id=>wwv_flow_api.id(11040247496786665494)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(11041215396469734038)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11040245186494665481)
,p_view_id=>wwv_flow_api.id(11040247496786665494)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(11041215534423734039)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11040245652624665483)
,p_view_id=>wwv_flow_api.id(11040247496786665494)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(11041215623579734040)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11040246096872665486)
,p_view_id=>wwv_flow_api.id(11040247496786665494)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(11041215743373734041)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(11040246613958665490)
,p_view_id=>wwv_flow_api.id(11040247496786665494)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(11041215853731734042)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_highlight(
 p_id=>wwv_flow_api.id(11014725791635936433)
,p_view_id=>wwv_flow_api.id(11040247496786665494)
,p_execution_seq=>5
,p_name=>'TOTAL'
,p_background_color=>'#99CCFF'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_api.id(11040220788037515241)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'0'
,p_is_enabled=>true
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11070371695447589368)
,p_plug_name=>'INDICE ROTACION GENERAL'
,p_parent_plug_id=>wwv_flow_api.id(11096802792023722782)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 3 ORDEN,',
'      tO_CHAR(ROUND((NVL(DES_MES1,0)/ DECODE(DOT_MES1,0,1,DOT_MES1))*100,1),''990D9'')||''%'' MES1,',
'      tO_CHAR(ROUND((NVL(DES_MES2,0)/ DECODE(DOT_MES2,0,1,DOT_MES2))*100,1),''990D9'')||''%'' MES2,',
'      tO_CHAR(ROUND((NVL(DES_MES3,0)/ DECODE(DOT_MES3,0,1,DOT_MES3))*100,1),''990D9'')||''%'' MES3,',
'     DOT_DPTO_DES, ',
'     DOT_AREA,',
'	 vMES1,vMES2,vMES3',
' FROM',
'  (SELECT COUNT(CASE WHEN C005 = C009 AND C006 =''DOTACION'' THEN',
'        C001',
'      END) DOT_MES1,',
'     COUNT(CASE WHEN C005 = C010 AND C006 =''DOTACION'' THEN',
'        C001',
'      END)  DOT_MES2,',
'     COUNT(CASE WHEN C005 = C011 AND C006 =''DOTACION'' THEN',
'        C001',
'      END) DOT_MES3,',
'      COUNT(CASE WHEN C005 = C009 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END) DES_MES1,',
'     COUNT(CASE WHEN C005 = C010 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END)  DES_MES2,',
'     COUNT(CASE WHEN C005 = C011 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END) DES_MES3,',
'          C003 DOT_DPTO_DES,',
'          C004 DOT_AREA,',
'      C002 DOT_DEPARTAMENTO,',
'      C009 vMES1, C010 vMES2, C011 vMES3',
'     FROM APEX_COLLECTIONS F',
'    WHERE COLLECTION_NAME = ''ROT_NUEVO''',
'    group by  C003,C004,C002, C009, C010, C011)',
'	',
'	UNION ALL',
'SELECT 2 ORDEN,',
'      tO_CHAR(ROUND((NVL(DES_MES1,0)/ DECODE(DOT_MES1,0,1,DOT_MES1))*100,2),''990D999'')||''%'' MES1,',
'      tO_CHAR(ROUND((NVL(DES_MES2,0)/ DECODE(DOT_MES2,0,1,DOT_MES2))*100,2),''990D999'')||''%'' MES2,',
'      tO_CHAR(ROUND((NVL(DES_MES3,0)/ DECODE(DOT_MES3,0,1,DOT_MES3))*100,2),''990D999'')||''%'' MES3,',
'     DOT_AREA DOT_DPTO_DES, ',
'     DOT_AREA,vMES1,vMES2,vMES3',
' FROM',
'  (SELECT COUNT(CASE WHEN C005 = C009 AND C006 =''DOTACION'' THEN',
'        C001',
'      END) DOT_MES1,',
'     COUNT(CASE WHEN C005 = C010 AND C006 =''DOTACION'' THEN',
'        C001',
'      END)  DOT_MES2,',
'     COUNT(CASE WHEN C005 = C011 AND C006 =''DOTACION'' THEN',
'        C001',
'      END) DOT_MES3,',
'      COUNT(CASE WHEN C005 = C009 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END) DES_MES1,',
'     COUNT(CASE WHEN C005 = C010 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END)  DES_MES2,',
'     COUNT(CASE WHEN C005 = C011 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END) DES_MES3,',
'      NULL DOT_DPTO_DES,',
'        C004 DOT_AREA,',
'      NULL DOT_DEPARTAMENTO,',
'   	 C009 vMES1, C010 vMES2, C011 vMES3',
'',
'     FROM APEX_COLLECTIONS F',
'    WHERE COLLECTION_NAME = ''ROT_NUEVO''',
'    group by C004, C009, C010, C011)',
'	UNION ALL',
'	',
'	SELECT 1 ORDEN,',
'    tO_CHAR(ROUND ((NVL(DES_MES1,0)/ DECODE(DOT_MES1,0,1,DOT_MES1))*100,3),''990D999'')||''%'' MES1,',
'    tO_CHAR( ROUND((NVL(DES_MES2,0)/ DECODE(DOT_MES2,0,1,DOT_MES2))*100,3),''990D999'')||''%'' MES2,',
'    tO_CHAR( ROUND((NVL(DES_MES3,0)/ DECODE(DOT_MES3,0,1,DOT_MES3))*100,3),''990D999'')||''%'' MES3,',
'     DOT_AREA DOT_DPTO_DES, ',
'     DOT_AREA, NULL vMES1, NULL vMES2, NULL vMES3',
' FROM',
'  (SELECT COUNT(CASE WHEN C005 = C009 AND C006 =''DOTACION'' THEN',
'        C001',
'      END) DOT_MES1,',
'     COUNT(CASE WHEN C005 = C010 AND C006 =''DOTACION'' THEN',
'        C001',
'      END)  DOT_MES2,',
'     COUNT(CASE WHEN C005 = C011 AND C006 =''DOTACION'' THEN',
'        C001',
'      END) DOT_MES3,',
'      COUNT(CASE WHEN C005 = C009 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END) DES_MES1,',
'     COUNT(CASE WHEN C005 = C010 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END)  DES_MES2,',
'     COUNT(CASE WHEN C005 = C011 AND C006 =''DESVINCULADOS'' THEN',
'        C001',
'      END) DES_MES3,',
'      NULL DOT_DPTO_DES,',
'      '' INDICE DE ROTACION'' DOT_AREA,',
'      NULL DOT_DEPARTAMENTO',
'     FROM APEX_COLLECTIONS F',
'    WHERE COLLECTION_NAME = ''ROT_NUEVO'')',
'  UNION ALL',
'  ',
'  SELECT 0 ORDEN, C009 MES1, C010 MES2, C011 MES3, ''INDICADOR'' INDICADOR, '' INDICADOR'',  NULL vMES1, NULL vMES2, NULL vMES3',
'     FROM APEX_COLLECTIONS F',
'    WHERE COLLECTION_NAME = ''ROT_NUEVO''',
'    GROUP BY C009,C010,C011'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'INDICE ROTACION GENERAL'
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
end;
/
begin
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11070371545913589366)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>571741729062876837
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11069852474263988497)
,p_db_column_name=>'DOT_DPTO_DES'
,p_display_order=>80
,p_column_identifier=>'S'
,p_column_label=>'Dot Dpto Des'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11069852351827988496)
,p_db_column_name=>'DOT_AREA'
,p_display_order=>90
,p_column_identifier=>'T'
,p_column_label=>'Dot Area'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11069851530067988488)
,p_db_column_name=>'ORDEN'
,p_display_order=>100
,p_column_identifier=>'AB'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11069851379288988487)
,p_db_column_name=>'MES1'
,p_display_order=>110
,p_column_identifier=>'AC'
,p_column_label=>'Mes1'
,p_column_link=>'f?p=&APP_ID.:30:&SESSION.::&DEBUG.::P30_DEPARTAMENTO,P30_MES:#DOT_DPTO_DES#,#VMES1#'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11069851373763988486)
,p_db_column_name=>'MES2'
,p_display_order=>120
,p_column_identifier=>'AD'
,p_column_label=>'Mes2'
,p_column_link=>'f?p=&APP_ID.:30:&SESSION.::&DEBUG.::P30_DEPARTAMENTO,P30_MES:#DOT_DPTO_DES#,#VMES2#'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11069851231700988485)
,p_db_column_name=>'MES3'
,p_display_order=>130
,p_column_identifier=>'AE'
,p_column_label=>'Mes3'
,p_column_link=>'f?p=&APP_ID.:30:&SESSION.::&DEBUG.::P30_DEPARTAMENTO,P30_MES:#DOT_DPTO_DES#,#VMES3#'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11069848869904988461)
,p_db_column_name=>'VMES1'
,p_display_order=>140
,p_column_identifier=>'AF'
,p_column_label=>'Vmes1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11069848746229988460)
,p_db_column_name=>'VMES2'
,p_display_order=>150
,p_column_identifier=>'AG'
,p_column_label=>'Vmes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11069848620949988459)
,p_db_column_name=>'VMES3'
,p_display_order=>160
,p_column_identifier=>'AH'
,p_column_label=>'Vmes3'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11069877156106081574)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'5722362'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DOT_DPTO_DES:MES1:MES2:MES3::VMES1:VMES2:VMES3'
,p_sort_column_1=>'DOT_AREA'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'ORDEN'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'DOT_DPTO_DES'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11069623654121206832)
,p_report_id=>wwv_flow_api.id(11069877156106081574)
,p_name=>'Area'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'ORDEN'
,p_operator=>'='
,p_expr=>'2'
,p_condition_sql=>' (case when ("ORDEN" = to_number(#APXWS_EXPR#)) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = #APXWS_EXPR_NUMBER#  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11069624002379206832)
,p_report_id=>wwv_flow_api.id(11069877156106081574)
,p_name=>'INDICE ROTACION'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'ORDEN'
,p_operator=>'='
,p_expr=>'1'
,p_condition_sql=>' (case when ("ORDEN" = to_number(#APXWS_EXPR#)) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = #APXWS_EXPR_NUMBER#  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11069624453646206833)
,p_report_id=>wwv_flow_api.id(11069877156106081574)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'ORDEN'
,p_operator=>'='
,p_expr=>'0'
,p_condition_sql=>' (case when ("ORDEN" = to_number(#APXWS_EXPR#)) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = #APXWS_EXPR_NUMBER#  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096802899755722783)
,p_plug_name=>'TAB_INDICE'
,p_parent_plug_id=>wwv_flow_api.id(11096802792023722782)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>30
,p_plug_grid_column_span=>5
,p_plug_display_column=>5
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 0 ORDEN, ''INDICADOR'', ''UM'' UM, ''PB'' PB, C002 MES1, C004 MES2, C006 MES3',
'     FROM APEX_collections',
'     WHERE collection_name = ''DOTACION_INDICE''',
'     GROUP BY C002, C004, C006',
'UNION ALL',
'',
'select 0 ORDEN, ''INDICE DE ROTACION'' DESCRIPCION, ''%'' UM, to_char(PB,''9990D9'')||'' %'', to_char(round((mes1/decode(mes_1,0,1,mes_1))*100,1),''9990D9'')||'' %'' mes1,   to_char(round((mes2/decode(mes_2,0,1,mes_2))*100,1),''9990D9'')||'' %'' mes2,  to_char(round'
||'((mes3/decode(mes_3,0,1,mes_3))*100,1),''9990D9'')||'' %'' mes3',
'from',
'(SELECT  sum(C001) mes1,sum(C003) mes2, sum(C005) mes3',
'     FROM APEX_collections',
'     WHERE collection_name = ''DESVIN_INDICE'')a,',
'(SELECT  sum(C003) mes_1,sum(C005) mes_2, sum(C007) mes_3',
'     FROM APEX_collections',
'     WHERE collection_name = ''DOTACION_INDICE'') b,',
'(SELECT C003 PB',
'         FROM APEX_collections',
'         WHERE collection_name = ''PB_INDICE''',
'         group by C003)C',
'UNION ALL',
'',
'SELECT TO_NUMBER(COD_ORDEN), DESCRIPCION, ''%'' UM, to_char(TOTAL_PB,''9990D9'')||'' %'' PB, to_char( ROUND((SUM(MES_1DES)/decode(SUM(MES1_DO),0,1,SUM(MES1_DO)))*100,1),''9990D9'')||'' %'' MES1, to_char(ROUND((SUM(MES_2DES)/decode(SUM(MES2_DO),0,1,SUM(MES2_DO)'
||'))*100,1),''9990D9'')||'' %'' MES2, ',
'to_char(ROUND((SUM(MES_3DES)/decode(SUM(MES3_DO),0,1,SUM(MES3_DO)))*100,1),''9990D9'')||'' %'' MES3',
'FROM ',
'(SELECT A. DEPARTAMENTO, A.MES1_DO, B.MES_1DES, A.MES2_DO,B.MES_2DES, A.MES3_DO, B.MES_3DES, COD_DEPART',
'FROM',
'    (SELECT  NVL(sum(C003),0) MES1_DO,  NVL(sum(C005),0) MES2_DO,  NVL(sum(C007),0) MES3_DO, c001 DEPARTAMENTO',
'         FROM APEX_collections',
'         WHERE collection_name = ''DOTACION_INDICE''',
'         group by c001) A,',
'    (SELECT   NVL(sum(C001),0) MES_1DES,  NVL(sum(C003),0) MES_2DES,  NVL(sum(C005),0) MES_3DES, c011 DEPARTAMENTO, (C012) COD_DEPART',
'         FROM APEX_collections',
'         WHERE collection_name = ''DESVIN_INDICE''',
'         group by c011, C012) B',
'    WHERE A.DEPARTAMENTO = B.DEPARTAMENTO) A,',
'(SELECT   C001 DESCRIPCION,C002 COD_ORDEN, C003 COD_DEP',
'     FROM APEX_collections',
'     WHERE collection_name = ''DEPARTAMENTO_INDICE'')B,',
' (SELECT TO_NUMBER(C001) CODIGO, c002 TOTAL_PB',
'         FROM APEX_collections',
'         WHERE collection_name = ''PB_INDICE''',
'        AND C001 =1 ) C ',
'WHERE B.COD_DEP = A.COD_DEPART   ',
'  AND COD_ORDEN = CODIGO(+)',
'GROUP BY TO_NUMBER(COD_ORDEN), DESCRIPCION,TOTAL_PB',
'UNION ALL',
'SELECT COD_DEPATA2, DESCRIPCION, ''%'' UM, to_char(TOTAL_PB,''9990D9'')||'' %'' PB,  MES1,MES2,MES3',
'FROM ',
'(SELECT A.COD_DEPART DE, TO_CHAR((B.MES_1DES/NVL(A.MES1_DO,1))*100, ''990D9'') MES1,TO_CHAR((B.MES_2DES/NVL(A.MES2_DO,1))*100, ''990D9'') MES2, TO_CHAR((B.MES_3DES/NVL(A.MES3_DO,1))*100, ''990D9'') MES3, A.COD_DEPART',
'                FROM',
'                (SELECT  NVL(sum(C003),1) MES1_DO,  NVL(sum(C005),1) MES2_DO,  NVL(sum(C007),1) MES3_DO, C008 COD_DEPART',
'                     FROM APEX_collections',
'                     WHERE collection_name = ''DOTACION_INDICE''',
'                     group by C008) A,',
'                (SELECT   NVL(sum(C001),0) MES_1DES,  NVL(sum(C003),0) MES_2DES,  NVL(sum(C005),0) MES_3DES, (C013) COD_DEPART',
'                     FROM APEX_collections',
'                     WHERE collection_name = ''DESVIN_INDICE''',
'                     group by C013) B',
'                WHERE A.COD_DEPART = B.COD_DEPART) A,',
'(SELECT  ',
'    CASE ',
'     WHEN c004 = 2 THEN',
'        ''CDA''',
'    WHEN (C002 IN(14,22,2) OR c004 NOT IN (1,2)) THEN',
'        ''COMERCIAL''',
'   ELSE',
'        ''INDUSTRIAL''     ',
'    END DESCRIPCION,',
'  CASE ',
'    WHEN c004 = 2 THEN',
'        12',
'    WHEN (C002 IN(14,22,2) OR c004 NOT IN (1,2)) THEN',
'        17',
'   ELSE',
'        2',
'    END COD_DEPATA2,',
'    C003 COD_DEPARTAMENTO',
'     FROM APEX_collections',
'     WHERE collection_name = ''DEPARTAMENTO_INDICE''',
'     AND C003 <>1 ) B,',
'    ',
'    (SELECT TO_NUMBER(C001) CODIGO, c002 TOTAL_PB',
'         FROM APEX_collections',
'         WHERE collection_name = ''PB_INDICE''',
'        AND C001 <>1 ) C ',
'    ',
' WHERE A.COD_DEPART = B.DESCRIPCION',
'   AND B.COD_DEPARTAMENTO = C.CODIGO',
' GROUP BY COD_DEPATA2, DESCRIPCION, TOTAL_PB,MES1,MES2,MES3'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'1'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11096803623320722790)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>55598985301471650
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096994725790042563)
,p_db_column_name=>'MES1'
,p_display_order=>130
,p_column_identifier=>'AU'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2258:&SESSION.::&DEBUG.:RP:P2258_FECHA,P2258_COD_DEPARTAMENTO,P2258_MES:&P3528_FECHA_HASTA.,#ORDEN#,1'
,p_column_linktext=>'#MES1#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096994765034042564)
,p_db_column_name=>'MES2'
,p_display_order=>140
,p_column_identifier=>'AV'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2258:&SESSION.::&DEBUG.:RP:P2258_FECHA,P2258_COD_DEPARTAMENTO,P2258_MES:&P3528_FECHA_HASTA.,#ORDEN#,2'
,p_column_linktext=>'#MES2#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096994849980042565)
,p_db_column_name=>'MES3'
,p_display_order=>150
,p_column_identifier=>'AW'
,p_column_label=>'MES'
,p_column_link=>'f?p=&APP_ID.:2258:&SESSION.::&DEBUG.:RP:P2258_FECHA,P2258_COD_DEPARTAMENTO,P2258_MES:&P3528_FECHA_HASTA.,#ORDEN#,3'
,p_column_linktext=>'#MES3#'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096995642925042573)
,p_db_column_name=>'ORDEN'
,p_display_order=>160
,p_column_identifier=>'AX'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096996388366042580)
,p_db_column_name=>'PB'
,p_display_order=>170
,p_column_identifier=>'AY'
,p_column_label=>'PB'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096996760521042584)
,p_db_column_name=>'''INDICADOR'''
,p_display_order=>180
,p_column_identifier=>'AZ'
,p_column_label=>'DESCRIPCION'
,p_column_type=>'STRING'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11096996914098042585)
,p_db_column_name=>'UM'
,p_display_order=>190
,p_column_identifier=>'BA'
,p_column_label=>'UM'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'CHICO'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11096937706641458808)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'557331'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'''INDICADOR'':UM:PB:MES1:MES2:MES3:'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'TO_NUMBER(COD_ORDEN)'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'COD_ORDEN'
,p_sort_direction_3=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11014844929669097613)
,p_report_id=>wwv_flow_api.id(11096937706641458808)
,p_name=>'INDUSTRIAL'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'''INDICADOR'''
,p_operator=>'='
,p_expr=>'INDUSTRIAL'
,p_condition_sql=>' (case when ("''INDICADOR''" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDUSTRIAL''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11014845335002097625)
,p_report_id=>wwv_flow_api.id(11096937706641458808)
,p_name=>'INDICE'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'''INDICADOR'''
,p_operator=>'='
,p_expr=>'INDICE DE ROTACION'
,p_condition_sql=>' (case when ("''INDICADOR''" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICE DE ROTACION''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11014845723819097626)
,p_report_id=>wwv_flow_api.id(11096937706641458808)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'''INDICADOR'''
,p_operator=>'='
,p_expr=>'INDICADOR'
,p_condition_sql=>' (case when ("''INDICADOR''" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11014846142564097627)
,p_report_id=>wwv_flow_api.id(11096937706641458808)
,p_name=>'COMERCIAL'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'''INDICADOR'''
,p_operator=>'='
,p_expr=>'COMERCIAL'
,p_condition_sql=>' (case when ("''INDICADOR''" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''COMERCIAL''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11014846530745097629)
,p_report_id=>wwv_flow_api.id(11096937706641458808)
,p_name=>'CDA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'''INDICADOR'''
,p_operator=>'='
,p_expr=>'CDA'
,p_condition_sql=>' (case when ("''INDICADOR''" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''CDA''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11014846927729097631)
,p_report_id=>wwv_flow_api.id(11096937706641458808)
,p_name=>'ADM'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'''INDICADOR'''
,p_operator=>'='
,p_expr=>'ADM'
,p_condition_sql=>' (case when ("''INDICADOR''" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''ADM''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#B5C0C4'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11096997016890042586)
,p_plug_name=>'TABLERO DE MARCACIONES'
,p_parent_plug_id=>wwv_flow_api.id(11095207373900361172)
,p_region_template_options=>'#DEFAULT#:t-Region--accent2:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>130
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11079902605219912979)
,p_plug_name=>'Listado llegada tardia'
,p_parent_plug_id=>wwv_flow_api.id(11096997016890042586)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>100
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  C025 AREA, c001 FECHA, C003 EMPLEADO, c013 HORA_MARC,C028,C020, C020 IMPUNTUAL',
'     FROM APEX_collections F',
'     WHERE collection_name = ''TABLERO_MARCACION''',
'    AND C028  = TO_CHAR(TO_dATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'  AND C020 = ''IMPUNTUAL''',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11079902587575912978)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>128583800785677106
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079902462286912977)
,p_db_column_name=>'AREA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Area'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079902305609912976)
,p_db_column_name=>'FECHA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Fecha'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079902222265912975)
,p_db_column_name=>'EMPLEADO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Empleado'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11079901222812912965)
,p_db_column_name=>'HORA_MARC'
,p_display_order=>40
,p_column_identifier=>'M'
,p_column_label=>'Hora Marcacion '
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11052105071228199105)
,p_db_column_name=>'C028'
,p_display_order=>50
,p_column_identifier=>'N'
,p_column_label=>'C028'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11035223038584842654)
,p_db_column_name=>'C020'
,p_display_order=>60
,p_column_identifier=>'O'
,p_column_label=>'C020'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10874730422145305206)
,p_db_column_name=>'IMPUNTUAL'
,p_display_order=>70
,p_column_identifier=>'P'
,p_column_label=>'Impuntual'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11079888642830813837)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1285978'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>100000
,p_report_columns=>'AREA:FECHA:EMPLEADO:HORA_MARC::IMPUNTUAL'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11088633944572080653)
,p_plug_name=>'PUNTUALIDAD_1'
,p_parent_plug_id=>wwv_flow_api.id(11096997016890042586)
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>90
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  decode(C004,1,''a-'',2,''b-'',4,''d- Sem'',5,''e- Sem'')||'' - ''||C001 ORDEN, C002 DESCR, to_number(C003) PORC',
'   FROM APEX_collections F',
'   WHERE collection_name = ''MAR_ANT_PUNT''',
'union all',
'SELECT  ''c- ''||C013 FECHA, ''CUMPLE'' DESCRIPCION ,',
'            ',
'             ROUND ((SUM(C001)/DECODE((SUM(C001)+SUM(C005)),0,1,(SUM(C001)+SUM(C005))))*100) PORC     ',
'             ',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'     AND C009 <> ''A''',
'    AND C013  = TO_CHAR(TO_dATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'    GROUP BY C013',
' UNION ALL',
' SELECT ''c- ''||C013 FECHA,''NO CUMPLE'' DESCRIPCION,',
'          ROUND ((SUM(C005)/DECODE((SUM(C001)+SUM(C005)),0,1,(SUM(C001)+SUM(C005))))*100) NO_CUMPLE',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'     AND C009 <> ''A''',
'     AND C013  = TO_CHAR(TO_dATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'    GROUP BY C013',
'UNION ALL',
'SELECT  ''f- Sem ''||C012 FECHA, ''CUMPLE'' DESCRIPCION ,',
'            ',
'        ROUND ((SUM(C001)/DECODE((SUM(C001)+SUM(C005)),0,1,(SUM(C001)+SUM(C005))))*100) PORC',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'     AND C009 <> ''A''',
'    -- AND C011 <>''4''',
'     AND TO_NUMBER(C012) =  to_NUMBER(TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW''))',
'    GROUP BY C012',
' UNION ALL',
' SELECT ''f- Sem ''||C012 FECHA,''NO CUMPLE'' DESCRIPCION,',
'       ROUND ((SUM(C005)/DECODE((SUM(C001)+SUM(C005)),0,1,(SUM(C001)+SUM(C005))))*100) NO_CUMPLE',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'     AND C009 <> ''A''',
'    AND TO_NUMBER(C012) = to_NUMBER(TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW''))',
'             ',
'    GROUP BY C012'))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11087415092983718952)
,p_region_id=>wwv_flow_api.id(11088633944572080653)
,p_chart_type=>'bar'
,p_title=>'CUMPLIMIENTO HORARIO DE ENTRADA'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11087415013187718951)
,p_chart_id=>wwv_flow_api.id(11087415092983718952)
,p_seq=>10
,p_name=>'Nuevo'
,p_location=>'REGION_SOURCE'
,p_series_name_column_name=>'DESCR'
,p_items_value_column_name=>'PORC'
,p_items_label_column_name=>'ORDEN'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'center'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_size=>'10'
,p_items_label_font_color=>'#000000'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11087414910582718950)
,p_chart_id=>wwv_flow_api.id(11087415092983718952)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11087414825599718949)
,p_chart_id=>wwv_flow_api.id(11087415092983718952)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11089272332855672635)
,p_plug_name=>'AUSENCIA_1'
,p_parent_plug_id=>wwv_flow_api.id(11096997016890042586)
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>110
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT decode(C004,1,''a-'',2,''b-'',4,''d- Sem'',5,''e- Sem'')||''  ''||C001 ORDEN, C002 DESCR, to_number(C003) PORC',
'   FROM APEX_collections F',
'   WHERE collection_name = ''MAR_ANT_ASIST''',
'UNION ALL',
'SELECT  ''c- ''||C013 FECHA, ''AUSENCIA'' DESCRIPCION,',
'        ROUND((sum(C020)/DECODE(count(C020),0,1,count(C020)))*100)PROC',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD'' ',
'     and c021 NOT IN(''7'')',
'     AND C013  = TO_CHAR(TO_dATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'    GROUP BY C013',
'UNION ALL',
'SELECT   ''f- sem ''||C012 FECHA, ''AUSENCIA'' DESCRIPCION ,',
'       ROUND((sum(C020)/DECODE(count(C020),0,1,count(C020)))*100) PORC',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'  --   AND C011 <>''4''',
'     and c021 NOT IN(''7'')',
'     AND TO_NUMBER(C012) =  to_NUMBER(TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW''))',
'    GROUP BY C012',
'UNION ALL',
'SELECT  ''c- ''||C013 FECHA, ''PRESENCIA'' DESCRIPCION ,',
'           ROUND(((count(C020)-sum(C020))/DECODE(count(C020),0,1,count(C020)))*100) PORC',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'     AND C013  = TO_CHAR(TO_dATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'     and c021 NOT IN(''7'')',
'    GROUP BY C013',
' UNION ALL',
' SELECT  ''f- sem ''||C012 FECHA,''PRESENCIA'' DESCRIPCION,',
'       ROUND(((count(C020)-sum(C020))/DECODE(count(C020),0,1,count(C020)))*100)  PORC',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'     and c021 NOT IN(''7'')',
'      AND TO_NUMBER(C012)  =  to_NUMBER(TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW''))',
'    GROUP BY C012',
'    ',
'   ',
''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11087414480624718945)
,p_region_id=>wwv_flow_api.id(11089272332855672635)
,p_chart_type=>'bar'
,p_title=>'NIVEL DE AUSENTISMO'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11087414356085718944)
,p_chart_id=>wwv_flow_api.id(11087414480624718945)
,p_seq=>10
,p_name=>'Nuevo'
,p_location=>'REGION_SOURCE'
,p_series_name_column_name=>'DESCR'
,p_items_value_column_name=>'PORC'
,p_items_label_column_name=>'ORDEN'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideBarEdge'
,p_items_label_display_as=>'PERCENT'
,p_items_label_font_family=>'Arial Black'
,p_items_label_font_style=>'normal'
,p_items_label_font_size=>'10'
,p_items_label_font_color=>'#000000'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11087414230898718943)
,p_chart_id=>wwv_flow_api.id(11087414480624718945)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11087414182745718942)
,p_chart_id=>wwv_flow_api.id(11087414480624718945)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
end;
/
begin
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11097194005880942884)
,p_plug_name=>'TABLA_PUNTUALIDAD'
,p_parent_plug_id=>wwv_flow_api.id(11096997016890042586)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>4
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT MES_ANT.ORDEN, MES_ANT.DESCRIPCION, MES_ANT.UM, MES_ANT.PB, MES_ANT.MES1, MES_ANT.MES2, DECODE(DESCRIPCION, ''INDICADOR'',MES_ANT.MES3,MES_ACT.MES3 )MES3',
'FROM',
'(SELECT  0 ORDEN, ''INDICADOR'' DESCRIPCION, ''UM'' UM, ''PB'' PB, C001 MES1, C002 MES2, C003 mes3',
'     FROM APEX_collections',
'     WHERE collection_name = ''MAR_MES''',
'UNION ALL',
'SELECT *',
'FROM',
'(SELECT ORDEN, TMARC_DETALLE,''%'',  T.TMARC_PROC, ',
'CASE ',
' WHEN T.TMARC_FECHA = TO_CHAR(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA),-2),''MM/YYYY'') THEN',
'      ''B''',
' WHEN T.TMARC_FECHA = TO_CHAR(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA),-1),''MM/YYYY'') THEN',
'      ''C''',
' WHEN T.TMARC_FECHA = TO_CHAR(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA),-12),''MM/YYYY'') THEN',
'      ''A''',
' ELSE ',
'    ''D''    ',
' END',
'  FECHA',
'FROM PER_TABLERO_MARCACION T',
'WHERE TMARC_EMPR = :p_empresa',
'AND OPCION = 1',
'AND INDICADOR IS NULL)',
'PIVOT (MAX(TMARC_PROC) FOR FECHA IN (''A'',''B'',''C'',''D'') ) A ) MES_ANT,',
'(',
'SELECT 0 ORDEN, ',
'       ROUND ((nvl(SUM(C004),0)/decode((SUM(nvl(C004,0))+SUM(nvl(C008,0))),0,1,(SUM(nvl(C004,0))+SUM(nvl(C008,0))))*100),0)||''%''  MES3   ',
'     FROM APEX_collections',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'      AND C009 <> ''A''',
'   /* AND TO_NUMBER(C012) NOT IN (SELECT  CASE ',
'            WHEN C004 = ''N''THEN TO_NUMBER (C001)',
'               ELSE TO_NUMBER (C001)+1 END SEMANA',
'             FROM APEX_collections',
'             WHERE collection_name = ''MAR_SEMANA''',
'              AND C003 = ''1'')*/',
'UNION ALL       ',
'SELECT TO_NUMBER(C011) ORDEN, ',
'        ROUND ((nvl(SUM(C004),0)/decode((SUM(nvl(C004,0))+SUM(nvl(C008,0))),0,1,(SUM(nvl(C004,0))+SUM(nvl(C008,0))))*100),0)||''%''  MES3   ',
'     FROM APEX_collections',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'     AND C009 <> ''A''',
'    /* AND TO_NUMBER(C012) NOT IN (SELECT  CASE ',
'            WHEN C004 = ''N''THEN TO_NUMBER (C001)',
'               ELSE TO_NUMBER (C001)+1 END SEMANA',
'             FROM APEX_collections',
'             WHERE collection_name = ''MAR_SEMANA''',
'              AND C003 = ''1'')*/',
'     GROUP BY C010, C011)MES_ACT',
'WHERE MES_ANT.ORDEN = MES_ACT.ORDEN(+)',
'AND MES_ANT.DESCRIPCION IS NOT NULL',
'',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11097194334421942887)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>55989696402691747
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11097276559326873390)
,p_db_column_name=>'ORDEN'
,p_display_order=>10
,p_column_identifier=>'AR'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11088632501690080639)
,p_db_column_name=>'MES3'
,p_display_order=>20
,p_column_identifier=>'AY'
,p_column_label=>'Mes3'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11088632423630080638)
,p_db_column_name=>'DESCRIPCION'
,p_display_order=>30
,p_column_identifier=>'AZ'
,p_column_label=>'Descripcion'
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11088632315047080637)
,p_db_column_name=>'UM'
,p_display_order=>40
,p_column_identifier=>'BA'
,p_column_label=>'Um'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11088632250028080636)
,p_db_column_name=>'PB'
,p_display_order=>50
,p_column_identifier=>'BB'
,p_column_label=>'Pb'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11088632128462080635)
,p_db_column_name=>'MES1'
,p_display_order=>60
,p_column_identifier=>'BC'
,p_column_label=>'Mes1'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11088632085661080634)
,p_db_column_name=>'MES2'
,p_display_order=>70
,p_column_identifier=>'BD'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11097279999664874480)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'560754'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DESCRIPCION:UM:PB:MES1:MES2:MES3:'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'DESCRIPCION'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016737464450624637)
,p_report_id=>wwv_flow_api.id(11097279999664874480)
,p_name=>'PUNTUALIDAD'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'PUNTUALIDAD'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''PUNTUALIDAD''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016737809059624637)
,p_report_id=>wwv_flow_api.id(11097279999664874480)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'INDICADOR'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11097272326745873347)
,p_plug_name=>'GRAFICO_PUNTUALIDAD'
,p_parent_plug_id=>wwv_flow_api.id(11096997016890042586)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  (SELECT  S.C002',
'             FROM APEX_collections S',
'             WHERE collection_name = ''ORDEN''',
'             AND S.C003= 1',
'              AND S.C001 = F.C013)||'' - ''||C013 FECHA, ''CUMPLE'' DESCRIPCION ,',
'         CASE ',
'             WHEN C013 = ''12/2019'' THEN 96',
'             WHEN C013 = ''01/2020'' THEN 94',
'             WHEN C013 = ''5'' THEN  94',
'             WHEN C013 = ''6'' THEN 95',
'        ELSE     ',
'             ROUND ((SUM(C001)/DECODE((SUM(C001)+SUM(C005)),0,1,(SUM(C001)+SUM(C005))))*100) ',
'        END PORC     ',
'             ',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'     AND C009 <> ''A''',
'    --  AND C011 <>''4''',
'     AND TO_NUMBER(C012) NOT IN (SELECT  CASE ',
'            WHEN C004 = ''N''THEN TO_NUMBER (C001)',
'               ELSE TO_NUMBER (C001)+1 END SEMANA',
'             FROM APEX_collections',
'             WHERE collection_name = ''MAR_SEMANA''',
'              AND C003 = ''1'')',
'    GROUP BY C013',
' UNION ALL',
' SELECT  (SELECT  S.C002',
'             FROM APEX_collections S',
'             WHERE collection_name = ''ORDEN''',
'             AND S.C003= 1',
'              AND S.C001 = F.C013)||'' - ''||C013 FECHA,''NO CUMPLE'' DESCRIPCION,',
'          CASE ',
'             WHEN C013 = ''12/2019'' THEN 4',
'             WHEN C013 = ''01/2020'' THEN 6',
'             WHEN C013 = ''5'' THEN  6',
'             WHEN C013 = ''6'' THEN 5',
'        ELSE       ',
'        ROUND ((SUM(C005)/DECODE((SUM(C001)+SUM(C005)),0,1,(SUM(C001)+SUM(C005))))*100) ',
'        END NO_CUMPLE',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'     AND C009 <> ''A''',
'    -- AND C011 <>''4''',
'     AND TO_NUMBER(C012) NOT IN (SELECT  CASE ',
'            WHEN C004 = ''N''THEN TO_NUMBER (C001)',
'               ELSE TO_NUMBER (C001)+1 END SEMANA',
'             FROM APEX_collections',
'             WHERE collection_name = ''MAR_SEMANA''',
'              AND C003 = ''1'')',
'    GROUP BY C013',
'UNION ALL',
'SELECT  (SELECT  S.C002',
'             FROM APEX_collections S',
'             WHERE collection_name = ''ORDEN''',
'             AND S.C003= 1',
'              AND S.C001 = F.C012)||'' - ''||C012 FECHA, ''CUMPLE'' DESCRIPCION ,',
'         CASE ',
'             WHEN C012 = ''12/2019'' THEN 96',
'             WHEN C012 = ''01/2020'' THEN 94',
'             WHEN C012 = ''5'' THEN  94',
'             WHEN C012 = ''6'' THEN 95',
'        ELSE        ',
'        ROUND ((SUM(C001)/DECODE((SUM(C001)+SUM(C005)),0,1,(SUM(C001)+SUM(C005))))*100) ',
'        END PORC',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'     AND C009 <> ''A''',
'    -- AND C011 <>''4''',
'     AND TO_NUMBER(C012) IN (SELECT  C001',
'             FROM APEX_collections',
'             WHERE collection_name = ''MAR_SEMANA''',
'                 and c002 <>''N'')',
'    GROUP BY C012',
' UNION ALL',
' SELECT  (SELECT  S.C002',
'             FROM APEX_collections S',
'             WHERE collection_name = ''ORDEN''',
'             AND S.C003= 1',
'              AND S.C001 = F.C012)||'' - ''||C012 FECHA,''NO CUMPLE'' DESCRIPCION,',
'        CASE ',
'             WHEN C012 = ''12/2019'' THEN 4',
'             WHEN C012 = ''01/2020'' THEN 6',
'             WHEN C012 = ''5'' THEN  6',
'             WHEN C012 = ''6'' THEN 5',
'        ELSE  ',
'            ROUND ((SUM(C005)/DECODE((SUM(C001)+SUM(C005)),0,1,(SUM(C001)+SUM(C005))))*100)',
'        END NO_CUMPLE',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'     AND C009 <> ''A''',
'    -- AND C011 <>''4''',
'      AND TO_NUMBER(C012) IN ( SELECT  C001',
'             FROM APEX_collections',
'             WHERE collection_name = ''MAR_SEMANA''',
'                  and c002 <>''N'')',
'             ',
'    GROUP BY C012',
'    '))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11097334248785272863)
,p_region_id=>wwv_flow_api.id(11097272326745873347)
,p_chart_type=>'bar'
,p_title=>'CUMPLIMIENTO HORARIO DE ENTRADA'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11097334391664272864)
,p_chart_id=>wwv_flow_api.id(11097334248785272863)
,p_seq=>10
,p_name=>'PUNTUALIDAD'
,p_location=>'REGION_SOURCE'
,p_series_name_column_name=>'DESCRIPCION'
,p_items_value_column_name=>'PORC'
,p_items_label_column_name=>'FECHA'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11097334465788272865)
,p_chart_id=>wwv_flow_api.id(11097334248785272863)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11097334578152272866)
,p_chart_id=>wwv_flow_api.id(11097334248785272863)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11097333776794272858)
,p_plug_name=>'TABLA_AUSENCIA'
,p_parent_plug_id=>wwv_flow_api.id(11096997016890042586)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT MES_ANT.ORDEN, MES_ANT.DESCRIPCION, MES_ANT.UM, MES_ANT.PB, MES_ANT.MES1, MES_ANT.MES2, DECODE(DESCRIPCION, ''INDICADOR'',MES_ANT.MES3,MES_ACT.MES3 )MES3',
'FROM',
'(SELECT  0 ORDEN, ''INDICADOR'' DESCRIPCION, ''UM'' UM, ''PB'' PB, C001 MES1, C002 MES2, C003 mes3',
'     FROM APEX_collections',
'     WHERE collection_name = ''MAR_MES''',
'UNION ALL',
'SELECT *',
'FROM',
'(SELECT ORDEN, TMARC_DETALLE,''%'',  T.TMARC_PROC, ',
'CASE ',
' WHEN T.TMARC_FECHA = TO_CHAR(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA),-2),''MM/YYYY'') THEN',
'      ''B''',
' WHEN T.TMARC_FECHA = TO_CHAR(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA),-1),''MM/YYYY'') THEN',
'      ''C''',
' WHEN T.TMARC_FECHA = TO_CHAR(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA),-12),''MM/YYYY'')  THEN',
'      ''A''',
' ELSE ',
'    ''D''    ',
' END',
'  FECHA',
'FROM PER_TABLERO_MARCACION T',
'WHERE TMARC_EMPR = :p_empresa',
'AND OPCION = 2',
'AND INDICADOR IS NULL)',
'PIVOT (MAX(TMARC_PROC) FOR FECHA IN (''A'',''B'',''C'',''D'') ) A ) MES_ANT,',
'(SELECT  0 ORDEN, ROUND((SUM(C016)/decode(SUM(C019),0,1,SUM(C019)))*100)||''%'' MES3',
'     FROM APEX_collections',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'      and c021 NOT IN(''7'')',
'    --  AND C011 <>''4''',
'    /*  AND TO_NUMBER(C012) NOT IN (SELECT  CASE ',
'            WHEN C004 = ''N''THEN TO_NUMBER (C001)',
'               ELSE TO_NUMBER (C001)+1 END SEMANA',
'             FROM APEX_collections',
'             WHERE collection_name = ''MAR_SEMANA''',
'              AND C003 = ''1'')*/',
'   ',
'UNION ALL',
'SELECT',
'       TO_NUMBER(C011) COD_AREA, ROUND((SUM(C016)/decode(SUM(C019),0,1,SUM(C019)))*100)||''%'' MES3',
'     FROM APEX_collections',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'      and c021 NOT IN(''7'')',
'   /*  AND TO_NUMBER(C012) NOT IN (SELECT  CASE ',
'            WHEN C004 = ''N''THEN TO_NUMBER (C001)',
'               ELSE TO_NUMBER (C001)+1 END SEMANA',
'             FROM APEX_collections',
'             WHERE collection_name = ''MAR_SEMANA''',
'              AND C003 = ''1'')  */',
'GROUP BY C011, C010  ',
'ORDER BY 1)MES_ACT',
'WHERE MES_ANT.ORDEN = MES_ACT.ORDEN(+)',
'AND MES_ANT.DESCRIPCION IS NOT NULL'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11097333839546272859)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>56129201527021719
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11097409238446055453)
,p_db_column_name=>'PB'
,p_display_order=>40
,p_column_identifier=>'AI'
,p_column_label=>'PB'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11097409702689055457)
,p_db_column_name=>'ORDEN'
,p_display_order=>50
,p_column_identifier=>'AM'
,p_column_label=>'ORDEN'
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11097409819261055458)
,p_db_column_name=>'DESCRIPCION'
,p_display_order=>60
,p_column_identifier=>'AN'
,p_column_label=>unistr('DESCRIPCI\00D3N ')
,p_column_type=>'STRING'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11088631938112080633)
,p_db_column_name=>'UM'
,p_display_order=>70
,p_column_identifier=>'AS'
,p_column_label=>'Um'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11088631796207080632)
,p_db_column_name=>'MES1'
,p_display_order=>80
,p_column_identifier=>'AT'
,p_column_label=>'Mes1'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11088631752358080631)
,p_db_column_name=>'MES2'
,p_display_order=>90
,p_column_identifier=>'AU'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11088631634149080630)
,p_db_column_name=>'MES3'
,p_display_order=>100
,p_column_identifier=>'AV'
,p_column_label=>'Mes3'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_static_id=>'EDITARR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11097370834571567974)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'561662'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DESCRIPCION:UM:PB:MES1:MES2:MES3:'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'DESCRIPCION'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
,p_sum_columns_on_break=>'SUM(C014):SUM(C017)'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016736445423623984)
,p_report_id=>wwv_flow_api.id(11097370834571567974)
,p_name=>'AUSENCIA'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'NIVEL DE AUSENTISMO'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''NIVEL DE AUSENTISMO''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#CDE3FA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(11016736829377623984)
,p_report_id=>wwv_flow_api.id(11097370834571567974)
,p_name=>'INDICADOR'
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'DESCRIPCION'
,p_operator=>'='
,p_expr=>'INDICADOR'
,p_condition_sql=>' (case when ("DESCRIPCION" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# = ''INDICADOR''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#9AEAFC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11097410285775055463)
,p_plug_name=>'GRAFICO_AUSENCIA'
,p_parent_plug_id=>wwv_flow_api.id(11096997016890042586)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(11101533133529346327)
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  (SELECT DECODE(S.C002, 1,''a-'',2,''b-'',3,''c-'',4,''d- Sem'',5,''e- Sem'',6,''f- Sem'')',
'             FROM APEX_collections S',
'             WHERE collection_name = ''ORDEN''',
'             AND S.C003= 1',
'              AND S.C001 = F.C013)||''  ''||C013 FECHA, ''AUSENCIA'' DESCRIPCION ,',
'        CASE ',
'             WHEN C013 = ''12/2019'' THEN 13',
'             WHEN C013 = ''01/2020'' THEN 6',
'             WHEN C013 = ''5'' THEN  3',
'             WHEN C013 = ''6'' THEN 6',
'        ELSE',
'             ROUND((sum(C020)/DECODE(count(C020),0,1,count(C020)))*100)',
'        END PROC',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD'' ',
'   --  AND C011 <>''4''',
'     and c021 NOT IN(''7'',''6'')',
'       AND TO_NUMBER(C012) NOT IN (SELECT  CASE ',
'                                    WHEN C004 = ''N''THEN TO_NUMBER (C001)',
'                                       ELSE TO_NUMBER (C001)+1 END SEMANA',
'                                     FROM APEX_collections',
'                                     WHERE collection_name = ''MAR_SEMANA''',
'                                      AND C003 = ''1'')',
'    GROUP BY C013',
'UNION ALL',
'SELECT   (SELECT DECODE(S.C002, 1,''a-'',2,''b-'',3,''c-'',4,''d- Sem'',5,''e- Sem'',6,''f- Sem'')',
'             FROM APEX_collections S',
'             WHERE collection_name = ''ORDEN''',
'              AND S.C003=1',
'              AND S.C001 = F.C012)||''  ''||C012 FECHA, ''AUSENCIA'' DESCRIPCION ,',
'              ',
'         CASE ',
'             WHEN C012 = ''12/2019'' THEN 13',
'             WHEN C012 = ''01/2020'' THEN 6',
'             WHEN C012= ''5'' THEN  3',
'             WHEN C012 = ''6 ''THEN 6',
'        ELSE',
'        ROUND((sum(C020)/DECODE(count(C020),0,1,count(C020)))*100) ',
'       END PORC',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'  --   AND C011 <>''4''',
'     and c021 NOT IN(''7'',''6'')',
'     AND TO_NUMBER(C012) IN (SELECT  C001',
'             FROM APEX_collections',
'             WHERE collection_name = ''MAR_SEMANA''',
'                and c002 <>''N'')',
'    GROUP BY C012',
'UNION ALL',
'SELECT  (SELECT  DECODE(S.C002, 1,''a-'',2,''b-'',3,''c-'',4,''d- Sem'',5,''e- Sem'',6,''f- Sem'')',
'             FROM APEX_collections S',
'             WHERE collection_name = ''ORDEN''',
'              AND S.C003= 1',
'              AND S.C001 = F.C013)||''  ''||C013 FECHA, ''PRESENCIA'' DESCRIPCION ,',
'         CASE ',
'             WHEN C013 = ''12/2019'' THEN 87',
'             WHEN C013 = ''01/2020'' THEN 94',
'             WHEN C013 = ''5'' THEN  97',
'             WHEN C013 = ''6'' THEN 94',
'        ELSE      ',
'          ROUND(((count(C020)-sum(C020))/DECODE(count(C020),0,1,count(C020)))*100)',
'        END PORC',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'   -- AND C011 <>''4''',
'     and c021 NOT IN(''7'',''6'')',
'     AND TO_NUMBER(C012) NOT IN (SELECT  CASE ',
'            WHEN C004 = ''N''THEN TO_NUMBER (C001)',
'               ELSE TO_NUMBER (C001)+1 END SEMANA',
'             FROM APEX_collections',
'             WHERE collection_name = ''MAR_SEMANA''',
'              AND C003 = ''1'')',
'    GROUP BY C013',
' UNION ALL',
' SELECT   (SELECT  DECODE(S.C002, 1,''a-'',2,''b-'',3,''c-'',4,''d- Sem'',5,''e- Sem'',6,''f- Sem'')',
'             FROM APEX_collections S',
'             WHERE collection_name = ''ORDEN''',
'              AND S.C003= 1',
'              AND S.C001 = F.C012)||''  ''||C012 FECHA,''PRESENCIA'' DESCRIPCION,',
'       CASE ',
'             WHEN C012 = ''12/2019'' THEN 87',
'             WHEN C012 = ''01/2020'' THEN 94',
'             WHEN C012 = ''5'' THEN  97',
'             WHEN C012 = ''6'' THEN 94',
'        ELSE        ',
'              ',
'       ROUND(((count(C020)-sum(C020))/DECODE(count(C020),0,1,count(C020)))*100) ',
'       END PORC',
'     FROM APEX_collections F',
'     WHERE collection_name = ''MAR_PUNTUALIDAD''',
'     --AND C011 <>''4''',
'     and c021 NOT IN(''7'',''6'')',
'      AND TO_NUMBER(C012)  IN ( SELECT  C001',
'             FROM APEX_collections',
'             WHERE collection_name = ''MAR_SEMANA''',
'               AND C002 = ''S'')',
'    GROUP BY C012',
'    ',
'--ORDER BY 2,1'))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(11097411035434055470)
,p_region_id=>wwv_flow_api.id(11097410285775055463)
,p_chart_type=>'bar'
,p_title=>'NIVEL DE AUSENTISMO'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(11097411126635055471)
,p_chart_id=>wwv_flow_api.id(11097411035434055470)
,p_seq=>10
,p_name=>'AUSENCIA'
,p_location=>'REGION_SOURCE'
,p_series_name_column_name=>'DESCRIPCION'
,p_items_value_column_name=>'PROC'
,p_items_label_column_name=>'FECHA'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11097411222335055472)
,p_chart_id=>wwv_flow_api.id(11097411035434055470)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(11097411311122055473)
,p_chart_id=>wwv_flow_api.id(11097411035434055470)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'percent'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11098382043774237182)
,p_plug_name=>'Listado de ausentes'
,p_parent_plug_id=>wwv_flow_api.id(11096997016890042586)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(11101533630716346327)
,p_plug_display_sequence=>120
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  C025 AREA, c001 FECHA, C003 EMPLEADO, C021 AUSENTE',
'     FROM APEX_collections F',
'     WHERE collection_name = ''TABLERO_MARCACION''',
'   --  AND C028  = TO_CHAR(TO_dATE(:P3528_FECHA_HASTA),''MM/YYYY'')',
'    --AND C021 = ''AUSENTE''',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P3528_FECHA_HASTA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11098381982532237181)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>110104405829352903
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11098381815832237180)
,p_db_column_name=>'AREA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Area'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11098381661112237178)
,p_db_column_name=>'EMPLEADO'
,p_display_order=>30
,p_column_identifier=>'B'
,p_column_label=>'Empleado'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11098381553180237177)
,p_db_column_name=>'AUSENTE'
,p_display_order=>40
,p_column_identifier=>'C'
,p_column_label=>'Ausente'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(11098381382236237175)
,p_db_column_name=>'FECHA'
,p_display_order=>50
,p_column_identifier=>'D'
,p_column_label=>'Fecha'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(11098230215609737094)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1102562'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'AREA:EMPLEADO:AUSENTE:FECHA'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11076687947014251475)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(11079900014732912953)
,p_button_name=>'DOTACION'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Dotacion'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:2252:&SESSION.::&DEBUG.:RP::'
,p_grid_new_row=>'Y'
,p_grid_column=>10
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11095121227041088160)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(11094948742428347884)
,p_button_name=>'ACTUALIZAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Actualizar Todo'
,p_button_position=>'BODY'
,p_grid_new_row=>'Y'
,p_grid_column=>12
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11097796599258052349)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(11096209796738776673)
,p_button_name=>'Agre_entre'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_image_alt=>'aceptar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(10974594613841436297)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(10982579091552464459)
,p_button_name=>'rotacion_Cargo'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Refrescar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11033664728298094572)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(11049228020343540832)
,p_button_name=>'Act_Ausencias'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_image_alt=>'Actualizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11035011066592822954)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(11035011882843822962)
,p_button_name=>'Actualizar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Actualizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11042649164409307148)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(11042649345721307150)
,p_button_name=>'Actualizar_VSC'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Actualizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11096523663994908963)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(11096475841536425781)
,p_button_name=>'ACTUALIZAR_DES'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Actualizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11096802952296722784)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(11096802792023722782)
,p_button_name=>'ACTUALIZAR_DES_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Actualizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11096997129008042587)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(11095060579332305844)
,p_button_name=>unistr('clic_dotaci\00F3n')
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Actualizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11097132352592360048)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_button_name=>'clic_estructura'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Actualizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11097133720696360061)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(11095204422399361142)
,p_button_name=>'Act_vancia'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(11101510394712346301)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Actualizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11097134395130360068)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(11095875475084277856)
,p_button_name=>'Act_seleccion'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Actualizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11097135104589360075)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(11096132732797143873)
,p_button_name=>'act_contratacion'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Actualizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11097135793516360082)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(11096209796738776673)
,p_button_name=>'Act_RSC'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Actualizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11097136363006360088)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(11096211012115776685)
,p_button_name=>'Act_induccion'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Actualizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11097190110849942845)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(11096397677699067742)
,p_button_name=>'Act_contrataciones'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Actualizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11104348564234206168)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(11096997016890042586)
,p_button_name=>'Guardar_mes'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Guardar Mes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11104348608042206169)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(11096997016890042586)
,p_button_name=>'Guardar_Sem'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Guardar Sem'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11097193896443942883)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(11096997016890042586)
,p_button_name=>'act_marcaciones'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(11101510249501346300)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Actualizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11028622681420194081)
,p_name=>'P3528_DETALLE_P_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11028958544517837143)
,p_item_default=>'INDICADOR FACTOR VENTA KG COMERCIAL'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>5
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11028622777680194082)
,p_name=>'P3528_DETALLE_P'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11028962292053837181)
,p_item_default=>'INDICADOR FACTOR VENTA GS COMERCIAL'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>5
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11033097172111406461)
,p_name=>'P3528_AUSENCIA_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11035011628453822960)
,p_item_default=>'TABLERO DE INDICADORES - AUSENCIAS'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11033097208876406462)
,p_name=>'P3528_PUNTUALIDAD_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11033274622533569245)
,p_item_default=>'TABLERO DE INDICADORES - PUNTUALIDAD'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11035011781792822961)
,p_name=>'P3528_OBS_MARCA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11035011882843822962)
,p_item_default=>'Incluyen todas la personas que marcan, sim importar la forma de pago'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>6
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11040221135713515245)
,p_name=>'P3528_DES_ANT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11041218942899734073)
,p_item_default=>unistr('TABLERO ROTACI\00D3N POR RANGO DE ANTIG\00DCEDAD')
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>5
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11040221252512515246)
,p_name=>'P3528_VAC_DEP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11041772222937731357)
,p_item_default=>'TABLERO DE VACANCIA POR DEPARTAMENTO'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11063201245143433661)
,p_name=>'P3528_MES_ANHO_S'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(11078035960105509581)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11069734839628375443)
,p_name=>'P3528_PROCESO_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11069734928678375444)
,p_item_default=>'PROCESO DE RECLUTAMIENTO - SELECCION - CONTRATACION'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11070985729416601438)
,p_name=>'P3528_ESTRUCTURA_1_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11079900014732912953)
,p_item_default=>'Obs. para CDA no incluye el departamento 30- Marketing'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11076686598036251462)
,p_name=>'P3528_OBJ_GS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11076686754727251463)
,p_name=>'P3528_OBJ_KG'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11076687680258251472)
,p_name=>'P3528_IMAGEN_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT F.FAC_IMAGEN_BLOB ',
'  FROM COM_FACTURA_IMAGEN F ',
'  WHERE F.FAC_CLAVE = 10052 AND F.FAC_ITEM = 1 AND F.FAC_EMPR = 1'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078031490401509537)
,p_name=>'P3528_VAC_MES'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(11078033790430509560)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078031613583509538)
,p_name=>'P3528_VAC_TIPO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(11078033790430509560)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078031763026509539)
,p_name=>'P3528_VAC_FECHA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(11078033790430509560)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078031956179509541)
,p_name=>'P3528_DET_VACANCIA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11078033790430509560)
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078034637027509568)
,p_name=>'P3528_OPC_DOTA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(11078035960105509581)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078034774758509569)
,p_name=>'P3528_DET_DOT_FECHA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(11078035960105509581)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078034797472509570)
,p_name=>'P3528_DOT_MES_DEP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11078035960105509581)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078035766554509579)
,p_name=>'P3528_DET_DOT_DETALLE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(11078035960105509581)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Departamentos que lo conforman'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078036164582509583)
,p_name=>'P3528_DETALLE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(11078208862074359946)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078207872478359936)
,p_name=>'P3528_OPC_DOTACION'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(11078208862074359946)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078207976899359937)
,p_name=>'P3528_FECHA_DOT'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(11078208862074359946)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078208025382359938)
,p_name=>'P3528_DEPARTAMENTO_DOT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(11078208862074359946)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078210866200359966)
,p_name=>'P3528_DET_GRAF_DOTACION'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11094948869901347885)
,p_item_default=>unistr('El gr\00E1fico corresponde al ultimo mes de la tabla de dotaci\00F3n ')
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078496778822496642)
,p_name=>'P3528_MES3_DOT'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078891197647383766)
,p_name=>'P3528_EST_DIAS_TRA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11078891334169383767)
,p_name=>'P3528_EST_DIAS_HAB'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(11095123295489088181)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11095121070669088159)
,p_name=>'P3528_FECHA_HASTA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11094948742428347884)
,p_prompt=>'FECHA HASTA:'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11095206919928361167)
,p_name=>'P3528_IMAGEN'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(11094948742428347884)
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_grid_column=>3
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT F.FAC_IMAGEN_BLOB ',
'  FROM COM_FACTURA_IMAGEN F ',
'  WHERE F.FAC_CLAVE = 10052 AND F.FAC_ITEM = 1 AND F.FAC_EMPR = 1'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11095410267967524242)
,p_name=>'P3528_DOTACION'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11064175542013160860)
,p_item_default=>'TABLERO DE INDICADORES DE DOTACION'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11095410374714524243)
,p_name=>'P3528_ESTRUCTURA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11080254929974260949)
,p_item_default=>'TABLERO INDICADOR - COMERCIAL'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11095412551222524265)
,p_name=>'P3528_ESTRUCTURA_1'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(11079900014732912953)
,p_item_default=>'INDICADOR FACTOR VENTA COMERCIAL'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11095622953460897790)
,p_name=>'P3528_ESTRUCTURA_2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11073510799776177577)
,p_item_default=>'TABLERO INDICADOR - INDUSTRIAL'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11095725105205741565)
,p_name=>'P3528_ESTRUCTURA_2_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11078978616223231942)
,p_item_default=>unistr('INDICADOR FACTOR PRODUCCI\00D3N  ')
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11095874235369277843)
,p_name=>'P3528_ESTRUCTURA_2_2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11095622914100897789)
,p_item_default=>'TABLERO DE INDICADORES'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>5
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11096132608859143872)
,p_name=>'P3528_VACANCIA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11072701657099885758)
,p_item_default=>'TABLERO DE INDICADORES'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11096209441820776670)
,p_name=>'P3528_CONTRATACION'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11072229740759923755)
,p_item_default=>'TABLERO DE INDICADORES - SOLICITUD CONTRATACION'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11096397614238067741)
,p_name=>'P3528_INDUCCION'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11096328186764544273)
,p_item_default=>'PENDIENTES DE INDUCCION (Aparecen 4 meses antes de la FECHA HASTA)'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>2
,p_field_template=>wwv_flow_api.id(11101510977204346304)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11096473699142425759)
,p_name=>'P3528_CONTRATA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11096399929727067764)
,p_item_default=>'TABLERO DE INDICADORES - CONTRATACIONES'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>5
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11096474598956425768)
,p_name=>'P3528_CONTRATA_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11096472818258425750)
,p_item_default=>'CONTRATACIONES DEL MES'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>6
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11096474828878425770)
,p_name=>'P3528_CONTRATA_1_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11096474647920425769)
,p_item_default=>'CONTRATACIONES DE LA SEMANA'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>6
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11096476124421425783)
,p_name=>'P3528_DESVIN_MES'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11060915977334426969)
,p_item_default=>'DESVINCULACIONES DEL MES'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>6
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11096522419417908950)
,p_name=>'P3528_DESVIN_SEMANA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11096522305430908949)
,p_item_default=>'DESVINCULACIONES DE LA SEMANA'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>6
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11096525681488908983)
,p_name=>'P3528_DESVIN_'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11096524015670908966)
,p_item_default=>'TABLERO DE INDICADORES'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>6
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11097132094017360045)
,p_name=>'P3528_IMAGEN_DOTACION'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11095060579332305844)
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT F.FAC_IMAGEN_BLOB ',
'  FROM COM_FACTURA_IMAGEN F ',
'  WHERE F.FAC_CLAVE = 10052 AND F.FAC_ITEM = 1 AND F.FAC_EMPR = 1'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11097334665556272867)
,p_name=>'P3528_PUNTUALIDAD'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11097194005880942884)
,p_item_default=>'TABLERO DE INDICADORES - PUNTUALIDAD'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>3
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11097411396270055474)
,p_name=>'P3528_AUSENCIA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11097333776794272858)
,p_item_default=>'TABLERO DE INDICADORES - AUSENCIAS'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>3
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11097648841151523084)
,p_name=>'P3528_PROCESO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11100654110121405928)
,p_item_default=>'PROCESO DE RECLUTAMIENTO - SELECCION - CONTRATACION'
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11097649464127523090)
,p_name=>'P3528_MES_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11096209796738776673)
,p_prompt=>'Primera Entrevista:        Mes 1'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11097795755947052341)
,p_name=>'P3528_MES_2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(11096209796738776673)
,p_prompt=>'Mes 2'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11097795933369052342)
,p_name=>'P3528_MES_3'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(11096209796738776673)
,p_prompt=>'Mes 3'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11104120753000171926)
,p_name=>'P3528_ESTRUCTURA_2_2_1_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11104120791781171927)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'TABLERO DE VACANCIA',
'  POR DEPARTAMENTO'))
,p_prompt=>'Nuevo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_column=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(11101510892263346303)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11095121273470088161)
,p_name=>'CLIC_ACTUALIZAR'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11095121227041088160)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097192985138942874)
,p_event_id=>wwv_flow_api.id(11095121273470088161)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P3528_FECHA_HASTA IS NULL THEN',
' RAISE_APPLICATION_ERROR (-20001,''La fecha no puede quedar vacia'');',
'END IF;'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11095207147283361170)
,p_event_id=>wwv_flow_api.id(11095121273470088161)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3528_IMAGEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097193236985942876)
,p_event_id=>wwv_flow_api.id(11095121273470088161)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>'Puede tardar'
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11095061072575305849)
,p_event_id=>wwv_flow_api.id(11095121273470088161)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PERL051.PP_ESTRUCTURA_DETALLE(P_FECHA => :P3528_FECHA_HASTA,',
'                               P_EMPRESA => :P_EMPRESA,',
'                               P_DIAS_LABORAL=> :P3528_EST_DIAS_TRA,',
'                               P_DIAS_HABILES => :P3528_EST_DIAS_HAB,',
'                               P_DOTAC_M3    => :P3528_MES3_DOT,',
'                               P_OBJETIVO_KG => :P3528_OBJ_KG,',
'                               P_OBJETIVO_GS => :P3528_OBJ_GS);',
'                               ',
'',
'   '))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_attribute_03=>'P3528_EST_DIAS_HAB,P3528_EST_DIAS_TRA,P3528_MES3_DOT,P3528_OBJ_KG,P3528_OBJ_GS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11069736060638375455)
,p_event_id=>wwv_flow_api.id(11095121273470088161)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PERL051.PP_GUARDAR_DATOS_MARCACIONES (P_OPCION => ''f'',',
'                                      P_FECHA  => :P3528_FECHA_HASTA,',
'                                      P_EMPRESA => :P_EMPRESA);'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11095207528596361173)
,p_event_id=>wwv_flow_api.id(11095121273470088161)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11095206974926361168)
,p_name=>'al_cargar_pagina'
,p_event_sequence=>30
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11095207111633361169)
,p_event_id=>wwv_flow_api.id(11095206974926361168)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3528_IMAGEN,P3528_IMAGEN_DOTACION,P3528_IMAGEN_1'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097189706879942841)
,p_event_id=>wwv_flow_api.id(11095206974926361168)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096328186764544273)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097189807373942842)
,p_event_id=>wwv_flow_api.id(11095206974926361168)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096397788027067743)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097189913926942843)
,p_event_id=>wwv_flow_api.id(11095206974926361168)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096474647920425769)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097189991597942844)
,p_event_id=>wwv_flow_api.id(11095206974926361168)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096472818258425750)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097191228612942856)
,p_event_id=>wwv_flow_api.id(11095206974926361168)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096522305430908949)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11087414082235718941)
,p_event_id=>wwv_flow_api.id(11095206974926361168)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11097272326745873347)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11087413964132718940)
,p_event_id=>wwv_flow_api.id(11095206974926361168)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11097410285775055463)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11080253484055260934)
,p_event_id=>wwv_flow_api.id(11095206974926361168)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3528_MES_1,P3528_MES_2,P3528_MES_3'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11079902995799912983)
,p_event_id=>wwv_flow_api.id(11095206974926361168)
,p_event_result=>'TRUE'
,p_action_sequence=>110
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(11097796599258052349)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11071382058419458683)
,p_event_id=>wwv_flow_api.id(11095206974926361168)
,p_event_result=>'TRUE'
,p_action_sequence=>120
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11095120976268088158)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11068328745930140145)
,p_event_id=>wwv_flow_api.id(11095206974926361168)
,p_event_result=>'TRUE'
,p_action_sequence=>130
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11100654110121405928)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11015083514851075534)
,p_event_id=>wwv_flow_api.id(11095206974926361168)
,p_event_result=>'TRUE'
,p_action_sequence=>140
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11095874358461277845)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097412234352055482)
,p_event_id=>wwv_flow_api.id(11095206974926361168)
,p_event_result=>'TRUE'
,p_action_sequence=>150
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.jQuery("span[data-style]").each(',
'  function()',
'  { ',
'    apex.jQuery(this).parent().attr(''style'', apex.jQuery(this).attr(''data-style'')); ',
'  }',
');'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11096523795275908964)
,p_name=>'CLIC_DESVINCULACION'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11096523663994908963)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11096523892532908965)
,p_event_id=>wwv_flow_api.id(11096523795275908964)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P3528_FECHA_HASTA IS NULL THEN',
' RAISE_APPLICATION_ERROR (-20001,''La fecha no puede quedar vacia'');',
'END IF;',
'PERL051.PP_PROCESO_DESVINCULACION(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097191273271942857)
,p_event_id=>wwv_flow_api.id(11096523795275908964)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096525748141908984)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097191424468942858)
,p_event_id=>wwv_flow_api.id(11096523795275908964)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096524015670908966)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11100656897441405956)
,p_event_id=>wwv_flow_api.id(11096523795275908964)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096522305430908949)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11060914732358426957)
,p_event_id=>wwv_flow_api.id(11096523795275908964)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11060915977334426969)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097191578148942860)
,p_event_id=>wwv_flow_api.id(11096523795275908964)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096522305430908949)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097191679311942861)
,p_event_id=>wwv_flow_api.id(11096523795275908964)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>unistr('Desvinculaci\00F3n - Actualizado')
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11096803277762722787)
,p_name=>'CLIC_INDICE'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11096802952296722784)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11096803459774722789)
,p_event_id=>wwv_flow_api.id(11096803277762722787)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P3528_FECHA_HASTA IS NULL THEN',
' RAISE_APPLICATION_ERROR (-20001,''La fecha no puede quedar vacia'');',
'END IF;',
'PERL051.PP_PROCESO_INDICE_ROTACION(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);',
'							 ',
'							 ',
'BEGIN',
'',
'  PERL051.PP_NUEVO_IND_ROTACION(P_EMPRESA => :P_EMPRESA,',
'                                P_FECHA   => :P3528_FECHA_HASTA);',
'END;',
'							 '))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097191808749942862)
,p_event_id=>wwv_flow_api.id(11096803277762722787)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11014919384910230999)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11037507333608707148)
,p_event_id=>wwv_flow_api.id(11096803277762722787)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11041218942899734073)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11070371613917589367)
,p_event_id=>wwv_flow_api.id(11096803277762722787)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11070371695447589368)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10944966871644075415)
,p_event_id=>wwv_flow_api.id(11096803277762722787)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(10998234488301699129)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10971275868062106697)
,p_event_id=>wwv_flow_api.id(11096803277762722787)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(10974590498713436256)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10971273534906106674)
,p_event_id=>wwv_flow_api.id(11096803277762722787)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(10971274607630106685)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097191910483942863)
,p_event_id=>wwv_flow_api.id(11096803277762722787)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>unistr('Indice de Rotaci\00F3n - Actualizado')
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11096997236491042588)
,p_name=>'act_dotacion'
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11096997129008042587)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11096997411941042590)
,p_event_id=>wwv_flow_api.id(11096997236491042588)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P3528_FECHA_HASTA IS NULL THEN',
' RAISE_APPLICATION_ERROR (-20001,''La fecha no puede quedar vacia'');',
'END IF;',
'/*PERL051.PP_GRAFICO1_DOTACION(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);*/',
'',
'PERL051.PP_DOTACION(P_EMPRESA =>:P_EMPRESA,',
'                    P_FECHA => :P3528_FECHA_HASTA);'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097131664548360041)
,p_event_id=>wwv_flow_api.id(11096997236491042588)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11094948869901347885)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097131786951360042)
,p_event_id=>wwv_flow_api.id(11096997236491042588)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11095120882452088157)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097132032074360044)
,p_event_id=>wwv_flow_api.id(11096997236491042588)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11095120976268088158)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11064175376296160858)
,p_event_id=>wwv_flow_api.id(11096997236491042588)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11064175542013160860)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097132315022360047)
,p_event_id=>wwv_flow_api.id(11096997236491042588)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>unistr('Dotaci\00F3n - Actualizado')
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11097132513769360049)
,p_name=>'act_estructura'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11097132352592360048)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11076687565351251471)
,p_event_id=>wwv_flow_api.id(11097132513769360049)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3528_IMAGEN_1'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11080254675087260946)
,p_event_id=>wwv_flow_api.id(11097132513769360049)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PERL051.PP_ESTRUCTURA_DETALLE(P_FECHA => :P3528_FECHA_HASTA,',
'                               P_EMPRESA => :P_EMPRESA,',
'                               P_DIAS_LABORAL=> :P3528_EST_DIAS_TRA,',
'                               P_DIAS_HABILES => :P3528_EST_DIAS_HAB,',
'                               P_DOTAC_M3    => :P3528_MES3_DOT,',
'                               P_OBJETIVO_KG => :P3528_OBJ_KG,',
'                               P_OBJETIVO_GS => :P3528_OBJ_GS);',
'                               ',
'PERL051.PP_TABLERO_COMERCIAL  (P_EMPRESA  => :P_EMPRESA,',
'                                P_FECHA    => :P3528_FECHA_HASTA);   ',
'',
'  PERL051.PP_TABLERO_INDUSTRIAL  (P_EMPRESA  => :P_EMPRESA,',
'                                P_FECHA    => :P3528_FECHA_HASTA);   ',
' PERL051.PP_NUEVO_ESTRUCTURA (P_EMPRESA => :P_EMPRESA,',
'                                P_FECHA    => :P3528_FECHA_HASTA);'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_attribute_03=>'P3528_EST_DIAS_HAB,P3528_EST_DIAS_TRA,P3528_MES3_DOT,P3528_OBJ_KG,P3528_OBJ_GS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11076687436994251470)
,p_event_id=>wwv_flow_api.id(11097132513769360049)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3528_IMAGEN_1'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097132893319360053)
,p_event_id=>wwv_flow_api.id(11097132513769360049)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11079900014732912953)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097132986010360054)
,p_event_id=>wwv_flow_api.id(11097132513769360049)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11079898658297912939)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097133077769360055)
,p_event_id=>wwv_flow_api.id(11097132513769360049)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11079221995554575383)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097133173768360056)
,p_event_id=>wwv_flow_api.id(11097132513769360049)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11079219602362575359)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097133313983360057)
,p_event_id=>wwv_flow_api.id(11097132513769360049)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11078978616223231942)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11080253557437260935)
,p_event_id=>wwv_flow_api.id(11097132513769360049)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11080254929974260949)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11068328644551140144)
,p_event_id=>wwv_flow_api.id(11097132513769360049)
,p_event_result=>'TRUE'
,p_action_sequence=>110
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11073510799776177577)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11028957666451837134)
,p_event_id=>wwv_flow_api.id(11097132513769360049)
,p_event_result=>'TRUE'
,p_action_sequence=>120
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11028958544517837143)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11028622800584194083)
,p_event_id=>wwv_flow_api.id(11097132513769360049)
,p_event_result=>'TRUE'
,p_action_sequence=>130
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11028962292053837181)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11016837262605754875)
,p_event_id=>wwv_flow_api.id(11097132513769360049)
,p_event_result=>'TRUE'
,p_action_sequence=>140
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11017389204963157962)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097133587462360060)
,p_event_id=>wwv_flow_api.id(11097132513769360049)
,p_event_result=>'TRUE'
,p_action_sequence=>150
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>'Estructura - Actualizado'
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11097133757656360062)
,p_name=>'act_vacancia'
,p_event_sequence=>100
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11097133720696360061)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097134257193360067)
,p_event_id=>wwv_flow_api.id(11097133757656360062)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P3528_FECHA_HASTA IS NULL THEN',
' RAISE_APPLICATION_ERROR (-20001,''La fecha no puede quedar vacia'');',
'END IF;',
'PERL051.PP_PROCESO_SELECCION_VAC(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097133875689360063)
,p_event_id=>wwv_flow_api.id(11097133757656360062)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11015084667809075545)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097134000313360064)
,p_event_id=>wwv_flow_api.id(11097133757656360062)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11095622914100897789)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11103259567006553466)
,p_event_id=>wwv_flow_api.id(11097133757656360062)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11104120791781171927)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10940135974254563715)
,p_event_id=>wwv_flow_api.id(11097133757656360062)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(10944966537954075412)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10933889739123669727)
,p_event_id=>wwv_flow_api.id(11097133757656360062)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(10940134991754563705)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097134228594360066)
,p_event_id=>wwv_flow_api.id(11097133757656360062)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>'Vacancia - Actualizado'
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11097134476399360069)
,p_name=>'clic_seleccion'
,p_event_sequence=>110
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11097134395130360068)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097134635866360070)
,p_event_id=>wwv_flow_api.id(11097134476399360069)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P3528_FECHA_HASTA IS NULL THEN',
' RAISE_APPLICATION_ERROR (-20001,''La fecha no puede quedar vacia'');',
'END IF;',
'PERL051.PP_PROCESO_SELECCION_SELC(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097134796995360072)
,p_event_id=>wwv_flow_api.id(11097134476399360069)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11103476944962559462)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097134937890360073)
,p_event_id=>wwv_flow_api.id(11097134476399360069)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096130936038143855)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11063071957169742156)
,p_event_id=>wwv_flow_api.id(11097134476399360069)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11072701657099885758)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097134994628360074)
,p_event_id=>wwv_flow_api.id(11097134476399360069)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>unistr('Sol. Selecci\00F3n - Actualizado')
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11097135144824360076)
,p_name=>'clic_contrataciones'
,p_event_sequence=>120
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11097135104589360075)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097135241319360077)
,p_event_id=>wwv_flow_api.id(11097135144824360076)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P3528_FECHA_HASTA IS NULL THEN',
' RAISE_APPLICATION_ERROR (-20001,''La fecha no puede quedar vacia'');',
'END IF;',
'PERL051.PP_PROCESO_SELECCION_CONT(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097135448263360079)
,p_event_id=>wwv_flow_api.id(11097135144824360076)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096134001385143886)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097135571951360080)
,p_event_id=>wwv_flow_api.id(11097135144824360076)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096208608980776661)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11063071422879742151)
,p_event_id=>wwv_flow_api.id(11097135144824360076)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11072229740759923755)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097135649388360081)
,p_event_id=>wwv_flow_api.id(11097135144824360076)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>unistr('Sol. Contrataci\00F3n - Actualizado')
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11097135889387360083)
,p_name=>'clic_actualizar'
,p_event_sequence=>130
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11097135793516360082)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097135983382360084)
,p_event_id=>wwv_flow_api.id(11097135889387360083)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P3528_FECHA_HASTA IS NULL THEN',
' RAISE_APPLICATION_ERROR (-20001,''La fecha no puede quedar vacia'');',
'END IF;',
'PERL051.PP_PROCESO_SELECCION_RSC(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097136090557360085)
,p_event_id=>wwv_flow_api.id(11097135889387360083)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11069734928678375444)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097136194790360086)
,p_event_id=>wwv_flow_api.id(11097135889387360083)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>'Proceso R.S&C - Actualizado'
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11097136502289360089)
,p_name=>'clic_induccion'
,p_event_sequence=>140
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11097136363006360088)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097193090353942875)
,p_event_id=>wwv_flow_api.id(11097136502289360089)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P3528_FECHA_HASTA IS NULL THEN',
' RAISE_APPLICATION_ERROR (-20001,''La fecha no puede quedar vacia'');',
'END IF;'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097136615708360090)
,p_event_id=>wwv_flow_api.id(11097136502289360089)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096328186764544273)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10969541705302104180)
,p_event_id=>wwv_flow_api.id(11097136502289360089)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096328186764544273)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097190853351942853)
,p_event_id=>wwv_flow_api.id(11097136502289360089)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>unistr('Inducci\00F3n - Actualizado')
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11097190169117942846)
,p_name=>'clic_contratacion'
,p_event_sequence=>150
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11097190110849942845)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097190298304942847)
,p_event_id=>wwv_flow_api.id(11097190169117942846)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P3528_FECHA_HASTA IS NULL THEN',
' RAISE_APPLICATION_ERROR (-20001,''La fecha no puede quedar vacia'');',
'END IF;',
'PERL051.PP_PROCESO_CONTRATACIONES(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097190644067942851)
,p_event_id=>wwv_flow_api.id(11097190169117942846)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096399929727067764)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097191014715942854)
,p_event_id=>wwv_flow_api.id(11097190169117942846)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096525748141908984)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11098205538271165041)
,p_event_id=>wwv_flow_api.id(11097190169117942846)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096397788027067743)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11098205724921165042)
,p_event_id=>wwv_flow_api.id(11097190169117942846)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096472818258425750)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11098205807738165043)
,p_event_id=>wwv_flow_api.id(11097190169117942846)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096474647920425769)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097190339629942848)
,p_event_id=>wwv_flow_api.id(11097190169117942846)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096397788027067743)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097190470631942849)
,p_event_id=>wwv_flow_api.id(11097190169117942846)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096474647920425769)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097190614934942850)
,p_event_id=>wwv_flow_api.id(11097190169117942846)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096472818258425750)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097190757073942852)
,p_event_id=>wwv_flow_api.id(11097190169117942846)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>'Contrataciones - Actualizado'
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11097193306989942877)
,p_name=>'Nuevo_2'
,p_event_sequence=>160
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11095121227041088160)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097193398369942878)
,p_event_id=>wwv_flow_api.id(11097193306989942877)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3528_DOTACION'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11097193503948942879)
,p_name=>'Nuevo_3'
,p_event_sequence=>170
,p_condition_element=>'P3528_FECHA_HASTA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097192509670942869)
,p_event_id=>wwv_flow_api.id(11097193503948942879)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096397788027067743)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097192356793942868)
,p_event_id=>wwv_flow_api.id(11097193503948942879)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096328186764544273)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097192728870942871)
,p_event_id=>wwv_flow_api.id(11097193503948942879)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096472818258425750)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097192571795942870)
,p_event_id=>wwv_flow_api.id(11097193503948942879)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096474647920425769)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097192871112942873)
,p_event_id=>wwv_flow_api.id(11097193503948942879)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096522305430908949)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11097194045622942885)
,p_name=>'clic_marcaciones'
,p_event_sequence=>180
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11097193896443942883)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097194151754942886)
,p_event_id=>wwv_flow_api.id(11097194045622942885)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P3528_FECHA_HASTA IS NULL THEN',
' RAISE_APPLICATION_ERROR (-20001,''La fecha no puede quedar vacia'');',
'END IF;',
'PERL051.PP_PROCESO_MARCACIONES(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11069735902239375454)
,p_event_id=>wwv_flow_api.id(11097194045622942885)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PERL051.PP_GUARDAR_DATOS_MARCACIONES (P_OPCION => ''f'',',
'                                      P_FECHA  => :P3528_FECHA_HASTA,',
'                                      P_EMPRESA => :P_EMPRESA);'))
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097411519808055475)
,p_event_id=>wwv_flow_api.id(11097194045622942885)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11097194005880942884)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097411601370055476)
,p_event_id=>wwv_flow_api.id(11097194045622942885)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11097272326745873347)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097411719578055477)
,p_event_id=>wwv_flow_api.id(11097194045622942885)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11097410285775055463)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097411757347055478)
,p_event_id=>wwv_flow_api.id(11097194045622942885)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11097333776794272858)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11087413833023718939)
,p_event_id=>wwv_flow_api.id(11097194045622942885)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11088633944572080653)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11087413773111718938)
,p_event_id=>wwv_flow_api.id(11097194045622942885)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11089272332855672635)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11098381261417237174)
,p_event_id=>wwv_flow_api.id(11097194045622942885)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11098382043774237182)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11079901186789912964)
,p_event_id=>wwv_flow_api.id(11097194045622942885)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11079902605219912979)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097411935040055479)
,p_event_id=>wwv_flow_api.id(11097194045622942885)
,p_event_result=>'TRUE'
,p_action_sequence=>110
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>'Tab. Marcaciones - Actualizado'
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11097796677091052350)
,p_name=>'clic_Agregar'
,p_event_sequence=>190
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11097796599258052349)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097796798412052351)
,p_event_id=>wwv_flow_api.id(11097796677091052350)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11069734928678375444)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11097030454811752850)
,p_name=>'AL_CAMB_FECHA'
,p_event_sequence=>200
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3528_FECHA_HASTA'
,p_condition_element=>'P3528_FECHA_HASTA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11097030354036752849)
,p_event_id=>wwv_flow_api.id(11097030454811752850)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'PERL051.ORDEN_MES (P_FECHA => :P3528_FECHA_HASTA );'
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11104348454963206167)
,p_name=>'clic_guardar_Sem'
,p_event_sequence=>210
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11104348608042206169)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11104348309555206166)
,p_event_id=>wwv_flow_api.id(11104348454963206167)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PERL051.PP_GUARDAR_DATOS_MARCACIONES (P_OPCION => ''S'',',
'                                      P_FECHA  => :P3528_FECHA_HASTA,',
'                                      P_EMPRESA => :P_EMPRESA);'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11104347177622206154)
,p_event_id=>wwv_flow_api.id(11104348454963206167)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>'Registro Actualizado'
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11104347462523206157)
,p_name=>'clic_guardar_mes'
,p_event_sequence=>220
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11104348564234206168)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11104347372591206156)
,p_event_id=>wwv_flow_api.id(11104347462523206157)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PERL051.PP_GUARDAR_DATOS_MARCACIONES (P_OPCION => ''M'',',
'                                      P_FECHA  => :P3528_FECHA_HASTA,',
'                                      P_EMPRESA => :P_EMPRESA);'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11104347270168206155)
,p_event_id=>wwv_flow_api.id(11104347462523206157)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>'Registro Actualizado'
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11079714897305105177)
,p_name=>'al_cargar_Estr'
,p_event_sequence=>240
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11079714688775105175)
,p_event_id=>wwv_flow_api.id(11079714897305105177)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11080254929974260949)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11079714667475105174)
,p_event_id=>wwv_flow_api.id(11079714897305105177)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11079900014732912953)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11079714582039105173)
,p_event_id=>wwv_flow_api.id(11079714897305105177)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11079898658297912939)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11079103321291692354)
,p_name=>'AL_CARG_PAG_ESTR'
,p_event_sequence=>250
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11078207785942359935)
,p_name=>'opcion_actual_ant'
,p_event_sequence=>260
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3528_OPC_DOTACION'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11078207665643359934)
,p_event_id=>wwv_flow_api.id(11078207785942359935)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
' IF :P3528_OPC_DOTACION = ''A'' THEN',
' :P3528_FECHA_DOT := :P3528_FECHA_HASTA;',
' :P3528_DETALLE := ''Tiene en cuenta las contrataciones y desvinculaciones realizados en la semana'';',
' ELSE',
' :P3528_FECHA_DOT := TO_dATE(:P3528_FECHA_HASTA)-7;',
'  :P3528_DETALLE := ''Tiene en cuenta las contrataciones y desvinculaciones realizados en la semana anterior'';',
' END IF;',
' ',
' '))
,p_attribute_02=>'P3528_OPC_DOTACION,P3528_FECHA_HASTA'
,p_attribute_03=>'P3528_FECHA_DOT,P3528_DETALLE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11078036028179509582)
,p_event_id=>wwv_flow_api.id(11078207785942359935)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11078208862074359946)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11078034510751509567)
,p_name=>'AL_CAMB_DOTACION_MES'
,p_event_sequence=>270
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3528_OPC_DOTA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11078034426943509566)
,p_event_id=>wwv_flow_api.id(11078034510751509567)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF  :P3528_OPC_DOTA = 1 THEN',
'    :P3528_DET_DOT_FECHA := LAST_DAY(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA), -2));',
'     :P3528_MES_ANHO_S := TO_CHAR(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA), -2),''MM/YYYY'');',
'ELSIF  :P3528_OPC_DOTA = 2 THEN',
':P3528_DET_DOT_FECHA := LAST_DAY(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA), -1));',
':P3528_MES_ANHO_S := TO_CHAR(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA), -1),''MM/YYYY'');',
'ELSE',
':P3528_DET_DOT_FECHA :=TO_DATE(:P3528_FECHA_HASTA);',
':P3528_MES_ANHO_S := TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''IW/YYYY'');',
'    if TO_DATE(:P3528_FECHA_HASTA ,''dd/mm/yyyy'') = last_day(TO_DATE(:P3528_FECHA_HASTA ,''dd/mm/yyyy'')) then',
'    :P3528_MES_ANHO_S := TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''MM/YYYY'');',
'    end if;',
'END IF;'))
,p_attribute_02=>'P3528_OPC_DOTA'
,p_attribute_03=>'P3528_DET_DOT_FECHA,P3528_MES_ANHO_S'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11078034330709509565)
,p_event_id=>wwv_flow_api.id(11078034510751509567)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11078035960105509581)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11078034024728509562)
,p_name=>'al_ccamb_dep_dot'
,p_event_sequence=>280
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3528_DOT_MES_DEP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11078033900227509561)
,p_event_id=>wwv_flow_api.id(11078034024728509562)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
' SELECT wm_concat(DEPARTAMENTO)',
' into :P3528_DET_DOT_DETALLE',
'               FROM ',
'                (SELECT CASE  WHEN DPTO_SUC = 2 THEN',
'                                 ''CDA'' ',
'                            WHEN DPTO_CODIGO = 1 THEN',
'                                 ''ADM'' ',
'                            WHEN (DPTO_CODIGO IN(14,22,2) OR DPTO_SUC NOT IN (1,2)) THEN',
'                                ''COMERCIAL'' ',
'                            ELSE',
'                               ''INDUSTRIAL''',
'                            END DEPARTAMENTO1,',
'                  DPTO_CODIGO||'' - ''||DPTO_DESC DEPARTAMENTO ',
'                FROM GEN_DEPARTAMENTO',
'                WHERE DPTO_eMPR = 1)',
'                WHERE DEPARTAMENTO1 = :P3528_DOT_MES_DEP;'))
,p_attribute_02=>'P3528_DOT_MES_DEP'
,p_attribute_03=>'P3528_DET_DOT_DETALLE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11078031408578509536)
,p_name=>'Nuevo'
,p_event_sequence=>290
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3528_VAC_MES'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11078031310055509535)
,p_event_id=>wwv_flow_api.id(11078031408578509536)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF  :P3528_VAC_MES = 1 THEN',
'    :P3528_VAC_FECHA := LAST_DAY(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA), -2));',
'ELSIF  :P3528_VAC_MES = 2 THEN',
':P3528_VAC_FECHA := LAST_DAY(ADD_MONTHS(TO_DATE(:P3528_FECHA_HASTA), -1));',
'ELSE',
':P3528_VAC_FECHA :=TO_DATE(:P3528_FECHA_HASTA);',
'END IF;',
'',
'IF :P3528_VAC_TIPO <> ''VACANCIAS DEL MES'' THEN',
'    :P3528_DET_VACANCIA := ''Solicitudes de personal realizadas en el  mes'';',
' else',
'    :P3528_DET_VACANCIA := ''Solitudes en que no han encontrado candidatos, no incluye el mes'';',
' end if;',
''))
,p_attribute_02=>'P3528_VAC_MES,P3528_VAC_TIPO'
,p_attribute_03=>'P3528_VAC_FECHA,P3528_DET_VACANCIA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11077863996629698483)
,p_event_id=>wwv_flow_api.id(11078031408578509536)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11078033790430509560)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11073511332746177582)
,p_name=>'clic_dot_comercial'
,p_event_sequence=>300
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11076687947014251475)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11073511247864177581)
,p_event_id=>wwv_flow_api.id(11073511332746177582)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11079900014732912953)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11073511152825177580)
,p_event_id=>wwv_flow_api.id(11073511332746177582)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11079898658297912939)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11064173044334160835)
,p_name=>'OCULTAR'
,p_event_sequence=>310
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11064172969484160834)
,p_event_id=>wwv_flow_api.id(11064173044334160835)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11095060707721305845)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11062741021083678459)
,p_event_id=>wwv_flow_api.id(11064173044334160835)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(11104348564234206168)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11062740938676678458)
,p_event_id=>wwv_flow_api.id(11064173044334160835)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(11104348608042206169)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11016067431324583697)
,p_event_id=>wwv_flow_api.id(11064173044334160835)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11096802899755722783)
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11042648383717307140)
,p_name=>'ACT_VSC'
,p_event_sequence=>320
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11042649164409307148)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11042648195202307139)
,p_event_id=>wwv_flow_api.id(11042648383717307140)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  PERL051.PP_VAC_SEL_CONT (:P_EMPRESA , ',
'                            :P3528_FECHA_HASTA) ;'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11042648182014307138)
,p_event_id=>wwv_flow_api.id(11042648383717307140)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11042649228458307149)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11040220676536515240)
,p_event_id=>wwv_flow_api.id(11042648383717307140)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11041772222937731357)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11040220492964515239)
,p_event_id=>wwv_flow_api.id(11042648383717307140)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11040223577000515269)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11040220331458515237)
,p_event_id=>wwv_flow_api.id(11042648383717307140)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11040222897938515263)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11040220226378515236)
,p_event_id=>wwv_flow_api.id(11042648383717307140)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11041214999894734034)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11040220143148515235)
,p_event_id=>wwv_flow_api.id(11042648383717307140)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11040221889380515253)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11039199659267651842)
,p_event_id=>wwv_flow_api.id(11042648383717307140)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>'Registro Actualizado'
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11035010979306822953)
,p_name=>'clic_actualizar_marc'
,p_event_sequence=>330
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11035011066592822954)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11035010837427822952)
,p_event_id=>wwv_flow_api.id(11035010979306822953)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  PERL051.PP_MARCACION_NUEVO (:P_EMPRESA, ',
'                              :P3528_FECHA_HASTA) ;'))
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11035010678679822951)
,p_event_id=>wwv_flow_api.id(11035010979306822953)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11035011628453822960)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11033273737731569236)
,p_event_id=>wwv_flow_api.id(11035010979306822953)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11033274622533569245)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11033098815744406478)
,p_event_id=>wwv_flow_api.id(11035010979306822953)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11033273534543569234)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11033097711403406467)
,p_event_id=>wwv_flow_api.id(11035010979306822953)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11033098285051406472)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11033098722825406477)
,p_event_id=>wwv_flow_api.id(11035010979306822953)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_PRETIUS_COM_NOTIFICATIONS'
,p_attribute_01=>'SUCCESS'
,p_attribute_02=>'NOTIFICATION'
,p_attribute_03=>'.t-Body-main'
,p_attribute_04=>'0'
,p_attribute_05=>'TOP'
,p_attribute_06=>'STATIC'
,p_attribute_07=>'REGISTRO ACTUALIZADO'
,p_attribute_08=>'REMOVE'
,p_attribute_10=>'TOPRIGHT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11034897256769764504)
,p_name=>'Nuevo_1'
,p_event_sequence=>340
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(11017389204963157962)
,p_bind_type=>'bind'
,p_bind_event_type=>'NATIVE_IG|REGION TYPE|interactivegridreportchange'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11034897384418764505)
,p_event_id=>wwv_flow_api.id(11034897256769764504)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(11017389204963157962)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11033664669937094571)
,p_name=>'clic_act_ausencia'
,p_event_sequence=>350
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11033664728298094572)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11033664533784094570)
,p_event_id=>wwv_flow_api.id(11033664669937094571)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  -- CALL THE PROCEDURE',
'  PERL051.PP_AUSENCIAS(P_EMPRESA     => :P_EMPRESA,',
'                       P_FECHA       => :P3528_FECHA_HASTA,',
'                       P_SESSION     => :APP_SESSION);',
'END;'))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11033155909579196448)
,p_event_id=>wwv_flow_api.id(11033664669937094571)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11020244112780730225)
,p_name=>'al_clic_actualizar'
,p_event_sequence=>360
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(11095121227041088160)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11020243932381730224)
,p_event_id=>wwv_flow_api.id(11020244112780730225)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(11095121227041088160)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(10974594541997436296)
,p_name=>'clic_rot_cargo'
,p_event_sequence=>370
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(10974594613841436297)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10974594446503436295)
,p_event_id=>wwv_flow_api.id(10974594541997436296)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  -- CALL THE PROCEDURE',
'  PERL051.PP_ROTACION_CARGO (:P_EMPRESA,',
'						     :P3528_FECHA_HASTA);',
'END;',
''))
,p_attribute_02=>'P3528_FECHA_HASTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10974594358167436294)
,p_event_id=>wwv_flow_api.id(10974594541997436296)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(10982579046441464458)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(11035222997207842653)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'al_clic_actualizar_todo'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'X_CANTIDAD NUMBER;',
'',
'BEGIN',
'SELECT count (*)',
' INTO X_CANTIDAD',
'  FROM APEX_200100.WWV_FLOW_SESSIONS$ a',
'  where username||'':''||ID in (select T.CLIENT_IDENTIFIER',
'from v$session t',
'where module like ''%APEX:APP 103:3528%'');',
'if X_CANTIDAD > 1 then',
'',
unistr('RAISE_APPLICATION_ERROR (-20001,''Actualmente existe un proceso en ejecuci\00F3n - Espere un momento'');'),
'end if;',
'END;',
'',
'IF :P3528_FECHA_HASTA IS NULL THEN',
' RAISE_APPLICATION_ERROR (-20001,''La fecha no puede quedar vacia'');',
'END IF;',
'',
'IF  TO_CHAR(TO_DATE(:P3528_FECHA_HASTA),''D'') = 7  OR  LAST_DAY(TO_DATE(:P3528_FECHA_HASTA)) = :P3528_FECHA_HASTA THEN',
'',
'',
'',
'',
'if :P_EMPRESA = 1 THEN',
'PERL051.PP_ESTRUCTURA_DETALLE(P_FECHA => :P3528_FECHA_HASTA,',
'                               P_EMPRESA => :P_EMPRESA,',
'                               P_DIAS_LABORAL=> :P3528_EST_DIAS_TRA,',
'                               P_DIAS_HABILES => :P3528_EST_DIAS_HAB,',
'                               P_DOTAC_M3    => :P3528_MES3_DOT,',
'                               P_OBJETIVO_KG => :P3528_OBJ_KG,',
'                               P_OBJETIVO_GS => :P3528_OBJ_GS);',
'                               ',
' PERL051.PP_TABLERO_COMERCIAL  (P_EMPRESA  => :P_EMPRESA,',
'                                P_FECHA    => :P3528_FECHA_HASTA);  ',
'',
'  PERL051.PP_TABLERO_INDUSTRIAL  (P_EMPRESA  => :P_EMPRESA,',
'                                P_FECHA    => :P3528_FECHA_HASTA); ',
'                                ',
'                           ',
'',
'PERL051.PP_NUEVO_ESTRUCTURA (P_EMPRESA => :P_EMPRESA,',
'                                P_FECHA    => :P3528_FECHA_HASTA);  ',
'                                ',
'PERL051.PP_DOTACION(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);',
'PERL051.PP_PROCESO_SELECCION_VAC(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);',
'PERL051.PP_PROCESO_SELECCION_CONT(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);',
' PERL051.PP_PROCESO_SELECCION_SELC(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);',
'PERL051.PP_PROCESO_SELECCION_RSC(P_EMPRESA =>:P_EMPRESA,',
'                           P_FECHA => :P3528_FECHA_HASTA);',
'PERL051.PP_PROCESO_CONTRATACIONES(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);',
'PERL051.PP_PROCESO_DESVINCULACION(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);',
'PERL051.PP_PROCESO_INDICE_ROTACION(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);   ',
' PERL051.PP_VAC_SEL_CONT (:P_EMPRESA , ',
'                            :P3528_FECHA_HASTA) ;     ',
'                            ',
'PERL051.PP_PROCESO_MARCACIONES(P_EMPRESA =>:P_EMPRESA,',
'                            P_FECHA => :P3528_FECHA_HASTA);     ',
'                                ',
'',
'                                      ',
' PERL051.PP_AUSENCIAS(P_EMPRESA     => :P_EMPRESA,',
'                       P_FECHA       => :P3528_FECHA_HASTA,',
'                       P_SESSION     => :APP_SESSION);',
'',
'                                                          ',
'                            ',
'PERL051.PP_GUARDAR_DATOS_MARCACIONES (P_OPCION => ''f'',',
'                                      P_FECHA  => :P3528_FECHA_HASTA,',
'                                   p_EMPRESA => :P_EMPRESA);          ',
'                                   ',
'                                   ',
'END IF;',
'IF :P_EMPRESA = 2 THEN',
'',
'PERL051.PP_PROCESO_MARCACIONES(P_EMPRESA =>:P_EMPRESA,',
'                            P_FECHA => :P3528_FECHA_HASTA);     ',
'                                ',
'',
'                                      ',
' PERL051.PP_AUSENCIAS(P_EMPRESA     => :P_EMPRESA,',
'                       P_FECHA       => :P3528_FECHA_HASTA,',
'                       P_SESSION     => :APP_SESSION);',
'',
'                                                          ',
'                            ',
'      ',
'                                   ',
'PERL051.PP_PROCESO_CONTRATACIONES(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);',
'PERL051.PP_PROCESO_DESVINCULACION(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);',
'                                  ',
'                                  ',
' PERL051.PP_DOTACION(P_EMPRESA =>:P_EMPRESA,',
'                             P_FECHA => :P3528_FECHA_HASTA);',
'',
'END IF;',
'',
'',
'ELSE',
' RAISE_APPLICATION_ERROR (-20001,''La fecha de filtro solo puede ser domingo'');',
'END IF;',
'',
'PERL051.PP_GUARDAR_DATOS_MARCACIONES (P_OPCION => ''f'',',
'                                      P_FECHA  => :P3528_FECHA_HASTA,',
'                                   p_EMPRESA => :P_EMPRESA);    '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(11095121227041088160)
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
