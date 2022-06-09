create or replace package TRAI215 is

  -- Author  : PROGRAMACION7
  -- Created : 09/06/2022 14:39:26
  -- Purpose : Programas Transporte Movimiento
  
  -- Procedures
  procedure baja_articulo(
    in_data    varchar2, --> Regla: ARTICULO:SERIE
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
  procedure get_data_baja(
     in_empresa  in number,
     in_suc      in number,
     out_dep_baja       out number,
     out_dep_recapado   out number,
     out_dep_prov_recap out number
  );
  
end TRAI215;
/
create or replace package body TRAI215 is

  co_name_pkg constant varchar2(7 char) := 'TRAI215';
  
  procedure baja_articulo(
    in_data    varchar2,
    in_obs     tal_stk_baja_neu.tsb_obs%type,
    in_empresa number,
    in_suc     number,
    in_user    varchar2 
  )as
  l_clave_salida number;
  l_dep_recapado number;
  l_dep_dest     number;
  l_prov         number; -- comodin
  l_success_items boolean := false;
  l_nro number;
  l_mgs_error     varchar2(50 char);
  
  co_tran_salida  constant stk_operacion.oper_codigo%type := 12;
  
  begin
    <<v_items>>
    case
      when in_obs is null then
        l_mgs_error := 'la observaci'||chr(243)||'n';
      when in_data is null then
        l_mgs_error := 'seleccionar '||chr(237)||'tems del listado';
      when in_empresa is null then
        l_mgs_error := 'la empresa';
      when in_suc is null then
        l_mgs_error := 'la sucursal';
      when in_user is null then
        l_mgs_error := 'el usuario';
      else
        l_success_items := true;
    end case v_items;
    
    if l_success_items then
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
      
      get_data_baja(in_empresa         => in_empresa,
                    in_suc             => in_suc,
                    out_dep_baja       => l_dep_dest,
                    out_dep_recapado   => l_dep_recapado,
                    out_dep_prov_recap => l_prov
                    );
                    
      l_clave_salida := STK_SEQ_DOCU_NEXTVAL;
      
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
       docu_form
       )
      values
      (l_clave_salida,
       co_tran_salida,--salida
       l_nro,
       in_empresa,
       in_suc,         --suc origen de extracción
       l_dep_recapado, --dep origen de extracción
       in_suc,         --suc destino deposito
       l_dep_dest,     --dep deposito destino
       trunc(current_date),
       'Transferencia recapado a desecho en fecha'||trunc(current_date)||' Usuario: '||in_user,
       in_user,
       current_date,
       1, -- gs
       'STK',
       2, -- docu_operador
       trunc(current_date),
       null,
       co_name_pkg
      );
      
      /*
        Author  : @PabloACespedes \(^-^)/
        Created : 09/06/2022 15:19:18
        el parametro pasado cuenta con dos campos ARTICULO:SERIE
        separados por coma ",". Ejemplo
        11:TS11,22:TS22,33:TS33
      */
      <<ins_stk_doc_det>>
      declare
        l_item number := 0;
        l_result apex_application_global.vc_arr2;
        l_art    number;
        l_serie  varchar2(4000);
      begin
        l_item := l_item + 1;
        
        for detArt in (
          select column_value x
          from table(apex_string.split(p_str => in_data, p_sep => ','))  
        )
        loop
          l_result := apex_string.string_to_table(detArt.x, ':');
          
          l_art   := l_result(1);
          l_serie := l_result(2);
          
          insert into stk_documento_det (deta_clave_doc, 
                                         deta_nro_item, 
                                         deta_art, 
                                         deta_empr, 
                                         deta_cant, 
                                         deta_serie
                                         )
          values(l_clave_salida, 
                 l_item, 
                 l_art, 
                 in_empresa,
                 1,  -- cantidad
                 l_serie
                 );
                 
                 
           insert into tal_stk_baja_neu(tsb_ot,
                                        tsb_fecha,
                                        tsb_art,
                                        tsb_serie,
                                        tsb_obs,
                                        tsb_empr,
                                        tsb_suc,
                                        tsb_login
                                        )
            values
            (null, 
             TRUNC(current_date), 
             l_art,
             l_serie,
             in_obs, 
             in_empresa,
             in_suc, 
             in_user
             );
               
        end loop;
      end ins_stk_doc_det;
      
    else
      raise_application_error(-20000, 'Es necesario '||l_mgs_error);
    end if;
        
  end baja_articulo;
  
  procedure get_data_baja(
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
  end get_data_baja;
  
end TRAI215;
/
