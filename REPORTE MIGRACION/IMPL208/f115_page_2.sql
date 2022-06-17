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
,p_default_application_id=>115
,p_default_id_offset=>80035140186936010
,p_default_owner=>'ADCS'
);
end;
/
 
prompt APPLICATION 115 - IMPORTACIONES
--
-- Application Export:
--   Application:     115
--   Name:            IMPORTACIONES
--   Date and Time:   08:45 Friday June 17, 2022
--   Exported By:     PABLOC
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 2
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     211687171918188
--

begin
null;
end;
/
prompt --application/pages/delete_00002
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>2);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_api.create_page(
 p_id=>2
,p_user_interface_id=>wwv_flow_api.id(154456732393772809)
,p_name=>'IMPL208 - Reporte de Importaciones'
,p_alias=>'IMPL208-REPORTE-DE-IMPORTACIONES'
,p_step_title=>'IMPL208 - Reporte de Importaciones'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'PABLOC'
,p_last_upd_yyyymmddhh24miss=>'20220617084011'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(677465807183939514)
,p_plug_name=>'Aviso'
,p_region_template_options=>'#DEFAULT#:t-Alert--colorBG:t-Alert--wizard:t-Alert--defaultIcons:t-Alert--warning'
,p_plug_template=>wwv_flow_api.id(154411338300772747)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>unistr('<center>\00C9ste programa solo se encuentra disponible para la empresa de TransAgro</center>')
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'2'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(677465977059939515)
,p_plug_name=>'IMPL208 - Reporte de importaciones'
,p_region_template_options=>'#DEFAULT#:t-Region--accent4:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(154423138741772759)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>7
,p_plug_display_column=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P_EMPRESA'
,p_plug_display_when_cond2=>'2'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(677466109803939517)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(677465977059939515)
,p_button_name=>'VIEW'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(154446022769772786)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'u-pullRight'
,p_icon_css_classes=>'fa-print'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(677466007796939516)
,p_name=>'P2_NRO_IMPORTACION'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(677465977059939515)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Nro Importaci\00F3n')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.imp_nro||''-''||m.marc_desc ||'' (Clave Int. ''|| i.imp_clave ||'')'' d,',
'       i.imp_clave r',
'from imp_importacion i',
'inner join stk_marca m on (m.marc_codigo = i.imp_marca)',
'group by i.imp_nro,',
'         i.imp_clave,',
'         m.marc_desc'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Ninguno'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(87749870790316679)
,p_item_template_options=>'#DEFAULT#'
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
 p_id=>wwv_flow_api.id(677466401153939520)
,p_name=>'P2_URL'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(677465977059939515)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(677466240098939518)
,p_name=>'get report url'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(677466109803939517)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(677466302943939519)
,p_event_id=>wwv_flow_api.id(677466240098939518)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P2_URL := impl208.get_report(in_clave_importacion => :P2_NRO_IMPORTACION, in_empresa => :P_EMPRESA);'
,p_attribute_02=>'P2_NRO_IMPORTACION'
,p_attribute_03=>'P2_URL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(677466523739939521)
,p_name=>'open tab window'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P2_URL'
,p_condition_element=>'P2_URL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(677466627148939522)
,p_event_id=>wwv_flow_api.id(677466523739939521)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.navigation.openInNewWindow( apex.item(''P2_URL'').getValue(), "IMPL208" );'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(677466744898939523)
,p_name=>'Validate View'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P2_NRO_IMPORTACION'
,p_condition_element=>'P2_NRO_IMPORTACION'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'live'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(677466829976939524)
,p_event_id=>wwv_flow_api.id(677466744898939523)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(677466109803939517)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(677466976732939525)
,p_event_id=>wwv_flow_api.id(677466744898939523)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(677466109803939517)
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
