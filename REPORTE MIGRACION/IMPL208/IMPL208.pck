create or replace package IMPL208 is

  -- Author  : PROGRAMACION7
  -- Created : 16/06/2022 16:22:36
  -- Purpose : Generacion del reporte
  
  function get_report(
    in_clave_importacion number,
    in_empresa           number
  )return varchar2;

end IMPL208;
/
create or replace package body IMPL208 is

  function get_report(
      in_clave_importacion number,
      in_empresa           number
  )return varchar2 as
    l_additional_parameters varchar2(32767);
    l_url                   varchar2(4000);
    
    co_reporte  constant varchar2(8 char) := 'impl208';
  begin
      l_additional_parameters := 'nroImportacion=' ||APEX_UTIL.URL_ENCODE(in_clave_importacion);
          
      jripacr.get_report_url(
          p_rep_name          => co_reporte,
          in_empresa          => in_empresa,
          p_rep_format        => 'pdf', 
          p_data_source       => 'default',
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
