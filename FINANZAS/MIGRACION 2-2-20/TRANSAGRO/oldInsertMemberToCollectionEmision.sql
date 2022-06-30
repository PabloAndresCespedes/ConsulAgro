        /*
          if 1 = 2 then --> BLOQUEE PARA PRUEBAS DE PERFORMANCE
          
          <<f_nch_emit>>
          for i in (
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
                   fd.doc_tipo_mov
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
          end loop f_nch_emit;
        
            
          <<f_fch_emit>>
          for f in (select fd.doc_nro_doc,
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
                           fd.doc_tipo_mov
                    from fin_documento fd
                    inner join fin_cuota fc on (fc.cuo_clave_doc = fd.doc_clave and fc.cuo_empr = fd.doc_empr)
                    inner join table(get_client_holding(in_holding => in_holding, in_empresa => in_empresa)) cl on (fd.doc_cli = cl.id)
                    inner join gen_moneda gm on (gm.mon_codigo = fd.doc_mon and gm.mon_empr = fd.doc_empr)
                    where cl.id is not null
                    and gm.mon_codigo = in_mnd 
                    and fd.doc_empr   = in_empresa
                    and (trunc(fd.doc_fec_doc) between in_desde and in_fecha_op)
                    and fc.cuo_saldo_mon > 0
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
          end loop f_fch_emit;
          
          end if; --> FIN LO BLOQUEE PARA PRUEBAS DE PERFORMANCE
          */