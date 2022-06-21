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
--   Date and Time:   13:10 Tuesday June 21, 2022
--   Exported By:     PABLOC
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 48
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     211687171918188
--

begin
null;
end;
/
prompt --application/pages/delete_00048
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>48);
end;
/
prompt --application/pages/page_00048
begin
wwv_flow_api.create_page(
 p_id=>48
,p_user_interface_id=>wwv_flow_api.id(25547296363951795)
,p_name=>'FACI240 - PEDIDO VENTA INSUM'
,p_alias=>'FACI240-PEDIDO-VENTA-INSUM'
,p_step_title=>'FACI240 - PEDIDO VENTA INSUM'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//-------------------------------------------------------------------------------',
'function activarItem(pItem) {        ',
'    $(''#'' + pItem).attr(''readonly'',false) ; ',
'    apex.item(pItem).enable() ;     ',
'    apex.item(pItem).setStyle( "opacity", "1" );         ',
'}',
'//-------------------------------------------------------------------------------',
'function desacItem(pItem) {     ',
'    $(''#'' + pItem).attr(''readonly'',true) ; ',
'    apex.item(pItem).disable() ;     ',
'    apex.item(pItem).setStyle( "opacity", "1" );     ',
'}',
'//-------------------------------------------------------------------------------    ',
'function activarEntradas() ',
'{       ',
'       var allInputs = $("input,select");   ',
'       ',
'       for (var i = 0; i < allInputs.length - 1 ; i++) {              ',
'             x = 0 ; ',
'             while (  i < allInputs.length - 1 && x===0 )                                      ',
'             {     ',
'                   vElem = ( allInputs[i] )      ; ',
'                   vName  =  vElem.name;',
'                   if (vName !== "") {',
'                       apex.item( vName  ).enable();  ',
'                   } ',
'                   i++ ;  ',
'             }                                                     ',
'       }',
'    ',
' }',
'//-------------------------------------------------------------------------------    ',
'function desacEntradas() ',
'{       ',
'       var allInputs = $("input,select");  ',
'       // alert("desacEntradas");',
'       for (var i = 0; i < allInputs.length - 1 ; i++) {              ',
'             x = 0 ; ',
'             ',
'             while (  i < allInputs.length - 1 && x===0 )                                      ',
'             {     ',
'                   vElem = ( allInputs[i] )      ; ',
'                   vName  =  vElem.name;',
'                   if ( vName !== "" && vName !== "P48_PED_CLAVE" ) {',
'                       apex.item( vName  ).disable();  ',
'                       apex.item(vName).setStyle( "opacity", "0.9" );',
'                   } ',
'                   i++ ;  ',
'             } ',
'           ',
'       }     ',
'    ',
'}',
'//-------------------------------------------------------------------------------        ',
'$(document).keyup(function( event ) {',
'  if (event.altKey && event.keyCode == 67) {',
'     $(''#cancelar'').click() ;',
'  }',
'  // F2',
'  if (event.keyCode == 113) {',
'    $(''#SR_RegionItems_tab a'').trigger(''click'');   ',
'    $(''#agregarDeta'').click() ;      ',
'  }',
'  if (event.keyCode == 115) {',
'      if ($v("P48_PED_CLAVE") == "") {',
'         $(''#crear'').click() ;              ',
'      } else {',
'         $(''#guardar'').click() ;            ',
'      }    ',
'  }',
'  //ALT G',
'  if (event.altKey && (event.keyCode == 71 || event.keyCode == 102 )) { ',
'      if ($v("P48_PED_CLAVE") == "") {',
'         $(''#crear'').click() ;              ',
'      } else {',
'         $(''#guardar'').click() ;            ',
'      }    ',
'  }    ',
'});',
'',
'//========================================================================          ',
'//--------------------------------------------------------------------------------------------------',
'',
'function enfocarSgte(pElemAc)',
'{',
'       var vRet = 0;',
'       var allInputs = $("button,input,select"); ',
'       //========================================================================   ',
'       for (var i = 0; i < allInputs.length - 1 ; i++) { ',
'',
'            // console.log ("allInputs[" + i + "]).name = " + (allInputs[i]).name );',
'            // console.log ("allInputs[" + i + "]).type = " + (allInputs[i]).type );',
'',
'            //-----------------------------------------------------------------       ',
'            if (allInputs[i] == pElemAc) ',
'            { ',
'                 //\\----------------------------------------------------------',
'',
'                         x = 0 ; ',
'                         while (  i < allInputs.length - 1 && x===0 )                                      ',
'                         {     ',
'                               vElemAc = ( allInputs[i] )      ; ',
'                               vElemSg = ( allInputs[i + 1] )  ; ',
'                               ',
'                               if (   ',
'                                      (      (vElemAc).name == (vElemSg).name ',
'                                          || (vElemSg).name    == "" ',
'                                          || (vElemSg).hasAttribute("readonly") ',
'                                          || (vElemSg).hasAttribute("disabled") ',
'                                      )',
'                                  )',
'                               {',
'                                   if (  ( vElemSg.type   !== "button") ) {',
'                                       i++; ',
'                                   } else ',
'                                   if (  ( vElemSg.className.indexOf("t-Button")  === -1 ) ) { ',
'                                       i++; ',
'                                   } else                                       ',
'                                   { ',
'                                      x = 1;',
'                                   } ',
'                                  // console.log (i);    ',
'                               } else',
'                               {  ',
'                                  x = 1; // Salir del loop.. ',
'                               }    ',
'',
'                         }                 ',
'                         //------------------------------------------------------------',
'                         if (  (i + 1) < allInputs.length  ) ',
'                         {   ',
'                                 vElem = (allInputs[i + 1]);',
'                                 vName  =  vElem.name;',
'                                 if (vName !== "") {',
'                                    apex.item( vName  ).setFocus();  ',
'                                 } else',
'                                 { vElem.focus() }',
'                                 return vElem;',
'                         } ',
'                         //------------------------------------------------------------                                     ',
'',
'             }',
'             //----------------------------------------------------------------       ',
'       }',
'       //========================================================================          ',
'       //||  (allInputs[i + 1 ]).type   == "hidden"    ',
'}',
'//--------------------------------------------------------------------------------------------------',
'$(document).ready(  function() {  ',
'    ',
'     $("button,input,select").bind( "keydown", function (e) { ',
'         ',
'          if (e.keyCode == 13 || ( !e.shiftKey && e.keyCode == 9)) ',
'          {   ',
'			 if (this.name == "P48_PED_LUGAR_ENTREGA") {',
'                $(''#SR_RegionItems_tab a'').trigger(''click'');',
'			 } else { ',
'               vElemAc = this;',
'               if ( (e.keyCode == 13 && vElemAc.className.indexOf("t-Button")  > -1)  )  ',
'               {   return true;}  else ',
'               {',
'                   vElemSg = enfocarSgte(this) ;',
'                   if ( (e.keyCode == 9))    {return false;}',
'                   if ( (e.keyCode == 13 && typeof vElemSg == "object"))  ',
'                   { if ( vElemSg.className.indexOf("t-Button")  > -1 ) {return false;} } ',
'               }    ',
'			 } ',
'          }                        ',
'     })',
'     //button //$.event.trigger("irBtnAcepDeta") ; ',
'})   ;  ',
'',
'//--------------------------------------------------------------------------------------------------',
'',
'function initAutonum(iElemento, vDec)',
'{',
'   ',
'    if (vDec=="") { vDec = 0 }',
'    ',
'   let config= {    digitGroupSeparator: ''.'', ',
'                    decimalCharacter: '','' ,',
'                    decimalPlaces: 0 ',
'                    // decimalCharacterAlternative: ''.'' ',
unistr('                    // currencySymbol: '' \20AC'', '),
'                    // currencySymbolPlacement: ''s'', ',
'                    // roundingMethod: ''U'' ',
'                    };',
'',
'   $(iElemento).autoNumeric(''init'',config);',
'   $(iElemento).autoNumeric(''update'',{mDec:vDec});',
'   ',
'   // console.log("initAutonum");',
'}',
'//--------------------------------------------------------------------',
'',
'function updateDecim(iElemento, iDecim)',
'{',
'  $(iElemento).autoNumeric(''update'',{mDec:iDecim});',
'    ',
'   //console.log("updateDecim");',
'    ',
'}',
'//--------------------------------------------------------------------',
'',
'function actDecimElem()',
'{',
'    vDec = $v("P48_MON_DEC_IMP");',
'    if (vDec=="") { vDec = 0 }',
'     ',
'    updateDecim("#P48_PED_IMP_TOTAL_MON"      ,  vDec ) ; ',
'    updateDecim("#P48_PED_IMP_TOTAL_MON_RD"   ,  vDec ) ; ',
'    updateDecim("#P48_PED_IMP_FACTURADO"      ,  vDec ) ;    ',
'    updateDecim("#P48_PED_IMP_AFACTURAR"      ,  vDec ) ;  ',
'    updateDecim("#P48_IMP_DISP_LINEA"         ,  vDec ) ;  ',
'    updateDecim("#P48_IMP_TOT_DETA"           ,  vDec ) ; ',
'    ',
'    // console.log("actDecimElem");',
'    ',
'    updateDecim("#P48_PRECIO_UN"         , 5   );    ',
'    updateDecim("#P48_CANT_PED"          , 2   ); ',
'    updateDecim("#P48_CANT_FAC"          , 2   ); ',
'    updateDecim("#P48_CANT_PEN_FAC"      , 2   );',
'    updateDecim("#P48_CANT_EXIST"        , 2   );    ',
'    updateDecim("#P48_CANT_DISP_VENTA"   , 2   );',
'',
'    ',
'} ',
'',
''))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''.dec0'').autoNumeric(''init'', {',
'    decimalCharacter: ",",',
'    decimalPlacesOverride: 0,',
'    digitGroupSeparator: "."',
'}); ',
'',
'//alert("initAutonum");',
'',
'initAutonum("#P48_PED_IMP_TOTAL_MON");',
'initAutonum("#P48_PED_IMP_FACTURADO");',
'initAutonum("#P48_PED_IMP_AFACTURAR");',
'initAutonum("#P48_IMP_DISP_LINEA");',
'initAutonum("#P48_IMP_TOT_DETA");',
'',
'initAutonum("#P48_PED_IMP_TOTAL_MON_RD");',
'',
'initAutonum("#P48_PRECIO_UN"    , 4 ) ; ',
'initAutonum("#P48_CANT_PED"     , 2 ) ; ',
'initAutonum("#P48_CANT_FAC"     , 2 ) ; ',
'initAutonum("#P48_CANT_PEN_FAC" , 2 ) ; ',
'initAutonum("#P48_CANT_EXIST"   , 2 ) ;',
'initAutonum("#P48_CANT_DISP_VENTA", 2 ) ; '))
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'PABLOC'
,p_last_upd_yyyymmddhh24miss=>'20220621130138'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1952315055716176094)
,p_plug_name=>'PEDIDO DE VENTA INSUMO'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--accent14:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(25513702711951745)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(703542835687035952)
,p_plug_name=>'Buscar Pedido'
,p_parent_plug_id=>wwv_flow_api.id(1952315055716176094)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size720x480'
,p_plug_template=>wwv_flow_api.id(25512216864951744)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(724128226615908486)
,p_plug_name=>'Region_TAB_DETA'
,p_region_name=>'TAB_CONTAINER'
,p_parent_plug_id=>wwv_flow_api.id(1952315055716176094)
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--fillLabels:t-TabsRegion-mod--pill:t-TabsRegion-mod--large:margin-top-lg'
,p_plug_template=>wwv_flow_api.id(25516910943951748)
,p_plug_display_sequence=>35
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(420458324256545633)
,p_plug_name=>'DATOS GENERALES'
,p_parent_plug_id=>wwv_flow_api.id(724128226615908486)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--accent14:t-Region--scrollBody:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(25513702711951745)
,p_plug_display_sequence=>58
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(392970715113236236)
,p_plug_name=>'SALDO DE ANTICIPOS Y FACTURAS'
,p_parent_plug_id=>wwv_flow_api.id(420458324256545633)
,p_region_css_classes=>'u-color-14-border'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--large:t-Form--stretchInputs:margin-top-sm:margin-bottom-none:margin-left-none:margin-right-none'
,p_plug_template=>wwv_flow_api.id(25513702711951745)
,p_plug_display_sequence=>40
,p_plug_grid_column_span=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(443698636473282215)
,p_plug_name=>'Importes Linea'
,p_parent_plug_id=>wwv_flow_api.id(420458324256545633)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody:t-Form--noPadding:margin-top-lg:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(25513702711951745)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(703543418533035958)
,p_plug_name=>'Importes Cabecera'
,p_parent_plug_id=>wwv_flow_api.id(420458324256545633)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(25513702711951745)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1522383222630964632)
,p_plug_name=>'FormComprobante'
,p_parent_plug_id=>wwv_flow_api.id(420458324256545633)
,p_region_css_classes=>'u-color-14-border'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Region--accent5:t-Form--slimPadding:t-Form--large:t-Form--stretchInputs:t-Form--leftLabels:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(15474494266875662)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT V.PED_EMPR,',
'       V.PED_CLAVE,',
'       V.PED_SUC,',
'       V.PED_NRO,',
'       V.PED_FECHA,',
'       V.PED_FEC_ENTREG_REQ,',
'       V.PED_MON,',
'       V.MON_DESC,',
'       V.MON_DEC_IMP,',
'       V.PED_CLI,',
'       V.CLI_NOM,',
'       V.PED_CLI_RUC,',
'       V.PED_CLI_TEL,',
'       V.PED_CLI_CONTACTO,',
'       V.PED_VENDEDOR,',
'       V.VEND_NOMBRE,',
'       V.PED_OBS,',
'       V.PED_COND_VENTA,',
'       V.PED_LUGAR_ENTREGA,',
'       V.PED_TIPO_FAC,',
'       V.PED_TIPO_FAC_DESC,',
'       V.PED_TASA_US,',
'       V.PED_FEC_GRAB,',
'       V.PED_LOGIN,',
'       V.PED_SIST,',
'       V.PED_IMP_TOTAL_MON,',
'       V.PED_IMP_FACTURADO,',
'       V.PED_IMP_AFACTURAR, ',
'       V.PED_PRODUCTO,',
'       V.PROD_CODIGO,',
'       V.PROD_DESC, ',
'       V.PED_VENC, ',
'       V.PED_CONTRATO_BONO, ',
'       V.PED_CONTRATO_NRO, ',
'       V.PED_MONTO_BONO_ASIG ',
'  FROM FACI240_CAB_V V  ',
'',
''))
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(724128347065908487)
,p_plug_name=>'LISTA DE FACTURAS'
,p_parent_plug_id=>wwv_flow_api.id(724128226615908486)
,p_region_css_classes=>'u-color-14-border'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--accent14:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(25513702711951745)
,p_plug_display_sequence=>70
,p_plug_display_point=>'BODY'
,p_plug_item_display_point=>'BELOW'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(724128515331908489)
,p_plug_name=>'DETALLE_FACTU'
,p_parent_plug_id=>wwv_flow_api.id(724128347065908487)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(25513205524951745)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT DO.DOC_CLAVE                  FAC_CLAVE,',
'                DO.DOC_FEC_DOC                FAC_FECHA,',
'                UT.FACNUM_FM(DO.DOC_NRO_DOC)  FAC_NUMERO,',
'                DECODE(DO.DOC_TIPO_MOV, ',
'                09, ''CO'', ',
'                10, ''CR'', ',
'                16, ''NC'')                     FAC_TIPO,',
'                MO.MON_SIMBOLO                FAC_MON_SIMB,',
'                DO.DOC_NETO_EXEN_MON + ',
'                DO.DOC_NETO_GRAV_MON +',
'                NVL(DO.DOC_IVA_MON, 0)        FAC_IMPORTE,',
'                DO.DOC_SALDO_MON              FAC_SALDO,',
'                DE.DET_CLAVE_PED              DETC_CLAVE_PED',
'                ',
'  FROM GEN_MONEDA              MO, ',
'       FIN_DOCUMENTO           DO, ',
'       FAC_DOCUMENTO_DET       DE',
'       ',
' WHERE MO.MON_CODIGO       =    DO.DOC_MON',
'   AND MO.MON_EMPR         =    DO.DOC_EMPR',
'   ',
'   AND DO.DOC_EMPR         =    DE.DET_EMPR ',
'   AND DO.DOC_CLAVE        =    DE.DET_CLAVE_DOC',
'   ',
'   AND DO.DOC_TIPO_MOV     IN   (9,10,16)',
'   ',
'   AND DO.DOC_EMPR         =    :P_EMPRESA',
'   AND DE.DET_CLAVE_PED    =    :P48_PED_CLAVE',
' ',
' ',
''))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P48_PED_CLAVE'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(726316551820616562)
,p_name=>'FAC_CLAVE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FAC_CLAVE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>10
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
 p_id=>wwv_flow_api.id(726316661663616563)
,p_name=>'FAC_FECHA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FAC_FECHA'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Fecha Factura'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>30
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(726316747943616564)
,p_name=>'FAC_NUMERO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FAC_NUMERO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>unistr('N\00FAmero')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'CENTER'
,p_attribute_03=>'right'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
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
 p_id=>wwv_flow_api.id(726316772878616565)
,p_name=>'FAC_TIPO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FAC_TIPO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Tipo'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>2
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(726316916275616566)
,p_name=>'FAC_MON_SIMB'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FAC_MON_SIMB'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Moneda'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>3
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(726317023394616567)
,p_name=>'FAC_IMPORTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FAC_IMPORTE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Importe'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>70
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_format_mask=>'999G999G999G999G990D00'
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
 p_id=>wwv_flow_api.id(726317093070616568)
,p_name=>'FAC_SALDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FAC_SALDO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Saldo Factura'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>80
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_format_mask=>'999G999G999G999G990D00'
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
 p_id=>wwv_flow_api.id(726317198887616569)
,p_name=>'DETC_CLAVE_PED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETC_CLAVE_PED'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>20
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(726314300704616540)
,p_internal_uid=>726314300704616540
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
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(726322019041618706)
,p_interactive_grid_id=>wwv_flow_api.id(726314300704616540)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(726322062730618706)
,p_report_id=>wwv_flow_api.id(726322019041618706)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(726333772659650755)
,p_view_id=>wwv_flow_api.id(726322062730618706)
,p_display_seq=>22
,p_column_id=>wwv_flow_api.id(726316551820616562)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(726334301686650757)
,p_view_id=>wwv_flow_api.id(726322062730618706)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(726316661663616563)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>290.805
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(726334781202650760)
,p_view_id=>wwv_flow_api.id(726322062730618706)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(726316747943616564)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>204
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(726335329466650763)
,p_view_id=>wwv_flow_api.id(726322062730618706)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(726316772878616565)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>181
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(726335830686650766)
,p_view_id=>wwv_flow_api.id(726322062730618706)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(726316916275616566)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>82.997
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(726336313605650768)
,p_view_id=>wwv_flow_api.id(726322062730618706)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(726317023394616567)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>273.594
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(726336856186650771)
,p_view_id=>wwv_flow_api.id(726322062730618706)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(726317093070616568)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>293.9963320617676
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(726337315274650773)
,p_view_id=>wwv_flow_api.id(726322062730618706)
,p_display_seq=>29
,p_column_id=>wwv_flow_api.id(726317198887616569)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_highlight(
 p_id=>wwv_flow_api.id(410797092441916542)
,p_view_id=>wwv_flow_api.id(726322062730618706)
,p_execution_seq=>5
,p_name=>'COLOR'
,p_background_color=>'#FFFC96'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_api.id(726316661663616563)
,p_condition_operator=>'NN'
,p_condition_is_case_sensitive=>false
,p_is_enabled=>true
);
wwv_flow_api.create_ig_report_aggregate(
 p_id=>wwv_flow_api.id(410810845957987583)
,p_view_id=>wwv_flow_api.id(726322062730618706)
,p_function=>'SUM'
,p_column_id=>wwv_flow_api.id(726317023394616567)
,p_show_grand_total=>false
,p_is_enabled=>true
);
wwv_flow_api.create_ig_report_aggregate(
 p_id=>wwv_flow_api.id(410810887648988530)
,p_view_id=>wwv_flow_api.id(726322062730618706)
,p_function=>'SUM'
,p_column_id=>wwv_flow_api.id(726317093070616568)
,p_show_grand_total=>false
,p_is_enabled=>true
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1952316836460176112)
,p_plug_name=>'DETALLE DE PRODUCTOS '
,p_region_name=>'RegionItems'
,p_parent_plug_id=>wwv_flow_api.id(724128226615908486)
,p_region_css_classes=>'u-color-14-border'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--accent14:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(25513702711951745)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_plug_item_display_point=>'BELOW'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(420458452901545634)
,p_plug_name=>'Resumen Deta'
,p_parent_plug_id=>wwv_flow_api.id(1952316836460176112)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(25513702711951745)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1952317108594176114)
,p_plug_name=>'DETALLE_PROD'
,p_parent_plug_id=>wwv_flow_api.id(1952316836460176112)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(25513205524951745)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT SEQ_ID                       SEQ_ID            ,     ',
'             C001                   DETA_EMPR         ,',
'             C002                   DETA_CLAVE_PED    , ',
'             TO_NUMBER(C003)        DETA_ITEM         ,',
'             ',
'             C004                   DETA_ART_COD      , ',
'             C005                   DETA_ART_DESC     , ',
'             C006                   DETA_UN_MED       , ',
'             ',
'             C007                   DETA_ART_IMPU     , ',
'             C008                   DETA_IMPU_PORC    , ',
'             C009                   DETA_IMPU_PORC_D  ,        ',
'             ',
'             UT.GETNC(C010)         DETA_CANT_PED     ,',
'             UT.GETNC(C011)         DETA_CANT_FAC     ,',
'             UT.GETNC(C012)         DETA_CANT_PEN_F   ,',
'             ',
'             UT.GETNC(C020)         DETA_PRECIO       ,        ',
'       ',
'       C021                   DETA_IMP_TT       ,',
'       C022                   DETA_OBS          ,   ',
'       C023                   DETA_IND_RECIBIDO ,',
'       ',
'       ''ELIM''                 ELIMINAR         , ',
'       ''EDIT''                 EDITAR ',
'       ',
'  FROM APEX_collections',
' WHERE collection_name = ''FACI240_DE''  ',
'   AND NVL(C049,''X'')   <> ''E'' ',
'   ;',
''))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'DETALLE_PROD'
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
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(722608298187471153)
,p_name=>'DETA_ITEM'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_ITEM'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'#'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>50
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(722608408304471154)
,p_name=>'DETA_ART_IMPU'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_ART_IMPU'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>80
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(722608527637471155)
,p_name=>'DETA_IMPU_PORC'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_IMPU_PORC'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>20
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(722608588517471156)
,p_name=>'DETA_IMPU_PORC_D'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_IMPU_PORC_D'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Impu.'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>100
,p_value_alignment=>'RIGHT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(722608725317471157)
,p_name=>'DETA_CANT_PED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_CANT_PED'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Cant.Ped.'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>110
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_format_mask=>'999G999G999G999G990D00'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(722609039541471160)
,p_name=>'DETA_CANT_FAC'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_CANT_FAC'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Cant. Factu.'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>140
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_format_mask=>'999G999G999G999G990D00'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(722609070768471161)
,p_name=>'DETA_CANT_PEN_F'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_CANT_PEN_F'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'A Facturar'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>150
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_format_mask=>'999G999G999G999G990D00'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(722609224245471162)
,p_name=>'DETA_PRECIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_PRECIO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Precio'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>160
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_format_mask=>'999G999G999G999G990D0000'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(722609308982471163)
,p_name=>'DETA_IMP_TT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_IMP_TT'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Importe TT'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>170
,p_value_alignment=>'RIGHT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(722609440220471164)
,p_name=>'DETA_OBS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_OBS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Observaci\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>180
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(722609493583471165)
,p_name=>'DETA_CLAVE_PED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_CLAVE_PED'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(722609647337471166)
,p_name=>'DETA_EMPR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_EMPR'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(722609684467471167)
,p_name=>'DETA_UN_MED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_UN_MED'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'UM'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'CENTER'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(724124521070908449)
,p_name=>'EDITAR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EDITAR'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_LINK'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>200
,p_value_alignment=>'CENTER'
,p_link_target=>'javascript:$s(''P48_SEQ_ID_UPDATE'',''&SEQ_ID.'');'
,p_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(724127455284908478)
,p_name=>'DETA_IND_RECIBIDO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_IND_RECIBIDO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Ind.Recibido'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>220
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1232035350843810840)
,p_name=>'DETA_ART_COD'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_ART_COD'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('C\00F3digo')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1232035500965810841)
,p_name=>'DETA_ART_DESC'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETA_ART_DESC'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>unistr('Descripci\00F3n')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1391605088954988847)
,p_name=>'SEQ_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SEQ_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>10
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1392486904924753947)
,p_name=>'ELIMINAR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ELIMINAR'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_LINK'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>190
,p_value_alignment=>'CENTER'
,p_link_target=>'javascript:$s(''P48_SEQ_ID_DELETE'',''&SEQ_ID.'');'
,p_link_text=>'<span aria-hidden="true" class="fa fa-trash-o"></span>'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(1391604935198988846)
,p_internal_uid=>1391604935198988846
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
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(1391728636122957807)
,p_interactive_grid_id=>wwv_flow_api.id(1391604935198988846)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(1391728774747957807)
,p_report_id=>wwv_flow_api.id(1391728636122957807)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(410801982703080733)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>17
,p_column_id=>wwv_flow_api.id(724127455284908478)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(722681344036898040)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(722608298187471153)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>40
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(722681852728898046)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(722608408304471154)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(722682321812898048)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>14
,p_column_id=>wwv_flow_api.id(722608527637471155)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(722682842699898051)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(722608588517471156)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>52
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(722683321607898053)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(722608725317471157)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>78
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(722684780926898060)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(722609039541471160)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(722685314443898063)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(722609070768471161)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>83
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(722685781099898065)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(722609224245471162)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>89
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(722686355041898068)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>16
,p_column_id=>wwv_flow_api.id(722609308982471163)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>96
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(722686778448898071)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>18
,p_column_id=>wwv_flow_api.id(722609440220471164)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>400
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(722783741970423607)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>24
,p_column_id=>wwv_flow_api.id(722609493583471165)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(722784994943434243)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>25
,p_column_id=>wwv_flow_api.id(722609647337471166)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(722786744942444338)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(722609684467471167)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>48
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(724857565720744587)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(724124521070908449)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>49
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1258227872865122434)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(1232035350843810840)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>97.9861
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1258228420130122441)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(1232035500965810841)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>359
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1391729239882957811)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(1391605088954988847)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>51
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1392523225662595148)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(1392486904924753947)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>49
);
wwv_flow_api.create_ig_report_highlight(
 p_id=>wwv_flow_api.id(410796992445916541)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_execution_seq=>5
,p_name=>'SIN_FAC'
,p_background_color=>'#FFFF9E'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_api.id(724127455284908478)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'NO'
,p_is_enabled=>true
);
wwv_flow_api.create_ig_report_highlight(
 p_id=>wwv_flow_api.id(410797019871916541)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_execution_seq=>10
,p_name=>'FAC_TT'
,p_background_color=>'#F2E6F2'
,p_text_color=>'#1C1C1C'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_api.id(724127455284908478)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'TT'
,p_is_enabled=>true
);
wwv_flow_api.create_ig_report_highlight(
 p_id=>wwv_flow_api.id(410832133900048164)
,p_view_id=>wwv_flow_api.id(1391728774747957807)
,p_execution_seq=>15
,p_name=>'FAC_PA'
,p_background_color=>'#E8FAEF'
,p_condition_type=>'COLUMN'
,p_condition_column_id=>wwv_flow_api.id(724127455284908478)
,p_condition_operator=>'EQ'
,p_condition_is_case_sensitive=>false
,p_condition_expression=>'PA'
,p_is_enabled=>true
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1392485845932753936)
,p_plug_name=>'Ingrese los datos a anexar..'
,p_parent_plug_id=>wwv_flow_api.id(1952315055716176094)
,p_region_css_classes=>'js-dialog-size1000x480'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size720x480'
,p_plug_template=>wwv_flow_api.id(25512216864951744)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(707732594087496285)
,p_plug_name=>'Cuadro Deta Anexar 02'
,p_parent_plug_id=>wwv_flow_api.id(1392485845932753936)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Region--accent5:t-Form--slimPadding:t-Form--large:t-Form--stretchInputs:t-Form--leftLabels:margin-right-md'
,p_plug_template=>wwv_flow_api.id(15474494266875662)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1391605836120988855)
,p_plug_name=>'Cuadro Deta Anexar 01'
,p_parent_plug_id=>wwv_flow_api.id(1392485845932753936)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Region--accent5:t-Form--slimPadding:t-Form--large:t-Form--stretchInputs:t-Form--leftLabels'
,p_plug_template=>wwv_flow_api.id(15474494266875662)
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>8
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(410814928863916559)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(703542835687035952)
,p_button_name=>'BuscarPedido_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(25536586739951772)
,p_button_image_alt=>'Buscar Pedido'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_button_cattributes=>'style="margin-top: 5px;"'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(410804916159916550)
,p_button_sequence=>5
,p_button_plug_id=>wwv_flow_api.id(420458452901545634)
,p_button_name=>'AGREGAR_DETA'
,p_button_static_id=>'agregarDeta'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--primary:t-Button--simple:t-Button--stretch:t-Button--gapLeft:t-Button--padRight'
,p_button_template_id=>wwv_flow_api.id(25536441528951771)
,p_button_image_alt=>'+'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_cattributes=>'style="margin-top: 20px;"'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(410798319865916542)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(1952315055716176094)
,p_button_name=>'SAVE'
,p_button_static_id=>'guardar'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(25536586739951772)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aplicar Cambios'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_condition=>'P48_PED_CLAVE'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(410799121307916542)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(1952315055716176094)
,p_button_name=>'DELETE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(25536586739951772)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Borrar'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P48_PED_CLAVE'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(410797523826916542)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(1952315055716176094)
,p_button_name=>'CANCEL'
,p_button_static_id=>'cancelar'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(25536586739951772)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(410798739187916542)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(1952315055716176094)
,p_button_name=>'IMPRIMIR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(25536586739951772)
,p_button_image_alt=>'Imprimir'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P48_PED_CLAVE'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(410797919560916542)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(1952315055716176094)
,p_button_name=>'CREATE'
,p_button_static_id=>'crear'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(25536586739951772)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Crear'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P48_PED_CLAVE'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(410830153796916567)
,p_button_sequence=>120
,p_button_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_button_name=>'ACEPTAR_DETA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(25536441528951771)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aceptar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(410883492672916593)
,p_branch_name=>'GOTO_48'
,p_branch_action=>'f?p=&APP_ID.:48:&SESSION.::&DEBUG.:48:P48_PED_EMPR,P48_PED_CLAVE:&P_EMPRESA.,&P48_PED_CLAVE.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_branch_condition=>'QUERY'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(392970552993236234)
,p_name=>'P48_PED_CONTRATO_NRO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>'Contrato'
,p_source=>'PED_CONTRATO_NRO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CON_ACO_PED_INSU'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CONTRATO                       CON_NUM_ANHO       ,        ',
'       CON_MON_SIMB                   CON_MON_SIMB       , ',
'       CON_CANTIDAD                   CON_CANTIDAD    ',
'  FROM ACO_CONTRATO_FIJ_PEDIDO T ',
'  WHERE con_proveedor  = NVL(:P48_PED_CLI,-1)',
'    AND con_producto   = NVL(:P48_PED_PRODUCTO, -1)',
'    AND con_moneda     = NVL(:P48_PED_MON,-1) ',
'    ',
'    ',
'    '))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P48_PED_CLI,P48_PED_MON,P48_PROD_CODIGO,P48_PED_MON'
,p_ajax_items_to_submit=>'P48_PED_CLI,P48_PED_PRODUCTO,P48_PED_MON'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>100
,p_cMaxlength=>81
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25536224686951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_08=>'500'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(392970678998236235)
,p_name=>'P48_PED_MONTO_BONO_ASIG'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>'Bono'
,p_source=>'PED_MONTO_BONO_ASIG'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'READONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(392970812621236237)
,p_name=>'P48_IMP_AD_AVENCER_USD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(392970715113236236)
,p_item_default=>'0'
,p_prompt=>'AN. a Vencer'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'u-textEnd u-color-14-border u-bold'
,p_tag_attributes=>'READONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_css_classes=>'u-textEnd u-color-14-border'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(392970943065236238)
,p_name=>'P48_IMP_FA_VENCIDO_USD'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(392970715113236236)
,p_item_default=>'0'
,p_prompt=>'FA. Vencidas'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'u-textEnd u-color-14-border u-bold'
,p_tag_attributes=>'READONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(392971008034236239)
,p_name=>'P48_IMP_FA_AVENCER_USD'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(392970715113236236)
,p_item_default=>'0'
,p_prompt=>'FA. a Vencer'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'u-textEnd u-color-14-border u-bold'
,p_tag_attributes=>'READONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(392971256324236241)
,p_name=>'P48_IMP_AD_VENCIDO_USD'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(392970715113236236)
,p_item_default=>'0'
,p_prompt=>'AN. Vencidos '
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'u-textEnd u-color-14-border u-bold'
,p_tag_attributes=>'READONLY'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(392971594443236244)
,p_name=>'P48_PED_VENDEDOR'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>'Vendedor'
,p_source=>'PED_VENDEDOR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_VENDEDOR_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT F.VEND_LEGAJO||'' - ''||P.EMPL_NOMBRE||'' ''||P.EMPL_APE as d,F.VEND_LEGAJO as r',
'  FROM FAC_VENDEDOR F,PER_EMPLEADO P',
' WHERE F.VEND_LEGAJO = P.EMPL_LEGAJO',
'   AND F.VEND_EMPR = P.EMPL_EMPRESA',
'   AND F.VEND_EMPR = :P_EMPRESA'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_08=>'500'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(392971620544236245)
,p_name=>'P48_PED_CLI'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>'Cliente'
,p_source=>'PED_CLI'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CLIENTE_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT D.CLI_CODIGO||'' - ''||D.CLI_NOM,D.CLI_CODIGO',
'  FROM FIN_CLIENTE D ',
' WHERE D.CLI_EMPR = :P_EMPRESA'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_08=>'500'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(392971729611236246)
,p_name=>'P48_CLI_NOMBRE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_source=>'CLI_NOM'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>100
,p_tag_attributes=>'READONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(392971829082236247)
,p_name=>'P48_PED_CLI_RUC'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>'Ruc'
,p_source=>'PED_CLI_RUC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>20
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(392971915415236248)
,p_name=>'P48_PED_CLI_TEL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>unistr('Tel\00E9fono')
,p_source=>'PED_CLI_TEL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>25
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(392972030760236249)
,p_name=>'P48_PED_CLI_CONTACTO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>'Contacto'
,p_source=>'PED_CLI_CONTACTO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>50
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(392972144297236250)
,p_name=>'P48_VEND_NOMBRE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>'Vend Nombre'
,p_source=>'VEND_NOMBRE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>81
,p_tag_attributes=>'READONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410815651758916559)
,p_name=>'P48_IMPRIMIR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410817249839916560)
,p_name=>'P48_PED_FEC_GRAB'
,p_source_data_type=>'DATE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_source=>'PED_FEC_GRAB'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410817600378916560)
,p_name=>'P48_PED_LOGIN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_source=>'PED_LOGIN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410818009835916560)
,p_name=>'P48_PED_SIST'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_source=>'PED_SIST'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410818466542916561)
,p_name=>'P48_PED_NRO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_source=>'PED_NRO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410818813045916561)
,p_name=>'P48_PED_TASA_US'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_source=>'PED_TASA_US'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410819217058916561)
,p_name=>'P48_PED_EMPR'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_source=>'PED_EMPR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410819670242916561)
,p_name=>'P48_MON_DEC_IMP'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_source=>'MON_DEC_IMP'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410820076311916561)
,p_name=>'P48_PED_PRODUCTO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_source=>'PED_PRODUCTO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410820455018916561)
,p_name=>'P48_PED_CLAVE'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>unistr('N\00FAmero')
,p_source=>'PED_CLAVE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_PED_VEN_INSUM'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT PE.PED_EMPR        PED_EMPR    , ',
'       PE.PED_CLAVE       PED_CLAVE   ,',
'       PE.FEC_PED         FEC_PED     ,',
'       PE.PERIODO         PERIODO     ,',
'       PE.PED_NRO         PED_NRO     ,',
'       PE.CLI_NOM         CLI_NOM     ,',
'       PE.VEND_NOMBRE     VEND_NOMBRE ,',
'       PE.SUC_ABREV       SUC_ABREV   ,',
'       PE.ESTADO_FAC      ESTADO_FAC  ,',
'       UT.GETNUMFM(',
'       PE.IMPORTE_TT,2)           ',
'                          IMPORTE_TT  ,',
'       PE.SIMB_MON        SIMB_MON    ,',
'       PE.PED_OBS         PED_OBS     ,',
'       null x ',
'  FROM FAC_PEDIDO_IN_LOV_V PE ',
' WHERE PED_EMPR = :P_EMPRESA ',
' ORDER BY PE.FEC_PED DESC, PE.PED_NRO DESC',
' '))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_tag_css_classes=>'u-textStart  u-bold'
,p_tag_attributes=>'READONLY'
,p_colspan=>6
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_plugin_init_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function(options) {	',
' options.defaultGridOptions = ',
'    {',
'		 columns: ',
'		 [{',
'				SUC_ABREV: {',
'					heading: "SUC.",					',
'                    width: 50,',
'					alignment: "start",',
'					headingAlignment: "start",',
'					canSort: true               ',
'					}  ,      ',
'				PED_NRO: {',
'					heading: "NRO.PEDIDO",',
'					width: 90,',
'					alignment: "start",',
'					headingAlignment: "start",',
'					canSort: false               ',
'					}   ,	',
'				FEC_PED: {',
'					heading: "FECHA",',
'                    width: 85,',
'					noStretch: false,',
'					alignment: "start",',
'					headingAlignment: "start",',
'					canSort: true               ',
'					}   ,',
'				PERIODO: {',
'					heading: "PERIODO",',
'                    width: 70,',
'					noStretch: false,',
'					alignment: "start",',
'					headingAlignment: "start",',
'					canSort: true               ',
'					}   ,',
'             ',
'             CLI_NOM: {',
'					heading: "CLIENTE",					',
'                    width: 280,',
'					alignment: "start",',
'					headingAlignment: "start",',
'					canSort: true               ',
'					}  , ',
'             ',
'             VEND_NOMBRE: {',
'					heading: "VENDEDOR",					',
'                    width: 280,',
'					alignment: "start",',
'					headingAlignment: "start",',
'					canSort: true               ',
'					}  ,',
'             ',
'				SIMB_MON: {',
'					heading: "MON",',
'                    width: 60,',
'					noStretch: false,',
'                    alignment: "right",',
'                    headingAlignment: "center",',
'					canSort: false               ',
'					}       ,             ',
'				IMPORTE_TT: {',
'					heading: "IMPORTE",',
'                    width: 90,',
'					noStretch: false,',
'                    alignment: "right",',
'                    headingAlignment: "center",',
'					canSort: false               ',
'					}    ,   ',
'             ',
'				ESTADO_FAC: {',
'					heading: "ESTADO FA",',
'                    width: 100,',
'					noStretch: false,',
'                    alignment: "left",',
'                    headingAlignment: "center",',
'					canSort: false               ',
'					}   ,',
'             ',
'				PED_OBS: {',
'					heading: "OBS",',
'                    width: 280,',
'					noStretch: false,',
'                    alignment: "left",',
'                    headingAlignment: "left",',
'					canSort: false               ',
'					}    , ',
'             ',
'				X: {',
'					heading: "",',
'                    width: 10,',
'					noStretch: false,',
'                    alignment: "right",',
'                    headingAlignment: "center",',
'					canSort: false               ',
'					}              ',
'		 }]',
'',
'    }; ',
'',
'    return options;',
'',
'}',
'',
'',
'',
''))
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_08=>'1250'
,p_attribute_09=>'550'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410821208781916562)
,p_name=>'P48_PED_SUC'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_default=>'P_SUCURSAL'
,p_item_default_type=>'ITEM'
,p_prompt=>'Sucursal'
,p_source=>'PED_SUC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_SUCURSAL_COD'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT D.SUC_CODIGO||'' - ''||D.SUC_DESC,D.SUC_CODIGO',
'  FROM GEN_SUCURSAL D ',
' WHERE D.SUC_EMPR = :P_EMPRESA',
'  ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_tag_attributes=>'READONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25536224686951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410821665182916562)
,p_name=>'P48_PED_FECHA'
,p_source_data_type=>'DATE'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_default=>'TO_CHAR(SYSDATE, ''DD/MM/YYYY'')'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Fec.Ped'
,p_source=>'PED_FECHA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25536224686951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410822043490916562)
,p_name=>'P48_PED_FEC_ENTREG_REQ'
,p_source_data_type=>'DATE'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>'Fecha Req.'
,p_source=>'PED_FEC_ENTREG_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410824405510916563)
,p_name=>'P48_PED_MON'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>'Moneda'
,p_source=>'PED_MON'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_MONEDA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT MON_CODIGO || '' - '' || MON_DESC AS DISPLAY_VALUE,',
'       MON_CODIGO AS RETURN_VALUE',
'  FROM GEN_MONEDA',
' WHERE MON_EMPR = :P_EMPRESA',
' ORDER BY 1',
''))
,p_lov_display_null=>'YES'
,p_cSize=>100
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25536224686951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_08=>'500'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410824851064916564)
,p_name=>'P48_MON_DESC'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_source=>'MON_DESC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>20
,p_tag_attributes=>'READONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410825290049916564)
,p_name=>'P48_PROD_CODIGO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>'Zafra'
,p_source=>'PROD_CODIGO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT LPAD(PR.PROD_CODIGO, 4, '' '') || ''- '' || PR.PROD_DESC PROD_DESC ,',
'       PR.PROD_CODIGO ',
'  FROM ACO_PRODUCTO PR',
' WHERE PR.PROD_EMPR = :P_EMPRESA ',
'   AND CASE ',
'       WHEN :P48_PED_CLAVE IS NULL AND ',
'            (PR.PROD_ZAFRA_ACTUAL >= TO_NUMBER(TO_CHAR(SYSDATE, ''YYYY'')) - 1)',
'       THEN ''S''       ',
'       WHEN :P48_PED_CLAVE IS NOT NULL ',
'       THEN ''S''',
'       ELSE ''N''',
'       END  = ''S'' ',
'',
'',
''))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P48_PED_TIPO_FAC,P48_PED_CLI'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>100
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25536224686951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_08=>'450'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410825656716916564)
,p_name=>'P48_PROD_DESC'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_source=>'PROD_DESC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>30
,p_tag_attributes=>'READONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410826049817916564)
,p_name=>'P48_PED_OBS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>'Observ.'
,p_source=>'PED_OBS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>100
,p_cMaxlength=>300
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410826451329916564)
,p_name=>'P48_PED_COND_VENTA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>unistr('Condici\00F3n')
,p_source=>'PED_COND_VENTA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC:CONTADO;CONTADO,FINANCIADO;FINANCIADO'
,p_colspan=>5
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410826867360916565)
,p_name=>'P48_VERIFICAR_ELEM'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410828257344916566)
,p_name=>'P48_CANT_FAC'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(707732594087496285)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Facturado'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'READONLY style="text-align: right;font-weight:bold;"'
,p_grid_label_column_span=>5
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410828675547916567)
,p_name=>'P48_CANT_PEN_FAC'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(707732594087496285)
,p_use_cache_before_default=>'NO'
,p_prompt=>'a Facturar'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'READONLY style="text-align: right;font-weight:bold;"'
,p_grid_label_column_span=>5
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410830403245916568)
,p_name=>'P48_SEQ_ID_DELETE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410830836627916568)
,p_name=>'P48_SEQ_ID_UPDATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410831202815916568)
,p_name=>'P48_OPER_AUX'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410831653607916568)
,p_name=>'P48_ART_CODIGO_AUX'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410832049311916568)
,p_name=>'P48_ART_DESC_AUX'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410832451776916569)
,p_name=>'P48_PRECIO_UN_AUX'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410832856008916569)
,p_name=>'P48_NRO_ITEM_AUX'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410833202230916569)
,p_name=>'P48_ART_IMPU'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410833682602916569)
,p_name=>'P48_URL_REP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410834054517916569)
,p_name=>'P48_URL_DESC'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410834496717916569)
,p_name=>'P48_IMPU_PORC'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410834845537916570)
,p_name=>'P48_ART_CODIGO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_use_cache_before_default=>'NO'
,p_item_default=>'1'
,p_prompt=>unistr('Art\00EDculo')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ''['' || ',
'       V.ART_ALFA ',
'       || '' ]   '' || ',
'       V.ART_DESC',
'                                  ART_DESC    ,              ',
'       V.ART_CODIGO               ART_CODIGO   ',
'  FROM STK_ARTICULO_AM_V V  ',
' WHERE V.ART_EMPR        =       :P_EMPRESA',
'   AND V.ART_TIPO        <>      4  ',
' ORDER BY ART_DESC ASC ',
' ;',
' '))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_tag_attributes=>'READONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(25536224686951769)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_08=>'700'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410835218277916570)
,p_name=>'P48_ART_UN_MED'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_prompt=>'UnMed'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'READONLY'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410835670190916570)
,p_name=>'P48_CANT_PED'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Cantidad'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>100
,p_tag_attributes=>'style="text-align: right;font-weight:bold;"'
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(25536224686951769)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410836017530916570)
,p_name=>'P48_IMPU_PORC_DESC'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_prompt=>'Tipo Impu'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'READONLY'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410836434189916571)
,p_name=>'P48_PRECIO_UN'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Precio'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>100
,p_tag_attributes=>'style="text-align: right;font-weight:bold;"'
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(25536224686951769)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410836873470916571)
,p_name=>'P48_IMP_TOT_DETA'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Importe TT'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>100
,p_tag_attributes=>'READONLY style="text-align: right;font-weight:bold;"'
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(25536224686951769)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410837268772916571)
,p_name=>'P48_OBS_DETA'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Observ.'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'onChange="this.value=this.value.toUpperCase();" onkeyup="this.value=this.value.toUpperCase();"'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(25536224686951769)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410837976349916571)
,p_name=>'P48_PED_IMP_TOTAL_MON'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(703543418533035958)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_default=>'0'
,p_prompt=>'TOTAL PEDIDO'
,p_source=>'PED_IMP_TOTAL_MON'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'READONLY style="background-color: none; border: 1px solid rgb(204,198,145); width: 40px; height: 20px;font-size: 17px; text-align: right; font-weight:bold;padding-right: 15px;color: #620a02"'
,p_colspan=>10
,p_grid_column=>2
,p_field_template=>wwv_flow_api.id(199912145983970073)
,p_item_template_options=>'#DEFAULT#:margin-top-sm:margin-bottom-none'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410839566452916572)
,p_name=>'P48_PED_IMP_FACTURADO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(703543418533035958)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_default=>'0'
,p_prompt=>'IMP. FACTURADO'
,p_source=>'PED_IMP_FACTURADO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'READONLY style="background-color: none; border: 1px solid rgb(204,198,145); width: 40px; height: 20px;font-size: 17px; text-align: right; font-weight:bold;padding-right: 15px;color: #620a02"'
,p_colspan=>10
,p_grid_column=>2
,p_field_template=>wwv_flow_api.id(199912145983970073)
,p_item_template_options=>'#DEFAULT#:margin-top-none:margin-bottom-sm'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410839977297916573)
,p_name=>'P48_PED_IMP_AFACTURAR_AUX'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(703543418533035958)
,p_item_default=>'0'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(410840330860916573)
,p_name=>'P48_PED_IMP_TOTAL_MON_AUX'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(703543418533035958)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_default=>'0'
,p_source=>'PED_IMP_TOTAL_MON'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(420455121806545601)
,p_name=>'P48_PED_TIPO_FAC'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>'Tipo Fa'
,p_source=>'PED_TIPO_FAC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'STATIC:1-CONTADO;1,2-CREDITO;2'
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(420455233641545602)
,p_name=>'P48_PED_TIPO_FAC_DESC'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_source=>'PED_TIPO_FAC_DESC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>7
,p_tag_attributes=>'READONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(420455397586545603)
,p_name=>'P48_PED_LUGAR_ENTREGA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>'Lug Entreg.'
,p_source=>'PED_LUGAR_ENTREGA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC:EMPRESA ENTREGA;EMPRESA_ENTREGA,CLIENTE RETIRA;CLIENTE_RETIRA'
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_grid_column=>7
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(420456700080545617)
,p_name=>'P48_PED_CONTRATO_BONO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_source=>'PED_CONTRATO_BONO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(420457639076545626)
,p_name=>'P48_PED_VENC'
,p_source_data_type=>'DATE'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_prompt=>'Venc. Zafra'
,p_source=>'PED_VENC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'READONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(420457935250545629)
,p_name=>'P48_PED_IMP_AFACTURAR'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(703543418533035958)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_default=>'0'
,p_prompt=>'IMP. A FACTURAR'
,p_source=>'PED_IMP_AFACTURAR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'READONLY style="background-color: none; border: 1px solid rgb(204,198,145); width: 40px; height: 20px;font-size: 17px; text-align: right; font-weight:bold;padding-right: 15px;color: #620a02"'
,p_colspan=>10
,p_grid_column=>2
,p_field_template=>wwv_flow_api.id(199912145983970073)
,p_item_template_options=>'#DEFAULT#:margin-top-none:margin-bottom-sm'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(420458521417545635)
,p_name=>'P48_TEXTO_INFO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(420458452901545634)
,p_item_default=>'Presione F2 para agregar una fila.. '
,p_pre_element_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
''))
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'u-alignMiddle'
,p_tag_attributes=>'READONLY style="background-color: none; border: none; text-align: left; color: #85929E; font-style: italic"'
,p_begin_on_new_line=>'N'
,p_colspan=>9
,p_field_template=>wwv_flow_api.id(199912145983970073)
,p_item_template_options=>'#DEFAULT#:margin-top-sm:margin-bottom-none'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
,p_item_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<span style = "color: #85929E;font-style: italic;"',
'> ',
'   Presione ',
'   <span style = "font-weight: bold;"> F2 </span>',
'   para agregar una fila.. ',
'</span>'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(420459023064545640)
,p_name=>'P48_PED_IMP_TOTAL_MON_RD'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(420458452901545634)
,p_item_source_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_item_default=>'0'
,p_prompt=>'TOTAL PEDIDO'
,p_source=>'PED_IMP_TOTAL_MON'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'READONLY style="background-color: none; border: 1px solid rgb(204,198,145); height: 15px;font-size: 17px; text-align: right; font-weight:bold;padding-right: 15px;color: #620a02"'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(199912145983970073)
,p_item_template_options=>'#DEFAULT#:margin-top-sm:margin-bottom-none:margin-right-sm'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(420459618637545646)
,p_name=>'P48_CANT_EXIST'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(707732594087496285)
,p_use_cache_before_default=>'NO'
,p_prompt=>'En Sucursal'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'READONLY style="text-align: right;font-weight:bold;"'
,p_grid_label_column_span=>5
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(420459731806545647)
,p_name=>'P48_ART_CODIGO_INI'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(1391605836120988855)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(443697433368282203)
,p_name=>'P48_OPER_EDITAR_PED'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(443697567836282204)
,p_name=>'P48_OPER_EDITAR_PRE'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(1522383222630964632)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(443698347809282212)
,p_name=>'P48_IMP_DISP_LINEA'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(443698636473282215)
,p_item_default=>'0'
,p_prompt=>'LINEA DISPONIBLE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'u-textEnd u-color-14-border u-bold'
,p_tag_attributes=>'READONLY'
,p_colspan=>10
,p_grid_column=>2
,p_field_template=>wwv_flow_api.id(199912145983970073)
,p_item_template_options=>'#DEFAULT#:margin-top-sm:margin-bottom-sm'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(679342733964094216)
,p_name=>'P48_CANT_DISP_VENTA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(707732594087496285)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Total Disponible'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'READONLY style="text-align: right;font-weight:bold;"'
,p_grid_label_column_span=>5
,p_field_template=>wwv_flow_api.id(25535943977951769)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(410849853046916578)
,p_validation_name=>'VALIDAR_DETALLE'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'     X NUMBER;',
'BEGIN',
'  BEGIN',
'        SELECT COUNT(SEQ_ID) INTO  X',
'          FROM APEX_collections',
'         WHERE collection_name = ''FACI240_DE'';  ',
' END;',
' ',
' IF X = 0 THEN',
'   RAISE_APPLICATION_ERROR(-20001,''No se puede generar doumento sin un detalle!'');',
' END IF;',
'',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(410797919560916542)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(410850256941916578)
,p_validation_name=>'VALIDACION'
,p_validation_sequence=>20
,p_validation=>'NULL;'
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(410797919560916542)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410865303265916585)
,p_name=>'AL CARGAR'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410865891625916585)
,p_event_id=>wwv_flow_api.id(410865303265916585)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'   V_MENSAJE VARCHAR2(500);',
'BEGIN ',
'   V_MENSAJE := ''% FACI240.ON LOAD.. '';',
'   APEX_DEBUG_MESSAGE.LOG_MESSAGE ( V_MENSAJE ,  TRUE, 6 ) ; ',
'',
'   V_MENSAJE := ''% FACI240.ON LOAD.. OBTENER P48_OPER_EDITAR_PED=> '' || :P48_OPER_EDITAR_PED;',
'   APEX_DEBUG_MESSAGE.LOG_MESSAGE ( V_MENSAJE ,  TRUE, 6 ) ; ',
'   ',
'   ',
'   ',
'END;',
'',
'-- FACI240_P.PP_CARGAR_DATOS ;  ',
'--RAISE_APPLICATION_ERROR( -20001,  ''XX01'') ; ',
'NULL ; '))
,p_attribute_02=>'P_EMPRESA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(420459144703545641)
,p_event_id=>wwv_flow_api.id(410865303265916585)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($v("P48_PED_CLAVE") !== "")  {',
'    if ($v("P48_OPER_EDITAR_PED") == "N") {',
'       desacEntradas();    ',
'    } ',
'}',
'',
'desacItem("P48_PED_SUC");',
'',
'if ( $("#P48_PED_IMP_FACTURADO").autoNumeric(''getNumber'') > 0 ) {',
'    desacItem("P48_PED_CLI");',
'    desacItem("P48_PED_FECHA");',
'    desacItem("P48_PED_MON");',
'    desacItem("P48_PROD_CODIGO");',
'    desacItem("P48_PED_CONTRATO_NRO");',
'} ',
'',
'// alert("P48_OPER_EDITAR_PRE => " + $v("P48_OPER_EDITAR_PRE") );',
'/*',
'if ($v("P48_OPER_EDITAR_PRE") == "N")  {',
'    desacItem("P48_PRECIO_UN");',
'}',
'*/',
'',
'$s("P48_VERIFICAR_ELEM", "N");',
'',
'',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410870093847916586)
,p_name=>'AL CAMBIAR CLI'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_PED_CLI'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410870558713916587)
,p_event_id=>wwv_flow_api.id(410870093847916586)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FACI240_P.PP_BUSCAR_CLIENTE ; ',
'FACI240_P.PP_CARGAR_CUENTAS_CLI ; '))
,p_attribute_02=>'P48_PED_CLI,P_EMPRESA'
,p_attribute_03=>'P48_PED_CLI,P48_CLI_NOMBRE,P48_PED_CLI_CONTACTO,P48_PED_CLI_TEL,P48_PED_CLI_RUC,P48_PED_VENDEDOR,P48_VEND_NOMBRE,P48_IMP_AD_VENCIDO_USD, P48_IMP_AD_AVENCER_USD, P48_IMP_FA_VENCIDO_USD, P48_IMP_FA_AVENCER_USD'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410870997934916587)
,p_name=>'AL CAMBIAR FEC'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_PED_FECHA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410871416535916587)
,p_event_id=>wwv_flow_api.id(410870997934916587)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P48_PED_FECHA:= GENERAL.FL_AUTO_FECHA(:P48_PED_FECHA);',
''))
,p_attribute_02=>'P48_PED_FECHA,P_EMPRESA'
,p_attribute_03=>'P48_PED_FECHA'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410877089537916589)
,p_name=>'AL CAMBIAR FEC_ENTREG'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_PED_FEC_ENTREG_REQ'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410877560433916589)
,p_event_id=>wwv_flow_api.id(410877089537916589)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P48_PED_FEC_ENTREG_REQ  := GENERAL.FL_AUTO_FECHA(:P48_PED_FEC_ENTREG_REQ); ',
''))
,p_attribute_02=>'P48_PED_FEC_ENTREG_REQ,P_EMPRESA'
,p_attribute_03=>'P48_PED_FEC_ENTREG_REQ'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410866257226916585)
,p_name=>'AL CAMBIAR'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_S_DETAT_CLAVE_CONCEPTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410866711019916585)
,p_event_id=>wwv_flow_api.id(410866257226916585)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  -- CALL THE PROCEDURE',
'  PRDI024.PP_CONCEPTO(  :P_EMPRESA,',
'                        :P_SUCURSAL,',
'                        :P48_DOCU_DEP_ORIG,',
'                        :P48_S_DETAT_CLAVE_CONCEPTO,',
'                        :P48_DETAT_CLAVE_CONCEPTO,',
'                        :P48_DESC_CONCEPTO,',
'                        :P48_DETAT_DESTINO_USO,',
'                        :P48_C1,',
'                        :P48_C2,',
'                        :P48_C3,',
'                        :P48_C4,',
'                        :P48_C5,',
'                        :P48_C6,',
'                        :P48_C7,',
'                        :P48_C8,',
'                        :P48_C9,',
'                        :P48_C12,',
'                        :P48_IND_CANAL_REQ);',
''))
,p_attribute_02=>'P48_S_DETAT_CLAVE_CONCEPTO'
,p_attribute_03=>'P48_DETAT_CLAVE_CONCEPTO,P48_DETAT_DESTINO_USO,P48_DESC_CONCEPTO,P48_C1,P48_C2,P48_C3,P48_C4,P48_C5,P48_C9,P48_C12,P48_C6,P48_C7,P48_C8'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410862912146916584)
,p_name=>'EDITAR_REGISTRO'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_NRO_ITEM_UPDATE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410864488527916584)
,p_event_id=>wwv_flow_api.id(410862912146916584)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'SELECT SEQ_ID NRO_ITEM,',
'       N001   ARTICULO,',
'       N002   CANTIDAD,',
'       N003   CONCEPTO,',
'       N004   DEST_USO,',
'       N005   COSTO_TOTAL',
'  INTO :P48_NRO_ITEM,',
'       :P48_DETAT_ART,',
'       :P48_DETAT_ART_CANT,',
'       :P48_DETAT_CLAVE_CONCEPTO,',
'       :P48_DETAT_DESTINO_USO,',
'       :P48_DETA_TOTAL_COST',
'  FROM APEX_collections',
' WHERE collection_name = ''STKI005''',
' AND SEQ_ID=:P48_NRO_ITEM_UPDATE;',
'EXCEPTION WHEN OTHERS THEN',
'NULL;',
'END;'))
,p_attribute_02=>'P48_NRO_ITEM_UPDATE'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410863986961916584)
,p_event_id=>wwv_flow_api.id(410862912146916584)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
' BEGIN',
' SELECT D.FCON_CODIGO',
'    INTO :P48_S_DETAT_CLAVE_CONCEPTO',
'   FROM FIN_CONCEPTO  D   ',
'   WHERE FCON_CLAVE=:P48_DETAT_CLAVE_CONCEPTO',
'      AND D.FCON_EMPR=:P_EMPRESA;',
'  EXCEPTION WHEN OTHERS THEN',
'  NULL;',
'  END;',
' '))
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410863420651916584)
,p_event_id=>wwv_flow_api.id(410862912146916584)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
' BEGIN',
' SELECT D.FCON_CODIGO',
'    INTO :P48_S_DETAT_CLAVE_CONCEPTO',
'   FROM FIN_CONCEPTO  D   ',
'   WHERE FCON_CLAVE=:P48_DETAT_CLAVE_CONCEPTO',
'      AND D.FCON_EMPR=:P_EMPRESA;',
'  EXCEPTION WHEN OTHERS THEN',
'  NULL;',
'  END;',
'  ',
'  BEGIN',
'SELECT',
'       C001   CA1,',
'       C002   CA2,',
'       C003   CA3,',
'       C004   CA4,',
'       C005   CA5,',
'       C006   CA6,',
'       C007   CA7,',
'       C008   CA8,',
'       C009   CA9,',
'       C010  CA12',
'  INTO ',
'       :P48_C1,',
'       :P48_C2,',
'       :P48_C3,',
'       :P48_C4,',
'       :P48_C5,',
'       :P48_C6,',
'       :P48_C7,',
'       :P48_C8,',
'       :P48_C9,',
'       :P48_C12',
'  FROM APEX_collections',
' WHERE collection_name = ''STKI005''',
' AND SEQ_ID=:P48_NRO_ITEM_UPDATE;',
'EXCEPTION WHEN OTHERS THEN',
'NULL;',
'END;'))
,p_attribute_02=>'P48_NRO_ITEM_UPDATE'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410864952129916584)
,p_event_id=>wwv_flow_api.id(410862912146916584)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(1952317108594176114)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410861530966916583)
,p_name=>'ELIMINAR_REGISTRO'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_NRO_ITEM_DELETE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410862047462916583)
,p_event_id=>wwv_flow_api.id(410861530966916583)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>' STKI005.PP_BORRAR_ITEM(:P48_NRO_ITEM_DELETE);'
,p_attribute_02=>'P48_NRO_ITEM_DELETE'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410862534114916584)
,p_event_id=>wwv_flow_api.id(410861530966916583)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(1952317108594176114)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410854835242916580)
,p_name=>'ACEPTAR_DETA'
,p_event_sequence=>120
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(410830153796916567)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410855381555916581)
,p_event_id=>wwv_flow_api.id(410854835242916580)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FACI240_P.PP_VALIDAR_PRECIO ; ',
'faci240_p.validate_disp_venta ;',
'FACI240_P.PP_ACTU_DETA;',
'',
'',
''))
,p_attribute_02=>'P48_PED_CLAVE,P48_OPER_AUX,P48_SEQ_ID_UPDATE,P48_NRO_ITEM_AUX,P_EMPRESA,P48_ART_CODIGO,P48_ART_IMPU,P48_IMPU_PORC,P48_IMPU_PORC_DESC,P48_CANT_PED,P48_PRECIO_UN,P48_IMP_TOT_DETA,P48_CANT_FAC,P48_CANT_PEN_FAC,P48_OBS_DETA,P48_PED_MON,P48_PED_FECHA,P48_'
||'MON_DEC_IMP'
,p_attribute_03=>'P48_PED_IMP_TOTAL_MON_AUX,P48_PED_IMP_AFACTURAR_AUX'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410856398726916581)
,p_event_id=>wwv_flow_api.id(410854835242916580)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(1952317108594176114)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410855865185916581)
,p_event_id=>wwv_flow_api.id(410854835242916580)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item( "P48_ART_CODIGO" ).setValue( null,  null, true );',
'apex.item( "P48_PRECIO_UN" ).setValue( null,  null, true );',
'apex.item( "P48_CANT_PED" ).setValue( null,  null, true );',
'apex.item( "P48_IMP_TOT_DETA" ).setValue( null,  null, true );',
'apex.item( "P48_OBS_DETA" ).setValue( null,  null, true );',
'apex.item( "P48_IMPU_PORC_DESC" ).setValue( null,  null, true );',
'',
'apex.item( "P48_CANT_FAC" ).setValue( 0,  null, true );',
'apex.item( "P48_CANT_PEN_FAC" ).setValue( null,  null, true );',
'',
'apex.item( "P48_CANT_EXIST" ).setValue( null,  null, true );',
'',
'',
'$s("P48_PED_IMP_TOTAL_MON", $v("P48_PED_IMP_TOTAL_MON_AUX"));',
'$s("P48_PED_IMP_TOTAL_MON_RD", $v("P48_PED_IMP_TOTAL_MON_AUX"));',
'$s("P48_PED_IMP_AFACTURAR", $v("P48_PED_IMP_AFACTURAR_AUX"));',
'',
'actDecimElem();',
'',
'// P48_ART_CODIGO,P48_PRECIO_UN,P48_CANT_PED,,P48_IMP_TOT_DETA,P48_OBS_DETA,P48_IMPU_PORC_DESC'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410856847178916581)
,p_event_id=>wwv_flow_api.id(410854835242916580)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P48_ART_CODIGO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410867197517916585)
,p_name=>'AGREG_DETA_ON_CLICK'
,p_event_sequence=>130
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(410804916159916550)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410868175805916586)
,p_event_id=>wwv_flow_api.id(410867197517916585)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FACI240_P.PP_VALIDAR_CAB      ; ',
'FACI240_P.PP_LIMPIAR_AUX      ; ',
':P48_OPER_AUX      :=   ''I''   ; ',
':P48_SEQ_ID_UPDATE :=   NULL  ; ',
''))
,p_attribute_02=>'P48_PED_FECHA,P48_PED_MON,P48_PED_CLI'
,p_attribute_03=>'P48_ART_CODIGO,P48_OPER_AUX,P48_SEQ_ID_UPDATE'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(443698118743282210)
,p_event_id=>wwv_flow_api.id(410867197517916585)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item( "P48_ART_CODIGO" ).setValue( null,  null, true );',
'apex.item( "P48_IMPU_PORC" ).setValue( null,  null, true );',
'apex.item( "P48_ART_UN_MED" ).setValue( null,  null, true );',
'',
'apex.item( "P48_PRECIO_UN" ).setValue( null,  null, true );',
'apex.item( "P48_CANT_PED" ).setValue( null,  null, true );',
'',
'apex.item( "P48_IMP_TOT_DETA" ).setValue( null,  null, true );',
'apex.item( "P48_OBS_DETA" ).setValue( null,  null, true );',
'apex.item( "P48_IMPU_PORC_DESC" ).setValue( null,  null, true );',
'',
'//apex.item( "P48_CANT_FAC" ).setValue( null,  null, true );',
'apex.item( "P48_CANT_FAC" ).setValue( 0,  null, true );',
'apex.item( "P48_CANT_PEN_FAC" ).setValue( null,  null, true );',
'apex.item( "P48_ART_CODIGO_INI" ).setValue( null,  null, true );',
'apex.item( "P48_SEQ_ID_UPDATE" ).setValue( null,  null, true );',
'',
'apex.item( "P48_OPER_AUX" ).setValue( "I",  null, true );',
'apex.item( "P48_CANT_EXIST" ).setValue( null,  null, true );',
'',
'',
''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410867617286916585)
,p_event_id=>wwv_flow_api.id(410867197517916585)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(1392485845932753936)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410869108511916586)
,p_event_id=>wwv_flow_api.id(410867197517916585)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P48_ART_CODIGO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410871857683916587)
,p_name=>'P48_SEQ_ID_DELETE_ON_CHANGE'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_SEQ_ID_DELETE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410872356232916587)
,p_event_id=>wwv_flow_api.id(410871857683916587)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FACI240_P.PP_BORRAR_ITEM(:P48_SEQ_ID_DELETE);',
''))
,p_attribute_02=>'P48_SEQ_ID_DELETE'
,p_attribute_03=>'P48_PED_IMP_TOTAL_MON_AUX,P48_PED_IMP_AFACTURAR_AUX'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410872829189916587)
,p_event_id=>wwv_flow_api.id(410871857683916587)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(1952317108594176114)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410873308023916588)
,p_event_id=>wwv_flow_api.id(410871857683916587)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$s("P48_PED_IMP_TOTAL_MON"    , $v("P48_PED_IMP_TOTAL_MON_AUX"));',
'$s("P48_PED_IMP_TOTAL_MON_RD" , $v("P48_PED_IMP_TOTAL_MON_AUX"));',
'$s("P48_PED_IMP_AFACTURAR"    , $v("P48_PED_IMP_AFACTURAR_AUX"));',
'actDecimElem();',
'',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410857266732916581)
,p_name=>'P48_SEQ_ID_UPDATE_ON_CHANGE'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_SEQ_ID_UPDATE'
,p_condition_element=>'P48_SEQ_ID_UPDATE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410857737497916582)
,p_event_id=>wwv_flow_api.id(410857266732916581)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'FACI240_P.MOSTRAR_FILA_EDIT        ; '
,p_attribute_02=>'P48_SEQ_ID_UPDATE,P48_PED_SUC'
,p_attribute_03=>'P48_ART_IMPU,P48_IMPU_PORC,P48_IMPU_PORC_DESC,P48_ART_UN_MED,P48_NRO_ITEM_AUX,P48_OPER_AUX,P48_PRECIO_UN_AUX,P48_ART_CODIGO_AUX,P48_ART_DESC_AUX,P48_ART_CODIGO,P48_CANT_PED,P48_PRECIO_UN,P48_IMP_TOT_DETA,P48_CANT_FAC,P48_CANT_PEN_FAC,P48_OBS_DETA,P48'
||'_ART_CODIGO_INI,P48_CANT_EXIST'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410858239811916582)
,p_event_id=>wwv_flow_api.id(410857266732916581)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(1392485845932753936)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410859261339916582)
,p_event_id=>wwv_flow_api.id(410857266732916581)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P48_ART_CODIGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410858777416916582)
,p_event_id=>wwv_flow_api.id(410857266732916581)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'vCod  = $v("P48_ART_CODIGO_AUX");',
'vDesc = $v("P48_ART_DESC_AUX");',
'apex.item( "P48_ART_CODIGO" ).setValue( vCod, vDesc , true) ; ',
'actDecimElem();',
''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410859789150916583)
,p_event_id=>wwv_flow_api.id(410857266732916581)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P48_ART_CODIGO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410873739648916588)
,p_name=>'P48_MONEDA_ON_CHANGE'
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_PED_MON'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410875706912916589)
,p_event_id=>wwv_flow_api.id(410873739648916588)
,p_event_result=>'TRUE'
,p_action_sequence=>9
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'FACI240_P.PP_BUSCAR_DEC_MON;'
,p_attribute_02=>'P48_PED_MON'
,p_attribute_03=>'P48_MON_DESC,P48_MON_DEC_IMP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410875285123916589)
,p_event_id=>wwv_flow_api.id(410873739648916588)
,p_event_result=>'TRUE'
,p_action_sequence=>19
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'FACI240_P.PP_ACT_MON_DOCU;'
,p_attribute_02=>'P48_PED_MON,P48_MON_DEC_IMP'
,p_attribute_03=>'P48_PED_IMP_TOTAL_MON_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410874730101916588)
,p_event_id=>wwv_flow_api.id(410873739648916588)
,p_event_result=>'TRUE'
,p_action_sequence=>29
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(1952317108594176114)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410874227444916588)
,p_event_id=>wwv_flow_api.id(410873739648916588)
,p_event_result=>'TRUE'
,p_action_sequence=>39
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$s("P48_PED_IMP_TOTAL_MON", $v("P48_PED_IMP_TOTAL_MON_AUX"));',
'$s("P48_PED_IMP_TOTAL_MON_RD", $v("P48_PED_IMP_TOTAL_MON_AUX"));',
'actDecimElem();',
'',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410876102909916589)
,p_name=>'P48_ART_CODIGO_ON_CHANGE'
,p_event_sequence=>180
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_ART_CODIGO'
,p_condition_element=>'P48_ART_CODIGO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410876615673916589)
,p_event_id=>wwv_flow_api.id(410876102909916589)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'FACI240_P.PP_BUSCAR_ARTICULO;'
,p_attribute_02=>'P_EMPRESA,P48_PED_SUC,P48_CANT_PED,P48_ART_CODIGO,P48_PED_MON,P48_PED_FECHA,P48_MON_DEC_IMP,P48_CANT_DISP_VENTA'
,p_attribute_03=>'P48_ART_UN_MED,P48_ART_IMPU,P48_IMPU_PORC,P48_IMPU_PORC_DESC,P48_PRECIO_UN,P48_IMP_TOT_DETA,P48_CANT_EXIST,P48_CANT_DISP_VENTA'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(420459856929545648)
,p_event_id=>wwv_flow_api.id(410876102909916589)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'actDecimElem();'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410879779614916590)
,p_name=>'P48_ART_CODIGO_ON_FOCUS'
,p_event_sequence=>190
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_ART_CODIGO'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410880237302916590)
,p_event_id=>wwv_flow_api.id(410879779614916590)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'actDecimElem();'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410852529770916579)
,p_name=>'BUSCAR_PED_ON_CLICK'
,p_event_sequence=>200
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(410814928863916559)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410853048585916579)
,p_event_id=>wwv_flow_api.id(410852529770916579)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(703542835687035952)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410853494591916580)
,p_name=>'P48_PRECIO_UN_ON_CHANGE'
,p_event_sequence=>210
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_PRECIO_UN'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410853903574916580)
,p_event_id=>wwv_flow_api.id(410853494591916580)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'FACI240_P.PP_CALC_TT_AUXI   ; '
,p_attribute_02=>'P48_CANT_PED,P48_PRECIO_UN,P48_MON_DEC_IMP'
,p_attribute_03=>'P48_IMP_TOT_DETA'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410854481467916580)
,p_event_id=>wwv_flow_api.id(410853494591916580)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'actDecimElem();',
'// console.log("x");',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(443697810445282207)
,p_name=>'P48_CANT_PED_ON_CHANGE'
,p_event_sequence=>220
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_CANT_PED'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(443697966383282208)
,p_event_id=>wwv_flow_api.id(443697810445282207)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'FACI240_P.PP_CALC_TT_AUXI; '
,p_attribute_02=>'P48_CANT_PED,P48_PRECIO_UN,P48_MON_DEC_IMP,P48_ART_CODIGO'
,p_attribute_03=>'P48_IMP_TOT_DETA,P48_CANT_PEN_FAC'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(443698009478282209)
,p_event_id=>wwv_flow_api.id(443697810445282207)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'actDecimElem();',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410881595467916591)
,p_name=>'P48_PED_CLAVE_ON_CHANGE'
,p_event_sequence=>230
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_PED_CLAVE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410882021552916592)
,p_event_id=>wwv_flow_api.id(410881595467916591)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// alert( "P48_PED_EMPR = " +  $v("P48_PED_EMPR")) ; ',
'// alert( "P48_PED_CLAVE = " +  $v("P48_PED_CLAVE")) ; ',
'',
'apex.page.submit( {request:"QUERY",showWait:true, validate:false});',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410880645229916591)
,p_name=>'irBtnAcepDeta'
,p_event_sequence=>240
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'document'
,p_bind_type=>'bind'
,p_bind_event_type=>'custom'
,p_bind_event_type_custom=>'irBtnAcepDeta'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410881123818916591)
,p_event_id=>wwv_flow_api.id(410880645229916591)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(410830153796916567)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410860150298916583)
,p_name=>'IMPRIMIR'
,p_event_sequence=>250
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(410798739187916542)
,p_condition_element=>'P48_PED_CLAVE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410860681411916583)
,p_event_id=>wwv_flow_api.id(410860150298916583)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'FACI240_P.PP_CONFIG_REP;'
,p_attribute_02=>'P48_PED_EMPR,P48_PED_CLAVE'
,p_attribute_03=>'P48_URL_REP,P48_URL_DESC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410861174134916583)
,p_event_id=>wwv_flow_api.id(410860150298916583)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:var myWindow = window.open(''f?p=100:3010:&SESSION.::::::'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410882418578916592)
,p_name=>'DELETE'
,p_event_sequence=>260
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(410799121307916542)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410882910114916592)
,p_event_id=>wwv_flow_api.id(410882418578916592)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:apex.confirm("Desea Eliminar el Pedido?",''DELETE'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410877903517916590)
,p_name=>'PED_PRODUCTO_ON_CHANGE'
,p_event_sequence=>270
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_PED_PROD_COD'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410878447501916590)
,p_event_id=>wwv_flow_api.id(410877903517916590)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'NULL;'
,p_attribute_02=>'P48_PED_PROD_COD'
,p_attribute_03=>'P48_PROD_DESC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(410878811739916590)
,p_name=>'P48_PROD_CODIGO_ON_CHANGE'
,p_event_sequence=>280
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_PROD_CODIGO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(410879333645916590)
,p_event_id=>wwv_flow_api.id(410878811739916590)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'FACI240_P.PP_BUSCAR_ZAFRA;'
,p_attribute_02=>'P48_PROD_CODIGO,P48_PED_FECHA,P48_PED_CLI,P48_PED_TIPO_FAC'
,p_attribute_03=>'P48_PROD_CODIGO,P48_PED_PRODUCTO,P48_PROD_DESC,P48_PED_VENC'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(443698416795282213)
,p_event_id=>wwv_flow_api.id(410878811739916590)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'FACI240_P.PP_BUSCAR_LINEA_DISP;'
,p_attribute_02=>'P48_PED_PRODUCTO,P48_PED_CLI,P48_PED_MON'
,p_attribute_03=>'P48_IMP_DISP_LINEA'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(443698504140282214)
,p_event_id=>wwv_flow_api.id(410878811739916590)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'actDecimElem();'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(420456314776545613)
,p_name=>'PED_VEND_OND_CHANGE'
,p_event_sequence=>290
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_PED_VENDEDOR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(420456415746545614)
,p_event_id=>wwv_flow_api.id(420456314776545613)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'FACI240_P.PP_BUSCAR_VENDEDOR;'
,p_attribute_02=>'P48_PED_VENDEDOR'
,p_attribute_03=>'P48_PED_VENDEDOR,P48_VEND_NOMBRE'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(420456554863545615)
,p_name=>'P48_PED_TIPO_FAC_ON_CHANGE'
,p_event_sequence=>300
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_PED_TIPO_FAC'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(420456607843545616)
,p_event_id=>wwv_flow_api.id(420456554863545615)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'FACI240_P.PP_BUSCAR_TIPO_FA;'
,p_attribute_02=>'P48_PED_TIPO_FAC'
,p_attribute_03=>'P48_PED_TIPO_FAC_DESC'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(420456810071545618)
,p_name=>'P48_PED_CONTRATO_NRO_ON_CHANGE'
,p_event_sequence=>310
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P48_PED_CONTRATO_NRO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(420456998298545619)
,p_event_id=>wwv_flow_api.id(420456810071545618)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'FACI240_P.PP_BUSCAR_CONTRATO_BONO;'
,p_attribute_02=>'P48_PED_CONTRATO_NRO,P48_PED_CLI,P48_PED_PRODUCTO,P48_PED_MON'
,p_attribute_03=>'P48_PED_CONTRATO_NRO,P48_PED_CONTRATO_BONO,P48_PED_MONTO_BONO_ASIG'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(420459263409545642)
,p_name=>'BEFORE_SUBMIT'
,p_event_sequence=>320
,p_bind_type=>'bind'
,p_bind_event_type=>'apexbeforepagesubmit'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(420459383985545643)
,p_event_id=>wwv_flow_api.id(420459263409545642)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'activarEntradas(); ',
'$s("P48_VERIFICAR_ELEM", "S");',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(420459414928545644)
,p_name=>'VENTANA_ON_FOCUS'
,p_event_sequence=>330
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(1952315055716176094)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(420459568192545645)
,p_event_id=>wwv_flow_api.id(420459414928545644)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (   $v("P48_VERIFICAR_ELEM") ==  "S" ) {',
'    ',
'    if ($v("P48_PED_CLAVE") !== "")  {',
'        if ($v("P48_OPER_EDITAR_PED") == "N") {',
'           desacEntradas();    ',
'        } ',
'    } ',
'    ',
'    desacItem("P48_PED_SUC");',
'',
'    if ( $("#P48_PED_IMP_FACTURADO").autoNumeric(''getNumber'') > 0 ) {',
'        desacItem("P48_PED_CLI");',
'        desacItem("P48_PED_FECHA");',
'        desacItem("P48_PED_MON");',
'        desacItem("P48_PROD_CODIGO");',
'        desacItem("P48_PED_CONTRATO_NRO");',
'    } ',
'    $s("P48_VERIFICAR_ELEM", "N");',
'',
'}',
'',
''))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(410850909453916578)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'GUARDAR_NUEVO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FACI240_P.GUARDAR_NUEVO ; ',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(410797919560916542)
,p_process_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Acci\00F3n Procesada. <br>'),
'',
'<a target="_blank" href="&P48_URL_REP.">&P48_URL_DESC.</a>  ',
'',
''))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(410851752961916579)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'APLICAR_CAMBIOS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FACI240_P.APLICAR_CAMBIOS ; ',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(410798319865916542)
,p_process_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Acci\00F3n Procesada. <br>'),
'',
'<a target="_blank" href="&P48_URL_REP.">&P48_URL_DESC.</a>  ',
'',
''))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(410852181549916579)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'ELIMINAR'
,p_process_sql_clob=>'FACI240_P.ELIMINAR_PEDIDO;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'DELETE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'Pedido Eliminado con Exito!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(410851300261916578)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'RESET'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'QUERY'
,p_process_when_type=>'REQUEST_NOT_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(410827215980916565)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(1522383222630964632)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form FACI240 -  PEDIDO VENTA INSUM'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_is_stateful_y_n=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(410850500928916578)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PP_CARGAR_DATOS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(P_COLLECTION_NAME => ''FACI240_DE''); ',
'FACI240_P.PP_CARGAR_DATOS;',
'',
'APEX_DEBUG_MESSAGE.LOG_MESSAGE ( ''FACI240.BEFORE HEADER'',  TRUE, 6 );',
'',
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
