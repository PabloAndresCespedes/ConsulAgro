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
--   Date and Time:   08:02 Friday July 15, 2022
--   Exported By:     PABLOC
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 2530
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     211687171918188
--

begin
null;
end;
/
prompt --application/pages/delete_02530
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>2530);
end;
/
prompt --application/pages/page_02530
begin
wwv_flow_api.create_page(
 p_id=>2530
,p_user_interface_id=>wwv_flow_api.id(540613735099119926)
,p_name=>'PERP007 - IMPORTACION DE MARCACION DIARIA'
,p_step_title=>' IMPORTACION DE MARCACION DIARIA'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let regHistory = ''regHistory'';',
'let regDetail = ''regDetail'';',
'',
'function viewHistory({fileName}){',
'    $s(''P2530_FILE_NAME'', fileName);',
'    apex.region( regDetail ).refresh();',
'    apex.theme.closeRegion( regHistory );',
'}'))
,p_css_file_urls=>'.cursor{cursor: pointer;}'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'PABLOC'
,p_last_upd_yyyymmddhh24miss=>'20220715075557'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(580001545952770057)
,p_plug_name=>'IMPORTACION DE MARCACION DIARIA'
,p_region_template_options=>'#DEFAULT#:t-Region--accent4:t-Region--scrollBody:t-Form--large'
,p_plug_template=>wwv_flow_api.id(540580141447119876)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P_EMPRESA<= 3'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(583696222858101726)
,p_plug_name=>'Codigos de reloj sin codigo de empleado'
,p_region_template_options=>'#DEFAULT#:t-Region--accent3:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(540580141447119876)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P_EMPRESA<= 3'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(580895466950668223)
,p_plug_name=>'detalle'
,p_parent_plug_id=>wwv_flow_api.id(583696222858101726)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(540579644260119876)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * from PERP007_TEMP',
'where app_session=:app_session',
'and usuario=:app_user'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_read_only_when_type=>'DISPLAYING_INLINE_VALIDATION_ERRORS'
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
 p_id=>wwv_flow_api.id(583698603850101750)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MVERA'
,p_internal_uid=>150071717235225631
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(583698763827101751)
,p_db_column_name=>'CODIGO'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Codigo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(583698845442101752)
,p_db_column_name=>'NOMBRE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nombre'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(584168190116102242)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1505414'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'CODIGO:NOMBRE'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(781275763075183274)
,p_plug_name=>'Vendedor- Empleado'
,p_parent_plug_id=>wwv_flow_api.id(583696222858101726)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(540579644260119876)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT to_number(DETALLE) cod_vend, MES1 FROM PRDL051_TEMP_TVC ',
'WHERE P_SESSION = :APP_SESSION',
'GROUP BY DETALLE, MES1'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :APP_USER IN (''MAREK'', ''ADCS'') THEN',
'',
'RETURN TRUE;',
'ELSE ',
'RETURN FALSE;',
'END IF;'))
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Vendedor- Empleado'
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
 p_id=>wwv_flow_api.id(781275907662183275)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'LVILLASANTI'
,p_internal_uid=>487454648685449727
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(781276060274183277)
,p_db_column_name=>'MES1'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nombre'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(781276297464183279)
,p_db_column_name=>'COD_VEND'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Cod Vend'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(782633302347756527)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'4888121'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_VEND:MES1:'
,p_sort_column_1=>'DETALLE'
,p_sort_direction_1=>'ASC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(7833212516317539519)
,p_plug_name=>'IMPORTAR HORAS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(540580141447119876)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P_EMPRESA > 3'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(7833212742079539521)
,p_name=>'Datos Importados'
,p_region_name=>'regDetail'
,p_parent_plug_id=>wwv_flow_api.id(7833212516317539519)
,p_template=>wwv_flow_api.id(540580141447119876)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--showIcon:t-Region--accent14:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--inline'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select marc_fecha fecha,',
'       marc_empleado empleado,',
'       case marc_evento when ''E'' then ''Entrada'' when ''S'' then ''Salida'' else marc_evento end tipo,',
'       marc_hora hora,',
'       marc_login usuario,',
'       marc_fecha_grab cargado,',
'       marc_origen',
'from per_marcacion_diaria m',
'where marc_empr = :p_empresa',
'and   marc_file_name = :P2530_FILE_NAME'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P2530_FILE_NAME'
,p_query_row_template=>wwv_flow_api.id(540590157911119886)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'<h4 class="u-textCenter">Seleccione un archivo y luego presione <strong>Cargar Registros</strong></h4>'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7833215598565539549)
,p_query_column_id=>1
,p_column_alias=>'FECHA'
,p_column_display_sequence=>3
,p_column_heading=>'Fecha'
,p_use_as_row_header=>'N'
,p_column_format=>'dd/mm/yyyy'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7833215682388539550)
,p_query_column_id=>2
,p_column_alias=>'EMPLEADO'
,p_column_display_sequence=>1
,p_column_heading=>'Empleado'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'TEXT_FROM_LOV_ESC'
,p_named_lov=>wwv_flow_api.id(533472941678607573)
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8379648585705338301)
,p_query_column_id=>3
,p_column_alias=>'TIPO'
,p_column_display_sequence=>2
,p_column_heading=>'Tipo'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8379648668794338302)
,p_query_column_id=>4
,p_column_alias=>'HORA'
,p_column_display_sequence=>4
,p_column_heading=>'Hora'
,p_use_as_row_header=>'N'
,p_column_format=>'hh24:mi:ss'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8379648793240338303)
,p_query_column_id=>5
,p_column_alias=>'USUARIO'
,p_column_display_sequence=>5
,p_column_heading=>'Usuario'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8379648832389338304)
,p_query_column_id=>6
,p_column_alias=>'CARGADO'
,p_column_display_sequence=>6
,p_column_heading=>'Cargado'
,p_use_as_row_header=>'N'
,p_column_format=>'dd/mm/yyyy hh24:mi:ss'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7833213951509539533)
,p_query_column_id=>7
,p_column_alias=>'MARC_ORIGEN'
,p_column_display_sequence=>7
,p_column_heading=>'Marc Origen'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(8379649244637338308)
,p_name=>unistr('Hist\00F3rico de Archivos')
,p_region_name=>'regHistory'
,p_template=>wwv_flow_api.id(540578655600119875)
,p_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d.marc_fecha_grab fecha,',
'       d.marc_file_name  archivo,',
'       count(1)          registros',
'from per_marcacion_diaria d',
'where nvl(:P2530_LAZY, ''N'') = ''Y'' ',
'and d.marc_empr=:p_empresa',
'group by d.marc_file_name,',
'         d.marc_fecha_grab'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P2530_LAZY'
,p_query_row_template=>wwv_flow_api.id(540590157911119886)
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8379649535278338311)
,p_query_column_id=>1
,p_column_alias=>'FECHA'
,p_column_display_sequence=>1
,p_column_heading=>'Fecha'
,p_use_as_row_header=>'N'
,p_column_format=>'dd/mm/yyyy hh24:mi'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8379649356791338309)
,p_query_column_id=>2
,p_column_alias=>'ARCHIVO'
,p_column_display_sequence=>2
,p_column_heading=>'Archivo'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8379649497519338310)
,p_query_column_id=>3
,p_column_alias=>'REGISTROS'
,p_column_display_sequence=>3
,p_column_heading=>'Registros'
,p_use_as_row_header=>'N'
,p_column_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8379649674195338312)
,p_query_column_id=>4
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>4
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'#'
,p_column_linktext=>'<span class="fa fa-search cursor u-success-text" aria-hidden="true"></span>'
,p_column_link_attr=>'title="Ver Registros" onclick="viewHistory({fileName: ''#ARCHIVO#''})"'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7833214972153539543)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(7833212516317539519)
,p_button_name=>'ADD_DATA'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(540603025475119903)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cargar Registros'
,p_button_position=>'BODY'
,p_button_css_classes=>'u-pullRight'
,p_icon_css_classes=>'fa-upload'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(781275719361183273)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(580001545952770057)
,p_button_name=>'Importar_cast'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(540603025475119903)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Importar Cast'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :APP_USER IN (''TOMASM'', ''ADCS'',''LIZAG'',''JBENITEZ'') THEN',
'',
'',
'RETURN TRUE;',
'ELSE ',
'RETURN FALSE;',
'END IF;'))
,p_button_condition_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(580895107792668220)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(580001545952770057)
,p_button_name=>'IMPORTAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(540603025475119903)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Importar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8379649188541338307)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(7833212742079539521)
,p_button_name=>'VIEW_HISTORY'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--warning'
,p_button_template_id=>wwv_flow_api.id(540602880264119902)
,p_button_image_alt=>unistr('Ver Hist\00F3rico de Archivos')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(581267890140257698)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(580895466950668223)
,p_button_name=>'refrescar'
,p_button_static_id=>'BT_REFRESCAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(540602880264119902)
,p_button_image_alt=>'Refrescar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P_EMPRESA'
,p_button_condition2=>'3'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(580001642218770058)
,p_name=>'P2530_PERIODO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(580001545952770057)
,p_prompt=>'Periodo:'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_CHAR(PERI_FEC_INI,''DD-MM-YYYY'')||'' AL ''|| TO_CHAR(PERI_FEC_FIN,''DD-MM-YYYY'') FECHA , PERI_CODIGO',
'FROM PER_PERIODO P ',
'WHERE PERI_EMPR =:P_EMPRESA',
'ORDER BY 1 DESC'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(540602382713119900)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(580001713994770059)
,p_name=>'P2530_FEC_INI'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(580001545952770057)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(540602382713119900)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(580001797292770060)
,p_name=>'P2530_FEC_FIN'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(580001545952770057)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(540602382713119900)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(580002142556770063)
,p_name=>'P2530_RUTA_ARCHIVO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(580001545952770057)
,p_prompt=>'Ruta Archivo'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(540602663422119900)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'SESSION'
,p_attribute_10=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(581724851217596657)
,p_name=>'P2530_MENSAJE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(583696222858101726)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7833212647751539520)
,p_name=>'P2530_ARCHIVO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(7833212516317539519)
,p_prompt=>'Archivo'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(594168985020855809)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--xlarge'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'SESSION'
,p_attribute_10=>'N'
,p_attribute_11=>'cvs'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8379648998420338305)
,p_name=>'P2530_FILE_NAME'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(7833212516317539519)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8379650097552338316)
,p_name=>'P2530_LAZY'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(8379649244637338308)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(8379650172708338317)
,p_computation_sequence=>10
,p_computation_item=>'P2530_LAZY'
,p_computation_point=>'AFTER_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(8379649034529338306)
,p_computation_sequence=>10
,p_computation_item=>'P2530_FILE_NAME'
,p_computation_type=>'ITEM_VALUE'
,p_computation=>'P2530_ARCHIVO'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(7833215467814539548)
,p_validation_name=>'format file'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'lower( :P31_FILE ) like ''%.xlsx'' or',
'lower( :P31_FILE ) like ''%.xml'' or',
'lower( :P31_FILE ) like ''%.csv'''))
,p_validation_type=>'PLSQL_EXPRESSION'
,p_error_message=>unistr('Formato de archivo no v\00E1lido, solo CSV')
,p_when_button_pressed=>wwv_flow_api.id(7833214972153539543)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(580001943248770061)
,p_name=>'AL CARGAR'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(580002037988770062)
,p_event_id=>wwv_flow_api.id(580001943248770061)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
' SELECT TO_CHAR(PERI_FEC_INI,''DD-MM-YYYY'') FEC_INI, TO_CHAR(PERI_FEC_FIN,''DD-MM-YYYY'') FEC_FIN , PERI_CODIGO',
'INTO :P2530_FEC_INI,:P2530_FEC_FIN, :P2530_PERIODO',
'FROM PER_PERIODO P ',
'WHERE PERI_EMPR =:P_EMPRESA',
'---and PERI_CODIGO=:P2530_PERIODO',
'  AND TRUNC(SYSDATE) BETWEEN PERI_FEC_INI AND PERI_FEC_FIN;',
'',
'',
''))
,p_attribute_02=>'P2530_PERIODO,P2530_MENSAJE'
,p_attribute_03=>'P2530_PERIODO,P2530_FEC_INI,P2530_FEC_FIN'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(582037534363579444)
,p_event_id=>wwv_flow_api.id(580001943248770061)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P2530_IMAGEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(583695698467101721)
,p_name=>'AL CAMBIAR'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P2530_PERIODO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(583695789714101722)
,p_event_id=>wwv_flow_api.id(583695698467101721)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'V_FECHA_INI DATE;',
'V_FECHA_FIN DATE;',
'BEGIN',
'',
'  perp007.pp_mostrar_periodo(:p_empresa,',
'                             :P2530_PERIODO,',
'                              V_FECHA_INI,',
'                              V_FECHA_FIN);',
'',
'',
'SELECT TO_CHAR(PERI_FEC_INI,''DD-MM-YYYY'') FEC_INI, TO_CHAR(PERI_FEC_FIN,''DD-MM-YYYY'') FEC_FIN ',
'INTO :P2530_FEC_INI,:P2530_FEC_FIN',
'FROM PER_PERIODO P ',
'WHERE PERI_EMPR =:P_EMPRESA',
'and PERI_CODIGO=:P2530_PERIODO;',
' END ;'))
,p_attribute_02=>'P2530_PERIODO'
,p_attribute_03=>'P2530_FEC_INI,P2530_FEC_FIN'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(581267695324257697)
,p_name=>'Refrescar'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(581267890140257698)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(581267681700257696)
,p_event_id=>wwv_flow_api.id(581267695324257697)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(580895466950668223)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8379649717929338313)
,p_name=>'view history'
,p_event_sequence=>100
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8379649188541338307)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8379649874871338314)
,p_event_id=>wwv_flow_api.id(8379649717929338313)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.theme.openRegion( regHistory );',
'apex.item(''P2530_LAZY'').setValue(''Y'');',
'apex.region( regHistory ).refresh();'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(581269085075257710)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRUEBA'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'/*IF :P_EMPRESA <> 3 THEN',
'IF :P2530_MENSAJE  like  ''Existen marcaciones'' THEN',
'  RAISE_APPLICATION_ERROR(-20001,''Existen marcaciones que no tienen asignado empleado.'');',
'  END IF;',
'END IF;*/',
'',
'NULL;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(582038097397579450)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Actualizar Marcaciones'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
':P2530_MENSAJE:=NULL;',
'  -- CALL THE PROCEDURE',
'  PERP007.PP_ACTUALIZAR_REGISTRO(P_EMPRESA => :P_EMPRESA,',
'                                 P_SUCURSAL => :P_SUCURSAL,',
'                                 P_RUTA_ARCHIVO => :P2530_RUTA_ARCHIVO,',
'                                 P_APP_SESSION => :APP_SESSION,',
'                                 P_USUARIO => :APP_USER,',
'                                 P_MENSAJE => :P2530_MENSAJE);',
'END;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(580895107792668220)
,p_process_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'&P2530_MENSAJE.',
''))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(781276241126183278)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'IMPORTAR_CAST'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  -- CALL THE PROCEDURE',
'  PERP007.PP_PROCESAR_CAST(P_EMPRESA  => :P_EMPRESA,',
'                           P_FEC_INI  => :P2530_FEC_INI,',
'                           P_FEC_HAST => :P2530_FEC_FIN);',
'END;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(781275719361183273)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(7833215251209539546)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'newImportData'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'perp007.import_hours(in_empresa  => :p_empresa,',
'                     in_user     => :app_user,',
'                     in_filename => :P2530_ARCHIVO',
'                    );'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(7833214972153539543)
,p_process_success_message=>'Registros importados correctamente'
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
