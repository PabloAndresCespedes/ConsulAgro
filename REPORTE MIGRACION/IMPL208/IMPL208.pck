create or replace package IMPL208 is

  -- Author  : PROGRAMACION7
  -- Created : 16/06/2022 16:22:36
  -- Purpose : Generacion del reporte
  
  function get_report(
    in_clave_importacion number,
    in_session           number,
    in_user              varchar2
  )return varchar2;

end IMPL208;
/
create or replace package body IMPL208 is

function get_report(
    in_clave_importacion number,
    in_session           number,
    in_user              varchar2
)return varchar2 as
  l_additional_parameters     VARCHAR2(32767);
  co_reporte constant varchar2(8 char) := 'impl208';
  co_div     constant varchar2(1 char)   := '&';
  l_url      varchar2(4000);
  l_base_url  varchar2(4000);
begin
    l_additional_parameters := 'P_FORMATO=' || APEX_UTIL.URL_ENCODE('pdf')||co_div||
    'P_DESC_PROGRAMA=' ||APEX_UTIL.URL_ENCODE(TO_CHAR('DETALLE DE GASTOS POR IMPOTACION'))||co_div||
    'P_SESSION_ID=' ||APEX_UTIL.URL_ENCODE(in_session)||co_div||
    'nroImportacion=' ||APEX_UTIL.URL_ENCODE(in_clave_importacion);
       
    delete from gen_parametros_report where usuario = in_user;
        
    insert into gen_parametros_report
    (parametros, usuario, nombre_reporte, formato_salida)
    values
    (l_additional_parameters, in_user, co_reporte, 'pdf');
     
    SELECT EMPR_URL_REPORTS
    INTO l_base_url
    FROM GEN_EMPRESA
    WHERE EMPR_CODIGO = 1;
        
    jripacr.get_report_url(
        p_base_url          => l_base_url,
        p_rep_name          => co_reporte,  
        p_rep_format        => 'pdf', 
        p_data_source       => 'default', 
        p_out_filename      => null, 
        p_rep_locale        => null, 
        p_rep_encoding      => null, 
        p_additional_params => l_additional_parameters,
        p_url               => l_url --> out
        );
     return l_url;   
exception
  when others then
       raise_application_error(-20001, sqlerrm);
end get_report;

end IMPL208;
/
