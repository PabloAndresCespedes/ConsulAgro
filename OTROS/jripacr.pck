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
  
  function decode_jwt(
    in_encode varchar2
  )return number;
  
  function generate_jwt(
    in_clave    number,
    in_seconds  number := 60  
  )return varchar2;
  
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
   
  function decode_jwt(
    in_encode varchar2
  )return number is
    l_token apex_jwt.t_token;
    l_keys  apex_t_varchar2;
  begin
    l_token := apex_jwt.decode (p_value => in_encode);
    
    -- valida los segundos del token
    apex_jwt.validate ( p_token => l_token);
    
    apex_json.parse(l_token.payload);
      
    l_keys := apex_json.get_members('.');
      
    return apex_json.get_number(l_keys(1));
    
  exception
    when others then
      return -1;   
  end decode_jwt;
  
  function generate_jwt(
    in_clave    number,
    in_seconds  number   
  )return varchar2 is
    l_jwt_value varchar2(32767);
  begin
    l_jwt_value := apex_jwt.encode (p_iss => in_clave, p_exp_sec => in_seconds );
    
    return l_jwt_value;
    
  end generate_jwt;
  
end jripacr;
/
