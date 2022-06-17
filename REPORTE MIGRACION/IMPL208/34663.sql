create or replace package jripacr as

  -- Author  : @PabloACespedes
  -- Created : 16/06/2022 16:52:31
  -- Purpose : generador de url para jasper integration
 
  procedure get_report_url (
      p_rep_name            in   varchar2 default 'test',
      p_rep_format          in   varchar2 default 'pdf',
      p_data_source         in   varchar2 default 'default',
      p_out_filename        in   varchar2 default null,
      p_rep_locale          in   varchar2 default 'de_DE',
      p_rep_encoding        in   varchar2 default 'UTF-8',
      p_additional_params   in   varchar2 default null,

      p_print_is_enabled    in   boolean default false,
      p_print_printer_name  in   varchar2 default null,
      p_print_media         in   varchar2 default null,
      p_print_copies        in   number default 1,
      p_print_duplex        in   boolean default false,
      p_print_collate       in   boolean default false,
      p_save_is_enabled     in   boolean default false,
      p_save_filename       in   varchar2 default null,
      p_rep_time_zone       in   varchar2 default null,
      in_empresa            in   number,
      p_url                 out  varchar2
   );
  
  
end jripacr;
/
create or replace package body jripacr as
  -- convert boolean to 'true' or 'false'
  function bool2string(b in boolean) return varchar2 is
  begin
    if b then
      return 'true';
    else
      return 'false';
    end if;
  end bool2string;
  
  procedure get_report_url (
      p_rep_name            in   varchar2 default 'test',
      p_rep_format          in   varchar2 default 'pdf',
      p_data_source         in   varchar2 default 'default',
      p_out_filename        in   varchar2 default null,
      p_rep_locale          in   varchar2 default 'de_DE',
      p_rep_encoding        in   varchar2 default 'UTF-8',
      p_additional_params   in   varchar2 default null,

      p_print_is_enabled    in   boolean default false,
      p_print_printer_name  in   varchar2 default null,
      p_print_media         in   varchar2 default null,
      p_print_copies        in   number default 1,
      p_print_duplex        in   boolean default false,
      p_print_collate       in   boolean default false,
      p_save_is_enabled     in   boolean default false,
      p_save_filename       in   varchar2 default null,
      p_rep_time_zone       in   varchar2 default null,
      in_empresa            in   number,
      p_url                 out  varchar2
   )as
      l_url  varchar2(32767);
      l_base gen_empresa.empr_url_reports%type;
   BEGIN
      <<get_base_url>>
      begin
        select g.empr_url_reports
        into l_base
        from gen_empresa g
        where empr_codigo = in_empresa;
      exception
        when no_data_found then
          Raise_application_error(-20000, 'Base URL no encontrada. Comun'||chr(237)||'quese con TI');
      end get_base_url;
      
      l_url := l_base;
      l_url := l_url || '?_repName=' || p_rep_name;
      l_url := l_url || '&_repFormat=' || p_rep_format;
      l_url := l_url || '&_dataSource=' || p_data_source;
      l_url := l_url || '&_outFilename=' || p_out_filename;
      l_url := l_url || '&_repLocale=' || p_rep_locale;
      l_url := l_url || '&_repEncoding=' || p_rep_encoding;
      l_url := l_url || '&_repTimeZone=' || APEX_UTIL.URL_ENCODE(p_rep_time_zone);

      -- direct printing
      l_url := l_url || '&_printIsEnabled=' || bool2string(p_print_is_enabled);
      l_url := l_url || '&_printPrinterName=' || p_print_printer_name;
      l_url := l_url || '&_printPrinterTray=' || p_print_media;
      l_url := l_url || '&_printCopies=' || p_print_copies;
      l_url := l_url || '&_printDuplex=' || bool2string(p_print_duplex);
      l_url := l_url || '&_printCollate=' || bool2string(p_print_collate);

      -- save file on server
      l_url := l_url || '&_saveIsEnabled=' || bool2string(p_save_is_enabled);
      l_url := l_url || '&_saveFileName=' || p_save_filename;

      -- additional report parameter passed?
      IF (p_additional_params IS NOT NULL)
      THEN
         l_url := l_url || '&' || p_additional_params;
      END IF;

      p_url := l_url;
   end get_report_url;
   
end jripacr;
/
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
