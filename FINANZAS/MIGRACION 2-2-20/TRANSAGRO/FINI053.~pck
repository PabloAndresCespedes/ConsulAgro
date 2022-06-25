create or replace package FINI053 is

  -- Author  : PROGRAMACION7
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
  */
  
  /*
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
    in_cliente   number,
    in_proveedor number,
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
  
end FINI053;
/
create or replace package body FINI053 is
  co_col_nc_emision constant varchar2(10 char) := 'NC_EMISION';
  co_col_fc_emision constant varchar2(10 char) := 'FC_EMISION';
  co_col_nc_rec     constant varchar2(11 char) := 'NC_RECIBIDO';
  co_col_fc_rec     constant varchar2(11 char) := 'FC_RECIBIDO';
  co_col_filtros    constant varchar2(7  char) := 'FILTROS';
  
  
  co_emision  constant varchar2(1 char) := 'E';
  co_recibido constant varchar2(1 char) := 'R';
  
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
    in_cliente   number,
    in_proveedor number,
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
        if in_cliente is null then
          Raise_application_error(-20000, 'Seleccione un cliente');
        end if;
      when in_ind_er = co_recibido then
        if in_proveedor is null then
          Raise_application_error(-20000, 'Seleccione un proveedor');
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
                 APEX_ITEM.CHECKBOX2(p_idx => 1, 
                   p_value => 0,
                   p_attributes => 'class="my_value selectorItem cursor"  
                   onclick="$s(''P158_NC_DOC_SELECT'', '||doc_nro_doc||'); 
                            $s(''P158_NC_MONTO_SELECT'', '||case when doc_mon <> 1 then cuo_saldo_loc else cuo_saldo_mon end||')
                   "'
                  ) seleccionar,
                  doc_tipo_mov
          from gen_moneda,
               fin_documento,
               fin_cuota
          where mon_codigo = doc_mon
          and cuo_clave_doc = doc_clave
          and doc_empr=mon_empr
          and doc_empr=cuo_empr
          and doc_empr = in_empresa
          and doc_fec_doc <= in_fecha_op
          and (
              (doc_cli = in_cliente
               and doc_tipo_mov in (l_nc_emitida, l_nc_emi_ajuste)
               and in_tipo_mov = l_recibo_nc_emitido
              )
              or 
              (doc_cli = in_cliente
               and doc_tipo_mov = l_adelanto_cli
               and in_tipo_mov  = l_recibo_adel_cli_emitido
              )
          )
          and cuo_saldo_mon > 0
          and (doc_mon = in_mnd)

          order by cuo_fec_vto, doc_fec_doc, doc_nro_doc
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
            p_c015            => i.seleccionar,
            p_c016            => in_fecha_op,
            p_c017            => i.doc_tipo_mov,
            p_c018            => in_mnd
         );
        end loop f_nc_emit;
        
        apex_collection.create_or_truncate_collection( p_collection_name => co_col_fc_emision );
        
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
                         apex_item.checkbox2(p_idx => 2, 
                           p_value => 0,
                           p_attributes => 'class="my_value selectorItem cursor"  
                           onclick="$s(''P158_FC_DOC_SELECT'', '||doc_nro_doc||'); 
                                    $s(''P158_FC_MONTO_SELECT'', '||case when doc_mon <> 1 then cuo_saldo_loc else cuo_saldo_mon end||')
                           "'
                          ) seleccionar,
                         doc_tipo_mov
                  from gen_moneda,
                       fin_documento,
                       fin_cuota
                  where mon_codigo = doc_mon
                  and cuo_clave_doc = doc_clave
                  and doc_empr=mon_empr
                  and doc_empr=cuo_empr
                  and doc_empr = in_empresa
                  and doc_fec_doc <= in_fecha_op
                  and 
                  (
                      (doc_cli = in_cliente
                       and doc_tipo_mov in (l_ndb_emit,
                                            l_tmv_orden_compra,
                                            l_fc_cr_emit,
                                            l_fc_cr_emit_ajuste
                                            )
                      and in_ind_er = co_emision
                      )
                  )
                  and cuo_saldo_mon > 0
                  and (doc_mon = in_mnd)
                  order by cuo_fec_vto, doc_fec_doc, doc_nro_doc
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
            p_c015 => f.seleccionar,
            p_c016 => in_fecha_op,
            p_c017 => f.doc_tipo_mov,
            p_c018 => in_mnd
          );
        end loop f_fc_emit;
        
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
                        doc_tipo_mov,
                        apex_item.checkbox2(p_idx => 1, 
                         p_value => 0,
                         p_attributes => 'class="my_value selectorItem cursor"  
                         onclick="$s(''P158_NCR_DOC_SELECT'', '||doc_nro_doc||'); 
                                  $s(''P158_NCR_MONTO_SELECT'', '||case when doc_mon <> 1 then cuo_saldo_loc else cuo_saldo_mon end||')
                         "'
                         ) seleccionar
          from  gen_moneda tm ,
                fin_documento fa ,
                fin_cuota cu
          where mon_codigo = doc_mon
          and mon_empr = doc_empr
          and doc_empr = cuo_empr
          and doc_clave = cuo_clave_doc
          and doc_empr = in_empresa
          and doc_prov = in_proveedor
          and doc_fec_doc <= in_fecha_op

          and (
                ( in_tipo_mov = l_recibo_nc_recibido
                  and in_ind_er = co_recibido

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
          and cuo_saldo_mon > 0
          and doc_mon = in_mnd

          order by cuo_fec_vto, doc_fec_doc, doc_nro_doc
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
            p_c015            => i.seleccionar,
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
                          doc_tipo_mov,
                          apex_item.checkbox2(p_idx => 2, 
                           p_value => 0,
                           p_attributes => 'class="my_value selectorItem cursor"  
                           onclick="$s(''P158_FCR_DOC_SELECT'', '||doc_nro_doc||'); 
                                    $s(''P158_FCR_MONTO_SELECT'', '||case when doc_mon <> 1 then cuo_saldo_loc else cuo_saldo_mon end||')
                           "'
                           ) seleccionar
                  from  gen_moneda,
                        fin_documento,
                        fin_cuota

                  where mon_empr = doc_empr
                  and mon_codigo = doc_mon
                  and doc_empr   = cuo_empr
                  and doc_clave  = cuo_clave_doc
                  and doc_empr   = in_empresa
                  and doc_prov   = in_proveedor
                  and doc_fec_doc <= in_fecha_op
                  and 
                  (
                    doc_tipo_mov in
                    (
                      l_ndb_rec,
                      l_fc_cr_rec,
                      l_tmv_despacho,
                      l_fc_cr_rec_ajuste
                    )
                    and in_ind_er = co_recibido
                  )

                  and cuo_saldo_mon > 0
                  and doc_mon = in_mnd
                  order by cuo_fec_vto, doc_fec_doc, doc_nro_doc
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
              p_c015            => j.seleccionar,
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
        p_c007            => in_suc
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
    l_error_comodin   varchar2(4000);
    
    l_tmv_cancela     number;
    l_tmv_cancela_two number;
    
    e_tmv_no_configurado exception;
    e_importe_mayor      exception;
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
        c.c003                        tipo_movimiento
      into
        l_emp_insert,
        l_fecha_op_insert,
        l_cli_or_prov_insert,
        l_ind_er,
        l_suc_insert,
        l_mnd_insert,
        l_tipo_mov_filter
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
        -- se utiliza para 
        if l_ind_er = co_emision then
          l_nc_doc_select     := ap.v(p_item => 'P158_NC_DOC_SELECT');
          l_fc_cre_doc_select := ap.v(p_item => 'P158_FC_DOC_SELECT');
        elsif l_ind_er = co_recibido then
          l_nc_doc_select     := ap.v(p_item => 'P158_NCR_DOC_SELECT');
          l_fc_cre_doc_select := ap.v(p_item => 'P158_FCR_DOC_SELECT');          
        end if;
        
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
          where c.collection_name = co_col_nc_emision
          and   to_number(c.c001) in ( l_nc_doc_select, l_fc_cre_doc_select)
          group by to_number(c.c009);
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
          where c.collection_name = co_col_nc_emision
          and   to_number(c.c001) = l_nc_doc_select;
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
          where c.collection_name = co_col_fc_emision
          and   to_number(c.c001) = l_fc_cre_doc_select;
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
         
        -- una vez que se cancela el segundo documento, vuelve a consultar todo
        -- y se hace un refresh desde APEX para las listas
        if l_fin_doc_child is not null then         
          generate_query(
           in_fecha_op  => l_fecha_op_insert,
           in_cliente   => case when l_ind_er = co_emision  then l_cli_or_prov_insert else null end, --> cliente
           in_proveedor => case when l_ind_er = co_recibido then l_cli_or_prov_insert else null end, --> proveedor
           in_tipo_mov  => l_tipo_mov_filter,
           in_mnd       => l_mnd_insert,
           in_empresa   => l_emp_insert,
           in_suc       => l_suc_insert,
           in_user      => in_user,
           in_ind_er    => l_ind_er,
           out_error    => l_error_comodin
          );
        end if;
                       
      else
        Raise_application_error(-20000, 'Opci'||chr(243)||'n no v'||chr(225)||'lida. Tipo de Movimiento no es ni Emisi'||chr(243)||'n y Recibido');
    end case c_options;
  exception
    when e_tmv_no_configurado then
      raise_application_Error(-20000, 'No se puede cancelar el documento, no se encuentra configurado');
    when e_importe_mayor then
      Raise_application_error(-20000, 'Importe de la NC/Adelanto no puede ser mayor al de la factura/Not. Deb.');
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
                              2,
                              in_user,
                              current_date,
                              'FIN',
                              in_clave_scli,
                              in_clave_padre
                              );
                              
     return l_new_fin_doc_clave;
     
  end add_fin_documento;
  
end FINI053;
/
