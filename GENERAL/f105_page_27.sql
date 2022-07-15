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
--   Date and Time:   13:56 Viernes Julio 15, 2022
--   Exported By:     PABLOC
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 27
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     211687171918188
--

begin
null;
end;
/
prompt --application/pages/delete_00027
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>27);
end;
/
prompt --application/pages/page_00027
begin
wwv_flow_api.create_page(
 p_id=>27
,p_user_interface_id=>wwv_flow_api.id(12932509144876455)
,p_name=>'Operadores Externos'
,p_alias=>'OPERADORES-EXTERNOS'
,p_step_title=>'Operadores Externos'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'PABLOC'
,p_last_upd_yyyymmddhh24miss=>'20220715114233'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(698690588470224658)
,p_plug_name=>'Informe 1'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(12898485531876360)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'GEN_OPERADOR_EXTERNO'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Informe 1'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(698690910539224659)
,p_name=>'Informe 1'
,p_max_row_count_message=>unistr('El recuento m\00E1ximo de filas de este informe es #MAX_ROW_COUNT# filas. Aplique un filtro para reducir el n\00FAmero de registros de la consulta.')
,p_no_data_found_message=>unistr('No se ha encontrado ning\00FAn dato.')
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:28:&SESSION.::&DEBUG.:RP,:P28_ID:\#ID#\'
,p_detail_link_text=>'<span aria-label="Editar"><span class="fa fa-edit" aria-hidden="true" title="Editar"></span></span>'
,p_owner=>'PABLOC'
,p_internal_uid=>698690910539224659
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(698691022324224661)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Cargos'
,p_column_link=>'f?p=&APP_ID.:30:&SESSION.::&DEBUG.::P30_OPERADOR_EXTERNO:\#ID#\'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(698691460913224664)
,p_db_column_name=>'THE_USER'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Usuario Login'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(698694028814227039)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6986941'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'THE_USER:ID:'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(698692826120224666)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(698690588470224658)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(12921796741876415)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Crear'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:28:&SESSION.::&DEBUG.:28'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(698691889602224664)
,p_name=>unistr('Editar Informe: Cuadro de Di\00E1logo Cerrado')
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(698690588470224658)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(698692320578224666)
,p_event_id=>wwv_flow_api.id(698691889602224664)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(698690588470224658)
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
