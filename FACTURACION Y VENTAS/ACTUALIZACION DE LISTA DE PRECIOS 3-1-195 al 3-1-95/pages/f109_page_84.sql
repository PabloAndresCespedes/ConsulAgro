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
,p_default_application_id=>109
,p_default_id_offset=>15440771937534814
,p_default_owner=>'ADCS'
);
end;
/
 
prompt APPLICATION 109 - FACTURACION Y VENTAS
--
-- Application Export:
--   Application:     109
--   Name:            FACTURACION Y VENTAS
--   Date and Time:   08:45 Tuesday June 21, 2022
--   Exported By:     PABLOC
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 84
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     211687171918188
--

begin
null;
end;
/
prompt --application/pages/delete_00084
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>84);
end;
/
prompt --application/pages/page_00084
begin
wwv_flow_api.create_page(
 p_id=>84
,p_user_interface_id=>wwv_flow_api.id(25547296363951795)
,p_name=>'Historico de Precios Lista'
,p_alias=>'HISTORICO-DE-PRECIOS-LISTA'
,p_page_mode=>'MODAL'
,p_step_title=>'Historico de Precios Lista'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>'.cursor{cursor:pointer;font-size: 2.5rem;}'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'60%'
,p_last_updated_by=>'PABLOC'
,p_last_upd_yyyymmddhh24miss=>'20220621074423'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(678980851611168935)
,p_plug_name=>'Detalle'
,p_region_name=>'detail'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(25513702711951745)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'PLUGIN_DEV.HARTENFELLER.SLIDEOVER'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'Detalle Listado'
,p_attribute_02=>'60%'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(678981070190168937)
,p_plug_name=>'{detailList}'
,p_parent_plug_id=>wwv_flow_api.id(678980851611168935)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(25513205524951745)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d.liprh_precio_anterior,',
'       d.liprh_precio_us,',
'       a.art_codigo cod_art,',
'       a.art_desc   articulo',
'from fac_lista_precio_det_hist d',
'inner join stk_articulo a on (a.art_codigo = d.liprh_art)',
'where d.liprh_empr = :P_EMPRESA',
'and   d.liprh_nro_lista_precio = :P84_NRO_LISTA',
'and   to_char(d.liprh_fecha_cambio, ''dd/mm/yyyy hh24:mi:ss'') = :P84_FECHA_DETAIL',
'order by d.liprh_fecha_cambio desc;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P84_FECHA_DETAIL,P84_NRO_LISTA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'{detailList}'
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
 p_id=>wwv_flow_api.id(678982226919168949)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'PABLOC'
,p_internal_uid=>678982226919168949
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(679341441737094203)
,p_db_column_name=>'COD_ART'
,p_display_order=>10
,p_column_identifier=>'D'
,p_column_label=>'Cod Art'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(679341307351094202)
,p_db_column_name=>'ARTICULO'
,p_display_order=>20
,p_column_identifier=>'C'
,p_column_label=>unistr('Art\00EDculo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(678982365659168950)
,p_db_column_name=>'LIPRH_PRECIO_ANTERIOR'
,p_display_order=>30
,p_column_identifier=>'A'
,p_column_label=>'Precio'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(679341245708094201)
,p_db_column_name=>'LIPRH_PRECIO_US'
,p_display_order=>40
,p_column_identifier=>'B'
,p_column_label=>'Precio Us'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(679349395066104263)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6793494'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>10
,p_report_columns=>'COD_ART:ARTICULO:LIPRH_PRECIO_ANTERIOR:LIPRH_PRECIO_US:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(679313406439929512)
,p_plug_name=>'Listado'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(25513205524951745)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select to_char(d.liprh_fecha_cambio, ''dd/mm/yyyy hh24:mi:ss'') fecha,',
'       d.liprh_nro_lista_precio nro,',
'       d.liprh_usuario,',
'       count(1) total,',
'       '''' ver,',
'       '''' volver_atras',
'from fac_lista_precio_det_hist d',
'where d.liprh_empr = :P_EMPRESA',
'and   d.liprh_nro_lista_precio = :P84_NRO_LISTA',
'group by to_char(d.liprh_fecha_cambio, ''dd/mm/yyyy hh24:mi:ss''),',
'         d.liprh_usuario,',
'         d.liprh_nro_lista_precio,',
'         d.liprh_precio_anterior',
'order by max(d.liprh_fecha_cambio) desc;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P84_NRO_LISTA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Listado'
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
 p_id=>wwv_flow_api.id(678979753172168924)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>unistr('Sin Hist\00F3rico registrado')
,p_search_button_label=>'Buscar'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'PABLOC'
,p_internal_uid=>678979753172168924
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(678980153040168928)
,p_db_column_name=>'NRO'
,p_display_order=>10
,p_column_identifier=>'B'
,p_column_label=>'Nro'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(678980077290168927)
,p_db_column_name=>'FECHA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Fecha'
,p_column_type=>'STRING'
,p_format_mask=>'dd/mm/yyyy hh24:mi:ss'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(678980457623168931)
,p_db_column_name=>'TOTAL'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Total'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(678980625116168933)
,p_db_column_name=>'LIPRH_USUARIO'
,p_display_order=>40
,p_column_identifier=>'E'
,p_column_label=>'Usuario'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(678980566409168932)
,p_db_column_name=>'VER'
,p_display_order=>50
,p_column_identifier=>'D'
,p_column_label=>'Ver'
,p_column_html_expression=>'<span class="fa fa-search-plus cursor" aria-hidden="true" onclick="apex.item(''P84_FECHA_DETAIL'').setValue(''#FECHA#'')"></span>'
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
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(679341523657094204)
,p_db_column_name=>'VOLVER_ATRAS'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Volver Atr\00E1s')
,p_column_html_expression=>'<span aria-hidden="true" class="fa fa-rotate-left cursor u-danger-text" onclick="apex.item(''P84_FECHA_REVERSION'').setValue(''#FECHA#'')"></span>'
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
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(679318087488960460)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6793181'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>10
,p_report_columns=>'FECHA:NRO:TOTAL:LIPRH_USUARIO:VER:VOLVER_ATRAS'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(678979848803168925)
,p_name=>'P84_NRO_LISTA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(679313406439929512)
,p_prompt=>'Nro Lista'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_tag_css_classes=>'u-textCenter u-bold'
,p_tag_attributes=>'style="border-style: double;"'
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(678981134225168938)
,p_name=>'P84_FECHA_DETAIL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(678980851611168935)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(679341613864094205)
,p_name=>'P84_FECHA_REVERSION'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(679313406439929512)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(679341908382094208)
,p_name=>'P84_REVERSION_ERROR'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(679313406439929512)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(678981990497168946)
,p_name=>'open and refresh'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P84_FECHA_DETAIL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(678982080917168947)
,p_event_id=>wwv_flow_api.id(678981990497168946)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(678980851611168935)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(678982145435168948)
,p_event_id=>wwv_flow_api.id(678981990497168946)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(678981070190168937)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(679341794944094206)
,p_name=>'reversion'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P84_FECHA_REVERSION'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(679342606668094215)
,p_event_id=>wwv_flow_api.id(679341794944094206)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CONFIRM'
,p_attribute_01=>unistr('\00BFEst\00E1 seguro/a que quiere volver a \00E9sta Lista?')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(679341808204094207)
,p_event_id=>wwv_flow_api.id(679341794944094206)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'facm070.revert_from_history(in_nro_lista => to_number(:P84_NRO_LISTA),',
'                            in_fecha     => :P84_FECHA_REVERSION,',
'                            in_empresa   => :P_EMPRESA',
'                            );',
':P84_REVERSION_ERROR := null;',
'exception',
'when  others then',
':P84_REVERSION_ERROR := replace(sqlerrm, ''ORA-20000:'', '''');',
'end;'))
,p_attribute_02=>'P84_NRO_LISTA,P84_FECHA_REVERSION'
,p_attribute_03=>'P84_REVERSION_ERROR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(679342486285094213)
,p_event_id=>wwv_flow_api.id(679341794944094206)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'REVERSION'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(679342005768094209)
,p_name=>'Show or view errors REVERSION'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P84_REVERSION_ERROR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(679342114183094210)
,p_event_id=>wwv_flow_api.id(679342005768094209)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.clearErrors();',
'let error = apex.item(''P84_REVERSION_ERROR'');',
'',
'if(error.isEmpty()){',
'    null;',
'}else{',
'    apex.message.showErrors([',
'        {',
'            type:       "error",',
'            location:   "page",',
'            message:    error.getValue(),',
'            unsafe:     false',
'        }',
'    ]);',
'}'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(679342510339094214)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close after Reversion'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'REVERSION'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
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
