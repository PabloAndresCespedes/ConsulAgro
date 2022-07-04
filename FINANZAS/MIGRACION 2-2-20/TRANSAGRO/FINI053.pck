create or replace package FINI053 is

  -- Author  : @PabloACespedes
  -- Created : 22/06/2022 10:07:31
  -- Purpose : Cancelacion de documentos
  
  /*
    CASOS DE USO:
     - Se tiene una Factura Emitida a un cliente, a la vez una Nota de Credito.
     Con el programa 2-2-20 permite seleccionar un comprobante con otro
     luego esto saldara cada documento.
     - Sucede lo mismo con facturas y notas de credito recibidas del proveedor.
     
     Preparado para estos tipos de documentos:
      - FACTURA EMITIDA
      - NOTAS DEBITOS EMITIDOS
      - NOTA DE CREDITO EMITIDA
      - ADELANTOS EMITIDOS
      
      - FACTURAS RECIBIDAS
      - NOTAS DEBITOS RECIBIDAS
      - NOTA DE CREDITO RECIBIDAS
      - ADELANTOS RECIBIDAS
  
    Author  : @PabloACespedes \(^-^)/
    Created : 22/06/2022 10:24:35
    retorna tipos movimientos de cancelacion de recibo, se basa
    en FIN_CONFIGURACION
  */
  procedure get_tipo_mov_cancel(
    in_empresa                  in  number,
    out_recibo_nc_emitido       out number,
    out_recibo_nc_recibido      out number,
    out_recibo_adel_cli_emitido out number,
    out_recibo_adel_prov_rec    out number,
    out_nc_emitida              out number,
    out_nc_recibido             out number,
    out_ndb_emit                out number,
    out_nd_emit_prov            out number,
    out_adelanto_cli            out number,
    out_adelanto_pro            out number,
    out_nc_rec_ajuste           out number,
    out_nc_emi_ajuste           out number,
    out_ndb_rec                 out number,
    out_fc_cr_emit              out number,
    out_fc_cr_emit_ajuste       out number,
    out_fc_cr_rec               out number,
    out_fc_cr_rec_ajuste        out number,
    out_tmv_despacho            out number,
    out_tmv_orden_compra        out number
  );
  
  procedure is_valid_fecha_operacion(
    in_fecha_op  varchar2,
    in_user      varchar2,
    in_empresa   number 
  );
  
  -- 23/06/2022 11:44:42 @PabloACespedes \(^-^)/
  -- generar consulta a partir de los filtros brindados
  -- trunca todo lo que se encuentra en la sesion del usuario
  -- genera de nuevo
  procedure generate_query(
    in_fecha_op  date,
    in_desde     date,
    in_cliente   number,
    in_proveedor number,
    in_holding   number := null,
    in_tipo_mov  number,
    in_mnd       number,
    in_empresa   number,
    in_suc       number,
    in_user      varchar2,
    in_ind_er    varchar2, -- E || R Emitidos o Recibidos
    out_error    out varchar2  -- retorna NO si no hubo inconvenientes, sino el texto
  );
  
  -- 24/06/2022 10:57:53 @PabloACespedes \(^-^)/
  -- Genera los registros de cancelacion en fin_documento
  procedure confirm(
    in_user varchar2
  );
 
  -- 24/06/2022 14:54:49 @PabloACespedes \(^-^)/
  -- agrega pagos
  procedure add_pago(
    in_clave_fc_nc  number,
    in_clave_recibo number,
    in_vencimiento  date,
    in_fecha_op     date,
    in_importe_mon  number,
    in_importe_loc  number,
    in_empresa      number,
    in_user         varchar2
  );
  
  -- 01/07/2022 14:36:53 @PabloACespedes \(^-^)/
  -- trunca todas las colecciones
  procedure truncate_all_collections;
  
  -- 22/06/2022 11:08:25 @PabloACespedes \(^-^)/
  -- retorna si el tipo mov. es EMISION o RECEPCION (E or R)
  function get_tipo_mov_er(
    in_tipo_mov in number,
    in_empresa  in number
  )return varchar2;

  -- 22/06/2022 11:54:12 @PabloACespedes \(^-^)/
  -- Comprueba si el operador tiene la marca de SI en GENM017 Operacion HABILITAR MES FINANZAS
  function operador_hab_mes_finanzas(
    in_user varchar2,
    in_emp  number
  )return boolean;
  
  -- 24/06/2022 10:25:48 @PabloACespedes \(^-^)/
  -- agrega el registro de recibo, solo importe, ya que es exenta el registro
  function add_fin_documento(
    in_empresa     number,
    in_user        varchar2,
    in_fecha       date,
    in_suc         number,
    in_tipo_mov    number,
    in_moneda      number,
    in_cliente     number,
    in_proveedor   number,
    in_nro_doc     number,
    in_importe_mon number,
    in_importe_loc number,
    in_clave_padre number,
    in_clave_scli  number
  )return fin_documento.doc_clave%type;
  
  -- 29/06/2022 10:36:11 @PabloACespedes \(^-^)/
  -- Retorna todos los clientes asociados al holding
  function get_client_holding(
    in_holding in number,
    in_empresa in number
  )return t_holding pipelined;
  
end FINI053;
/
create or replace package body FINI053 is
  -- CONSTANTES
  co_col_nc_emision constant varchar2(10 char) := 'NC_EMISION';
  co_col_fc_emision constant varchar2(10 char) := 'FC_EMISION';
  co_col_nc_rec     constant varchar2(11 char) := 'NC_RECIBIDO';
  co_col_fc_rec     constant varchar2(11 char) := 'FC_RECIBIDO';
  co_col_filtros    constant varchar2(7  char) := 'FILTROS';
  
  
  co_emision  constant varchar2(1 char) := 'E';
  co_recibido constant varchar2(1 char) := 'R';
    

  -- PROCEDURES
  procedure get_tipo_mov_cancel(
    in_empresa                  in  number,
    out_recibo_nc_emitido       out number,
    out_recibo_nc_recibido      out number,
    out_recibo_adel_cli_emitido out number,
    out_recibo_adel_prov_rec    out number,
    out_nc_emitida              out number,
    out_nc_recibido             out number,
    out_ndb_emit                out number,
    out_nd_emit_prov            out number,
    out_adelanto_cli            out number,
    out_adelanto_pro            out number,
    out_nc_rec_ajuste           out number,
    out_nc_emi_ajuste           out number,
    out_ndb_rec                 out number,
    out_fc_cr_emit              out number,
    out_fc_cr_emit_ajuste       out number,
    out_fc_cr_rec               out number,
    out_fc_cr_rec_ajuste        out number,
    out_tmv_despacho            out number,
    out_tmv_orden_compra        out number
  )as
  begin
    select
      conf_recibo_cncr_emit , 
      conf_recibo_cncr_rec ,  
      conf_recibo_cadcli_emit ,
      conf_recibo_cadpro_rec,
      conf_nota_cr_emit,
      conf_nota_cr_rec,
      conf_nota_db_emit,
      conf_nota_db_emit_prov,
      conf_adelanto_cli,
      conf_adelanto_pro,
      conf_nota_cr_rec_ajuste,
      conf_nota_cr_emit_ajuste,
      conf_nota_db_rec,
      conf_fact_cr_emit,
      conf_fact_cred_emit_ajus,
      conf_fact_cr_rec,
      conf_fact_cr_rec_ajuste,
      conf_tmov_despacho,
      conf_tmov_orden_compra
    into 
      out_recibo_nc_emitido,
      out_recibo_nc_recibido,
      out_recibo_adel_cli_emitido,
      out_recibo_adel_prov_rec,
      out_nc_emitida,
      out_nc_recibido,
      out_ndb_emit,
      out_nd_emit_prov,
      out_adelanto_cli,
      out_adelanto_pro,
      out_nc_rec_ajuste,
      out_nc_emi_ajuste,
      out_ndb_rec,
      out_fc_cr_emit,
      out_fc_cr_emit_ajuste,
      out_fc_cr_rec,
      out_fc_cr_rec_ajuste,
      out_tmv_despacho,
      out_tmv_orden_compra
    from fin_configuracion
    where conf_empr = in_empresa;
  
  end get_tipo_mov_cancel;
  
  procedure is_valid_fecha_operacion(
    in_fecha_op  varchar2,
    in_user      varchar2,
    in_empresa   number 
  )as
  l_date    date;
  l_per_act_inicio date;
  l_per_act_fin date;
  l_per_sig_inicio date;
  l_per_sig_fin date;

  co_format constant varchar2(10 char) := 'dd/mm/yyyy';
  
  e_no_valid exception;
  begin
    l_date := in_fecha_op;
    
    if l_date is null then
      Raise_application_error(-20000, 'La fecha debe contener un valor'); 
    end if;
  
    <<v_date>>
    begin
      l_date := to_date(in_fecha_op, co_format);
      
      if l_date is not null then
        null;
      end if;
      
    exception
      when others then
        raise e_no_valid;
    end v_date;
    
    <<fecha_config>>
    begin
      select 
       c.conf_per_act_ini,
       c.conf_per_act_fin,
       c.conf_per_sgte_ini,
       c.conf_per_sgte_fin
       into
       l_per_act_inicio,
       l_per_act_fin,
       l_per_sig_inicio,
       l_per_sig_fin
       from fin_configuracion c
       where c.conf_empr = in_empresa;
    exception
      when no_data_found then
        Raise_application_error(-20000, 'Sin configuraci'||chr(243)||'n de fechas de periodos');
      when too_many_rows then
        Raise_application_error(-20000, 'Existe m'||chr(225)||'s de 1 configuraci'||chr(243)||'n de fechas de periodos para la empresa');
    end fecha_config;
    
    if operador_hab_mes_finanzas(in_user => in_user, in_emp => in_empresa) then
      if  not in_fecha_op between l_per_act_inicio and l_per_act_fin 
      and not in_fecha_op between l_per_sig_inicio and l_per_sig_fin  
      then
        Raise_application_error(-20000, 'La fecha de operaci'||chr(243)||'n debe estar comprendida del '||l_per_act_inicio||' al '||l_per_act_fin||
        ' o del '||l_per_sig_inicio||' al '||l_per_sig_fin
        );
      end if;
    else
      if not in_fecha_op between l_per_sig_inicio and l_per_sig_fin then
        Raise_application_error(-20000, 'La fecha de operaci'||chr(243)||'n debe estar comprendida del '||l_per_sig_inicio||' al '||l_per_sig_fin);
      end if;
    end if;
    
  exception
    when e_no_valid then
      Raise_application_error(-20000, 'Fecha no v'||chr(225)||'lida');
  end is_valid_fecha_operacion;
  
  procedure generate_query(
    in_fecha_op  date,
    in_desde     date,
    in_cliente   number,
    in_proveedor number,
    in_holding   number := null,
    in_tipo_mov  number,
    in_mnd       number,
    in_empresa   number,
    in_suc       number,
    in_user      varchar2,
    in_ind_er    varchar2, -- E || R Emitidos o Recibidos
    out_error    out varchar2  -- retorna NO si no hubo inconvenientes, sino el texto
  )as  
  l_recibo_nc_emitido number;
  l_recibo_nc_recibido number;
  l_recibo_adel_cli_emitido number;
  l_recibo_adel_prov_rec number;
  l_nc_emitida number;
  l_nc_recibido number;
  l_ndb_emit number;
  l_nd_emit_prov number;
  l_adelanto_cli number;
  l_adelanto_pro number;
  l_nc_rec_ajuste number;
  l_nc_emi_ajuste number;
  l_ndb_rec number;
  l_fc_cr_emit number;
  l_fc_cr_emit_ajuste number;
  l_fc_cr_rec number;
  l_fc_cr_rec_ajuste number;
  l_tmv_despacho number;
  l_tmv_orden_compra number;
  
  begin
    
    if in_desde is null then
      Raise_application_error(-20000, 'Seleccione la fecha Desde');
    end if;
    
    if in_fecha_op is null then
      Raise_application_error(-20000, 'Seleccione la fecha de operaci'||chr(243)||'n');
    end if;
    
    if in_user is null then
      Raise_application_error(-20000, 'Usuario inv'||chr(225)||'lido, no se encuentra');
    end if;
    
    is_valid_fecha_operacion(in_fecha_op => in_fecha_op,
                             in_user     => in_user,
                             in_empresa  => in_empresa
                             );
    
    if in_tipo_mov is null then
       Raise_application_error(-20000, 'Seleccione el tipo de movimiento');  
    end if;
    
    if in_mnd is null then
       Raise_application_error(-20000, 'Seleccione una moneda');  
    end if;
    
    <<c_validations>>
    case
      when in_ind_er = co_emision then
        if in_cliente is null and in_holding is null then
          Raise_application_error(-20000, 'Seleccione un cliente/ Holding');
        end if;
      when in_ind_er = co_recibido then
        if in_proveedor is null and in_holding is null then
          Raise_application_error(-20000, 'Seleccione un proveedor/ Holding');
        end if;
      else
        raise_application_error(-20000, 'Tipo de Movimiento no contiene un indicador v'||chr(225)||'lido');
    end case c_validations;
    
    get_tipo_mov_cancel(
      in_empresa                  => in_empresa,
      out_recibo_nc_emitido       => l_recibo_nc_emitido,
      out_recibo_nc_recibido      => l_recibo_nc_recibido,
      out_recibo_adel_cli_emitido => l_recibo_adel_cli_emitido,
      out_recibo_adel_prov_rec    => l_recibo_adel_prov_rec,
      out_nc_emitida              => l_nc_emitida,
      out_nc_recibido             => l_nc_recibido,
      out_ndb_emit                => l_ndb_emit,
      out_nd_emit_prov            => l_nd_emit_prov,
      out_adelanto_cli            => l_adelanto_cli,
      out_adelanto_pro            => l_adelanto_pro,
      out_nc_rec_ajuste           => l_nc_rec_ajuste,
      out_nc_emi_ajuste           => l_nc_emi_ajuste,
      out_ndb_rec                 => l_ndb_rec,
      out_fc_cr_emit              => l_fc_cr_emit,
      out_fc_cr_emit_ajuste       => l_fc_cr_emit_ajuste,
      out_fc_cr_rec               => l_fc_cr_rec,
      out_fc_cr_rec_ajuste        => l_fc_cr_rec_ajuste,
      out_tmv_despacho            => l_tmv_despacho,
      out_tmv_orden_compra        => l_tmv_orden_compra
    );
   
    <<option_ind>>
    case 
      when in_ind_er = co_emision then --> To Client
        
        apex_collection.create_or_truncate_collection( p_collection_name => co_col_nc_emision );
        apex_collection.create_or_truncate_collection( p_collection_name => co_col_fc_emision );
        
        <<c_client_emision>>
        case
          when in_cliente is not null then
          <<f_nc_emit>>
          for i in (
            select doc_nro_doc,
                   doc_fec_doc,
                   doc_suc,
                   cuo_fec_vto,
                   cuo_imp_mon,
                   cuo_saldo_mon,
                   cuo_saldo_loc,
                   cuo_clave_doc,
                   doc_mon,
                   mon_dec_imp,
                   mon_dec_tasa,
                   mon_simbolo,
                   mon_tasa_vta,
                   doc_clave_scli,
                   '' seleccionar,
                   doc_tipo_mov
            from fin_documento,
                 fin_cuota,
                 gen_moneda
            where mon_codigo = doc_mon
            and cuo_clave_doc = doc_clave
            and doc_empr=mon_empr
            and doc_empr=cuo_empr
            and doc_empr = in_empresa
            and (trunc(doc_fec_doc) between in_desde and in_fecha_op)
            and doc_cli = in_cliente
            and cuo_saldo_mon > 0
            and doc_mon = in_mnd
            and
            (
                (
                 doc_tipo_mov in (l_nc_emitida, l_nc_emi_ajuste)
                 and 
                 in_tipo_mov = l_recibo_nc_emitido
                )
                or
                (
                 in_tipo_mov  = l_recibo_adel_cli_emitido
                 and 
                 doc_tipo_mov = l_adelanto_cli
                )
            )
          )
          loop
            -- add member to collections
            apex_collection.add_member(
              p_collection_name => co_col_nc_emision,
              p_c001            => i.doc_nro_doc,
              p_c002            => i.doc_fec_doc,
              p_c003            => i.doc_suc,
              p_c004            => i.cuo_fec_vto,
              p_c005            => i.cuo_imp_mon,
              p_c006            => i.cuo_saldo_mon,
              p_c007            => i.cuo_saldo_loc,
              p_c008            => i.cuo_clave_doc,
              p_c009            => i.doc_mon,
              p_c010            => i.mon_dec_imp,
              p_c011            => i.mon_dec_tasa,
              p_c012            => i.mon_simbolo,
              p_c013            => i.mon_tasa_vta,
              p_c014            => i.doc_clave_scli,
              p_c016            => in_fecha_op,
              p_c017            => i.doc_tipo_mov,
              p_c018            => in_mnd
             );
          end loop f_nc_emit;

          <<f_fc_emit>>
          for f in (select doc_nro_doc,
                           doc_fec_doc,
                           doc_suc,
                           cuo_fec_vto,
                           cuo_imp_mon,
                           cuo_saldo_mon,
                           cuo_saldo_loc,
                           cuo_clave_doc,
                           doc_mon,
                           mon_dec_imp,
                           mon_dec_tasa,
                           mon_simbolo,
                           mon_tasa_vta,
                           doc_clave_scli,
                           '' seleccionar,
                           doc_tipo_mov
                    from fin_documento,
                         fin_cuota,
                         gen_moneda
                    where mon_codigo = in_mnd 
                    and mon_codigo = doc_mon
                    and cuo_clave_doc = doc_clave
                    and doc_empr=mon_empr
                    and doc_empr=cuo_empr
                    and doc_empr = in_empresa
                    and doc_cli = in_cliente
                    and (trunc(doc_fec_doc) between in_desde and in_fecha_op)
                    and cuo_saldo_mon > 0
                    and doc_tipo_mov in (l_ndb_emit,
                                         l_tmv_orden_compra,
                                         l_fc_cr_emit,
                                         l_fc_cr_emit_ajuste
                                        )
                    )
          loop
            -- add member to collections
            apex_collection.add_member(
              p_collection_name => co_col_fc_emision,
              p_c001 => f.doc_nro_doc,
              p_c002 => f.doc_fec_doc,
              p_c003 => f.doc_suc,
              p_c004 => f.cuo_fec_vto,
              p_c005 => f.cuo_imp_mon,
              p_c006 => f.cuo_saldo_mon,
              p_c007 => f.cuo_saldo_loc,
              p_c008 => f.cuo_clave_doc,
              p_c009 => f.doc_mon,
              p_c010 => f.mon_dec_imp,
              p_c011 => f.mon_dec_tasa,
              p_c012 => f.mon_simbolo,
              p_c013 => f.mon_tasa_vta,
              p_c014 => f.doc_clave_scli,
              p_c016 => in_fecha_op,
              p_c017 => f.doc_tipo_mov,
              p_c018 => in_mnd
            );
          end loop f_fc_emit;
            
        else
          <<bulk_fc_emision>>
          declare
           l_fc_doc_nro         apex_application_global.vc_arr2;
           l_fc_fecha_doc       apex_application_global.vc_arr2;
           l_fc_doc_suc         apex_application_global.vc_arr2;
           l_fc_cuo_fec_vto     apex_application_global.vc_arr2;
           l_fc_cuo_imp_mon     apex_application_global.vc_arr2;
           l_fc_cuo_saldo_mon   apex_application_global.vc_arr2;
           l_fc_cuo_saldo_loc   apex_application_global.vc_arr2;
           l_fc_cuo_clave_doc   apex_application_global.vc_arr2;
           l_fc_doc_mon         apex_application_global.vc_arr2;
           l_fc_mon_dec_imp     apex_application_global.vc_arr2;
           l_fc_mon_dec_tasa    apex_application_global.vc_arr2;
           l_fc_mon_simbolo     apex_application_global.vc_arr2;
           l_fc_mon_tasa_vta    apex_application_global.vc_arr2;
           l_fc_doc_clave_scli  apex_application_global.vc_arr2;
           l_fc_doc_tipo_mov    apex_application_global.vc_arr2;
           l_fc_fecha_operacion apex_application_global.vc_arr2;
           l_fc_moneda          apex_application_global.vc_arr2;
          begin
             select fd.doc_nro_doc,
                   fd.doc_fec_doc,
                   fd.doc_suc,
                   fc.cuo_fec_vto,
                   fc.cuo_imp_mon,
                   fc.cuo_saldo_mon,
                   fc.cuo_saldo_loc,
                   fc.cuo_clave_doc,
                   fd.doc_mon,
                   gm.mon_dec_imp,
                   gm.mon_dec_tasa,
                   gm.mon_simbolo,
                   gm.mon_tasa_vta,
                   fd.doc_clave_scli,
                   fd.doc_tipo_mov,
                   to_char(in_fecha_op, 'dd/mm/yyyy'),
                   in_mnd
            bulk collect into l_fc_doc_nro,
                   l_fc_fecha_doc,
                   l_fc_doc_suc,
                   l_fc_cuo_fec_vto,
                   l_fc_cuo_imp_mon,
                   l_fc_cuo_saldo_mon,
                   l_fc_cuo_saldo_loc,
                   l_fc_cuo_clave_doc,
                   l_fc_doc_mon,
                   l_fc_mon_dec_imp,
                   l_fc_mon_dec_tasa,
                   l_fc_mon_simbolo,
                   l_fc_mon_tasa_vta,
                   l_fc_doc_clave_scli,
                   l_fc_doc_tipo_mov,
                   l_fc_fecha_operacion,
                   l_fc_moneda
            from fin_documento fd
            inner join fin_cuota fc on (fc.cuo_clave_doc = fd.doc_clave and fc.cuo_empr = fd.doc_empr)
            inner join table(get_client_holding(in_holding => in_holding, in_empresa => in_empresa)) cl on (fd.doc_cli = cl.id)
            inner join gen_moneda gm on (gm.mon_codigo = fd.doc_mon and gm.mon_empr = fd.doc_empr)
            where cl.id is not null
            and gm.mon_codigo = in_mnd 
            and fd.doc_empr   = in_empresa
            and (trunc(fd.doc_fec_doc) between in_desde and in_fecha_op)
            and fc.cuo_saldo_mon > 0
            and fd.doc_tipo_mov in (l_ndb_emit,
                                 l_tmv_orden_compra,
                                 l_fc_cr_emit,
                                 l_fc_cr_emit_ajuste
                                );
           
            if l_fc_doc_nro.count > 0 then
              apex_collection.add_members(
                p_collection_name => co_col_fc_emision,
                p_c001 => l_fc_doc_nro,
                p_c002 => l_fc_fecha_doc,
                p_c003 => l_fc_doc_suc,
                p_c004 => l_fc_cuo_fec_vto,
                p_c005 => l_fc_cuo_imp_mon,
                p_c006 => l_fc_cuo_saldo_mon,
                p_c007 => l_fc_cuo_saldo_loc,
                p_c008 => l_fc_cuo_clave_doc,
                p_c009 => l_fc_doc_mon,
                p_c010 => l_fc_mon_dec_imp,
                p_c011 => l_fc_mon_dec_tasa,
                p_c012 => l_fc_mon_simbolo,
                p_c013 => l_fc_mon_tasa_vta,
                p_c014 => l_fc_doc_clave_scli,
                p_c016 => l_fc_fecha_operacion,
                p_c017 => l_fc_doc_tipo_mov,
                p_c018 => l_fc_moneda
              );
            end if;
          exception
            when no_data_found then
              null;     
          end bulk_fc_emision;
          
        <<bulk_nc_emision>>
        declare
           l_doc_nro         apex_application_global.vc_arr2;
           l_fecha_doc       apex_application_global.vc_arr2;
           l_doc_suc         apex_application_global.vc_arr2;
           l_cuo_fec_vto     apex_application_global.vc_arr2;
           l_cuo_imp_mon     apex_application_global.vc_arr2;
           l_cuo_saldo_mon   apex_application_global.vc_arr2;
           l_cuo_saldo_loc   apex_application_global.vc_arr2;
           l_cuo_clave_doc   apex_application_global.vc_arr2;
           l_doc_mon         apex_application_global.vc_arr2;
           l_mon_dec_imp     apex_application_global.vc_arr2;
           l_mon_dec_tasa    apex_application_global.vc_arr2;
           l_mon_simbolo     apex_application_global.vc_arr2;
           l_mon_tasa_vta    apex_application_global.vc_arr2;
           l_doc_clave_scli  apex_application_global.vc_arr2;
           l_doc_tipo_mov    apex_application_global.vc_arr2;
           l_fecha_operacion apex_application_global.vc_arr2;
           l_moneda          apex_application_global.vc_arr2;
           
           l_sql varchar2(4000);
        begin
          /*
          select fd.doc_nro_doc,
                   fd.doc_fec_doc,
                   fd.doc_suc,
                   fc.cuo_fec_vto,
                   fc.cuo_imp_mon,
                   fc.cuo_saldo_mon,
                   fc.cuo_saldo_loc,
                   fc.cuo_clave_doc,
                   fd.doc_mon,
                   gm.mon_dec_imp,
                   gm.mon_dec_tasa,
                   gm.mon_simbolo,
                   gm.mon_tasa_vta,
                   fd.doc_clave_scli,
                   fd.doc_tipo_mov,
                   to_char(in_fecha_op, 'dd/mm/yyyy'),
                   in_mnd
            bulk collect into l_doc_nro,
                   l_fecha_doc,
                   l_doc_suc,
                   l_cuo_fec_vto,
                   l_cuo_imp_mon,
                   l_cuo_saldo_mon,
                   l_cuo_saldo_loc,
                   l_cuo_clave_doc,
                   l_doc_mon,
                   l_mon_dec_imp,
                   l_mon_dec_tasa,
                   l_mon_simbolo,
                   l_mon_tasa_vta,
                   l_doc_clave_scli,
                   l_doc_tipo_mov,
                   l_fecha_operacion,
                   l_moneda 
            from fin_documento fd
            inner join fin_cuota fc on (fc.cuo_clave_doc = fd.doc_clave and fc.cuo_empr = fd.doc_empr)
            inner join table(get_client_holding(in_holding => in_holding, in_empresa => in_empresa)) cl on (cl.id = fd.doc_cli)
            inner join gen_moneda gm on (gm.mon_codigo = fd.doc_mon and gm.mon_empr = fd.doc_empr)
            where cl.id is not null
            and fd.doc_mon = in_mnd
            and fd.doc_empr = in_empresa
            and (trunc(fd.doc_fec_doc) between in_desde and in_fecha_op)
            and fc.cuo_saldo_mon > 0
            and
            (
                (
                 in_tipo_mov = l_recibo_nc_emitido
                 and                
                 fd.doc_tipo_mov in (l_nc_emitida, l_nc_emi_ajuste)
                )
                or
                (
                 in_tipo_mov  = l_recibo_adel_cli_emitido
                 and 
                 fd.doc_tipo_mov = l_adelanto_cli
                )
            );
            */
            l_sql := '
            select fd.doc_nro_doc,
                   fd.doc_fec_doc,
                   fd.doc_suc,
                   fc.cuo_fec_vto,
                   fc.cuo_imp_mon,
                   fc.cuo_saldo_mon,
                   fc.cuo_saldo_loc,
                   fc.cuo_clave_doc,
                   fd.doc_mon,
                   gm.mon_dec_imp,
                   gm.mon_dec_tasa,
                   gm.mon_simbolo,
                   gm.mon_tasa_vta,
                   fd.doc_clave_scli,
                   fd.doc_tipo_mov,
                   '''||to_char(in_fecha_op, 'dd/mm/yyyy')||''',
                   '||in_mnd||'
                   from fin_documento fd
                   inner join fin_cuota fc on (fc.cuo_clave_doc = fd.doc_clave and fc.cuo_empr = fd.doc_empr)
                   inner join table(fini053.get_client_holding(in_holding => '||in_holding||', in_empresa => '||in_empresa||')) cl on (cl.id = fd.doc_cli)
                   inner join gen_moneda gm on (gm.mon_codigo = fd.doc_mon and gm.mon_empr = fd.doc_empr)
                   where cl.id is not null
                   and fd.doc_mon = '||in_mnd||'
                   and fd.doc_empr = '||in_empresa||'
                   and (trunc(fd.doc_fec_doc) between to_date('''||to_char(in_desde, 'dd/mm/yyyy')||''', ''dd/mm/yyyy'') and to_date('''||to_char(in_fecha_op, 'dd/mm/yyyy')||''', ''dd/mm/yyyy''))
                   and fc.cuo_saldo_mon > 0
                   '|| case 
                        when in_tipo_mov = l_recibo_nc_emitido then
                           'and fd.doc_tipo_mov in ('||nvl(l_nc_emitida, -1)||', '||nvl(l_nc_emi_ajuste, -1)||')' 
                        when in_tipo_mov  = l_recibo_adel_cli_emitido then 
                           'and fd.doc_tipo_mov = '||l_adelanto_cli
                        else 
                            ''
                        end ;
             
            <<add_reg_query>>
            declare
              id_name constant varchar2(23 char) := 'CANCEL_DOCUMENT_HOLDING';
            begin
              delete from x where x.otro = id_name;                         
              insert into x(campo1, otro) values(l_sql, id_name);
            end add_reg_query;
            
            execute immediate l_sql
            bulk collect into l_doc_nro,
                               l_fecha_doc,
                               l_doc_suc,
                               l_cuo_fec_vto,
                               l_cuo_imp_mon,
                               l_cuo_saldo_mon,
                               l_cuo_saldo_loc,
                               l_cuo_clave_doc,
                               l_doc_mon,
                               l_mon_dec_imp,
                               l_mon_dec_tasa,
                               l_mon_simbolo,
                               l_mon_tasa_vta,
                               l_doc_clave_scli,
                               l_doc_tipo_mov,
                               l_fecha_operacion,
                               l_moneda;
                       
            if l_doc_nro.count > 0 then
              apex_collection.add_members(
                p_collection_name => co_col_nc_emision,
                p_c001 => l_doc_nro,
                p_c002 => l_fecha_doc,
                p_c003 => l_doc_suc,
                p_c004 => l_cuo_fec_vto,
                p_c005 => l_cuo_imp_mon,
                p_c006 => l_cuo_saldo_mon,
                p_c007 => l_cuo_saldo_loc,
                p_c008 => l_cuo_clave_doc,
                p_c009 => l_doc_mon,
                p_c010 => l_mon_dec_imp,
                p_c011 => l_mon_dec_tasa,
                p_c012 => l_mon_simbolo,
                p_c013 => l_mon_tasa_vta,
                p_c014 => l_doc_clave_scli,
                p_c016 => l_fecha_operacion,
                p_c017 => l_doc_tipo_mov,
                p_c018 => l_moneda
              );
            end if;
        exception
          when no_data_found then
              null;       
        end bulk_nc_emision;
        
      end case c_client_emision;
        
      when in_ind_er = co_recibido then --> From Proveedors
        
        apex_collection.create_or_truncate_collection( p_collection_name => co_col_nc_rec );
        
        <<f_nc_recibido>>
        for i in (select doc_nro_doc ,
                          doc_fec_doc ,
                          doc_suc ,
                          cuo_fec_vto ,
                          cuo_imp_mon ,
                          cuo_saldo_mon ,
                          cuo_saldo_loc ,
                          cuo_clave_doc ,
                          doc_mon ,
                          mon_dec_imp ,
                          mon_dec_tasa ,
                          mon_simbolo ,
                          mon_tasa_vta,
                          doc_tipo_mov
            from  fin_documento fa ,
                  fin_cuota cu,
                  gen_moneda tm
            where mon_codigo = doc_mon
            and mon_empr = doc_empr
            and doc_empr = cuo_empr
            and doc_clave = cuo_clave_doc
            and doc_empr = in_empresa
            and doc_prov = in_proveedor
            and (trunc(doc_fec_doc) between in_desde and in_fecha_op)
            and cuo_saldo_mon > 0
            and doc_mon = in_mnd
            and (
                  ( in_tipo_mov = l_recibo_nc_recibido
                    and doc_tipo_mov in (l_nc_recibido,
                                         l_nd_emit_prov,
                                         l_nc_rec_ajuste
                                        )
                  )
                or 
                 ( in_tipo_mov = l_recibo_adel_prov_rec
                  and 
                  doc_tipo_mov = l_adelanto_pro
                 )
               )
          )loop
            -- add member to collections
            apex_collection.add_member(
              p_collection_name => co_col_nc_rec,
              p_c001            => i.doc_nro_doc,
              p_c002            => i.doc_fec_doc,
              p_c003            => i.doc_suc,
              p_c004            => i.cuo_fec_vto,
              p_c005            => i.cuo_imp_mon,
              p_c006            => i.cuo_saldo_mon,
              p_c007            => i.cuo_saldo_loc,
              p_c008            => i.cuo_clave_doc,
              p_c009            => i.doc_mon,
              p_c010            => i.mon_dec_imp,
              p_c011            => i.mon_dec_tasa,
              p_c012            => i.mon_simbolo,
              p_c013            => i.mon_tasa_vta,
              -- hace un salto para estandarizar todas las colecciones
              p_c016            => in_fecha_op,
              p_c017            => i.doc_tipo_mov,
              p_c018            => in_mnd
           );
          end loop f_nc_recibido;
          
        apex_collection.create_or_truncate_collection( p_collection_name => co_col_fc_rec );
            
        <<f_fc_recibida>>
        for j in (select doc_nro_doc,
                        doc_fec_doc,
                        doc_suc,
                        cuo_fec_vto,
                        cuo_imp_mon,
                        cuo_saldo_mon,
                        cuo_saldo_loc,
                        cuo_clave_doc,
                        doc_mon,
                        mon_dec_imp,
                        mon_dec_tasa,
                        mon_simbolo,
                        mon_tasa_vta,
                        doc_tipo_mov
                from  fin_documento,
                      fin_cuota,
                      gen_moneda
                where mon_empr = doc_empr
                and mon_codigo = doc_mon
                and doc_empr   = cuo_empr
                and doc_clave  = cuo_clave_doc
                and doc_empr   = in_empresa
                and doc_prov   = in_proveedor
                and (trunc(doc_fec_doc) between in_desde and in_fecha_op)
                and cuo_saldo_mon > 0
                and doc_mon = in_mnd
                and doc_tipo_mov in (
                                      l_ndb_rec,
                                      l_fc_cr_rec,
                                      l_tmv_despacho,
                                      l_fc_cr_rec_ajuste
                                    )
                  
       )
       loop
         -- add member to collections
          apex_collection.add_member(
            p_collection_name => co_col_fc_rec,
            p_c001            => j.doc_nro_doc,
            p_c002            => j.doc_fec_doc,
            p_c003            => j.doc_suc,
            p_c004            => j.cuo_fec_vto,
            p_c005            => j.cuo_imp_mon,
            p_c006            => j.cuo_saldo_mon,
            p_c007            => j.cuo_saldo_loc,
            p_c008            => j.cuo_clave_doc,
            p_c009            => j.doc_mon,
            p_c010            => j.mon_dec_imp,
            p_c011            => j.mon_dec_tasa,
            p_c012            => j.mon_simbolo,
            p_c013            => j.mon_tasa_vta,
            -- hace un salto para estandarizar todas las colecciones
            p_c016            => in_fecha_op,
            p_c017            => j.doc_tipo_mov,
            p_c018            => in_mnd
         );
       end loop f_fc_recibida;
      else
        Raise_application_error(-20000, 'Es necesario seleccionar el Tipo de movimiento ');
    end case option_ind;
    
    -- registra el filtro aplicado
    apex_collection.create_or_truncate_collection( p_collection_name => co_col_filtros );
        
    apex_collection.add_member(
        p_collection_name => co_col_filtros,
        p_c001            => in_empresa,
        p_c002            => in_fecha_op,
        p_c003            => in_tipo_mov,
        p_c004            => in_mnd,
        p_c005            => nvl(in_cliente, in_proveedor),
        p_c006            => in_ind_er,
        p_c007            => in_suc,
        p_c008            => in_desde
     );
         
    out_error := 'NO';
    
  exception
    when others then
      out_error := replace(sqlerrm, 'ORA-20000:', '');
  end generate_query;
  
  procedure confirm(
    in_user varchar2
  ) as
    l_ind_er             varchar2(1 char);

    l_nc_doc_select     number;
    l_fc_cre_doc_select number;
    
    l_tmv_fc_cr_emit      number;
    l_tmv_canc_fc_cr_emit number;
    
    l_tmv_nc_cr_emit        number;
    l_tmv_nc_cr_cancel_emit number;
    
    l_tmv_ndb_emit        number;
    l_tmv_cancel_ndb_emit number;
     
    l_tmv_adel_cliente_emit      number;
    l_tmv_adel_cliente_canc_emit number;
    
    l_tmv_nc_cr_rec number;
    l_tmv_cancel_nc_cr_rec number;
    
    l_tmv_adel_rec number;
    l_tmv_cancel_adel_rec number;
    
    l_tmv_fc_cr_rec number;
    l_tmv_cancel_fc_cr_rec number;
    
    l_tmv_nota_deb_rec number;
    l_tmv_cancel_nota_deb_rec number;

    l_fin_doc_father number;
    l_fin_doc_child  number;
    
    l_fecha_op_insert    date;
    l_emp_insert         number;
    l_suc_insert         number;
    l_cli_or_prov_insert number;
    l_mnd_insert         number;
    
    l_nc_nro_doc     number;
    l_nc_importe_mon number;
    l_nc_importe_loc number;
    l_nc_clave_scli  number;
    l_nc_tipo_mov    number;
    l_nc_doc_clave   number;
    l_nc_venc        date;
    
    l_fc_nro_doc     number;
    l_fc_importe_mon number;
    l_fc_importe_loc number;
    l_fc_clave_scli  number;
    l_fc_tipo_mov    number;
    l_fc_doc_clave   number;
    l_fc_venc        date;

    l_tipo_mov_filter number;
    l_since_date_filter date;
    
    l_tmv_cancela     number;
    l_tmv_cancela_two number;
    
    e_tmv_no_configurado exception;
    e_importe_mayor      exception;
    e_indicador          exception;
  begin
    <<get_data_col_filters>>
    begin
      select 
        to_number(c.c001)             empresa,
        to_date(c.c002, 'dd/mm/yyyy') fecha_operacion,
        to_number(c.c005)             cliente_o_proveedor,
        c.c006                        indicador_er, -- Emitido o Recibido
        c.c007                        sucursal,
        c.c004                        moneda,
        c.c003                        tipo_movimiento,
        to_date(c.c008, 'dd/mm/yyyy') desde
      into
        l_emp_insert,
        l_fecha_op_insert,
        l_cli_or_prov_insert,
        l_ind_er,
        l_suc_insert,
        l_mnd_insert,
        l_tipo_mov_filter,
        l_since_date_filter
      from apex_collections c
      where c.collection_name = co_col_filtros;
    exception
      when no_data_found then
        Raise_application_error(-20000, 'Consulte antes de confirmar');
      when too_many_rows then
        Raise_application_error(-20000, 'Muchos filtros guardados, cierre sesi'||chr(243)||'n e intente nuevamente');
    end get_data_col_filters;
 
    <<c_options>>
    case
      when l_ind_er in( co_emision, co_recibido ) then
        <<conf_comprobantes_emitidos>>
        begin
          select
            -- EMITIDOS AL CLIENTE
            -- FC
            fx.conf_fact_cr_emit        tmv_fc_cr_emit,
            fx.conf_recibo_can_fac_emit tmv_canc_fc_cr_emit,
            
            -- NDB
            fx.conf_nota_db_emit        tmv_ndb_emit,
            fx.conf_recibo_pago_rec     tmv_cancel_ndb_emit,
            
            -- NC
            fx.conf_nota_cr_emit        tmv_nc_cr_emit,
            fx.conf_recibo_cncr_emit    tmv_nc_cr_cancel_emit,
            
            -- ADELANTO
            fx.conf_adelanto_cli        tmv_adel_cliente_emit,
            fx.conf_recibo_cadcli_emit  tmv_adel_cliente_canc_emit,
            
            -- RECIBIDOS DEL PROVEEDOR
            -- NC REC 
            fx.conf_nota_cr_rec         tmv_nc_cr_rec,
            fx.conf_recibo_cncr_rec     tmv_cancel_nc_cr_rec,
            
            -- ADELANTO REC
            fx.conf_adelanto_pro        tmv_adel_rec,
            fx.conf_recibo_cadpro_rec   tmv_cancel_adel_rec,
            
            -- FC REC
            fx.conf_fact_cr_rec         tmv_fc_cr_rec,
            fx.conf_recibo_can_fac_rec  tmv_cancel_fc_cr_rec,
            
            -- NOT.DEB. REC
            fx.conf_nota_db_rec         tmv_nota_deb_rec,
            fx.conf_recibo_pago_rec     tmv_cancel_nota_deb_rec
            
          into
            -- emitidas
            l_tmv_fc_cr_emit,
            l_tmv_canc_fc_cr_emit,
            
            l_tmv_ndb_emit,
            l_tmv_cancel_ndb_emit,
            
            l_tmv_nc_cr_emit,
            l_tmv_nc_cr_cancel_emit,
            
            l_tmv_adel_cliente_emit,
            l_tmv_adel_cliente_canc_emit,
            
            -- recibidas
            l_tmv_nc_cr_rec,
            l_tmv_cancel_nc_cr_rec,
            
            l_tmv_adel_rec,
            l_tmv_cancel_adel_rec,
            
            l_tmv_fc_cr_rec,
            l_tmv_cancel_fc_cr_rec,
            
            l_tmv_nota_deb_rec,
            l_tmv_cancel_nota_deb_rec
            
          from fin_configuracion fx
          where fx.conf_empr = l_emp_insert;
        exception
          when no_data_found then
            Raise_application_error(-20000, 'Configuraci'||chr(243)||'n de documentos de emisi'||chr(243)||'n no encontrada');
          when too_many_rows then
            Raise_application_error(-20000, 'La empresa contiene muchas configuraciones de cancelaci'||chr(243)||'n de comprobantes de emisi'||chr(243)||'n');
        end conf_comprobantes_emitidos;
        
        /* 
        Se agregan 2 documentos, con sus pagos correspondientes. Toma el monto de la NC:
        La NC debe tener monto menor o igual al del al Factura Credito
         1. el recibo de cancelacion de la factura credito
         2. el recibo de la cancelacion de la nota de credito con la clave padre
        */ 
         
        -- items ocultos en APEX
        <<get_data_selected>>
        case
          when l_ind_er = co_emision then
            l_nc_doc_select     := ap.v(p_item => 'P158_NC_SEQ');
            l_fc_cre_doc_select := ap.v(p_item => 'P158_FC_SEQ');
            
          when l_ind_er = co_recibido then            
            l_nc_doc_select     := ap.v(p_item => 'P158_NCR_SEQ');
            l_fc_cre_doc_select := ap.v(p_item => 'P158_FCR_SEQ');  
          else
            raise e_indicador;        
        end case get_data_selected;
        
        if l_nc_doc_select is null or l_fc_cre_doc_select is null then
          Raise_application_error(-20000, 'Seleccione una Nota de cr'||chr(233)||'dito/Adelanto y luego relacione eso a una Factura/Not. Deb.');
        end if;
        
        <<v_coins>>
        declare
         l_c number;
        begin
          select to_number(c.c009)
          into l_c
          from apex_collections c
          where 
          (    -- emitidos
              (l_ind_er = co_emision
               and
               c.collection_name in (co_col_nc_emision, co_col_fc_emision)
              )
              or
              -- recibidos
              (l_ind_er = co_recibido
               and
               c.collection_name in (co_col_nc_rec, co_col_fc_rec)
              )
          
          )      
          and   to_number(c.seq_id) in ( l_nc_doc_select, l_fc_cre_doc_select)
          group by to_number(c.c009); --> see guarda el tipo de moneda en C009
        exception
          when too_many_rows then
            Raise_application_error(-20000, 'Solo puede cancelar documentos entre monedas del mismo tipo');
        end v_coins;
           
        <<nc_doc>>
        begin
          select 
            c.c001                        doc_nro_doc,
            ut.getnc(i_numero => c.c006)  cuo_saldo_mon,
            ut.getnc(i_numero => c.c007)  cuo_saldo_loc,
            c.c014                        doc_clave_scli,
            to_number(c.c017)             doc_tipo_mov,
            to_date(c.c004, 'dd/mm/yyyy') vencimiento,
            c.c008                        doc_clave
          into
            l_nc_nro_doc,
            l_nc_importe_mon,
            l_nc_importe_loc,
            l_nc_clave_scli,
            l_nc_tipo_mov,
            l_nc_venc,
            l_nc_doc_clave
          from apex_collections c
          where 
          (    -- emitidos
              (l_ind_er = co_emision
               and
               c.collection_name = co_col_nc_emision
              )
              or
              -- recibidos
              (l_ind_er = co_recibido
               and
               c.collection_name = co_col_nc_rec
              )
          
          )
          and   to_number(c.seq_id) = l_nc_doc_select;
        end nc_doc;
         
        if l_nc_tipo_mov not in( l_tmv_nc_cr_emit , l_tmv_adel_cliente_emit, l_tmv_nc_cr_rec, l_tmv_adel_rec)
        then
          raise e_tmv_no_configurado;
        end if;
        
        <<t_cancell>>
        case
          -- emitidas
          when l_nc_tipo_mov = l_tmv_nc_cr_emit then
            l_tmv_cancela := l_tmv_nc_cr_cancel_emit;
          when l_nc_tipo_mov = l_tmv_adel_cliente_emit then
            l_tmv_cancela := l_tmv_adel_cliente_canc_emit;
          -- recibidas 
          when l_nc_tipo_mov = l_tmv_nc_cr_rec then
            l_tmv_cancela := l_tmv_cancel_nc_cr_rec;  
          when l_nc_tipo_mov = l_tmv_adel_rec then
            l_tmv_cancela := l_tmv_cancel_adel_rec;  
          else
            raise e_tmv_no_configurado;
        end case t_cancell;
        
        l_fin_doc_father :=
        add_fin_documento(in_empresa     => l_emp_insert,
                          in_user        => in_user,
                          in_fecha       => l_fecha_op_insert,
                          in_suc         => l_suc_insert,
                          in_tipo_mov    => l_tmv_cancela,
                          in_moneda      => l_mnd_insert,
                          in_cliente     => case when l_ind_er = co_emision  then l_cli_or_prov_insert else null end,
                          in_proveedor   => case when l_ind_er = co_recibido then l_cli_or_prov_insert else null end,
                          in_nro_doc     => l_nc_nro_doc,
                          in_importe_mon => l_nc_importe_mon,
                          in_importe_loc => l_nc_importe_loc,
                          in_clave_padre => null,
                          in_clave_scli  => l_nc_clave_scli
                          );

        <<fc_doc>>
        begin
          select 
            c.c001                       doc_nro_doc,
            ut.getnc(i_numero => c.c006) cuo_saldo_mon,
            ut.getnc(i_numero => c.c007) cuo_saldo_loc,
            c.c014                       doc_clave_scli,
            to_number(c.c017)            doc_tipo_mov,
            to_date(c.c004, 'dd/mm/yyyy') vencimiento,
            c.c008                        doc_clave
          into
            l_fc_nro_doc     ,
            l_fc_importe_mon ,
            l_fc_importe_loc ,
            l_fc_clave_scli  ,
            l_fc_tipo_mov    ,
            l_fc_venc        ,
            l_fc_doc_clave
          from apex_collections c
          where 
          (    -- emitidos
              (
               l_ind_er = co_emision
               and
               c.collection_name = co_col_fc_emision
              )
              or
              -- recibidos
              (
               l_ind_er = co_recibido
               and
               c.collection_name = co_col_fc_rec
              )
          
          )  
          and   to_number(c.seq_id) = l_fc_cre_doc_select;
        end fc_doc;
         
        if l_fc_tipo_mov not in( l_tmv_fc_cr_emit , l_tmv_ndb_emit, l_tmv_fc_cr_rec, l_tmv_nota_deb_rec )
        then
            raise e_tmv_no_configurado;
        end if;
        
        <<t_cancell_two>>
        case
          -- emitidas
          when l_fc_tipo_mov = l_tmv_fc_cr_emit then
            l_tmv_cancela_two := l_tmv_canc_fc_cr_emit;
          when l_fc_tipo_mov = l_tmv_ndb_emit then
            l_tmv_cancela_two := l_tmv_cancel_ndb_emit; 
          -- recibidas
          when l_fc_tipo_mov = l_tmv_fc_cr_rec then
            l_tmv_cancela_two := l_tmv_cancel_fc_cr_rec;
          when l_fc_tipo_mov = l_tmv_nota_deb_rec then
            l_tmv_cancela_two := l_tmv_cancel_nota_deb_rec;   
          else
            raise e_tmv_no_configurado;
        end case t_cancell_two;
        
        if l_mnd_insert = 1 then -- GS
          if l_nc_importe_loc > l_fc_importe_loc then
            raise e_importe_mayor;
          end if;
        else -- otras monedas
          if l_nc_importe_mon > l_fc_importe_mon then
            raise e_importe_mayor;
          end if;
        end if;
        
        l_fin_doc_child :=
        add_fin_documento(in_empresa     => l_emp_insert,
                          in_user        => in_user,
                          in_fecha       => l_fecha_op_insert,
                          in_suc         => l_suc_insert,
                          in_tipo_mov    => l_tmv_cancela_two,
                          in_moneda      => l_mnd_insert,
                          in_cliente     => case when l_ind_er = co_emision  then l_cli_or_prov_insert else null end,
                          in_proveedor   => case when l_ind_er = co_recibido then l_cli_or_prov_insert else null end,
                          in_nro_doc     => l_fc_nro_doc,
                          in_importe_mon => l_nc_importe_mon, --> monto de la NC || ADELANTO
                          in_importe_loc => l_nc_importe_loc, --> monto de la NC || ADELANTO
                          in_clave_padre => l_fin_doc_father,
                          in_clave_scli  => l_fc_clave_scli
                          );
        
        -- add pago NC || ADELANTO
        add_pago(in_clave_fc_nc  => l_nc_doc_clave,
                 in_clave_recibo => l_fin_doc_father,
                 in_vencimiento  => l_nc_venc,
                 in_fecha_op     => l_fecha_op_insert,
                 in_importe_mon  => l_nc_importe_mon,
                 in_importe_loc  => l_nc_importe_loc,
                 in_empresa      => l_emp_insert,
                 in_user         => in_user
         );
        
        -- add pago FC, el importe es igual para el recibo de factura
        -- por la regla de negocio, solo se puede aplicar a 1 factura la NC
        add_pago(in_clave_fc_nc  => l_fc_doc_clave,
                 in_clave_recibo => l_fin_doc_child,
                 in_vencimiento  => l_fc_venc,
                 in_fecha_op     => l_fecha_op_insert,
                 in_importe_mon  => l_nc_importe_mon, --> monto de la NC || ADELANTO
                 in_importe_loc  => l_nc_importe_loc, --> monto de la NC || ADELANTO
                 in_empresa      => l_emp_insert,
                 in_user         => in_user
         );
          
        -- una vez que se cancela el segundo documento, elimina las secuencias
        if l_fin_doc_child is not null then
          <<clear_data_selected>>
          case
            when l_ind_er = co_emision then
              <<del_members_emision>>
              begin
                APEX_COLLECTION.DELETE_MEMBER(
                  p_collection_name => co_col_nc_emision,
                  p_seq             => l_nc_doc_select
                );
                  
                APEX_COLLECTION.DELETE_MEMBER(
                  p_collection_name => co_col_fc_emision,
                  p_seq             => l_fc_cre_doc_select
                );
              end del_members_emision;
                
              ap.sv(p_item => 'P158_NC_SEQ');
              ap.sv(p_item => 'P158_FC_SEQ');
                
            when l_ind_er = co_recibido then
              <<del_members_recibido>>
              begin
                APEX_COLLECTION.DELETE_MEMBER(
                  p_collection_name => co_col_nc_rec,
                  p_seq             => l_nc_doc_select 
                );
                  
                APEX_COLLECTION.DELETE_MEMBER(
                  p_collection_name => co_col_fc_rec,
                  p_seq             => l_fc_cre_doc_select 
                );
              end del_members_recibido;  
                     
              ap.sv(p_item => 'P158_NCR_SEQ');
              ap.sv(p_item => 'P158_FCR_SEQ');  
            else
              raise e_indicador;        
          end case clear_data_selected;
        end if;
                       
      else
        Raise_application_error(-20000, 'Opci'||chr(243)||'n no v'||chr(225)||'lida. Tipo de Movimiento no es ni Emisi'||chr(243)||'n y Recibido');
    end case c_options;
  exception
    when e_tmv_no_configurado then
      raise_application_Error(-20000, 'No se puede cancelar el documento, no se encuentra configurado');
    when e_importe_mayor then
      Raise_application_error(-20000, 'Importe de la NC/Adelanto no puede ser mayor al de la factura/Not. Deb.');
    when e_indicador then
      raise_application_Error(-20000, 'Documento no pertenece a Emitidos o Recibidos. Verificar su tipo de movimiento');
  end confirm;
  
  procedure add_pago(
    in_clave_fc_nc  number,
    in_clave_recibo number,
    in_vencimiento  date,
    in_fecha_op     date,
    in_importe_mon  number,
    in_importe_loc  number,
    in_empresa      number,
    in_user         varchar2
  )as
  begin
    insert into fin_pago(pag_clave_doc,
                         pag_fec_vto,
                         pag_clave_pago,
                         pag_fec_pago,
                         pag_imp_loc,
                         pag_imp_mon,
                         pag_login,
                         pag_fec_grab,
                         pag_sist,
                         pag_empr
                        )
                values(in_clave_fc_nc,
                       in_vencimiento,
                       in_clave_recibo,
                       in_fecha_op,
                       in_importe_loc,
                       in_importe_mon,
                       in_user,
                       current_date,
                       'FIN',
                       in_empresa
                       );
  end add_pago;
    
  procedure truncate_all_collections as
  begin 
    if apex_collection.collection_exists (p_collection_name => co_col_nc_emision) then
       apex_collection.truncate_collection ( p_collection_name => co_col_nc_emision );
    end if;

    if apex_collection.collection_exists (p_collection_name => co_col_fc_emision) then
       apex_collection.truncate_collection ( p_collection_name => co_col_fc_emision );
    end if;

    if apex_collection.collection_exists (p_collection_name => co_col_nc_rec) then
       apex_collection.truncate_collection ( p_collection_name => co_col_nc_rec );
    end if;

    if apex_collection.collection_exists (p_collection_name => co_col_fc_rec) then
       apex_collection.truncate_collection ( p_collection_name => co_col_fc_rec );
    end if;

    if apex_collection.collection_exists (p_collection_name => co_col_filtros) then
       apex_collection.truncate_collection ( p_collection_name => co_col_filtros );
    end if;
  end truncate_all_collections;
  
  -- FUNCTIONS:
  function operador_hab_mes_finanzas(
    in_user varchar2,
    in_emp  number
  )return boolean is
  l_tipo gen_operador_empresa.opem_ind_hab_mes_act%type;
  l_cod_oper number;
  begin
    select o.oper_codigo
    into l_cod_oper
    from gen_operador o
    where o.oper_login = in_user;
    
    select nvl(e.opem_ind_hab_mes_act, 'N')
    into l_tipo 
    from gen_operador_empresa e
    where e.opem_oper = l_cod_oper
    and   e.opem_empr = in_emp;
    
    if l_tipo = 'S' then
      return true;
    elsif l_tipo = 'N' then
      return false;
    end if;
  exception
    when no_data_found then
      return false;
  end operador_hab_mes_finanzas;
  
  function get_tipo_mov_er(
    in_tipo_mov in number,
    in_empresa  in number
  )return varchar2 is
  l_r varchar2(1 char);
  begin
    select t.tmov_ind_er
    into l_r
    from gen_tipo_mov t
    where t.tmov_codigo = in_tipo_mov
    and   t.tmov_empr   = in_empresa;
    
    return l_r;
  exception
    when no_data_found then
      return 'I'; --> indefinido, para comodin no+
  end get_tipo_mov_er;
 
  function add_fin_documento(
    in_empresa     number,
    in_user        varchar2,
    in_fecha       date,
    in_suc         number,
    in_tipo_mov    number,
    in_moneda      number,
    in_cliente     number,
    in_proveedor   number,
    in_nro_doc     number,
    in_importe_mon number,
    in_importe_loc number,
    in_clave_padre number,
    in_clave_scli  number
  )return fin_documento.doc_clave%type is
  
  l_new_fin_doc_clave fin_documento.doc_clave%type;
  l_tipo_saldo        gen_tipo_mov.tmov_tipo%type;
  begin
    <<get_tipo_saldo>>
    begin
      select t.tmov_tipo
      into l_tipo_saldo
      from gen_tipo_mov t
      where t.tmov_codigo = in_tipo_mov
      and   t.tmov_empr   = in_empresa;
    exception
      when no_Data_found then
       Raise_application_error(-20000, 'No se encuentra el tipo saldo del movimiento');   
    end get_tipo_saldo;
    
    l_new_fin_doc_clave := FIN_SEQ_DOC_NEXTVAL;
    
    insert into fin_documento(doc_clave,
                              doc_empr,
                              doc_suc,
                              doc_tipo_mov,
                              doc_tipo_saldo,
                              doc_mon,
                              doc_prov,
                              doc_cli,
                              doc_nro_doc,
                              doc_fec_oper,
                              doc_fec_doc,
                              doc_neto_exen_mon,
                              doc_neto_exen_loc,
                              doc_neto_grav_mon,
                              doc_neto_grav_loc,
                              doc_iva_mon,
                              doc_iva_loc,
                              doc_bruto_exen_mon,
                              doc_bruto_exen_loc,
                              doc_bruto_grav_mon,
                              doc_bruto_grav_loc,
                              doc_operador,
                              doc_login,
                              doc_fec_grab,
                              doc_sist,
                              doc_clave_scli,
                              doc_clave_padre
                              )
                       values(l_new_fin_doc_clave,
                              in_empresa,
                              in_suc,
                              in_tipo_mov,
                              l_tipo_saldo,
                              in_moneda,
                              in_proveedor,
                              in_cliente,
                              in_nro_doc,
                              in_fecha,
                              in_fecha,
                              in_importe_mon,
                              in_importe_loc,
                              0,
                              0,
                              0,
                              0,
                              in_importe_mon,
                              in_importe_loc,
                              0,
                              0,
                              2, --> doc operador generico, ya esta deprecado
                              in_user,
                              current_date,
                              'FIN',
                              in_clave_scli,
                              in_clave_padre
                              );
                              
     return l_new_fin_doc_clave;
     
  end add_fin_documento;
  
  function get_client_holding(
    in_holding in number,
    in_empresa in number
  )return t_holding pipelined is
  begin
    <<f_get_data>>
    for i in (select fx.cli_codigo
              from fin_cliente fx
              where fx.cli_cod_ficha_holding = in_holding
              and   fx.cli_empr = in_empresa
              group by fx.cli_codigo
            )
    loop
      pipe row(t_holding_dependencies(i.cli_codigo));
    end loop f_get_data;
    
    return;
  exception
    when no_data_needed then
      null; --> si no hay registros no envia nada
  end get_client_holding;
  
end FINI053;
/
