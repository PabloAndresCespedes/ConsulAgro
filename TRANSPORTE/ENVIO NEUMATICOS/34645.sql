create or replace package TRAI215 is

  -- Author  : PROGRAMACION7
  -- Created : 09/06/2022 14:39:26
  -- Purpose : Programas Transporte Movimiento
  
  -- Procedures
  procedure envio_articulo(
    in_data    varchar2, --> Regla: ARTICULO:SERIE
    in_tipo    varchar2, --> D || R >> Desecho o Recapado
    in_fecha   date   := null,   -- Para recapado
    in_prov    number := null, -- Para recapado
    in_obs     tal_stk_baja_neu.tsb_obs%type,
    in_empresa number,
    in_suc     number,
    in_user    varchar2
  );
  
  /*
    Author  : @PabloACespedes \(^-^)/
    Created : 09/06/2022 14:52:00
    Obtiene datos de la los departamentos de baja,
    para recapado y del proveedor asignado para recapar
  */
  procedure get_data_dep(
     in_empresa  in number,
     in_suc      in number,
     out_dep_baja       out number,
     out_dep_recapado   out number,
     out_dep_prov_recap out number
  );
  
  procedure add_det_stk_doc(
    in_data  varchar2, --> Regla: ARTICULO:SERIE,ARTICULO:SERIE
    in_clave stk_documento_det.deta_clave_doc%type,
    in_empr  stk_documento_det.deta_empr%type
  );
  
  procedure add_tal_env_recapado_det(
    in_clave_cab number,
    in_art       number,
    in_serie     varchar2,
    in_empresa   number
  );
  
  -- FUNCTIONS
  /*
    Author  : @PabloACespedes \(^-^)/
    Created : 10/06/2022 10:40:58
    agrega la cabecera del documento,
    en el caso que este relacionado a otro
    amerita el envio del argumento in_clave_padre
  */
  function add_stk_documento(
    in_empresa       stk_documento.docu_empr%type,
    in_suc           stk_documento.docu_suc_orig%type,
    in_user          stk_documento.docu_login%type,
    in_clave_padre   stk_documento.docu_clave_padre%type := null,
    in_nro           stk_documento.docu_nro_doc%type := null,
    in_tipo    varchar2 --> D || R >> Desecho o Recapado
  )return stk_documento.docu_clave%type;
  
  
  /*
    Author  : @PabloACespedes \(^-^)/
    Created : 14/06/2022 11:55:56
    registra en una tabla de conteos a donde se envio el recapado
  */
  function add_tal_env_recapado(
    in_fecha date,
    in_proveedor number,
    in_obs       varchar2,
    in_empresa   number,
    in_user      varchar2
  )return tal_env_recapado.ter_clave%type;

  function get_send_report(
    in_send varchar2
  )return varchar2;
   
end TRAI215;
/
create or replace package body TRAI215 is

  co_name_pkg constant varchar2(7 char) := 'TRAI215';
  
  co_tran_salida   constant stk_operacion.oper_codigo%type := 12;
  co_tran_entrada  constant stk_operacion.oper_codigo%type := 13;
  
  co_desecho  constant varchar2(1 char) := 'D';
  co_recapado constant varchar2(1 char) := 'R';
  
  /*Utilizar en produccion current_date,
    En prueba por el periodo se uso MAYO
    co_hoy      constant date := to_date('31/05/2022 23:59:00', 'dd/mm/yyyy hh24:mi:ss');
  */
  co_hoy      constant date := current_date;
  
  procedure envio_articulo(
    in_data    varchar2,       --> Regla: ARTICULO:SERIE
    in_tipo    varchar2,       --> D || R >> Desecho o Recapado
    in_fecha   date   := null, --> Para recapado
    in_prov    number := null, --> Para recapado
    in_obs     tal_stk_baja_neu.tsb_obs%type,
    in_empresa number,
    in_suc     number,
    in_user    varchar2 
  )as
  l_success_items boolean := false;
  l_mgs_error     varchar2(50 char);
  l_new_id_stk_doc_father stk_documento.docu_clave%type;
  l_new_id_stk_doc_child  stk_documento.docu_clave%type;
  l_new_env_recapado number;
  l_result apex_application_global.vc_arr2; 
  l_art    number;
  l_serie  varchar2(100);
  l_ot_neu_recapar tal_stk_neu_recapar.trec_ot%type;
  
  co_enviado constant varchar2(1 char) := 'E';
  begin
    <<v_items>>
    case
      when in_tipo = co_desecho and in_obs is null then
        l_mgs_error := 'la observaci'||chr(243)||'n';
      when in_data is null then
        l_mgs_error := 'seleccionar '||chr(237)||'tems del listado';
      when in_empresa is null then
        l_mgs_error := 'la empresa';
      when in_suc is null then
        l_mgs_error := 'la sucursal';
      when in_user is null then
        l_mgs_error := 'el usuario';
      when in_tipo not in (co_desecho, co_recapado) then
        l_mgs_error := 'asignar un tipo correcto (D: Desecho || R: Recapado)';
      else
        l_success_items := true;
    end case v_items;
    
    if l_success_items then
       l_new_id_stk_doc_father := add_stk_documento(
                           in_empresa     => in_empresa,
                           in_suc         => in_suc,
                           in_user        => in_user,
                           in_tipo        => in_tipo
                          );
  
       add_det_stk_doc(in_data  => in_data,
                       in_clave => l_new_id_stk_doc_father,
                       in_empr  => in_empresa
                       );
                  
       l_new_id_stk_doc_child := add_stk_documento(
                           in_empresa     => in_empresa,
                           in_suc         => in_suc,
                           in_user        => in_user,
                           in_clave_padre => l_new_id_stk_doc_father,
                           in_tipo        => in_tipo
                          );
                          
                          
       add_det_stk_doc(in_data  => in_data,
                        in_clave => l_new_id_stk_doc_child,
                        in_empr  => in_empresa
                       );
            
       -- recapado envio a proveedor               
       if in_tipo = co_recapado then                
         l_new_env_recapado := add_tal_env_recapado(
                              in_fecha     => in_fecha,
                              in_proveedor => in_prov,
                              in_obs       => upper(trim(in_obs)),
                              in_empresa   => in_empresa,
                              in_user      => in_user
                              );  
         
         <<add_baja_neumatico>> 
         for i in (select column_value artSerie
                   from table(apex_string.split(p_str   => in_data,
                                                p_sep   => ','))
           
         ) loop  
             l_result := apex_string.string_to_table(i.artSerie,':');  
             l_art    := to_number(l_result(1)); --> posicion 1 ARTICULO
             l_serie  := l_result(2); --> posicion 2 SERIE
                          
             add_tal_env_recapado_det(in_clave_cab => l_new_env_recapado,
                                      in_art       => l_art,
                                      in_serie     => l_serie,
                                      in_empresa   => in_empresa
                                  );
                                  
                                  
             update tal_stk_neu_recapar r
             set    r.trec_estado    = co_enviado,
                    r.trec_clave_stk = l_new_id_stk_doc_father
             where  r.trec_art   = l_art
             and    r.trec_serie = l_serie;
                             
         end loop add_baja_neumatico;                      
       end if;
       
       -- Proceso desecho
       if in_tipo = co_desecho then
         for i in (select column_value artSerie
                   from table(apex_string.split(p_str   => in_data,
                                                p_sep   => ','))
           
         ) loop  
             l_result := apex_string.string_to_table(i.artSerie,':');  
             l_art    := to_number(l_result(1)); --> posicion 1 ARTICULO
             l_serie  := l_result(2); --> posicion 2 SERIE
              
             <<get_orden_trabajo>>
             begin
               select r.trec_ot
               into l_ot_neu_recapar
               from tal_stk_neu_recapar r
               where  r.trec_art   = l_art
               and    r.trec_serie = l_serie;
             end get_orden_trabajo;
              
             insert into tal_stk_baja_neu
             (tsb_ot,tsb_fecha, tsb_art, 
              tsb_serie, tsb_obs, tsb_empr, 
              tsb_suc, tsb_login
             )
             values
              (l_ot_neu_recapar, TRUNC(co_hoy), l_art, 
               l_serie, in_obs, in_empresa, 
               in_suc, in_user 
              );
            
             update tal_stk_neu_recapar r
             set    r.trec_estado    = co_enviado,
                    r.trec_clave_stk = l_new_id_stk_doc_father
             where  r.trec_art   = l_art
             and    r.trec_serie = l_serie;
                             
         end loop add_det_env_rec;
       end if;
             
    else
      raise_application_error(-20000, 'Es necesario '||l_mgs_error);
    end if;
        
  end envio_articulo;
  
  procedure get_data_dep(
     in_empresa  in number,
     in_suc      in number,
     out_dep_baja       out number,
     out_dep_recapado   out number,
     out_dep_prov_recap out number
  )as
  begin
    select suc_dep_baja,
           suc_dep_recapado,
           suc_dep_prov_recapado
    into out_dep_baja,
         out_dep_recapado,
         out_dep_prov_recap
    from gen_sucursal 
    where suc_empr  = in_empresa
    and  suc_codigo = in_suc;
  exception
    when no_data_found then
      out_dep_baja       := null;
      out_dep_recapado   := null;
      out_dep_prov_recap := null;
  end get_data_dep;
  
  procedure add_tal_env_recapado_det(
    in_clave_cab number,
    in_art       number,
    in_serie     varchar2,
    in_empresa   number
  )as
  l_item number;
  begin
    select nvl(max(d.terd_nro_item), 0) + 1
    into l_item 
    from tal_env_recapado_det d
    where d.terd_clave = in_clave_cab;
    
    insert into tal_env_recapado_det(terd_clave,
                                     terd_art_env,
                                     terd_art_rec,
                                     terd_nro_item,
                                     terd_art_env_serie,
                                     terd_empr,
                                     terd_estado,
                                     terd_cant
                                     )
                               values(in_clave_cab,
                                      in_art,
                                      null,
                                      l_item,
                                      in_serie,
                                      in_empresa,
                                      'R',
                                      1
                                     );
  
  end add_tal_env_recapado_det; 
  
  procedure add_det_stk_doc(
    in_data  varchar2,
    in_clave stk_documento_det.deta_clave_doc%type,
    in_empr  stk_documento_det.deta_empr%type
  )as
  l_item   number := 0;
  l_result apex_application_global.vc_arr2;
  l_art    varchar2(100);
  l_serie  varchar2(100);
  co_art_recap constant number := 21027609;
  begin        
    for detArt in (
      select column_value serieArt
      from table(apex_string.split(p_str => in_data, p_sep => ','))  
    )
    loop
      -- asigna valor a item para desglozar
      -- en la posicion 1 esta el codigo del articulo
      -- en la posicion 2 esta la serie del articulo
      l_result := apex_string.string_to_table(detArt.serieArt,':');
      
      l_art   := l_result(1);
      l_serie := l_result(2);
      
      l_item := l_item + 1;
          
      insert into stk_documento_det (deta_clave_doc, 
                                     deta_nro_item, 
                                     deta_art, 
                                     deta_empr, 
                                     deta_cant, 
                                     deta_serie,
                                     deta_proc_recapado
                                     )
      values(in_clave, 
             l_item, 
             co_art_recap, 
             in_empr,
             1,  -- cantidad
             l_serie,
             l_art
             );
    end loop;
  end add_det_stk_doc;
  
  function add_stk_documento(
    in_empresa       stk_documento.docu_empr%type,
    in_suc           stk_documento.docu_suc_orig%type,
    in_user          stk_documento.docu_login%type,
    in_clave_padre   stk_documento.docu_clave_padre%type := null,
    in_nro           stk_documento.docu_nro_doc%type := null,
    in_tipo          varchar2 --> D || R >> Desecho o Recapado
  )return stk_documento.docu_clave%type is
  l_clave_documento stk_documento.docu_clave%type;
  l_dep_baja       number;  
  l_dep_recapado   number;
  l_dep_prov_recap number;
  l_dep            number;
  l_dep_dest       number;
  l_nro            number;
  l_obs_docu       varchar2(100);
  l_docu_cod_oper  number;
  begin
    l_clave_documento := STK_SEQ_DOCU_NEXTVAL;
     
    if in_nro is null then
      select s.suc_ult_nro_consumo + 1
      into l_nro
      from gen_sucursal s
      where suc_codigo = in_suc
      and suc_empr     = in_empresa;
        
      if l_nro is null then
        Raise_application_error(-20000, 'Error de numeraci'||chr(243)||'n, avise al departamento de inform'||chr(225)||'tica!');
      end if;
        
      update gen_sucursal
      set suc_ult_nro_consumo = l_nro
      where suc_codigo = in_suc
      and suc_empr     = in_empresa;
    else
      l_nro := in_nro;
    end if;
    
    get_data_dep(in_empresa         => in_empresa,
                 in_suc             => in_suc,
                 out_dep_baja       => l_dep_baja,
                 out_dep_recapado   => l_dep_recapado,
                 out_dep_prov_recap => l_dep_prov_recap
                 );
                     
    if in_tipo = co_desecho then
      l_obs_docu      := 'desecho';
      l_dep           := l_dep_recapado;
      l_dep_dest      := l_dep_baja;
    elsif in_tipo = co_recapado then
      l_obs_docu      := 'recapado';
      l_dep           := l_dep_recapado;
      l_dep_dest      := l_dep_prov_recap;
    end if;
      
    if in_clave_padre is null then
      l_docu_cod_oper := co_tran_salida;
    else
      l_docu_cod_oper := co_tran_entrada;
      
      <<envio_deposito_hijo>>
      case 
        when in_tipo = co_recapado then
          l_dep      := l_dep_prov_recap;
          l_dep_dest := l_dep_recapado;
        when in_tipo = co_desecho then
          l_dep      := l_dep_baja;
          l_dep_dest := l_dep_recapado; 
      end case envio_deposito_hijo;
    end if;
      
    insert into stk_documento
    (docu_clave,
     docu_codigo_oper,
     docu_nro_doc,
     docu_empr,
     docu_suc_orig,
     docu_dep_orig,
     docu_suc_dest,
     docu_dep_dest,
     docu_fec_emis,
     docu_obs,
     docu_login,
     docu_fec_grab,
     docu_mon,
     docu_sist,
     docu_operador,
     docu_fec_oper,
     docu_serie,
     docu_form,
     docu_clave_padre
     )
    values
    (l_clave_documento,
     l_docu_cod_oper,
     l_nro,
     in_empresa,
     in_suc,     --suc origen de extracci?n
     l_dep,      --dep origen de extraccion
     in_suc,     --suc destino deposito
     l_dep_dest, --dep deposito destino
     trunc(co_hoy),
     'Transferencia a '||l_obs_docu||' en fecha'||trunc(co_hoy)||' Usuario: '||in_user,
     in_user,
     co_hoy,
     1, -- gs
     'STK',
     2, -- docu_operador
     trunc(co_hoy),
     null,
     co_name_pkg,
     in_clave_padre
    );
    
    return l_clave_documento;
  end;
  
  function add_tal_env_recapado(
    in_fecha date,
    in_proveedor number,
    in_obs       varchar2,
    in_empresa   number,
    in_user    varchar2
  )return tal_env_recapado.ter_clave%type is
  l_nro_rec tal_env_recapado.ter_nro%type;
  l_clave   tal_env_recapado.ter_clave%type;
  begin
    select nvl(max(r.ter_nro), 0) + 1
    into l_nro_rec
    from tal_env_recapado r;
    
    l_clave := tal_seq_env_neumatico;
    
    insert into tal_env_recapado(ter_clave,
                                 ter_fecha,
                                 ter_prov,
                                 ter_obs,
                                 ter_login,
                                 ter_nro,
                                 ter_empr
                                 )
                            values(
                              l_clave,
                              in_fecha,
                              in_proveedor,
                              in_obs,
                              in_user,
                              l_nro_rec,
                              in_empresa
                            );
  
    return l_clave;
                            
  end add_tal_env_recapado;
  
  
  function get_send_report(
    in_send varchar2
  )return varchar2 is
  l_result apex_application_global.vc_arr2;
  l_serie   varchar2(4000);
  l_art_str varchar2(4000);
  begin
    for x in (select column_value serieArt
              from table(apex_string.split(p_str   => in_send,
                                           p_sep   => ',')
                        )
             )
    loop
      l_result := apex_string.string_to_table(x.serieArt,':');
      
      l_serie := l_result(2);
       
      select l_art_str||':'|| a.art_codigo||'-'||a.art_desc||'-'||l_serie
      into l_art_str
      from stk_articulo a
      where a.art_codigo = l_result(1);
      
    end loop;
     
    return l_art_str;
     
  end get_send_report;
  
end TRAI215;
/
