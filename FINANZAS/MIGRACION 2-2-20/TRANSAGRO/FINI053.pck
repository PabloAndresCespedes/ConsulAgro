create or replace package FINI053 is

  -- Author  : PROGRAMACION7
  -- Created : 22/06/2022 10:07:31
  -- Purpose : Cancelacion de documentos
  
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
    in_user      varchar2,
    in_ind_er    varchar2, -- E || R Emitidos o Recibidos
    out_error    out varchar2  -- retorna NO si no hubo inconvenientes, sino el texto
  );
end FINI053;
/
create or replace package body FINI053 is

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
    in_user      varchar2,
    in_ind_er    varchar2, -- E || R Emitidos o Recibidos
    out_error    out varchar2  -- retorna NO si no hubo inconvenientes, sino el texto
  )as
  co_col_nc_emision constant varchar2(10 char) := 'NC_EMISION';
  co_col_fc_emision constant varchar2(10 char) := 'FC_EMISION';
  co_col_nc_rec     constant varchar2(11 char) := 'NC_RECIBIDO';
  co_col_fc_rec     constant varchar2(11 char) := 'FC_RECIBIDO';
  
  co_emision  constant varchar2(1 char) := 'E';
  co_recibido constant varchar2(1 char) := 'R';
  
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
                  ) seleccionar 
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
            p_c015            => i.seleccionar
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
                          ) seleccionar 
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
            p_c015 => f.seleccionar
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
                        mon_tasa_vta
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
            p_c013            => i.mon_tasa_vta
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
                          mon_tasa_vta

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
              p_c013            => j.mon_tasa_vta
           );
         end loop f_fc_recibida;
      
      else
        Raise_application_error(-20000, 'Es necesario seleccionar el Tipo de movimiento ');
    end case option_ind;
    
    out_error := 'NO';
  exception
    when others then
      out_error := replace(sqlerrm, 'ORA-20000:', '');
  end generate_query;
  
  
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
 
end FINI053;
/
