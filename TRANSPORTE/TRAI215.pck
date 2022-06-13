create or replace package TRAI215 is

  -- Author  : PROGRAMACION7
  -- Created : 09/06/2022 14:39:26
  -- Purpose : Programas Transporte Movimiento
  
  -- Procedures
  procedure envio_articulo(
    in_data    varchar2, --> Regla: ARTICULO:SERIE
    in_tipo    varchar2, --> D || R >> Desecho o Recapado
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
    in_data  varchar2, --> Regla: ARTICULO:SERIE
    in_clave stk_documento_det.deta_clave_doc%type,
    in_empr  stk_documento_det.deta_empr%type
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
  
end TRAI215;
/
create or replace package body TRAI215 is

  co_name_pkg constant varchar2(7 char) := 'TRAI215';
  
  co_tran_salida   constant stk_operacion.oper_codigo%type := 12;
  co_tran_entrada  constant stk_operacion.oper_codigo%type := 13;
  
  co_desecho  constant varchar2(1 char) := 'D';
  co_recapado constant varchar2(1 char) := 'R';
  
  procedure envio_articulo(
    in_data    varchar2, --> Regla: ARTICULO:SERIE
    in_tipo    varchar2, --> D || R >> Desecho o Recapado
    in_obs     tal_stk_baja_neu.tsb_obs%type,
    in_empresa number,
    in_suc     number,
    in_user    varchar2 
  )as
  l_success_items boolean := false;
  l_mgs_error     varchar2(50 char);
  l_new_id_stk_doc_father stk_documento.docu_clave%type;
  l_new_id_stk_doc_child  stk_documento.docu_clave%type;
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
  
  
  procedure add_det_stk_doc(
    in_data  varchar2,
    in_clave stk_documento_det.deta_clave_doc%type,
    in_empr  stk_documento_det.deta_empr%type
  )as
  l_item number := 0;
  co_art_recap constant number := 21027609;
  begin        
    for detArt in (
      select column_value serieArt
      from table(apex_string.split(p_str => in_data, p_sep => ':'))  
    )
    loop
      l_item := l_item + 1;
          
      insert into stk_documento_det (deta_clave_doc, 
                                     deta_nro_item, 
                                     deta_art, 
                                     deta_empr, 
                                     deta_cant, 
                                     deta_serie
                                     )
      values(in_clave, 
             l_item, 
             co_art_recap, 
             in_empr,
             1,  -- cantidad
             detArt.serieArt
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
  co_hoy           constant date := to_date('31/05/2022 23:59:00', 'dd/mm/yyyy hh24:mi:ss'); -- current_date;
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
     in_suc,         --suc origen de extracci?n
     l_dep, --dep origen de extraccion
     in_suc,         --suc destino deposito
     l_dep_dest,     --dep deposito destino
     trunc(co_hoy),
     'Transferencia recapado a '||l_obs_docu||' en fecha'||trunc(co_hoy)||' Usuario: '||in_user,
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
  
end TRAI215;
/
