CREATE OR REPLACE PACKAGE FACI240_P IS
  
  -- CREATED : 11/08/2020 8:44:06
  -- PURPOSE :
  
  SUBTYPE CAB_RT      IS    FACI240_D.CAB_RT          ; 
  SUBTYPE DETA_RT     IS    FACI240_D.DET_RT          ; 
  SUBTYPE DETA_TT     IS    FACI240_D.DET_TT          ; 
  
  --TYPE DETA_TT IS TABLE OF DETA_RT;
  
  FUNCTION FP_IMP_TT_DOCU RETURN NUMBER ;
  
  FUNCTION FP_DETA_TAB RETURN DETA_TT ;

  function get_disp_venta(in_art  in  number,
                          in_emp  in  number := null) return number;
  
  -- 02/07/2022 7:37:08 @PabloACespedes \(^-^)/
  -- Valida la coleccion de APEX si hay disponible dentro de la empresa
  procedure val_new_sales_det ;
    
  procedure validate_disp_venta ;
    
  PROCEDURE PP_CARGAR_CUENTAS_CLI ;
    
  PROCEDURE PP_CARGAR_DATOS;
     
  PROCEDURE PP_VALIDAR_FECHA;
  
  PROCEDURE PP_BUSCAR_CLIENTE ;  
  
  PROCEDURE PP_BUSCAR_VENDEDOR ; 

  PROCEDURE PP_BUSCAR_TIPO_FA ; 
  
  PROCEDURE PP_BUSCAR_CONTRATO_BONO ; 
    
  PROCEDURE MOSTRAR_FILA_EDIT; 
    
  PROCEDURE PP_BORRAR_ITEM(I_SEQ_ID IN NUMBER);
  
  PROCEDURE PP_VALIDAR_CAB     ;
  
  PROCEDURE PP_LIMPIAR_AUX     ;

  PROCEDURE PP_BUSCAR_ARTICULO ;
  
  PROCEDURE PP_BUSCAR_DEC_MON  ;
  
  PROCEDURE PP_BUSCAR_ZAFRA    ; 
  
  PROCEDURE PP_BUSCAR_LINEA_DISP ;
    
  PROCEDURE PP_VALIDAR_PRECIO  ; 
  
  PROCEDURE PP_CALC_TT_AUXI    ; 
  
  PROCEDURE PP_ACT_MON_DOCU    ;

  PROCEDURE PP_CONFIG_REP      ;
        
  PROCEDURE PP_AGREGAR_DETA    ; 
  
  PROCEDURE PP_MODIFICAR_DETA  ; 
  
  PROCEDURE PP_ACTU_DETA       ;
      
  PROCEDURE GUARDAR_NUEVO      ; 
  
  PROCEDURE APLICAR_CAMBIOS    ; 

  PROCEDURE ELIMINAR_PEDIDO    ; 
    
END FACI240_P;
/
CREATE OR REPLACE PACKAGE BODY FACI240_P IS
  --========================================================================  
      X_CAB           CAB_RT  ; 
      X_DETA          DETA_TT ;
      X_DETA_E        DETA_TT ;      
  --========================================================================  
      V_DEC_MD        NUMBER  := 0 ;
      V_MON_LOC       NUMBER  := 1 ;
      V_MON_USD       NUMBER  := 2 ;        
  --========================================================================          
      TYPE ANEX_DETA_RT IS RECORD (
      SEQ                 NUMBER        ,  
      DETA_CLAVE_PED      NUMBER        ,  
      DETA_ITEM           NUMBER        ,  
      
      EMPR                NUMBER        ,
      
      ART_CODIGO          NUMBER        , 
      ART_CODIGO_INI      NUMBER        ,       
      ART_DESC            VARCHAR2(60)  , 
      ART_UN_MED          VARCHAR2(10)  , 
            
      ART_IMPU            NUMBER        ,       
      IMPU_PORC           NUMBER        ,             
      IMPU_PORC_DESC      VARCHAR2(10)  ,
      
      CANT_PED            NUMBER        , 
      CANT_FAC            NUMBER        , 
      CANT_PEN_F          NUMBER        , 
                   
      PRECIO_UN           NUMBER        , 
      PRECIO_UN_INI       NUMBER        , 
      
      IMPORTE_TT          VARCHAR2(30)  , 
      
      OBS_DETA            VARCHAR2(100) 
      
      ) ; 
  
  --========================================================================
    TYPE DETA_TT_RT IS RECORD 
    ( IMP_TT_PED      NUMBER    , 
      IMP_TT_FAC      NUMBER    , 
      IMP_TT_PEN_F    NUMBER    
    ) ;
    R_DETA_TT         DETA_TT_RT; 
  --========================================================================
  CURSOR CUR_MON IS 
  SELECT MO.MON_CODIGO  , 
         MO.MON_DESC    ,
         MO.MON_DEC_IMP 
    FROM GEN_MONEDA MO 
   WHERE MO.MON_EMPR   = AP.V('P_EMPRESA') 
     AND MO.MON_CODIGO = AP.V('P48_PED_MON') ;
         
   R_MON CUR_MON%ROWTYPE;  
  --========================================================================         
  CURSOR CUR_OPER IS 
  SELECT OP.OPER_CODIGO                            OPER_CODIGO        , 
         NVL(OPEM_IND_MOD_PED_INSUM, 'N')          OPER_EDITAR_PED    ,
         NVL(OPEM_IND_MOD_PRECIO_VTA_INS, 'N')     OPER_EDITAR_PRE       
    FROM GEN_OPERADOR           OP , 
         GEN_OPERADOR_EMPRESA   OE 
   WHERE OPER_CODIGO     =     OPEM_OPER 
     AND OPER_LOGIN      =     GEN_DEVUELVE_USER --  USER 
     AND OPEM_EMPR       =     AP.V('P_EMPRESA') 
     ;
  R_OPER  CUR_OPER%ROWTYPE ; 
  --========================================================================           
   CURSOR CUR_ARTICULO (I_EMPR IN NUMBER, I_CODIGO IN NUMBER ) IS 
   SELECT AR.ART_CODIGO                    ART_CODIGO        ,  
          AR.ART_COD_ALFANUMERICO          ART_ALFA          , 
          AR.ART_DESC                      ART_DESC          , 
          AR.ART_TIPO                      ART_TIPO          , 
          AR.ART_UNID_MED                  ART_UNID_MED      , 
          AR.ART_IMPU                      ART_IMPU          , 
          IM.IMPU_PORCENTAJE               IMPU_PORC         ,
          IM.IMPU_PORCENTAJE || ' % '
                                           IMPU_PORC_DESC    ,
          AE.AREM_MON                      AREM_MON          ,
          AE.AREM_PRECIO_VTA               AREM_PRECIO_VTA   
          
     FROM GEN_IMPUESTO IM          , 
          STK_ARTICULO AR          ,  
          STK_ARTICULO_EMPRESA AE   
           
    WHERE IM.IMPU_EMPR                   =    AR.ART_EMPR
      AND IM.IMPU_CODIGO                 =    AR.ART_IMPU  
      
      AND AE.AREM_EMPR                   =    AR.ART_EMPR
      AND AE.AREM_ART                    =    AR.ART_CODIGO
      
      AND AR.ART_EMPR                    =    I_EMPR 
      AND AR.ART_CODIGO                  =    I_CODIGO 
      AND AR.ART_TIPO                    NOT  IN 4
    ; 
    
    R_ARTICULO        CUR_ARTICULO%ROWTYPE        ; 
  --========================================================================   
   CURSOR CUR_PRECIO IS 
   SELECT AR.ART_CODIGO                    ART_CODIGO        ,  
          AR.ART_DESC                      ART_DESC          , 
          AE.AREM_MON                      AREM_MON          ,
          AE.AREM_PRECIO_VTA               AREM_PRECIO_VTA   ,
          NVL(AE.arem_precio_vta_min,0)    AREM_PRECIO_MIN   , 
          NVL(AE.arem_precio_vta_max,0)    AREM_PRECIO_MAX   ,

          0                                AREM_PREC_VTA_MP  ,
          0                                AREM_PREC_MIN_MP  , 
          0                                AREM_PREC_MAX_MP  
                            
     FROM STK_ARTICULO AR          ,  
          STK_ARTICULO_EMPRESA AE   
               
    WHERE AE.AREM_EMPR                   =    AR.ART_EMPR
      AND AE.AREM_ART                    =    AR.ART_CODIGO      
      AND AR.ART_EMPR                    =    AP.V( 'P_EMPRESA' )
      AND AR.ART_CODIGO                  =    AP.V( 'P48_ART_CODIGO' )
    ; 
    R_PRECIO     CUR_PRECIO%ROWTYPE  ;   
  --========================================================================      
  PROCEDURE PP_BUSCAR_PERMISO_OPER IS 
      
  BEGIN
      FOR R IN CUR_OPER LOOP 
          R_OPER := R ; 
      END LOOP;      
      
      IF R_OPER.OPER_CODIGO IS NULL THEN 
          RAISE_APPLICATION_ERROR( -20001,  'No se encontro el registro de configuracion de permisos para el usuario ' ||  
                                            gen_devuelve_user 
                                            ) ;                                                      
      END IF ; 
      
  END;
  --======================================================================================   
  FUNCTION FP_MON_TASA_US RETURN NUMBER IS 
      V_RET  NUMBER;
      CURSOR CUR_TASA_US IS 
      SELECT MO.MON_TASA_VTA 
        FROM GEN_MONEDA MO 
       WHERE MO.MON_EMPR    =   AP.V('P_EMPRESA') 
         AND MO.MON_CODIGO  =   V_MON_USD  
      ;  
  BEGIN
      FOR R IN CUR_TASA_US LOOP 
          V_RET := R.MON_TASA_VTA;
      END LOOP;
      RETURN V_RET;
  END;
  --========================================================================      
  FUNCTION FP_FEC_TASA_US RETURN NUMBER IS 
      V_RET  NUMBER;
      CURSOR CUR_TASA_US IS 
      SELECT CT.COT_TASA
        FROM STK_COTIZACION CT 
       WHERE CT.COT_EMPR    =   AP.V('P_EMPRESA') 
         AND CT.COT_FEC     =   TO_DATE( AP.V('P48_PED_FECHA'), 'DD/MM/YYYY' )  
         AND CT.COT_MON     =   2
      ;  
  BEGIN
      FOR R IN CUR_TASA_US LOOP 
          V_RET := R.COT_TASA;
      END LOOP;
      RETURN V_RET;
  END;   
  --========================================================================    
  FUNCTION FP_EXIS_ARTICULO(I_EMPR IN NUMBER, I_ART_COD IN NUMBER) RETURN BOOLEAN IS 
      
  BEGIN       
      
      R_ARTICULO             := NULL;      
      
      FOR R IN CUR_ARTICULO(I_EMPR, I_ART_COD) LOOP 
          R_ARTICULO             := R;
      END LOOP;
      
      IF R_ARTICULO.ART_CODIGO IS NOT NULL THEN 
         RETURN       TRUE; 
      ELSE 
         RETURN      FALSE;     
      END IF;
      
  END ;
  
  --===========================================================================
  function get_disp_venta(in_art  in  number,
                          in_emp  in  number        
                          ) return number is
    l_r number;
    l_pend_entrega number;
    l_pend_recep   number;
    l_dep_exis     number;
  begin
    select nvl(ped.PED_CANT_PEND_ENTREG, 0),
           nvl(ped.PED_CANT_PEND_RECEP, 0)
    into l_pend_entrega,
         l_pend_recep
    from STK_STKL076_V ped
    inner join  STK_ARTICULO ar on (ar.art_codigo = ped.PED_ART_COD)
    where ar.art_codigo = in_art
    and   ar.art_empr = in_emp
    and   ar.art_tipo <> 4;

    select sum(dep.arde_cant_act)
    into      l_dep_exis
    from STK_ARTICULO_DEPOSITO dep
    where dep.arde_empr = in_emp
    and   dep.arde_art = in_art;
    
    l_r := (l_pend_recep + l_dep_exis) - l_pend_entrega;
    
    return l_r;
  exception
    when no_data_found then
      return 0;
  end get_disp_venta;   
  --===============================================================================
  -- 02/07/2022 10:50:21 @PabloACespedes \(^-^)/
  -- valida si el usuario puede modificar el pedido
  -- se_agrego en por necesidad, pactado en la reunion
  -- del 02/07/2022 10:30 AM. FLORIAN
  function user_modify_unavailability return boolean
  is
    l_c number;
  begin
   select distinct 1
   into   l_c
   from gen_operador_empresa oe
   inner join gen_operador o on (o.oper_codigo = oe.opem_oper)
   where oe.opem_empr = ap.v(p_item => 'P_EMPRESA')
   and   o.oper_login = ap.v(p_item => 'APP_USER')
   and   nvl(oe.opem_ind_mod_ped_insum, 'N') = 'S';
  
   return true;
    
  exception
    when no_data_found then
      return false;
  end user_modify_unavailability;
  
  -----------
  procedure val_new_sales_det as
    col_name_det varchar2(25) := 'FACI240_DE';
    l_disp_venta number;
    l_empresa    constant number := ap.v(p_item => 'P_EMPRESA');
  begin
      <<f_det_col>>
      for i in (
            SELECT sum( to_number( nvl(c.c010, '0') ) ) total,
                   to_number( c.c004 )                  articulo
              FROM APEX_collections c
             WHERE c.collection_name = col_name_det
             group by c.c004
      )loop
        l_disp_venta := get_disp_venta(in_art => i.articulo, in_emp => l_empresa);

        if l_disp_venta < i.total then
          raise_Application_error(-20001, 'El Total Disponible es menor a lo solicitado. 
                                           Art'||chr(237)||'culo C'||chr(243)||'digo: '||i.articulo||' Disponible: '||l_disp_venta);
        else
          null;
        end if;
            
       end loop f_det_col;
  end val_new_sales_det;
  --============================================================================
  procedure validate_disp_venta as
  l_existencia number;
  begin
    l_existencia := get_disp_venta(in_art => AP.V( 'P48_ART_CODIGO' ) , in_emp => AP.V( 'P_EMPRESA'));
    
    if l_existencia < AP.GETNC('P48_CANT_PED') then
      raise_application_error(-20001, 'No puede cargar mas de lo disponible para venta. Total Disponible: '||l_existencia);
    end if;
  end;
  --======================================================================================        
  
  PROCEDURE PP_BUSCAR_PRECIO_MP IS 
       ------------------------------------------------------------------
       V_EMPRESA     NUMBER ; 
       V_ARTICULO    NUMBER ; 
       V_DEC_MD      NUMBER ; 
       ------------------------------------------------------------------
        CURSOR CUR_COTIZ IS 
        SELECT CT.COT_MON      COT_MON  , 
               COT_TASA        COT_TASA 
          FROM STK_COTIZACION CT 
         WHERE CT.COT_EMPR   =   AP.V( 'P_EMPRESA'   )
           AND CT.COT_MON    =   AP.V( 'P48_PED_MON' )
           AND CT.COT_FEC    =   TO_DATE( AP.V( 'P48_PED_FECHA' ) )
           ;
        --- 
        R_COTIZ CUR_COTIZ%ROWTYPE ; 
        ------------------------------------------------------------------
        V_PRECIO_VTA     NUMBER              ; 
        V_PRECIO_MIN     NUMBER              ; 
        V_PRECIO_MAX     NUMBER              ; 
        V_MON_PED        NUMBER              ; 
        V_TASA_US        NUMBER              ;        
        
        ------------------------------------------------------------------
  BEGIN
       
       --------------------------------------------------------------------------------- 
       V_ARTICULO  :=   AP.V( 'P48_ART_CODIGO'  ) ; 
       V_DEC_MD    :=   AP.V( 'P48_MON_DEC_IMP' ) ; 
       V_MON_PED   :=   AP.V( 'P48_PED_MON'     ) ; 
       --------------------------------------------------------------------------------- 
       R_PRECIO    :=   NULL;
       FOR R IN CUR_PRECIO LOOP 
           R_PRECIO := R ; 
       END LOOP;        
       --------------------------------------------------------------------------------- 
       IF R_PRECIO.AREM_PRECIO_VTA IS NOT NULL THEN 
          
          IF R_PRECIO.AREM_MON  = V_MON_PED THEN 
             V_PRECIO_VTA   :=  R_PRECIO.AREM_PRECIO_VTA  ; 
             V_PRECIO_MIN   :=  R_PRECIO.AREM_PRECIO_MIN  ;
             V_PRECIO_MAX   :=  R_PRECIO.AREM_PRECIO_MAX  ;             
          END IF;
          
          IF R_PRECIO.AREM_MON  <> V_MON_PED THEN              
             --------
             V_TASA_US := FP_FEC_TASA_US  ;             
             IF V_TASA_US IS NULL THEN 
                V_TASA_US := FP_MON_TASA_US; 
             END IF;
             --------
             IF R_PRECIO.AREM_MON   =   V_MON_LOC AND 
                V_MON_PED           =   V_MON_USD  
             THEN 
                V_PRECIO_VTA   :=  ROUND(R_PRECIO.AREM_PRECIO_VTA / V_TASA_US, V_DEC_MD)  ;
                V_PRECIO_MIN   :=  ROUND(R_PRECIO.AREM_PRECIO_MIN / V_TASA_US, V_DEC_MD)  ; 
                V_PRECIO_MAX   :=  ROUND(R_PRECIO.AREM_PRECIO_MAX / V_TASA_US, V_DEC_MD)  ;                              
             END IF ;  
             --------
             IF R_PRECIO.AREM_MON   =   V_MON_USD AND 
                V_MON_PED           =   V_MON_LOC  
             THEN 
                V_PRECIO_VTA   :=  ROUND(R_PRECIO.AREM_PRECIO_VTA * V_TASA_US, V_DEC_MD)  ; 
                V_PRECIO_MIN   :=  ROUND(R_PRECIO.AREM_PRECIO_MIN * V_TASA_US, V_DEC_MD)  ; 
                V_PRECIO_MAX   :=  ROUND(R_PRECIO.AREM_PRECIO_MAX * V_TASA_US, V_DEC_MD)  ;                 
             END IF ;  
             --------             
          END IF;
          
       END IF ; 
       
       R_PRECIO.AREM_PREC_VTA_MP :=  V_PRECIO_VTA  ;
       R_PRECIO.AREM_PREC_MIN_MP :=  V_PRECIO_MIN  ;
       R_PRECIO.AREM_PREC_MAX_MP :=  V_PRECIO_MAX  ;              
       ---------------------------------------------------------------------------------       
       -- RAISE_APPLICATION_ERROR(-20001, 'FP_PRECIO_MON_PED.. R_PRECIO.ART_CODIGO = ' || R_PRECIO.ART_CODIGO ); 
       /* 
       RAISE_APPLICATION_ERROR(-20001, 
       'FP_PRECIO_MON_PED.. ' || CHR(10) ||  
          'V_MON_PED = ' || V_MON_PED || CHR(10) || 
          'R_PRECIO.AREM_MON = ' || R_PRECIO.AREM_MON || CHR(10) || 
          'R_PRECIO.ART_CODIGO = ' || R_PRECIO.ART_CODIGO || CHR(10) ||           
          'R_PRECIO.AREM_PRECIO_VTA = ' || R_PRECIO.AREM_PRECIO_VTA -- || CHR(10)          
       ) ; 
       */        
  END;
  ------------------------------------------------------------------------
  FUNCTION FP_EXIST_ART_SUC RETURN NUMBER IS 
      V_RET NUMBER;
  BEGIN
    BEGIN
   SELECT SUM(NVL((ARDE_CANT_ACT), 0))
     INTO V_RET
     FROM STK_ARTICULO_DEPOSITO A, STK_DEPOSITO B
    WHERE A.ARDE_DEP = B.DEP_CODIGO
      AND A.ARDE_EMPR = B.DEP_EMPR
      AND A.ARDE_SUC = B.DEP_SUC
      AND ARDE_EMPR = AP.V('P_EMPRESA')
      AND ARDE_SUC = AP.V('P48_PED_SUC')
      AND ARDE_ART = AP.V('P48_ART_CODIGO')
      AND B.DEP_SUC_TRASLADO IS NOT NULL; 
      EXCEPTION
    WHEN NO_DATA_FOUND THEN
       V_RET := 0;
     END;
       RETURN V_RET ;
  END FP_EXIST_ART_SUC;
  ------------------------------------------------------------------------
  FUNCTION FP_EXIST_ART_SUC (I_SUC NUMBER, I_ART IN NUMBER ) RETURN NUMBER IS 
      V_RET NUMBER;
  BEGIN
      
      SELECT NVL(SUM(ARDE_CANT_ACT),0)
        INTO V_RET
        FROM STK_ARTICULO_DEPOSITO 
       WHERE ARDE_EMPR  = AP.V('P_EMPRESA' )
         AND ARDE_SUC   = I_SUC 
         AND ARDE_ART   = I_ART ;
         
       RETURN V_RET ;      
       
  END FP_EXIST_ART_SUC;  
  ------------------------------------------------------------------------  
  PROCEDURE PP_BUSCAR_ARTICULO IS 
       V_EMPRESA     NUMBER ; 
       V_ARTICULO    NUMBER ; 
       V_DEC_MD      NUMBER ;
       V_PRECIO      NUMBER ;
       V_CANTIDAD    NUMBER ;
       V_IMP_TOTAL   NUMBER ;
       
       l_disp_venta number;
       
  BEGIN
       
       V_EMPRESA   :=   AP.V('P_EMPRESA')          ; 
       V_ARTICULO  :=   AP.V('P48_ART_CODIGO')     ; 
       V_DEC_MD    :=   AP.V('P48_MON_DEC_IMP')    ; 
       V_CANTIDAD  :=   AP.GETNC('P48_CANT_PED')   ; 
       l_disp_venta :=  AP.GETNC('P48_CANT_DISP_VENTA');
       
       IF FP_EXIS_ARTICULO( V_EMPRESA, V_ARTICULO ) THEN 
          
           PP_BUSCAR_PRECIO_MP ; 
           
           V_PRECIO                     :=    R_PRECIO.AREM_PREC_VTA_MP; -- FP_PRECIO_MON_PED;         
           V_IMP_TOTAL                  :=    ROUND(V_IMP_TOTAL * V_PRECIO, V_DEC_MD)    ;
                      
           AP.SV('P48_ART_IMPU'        , R_ARTICULO.ART_IMPU        ) ; 
           AP.SV('P48_IMPU_PORC'       , R_ARTICULO.IMPU_PORC       ) ; 
           AP.SV('P48_IMPU_PORC_DESC'  , R_ARTICULO.IMPU_PORC_DESC  ) ; 
           AP.SV('P48_ART_UN_MED'      , R_ARTICULO.ART_UNID_MED    ) ; 
           AP.SV('P48_PRECIO_UN'       , V_PRECIO                   ) ; 
           AP.SV('P48_IMP_TOT_DETA'    , V_IMP_TOTAL                ) ;            
           
           -- AE.AREM_MON                AREM_MON            ; 
           -- AE.AREM_PRECIO_VTA         AREM_PRECIO_VTA     ; 
           
           
           AP.SV('P48_CANT_EXIST'    , FP_EXIST_ART_SUC             ) ;  
           
           AP.SV('P48_CANT_DISP_VENTA'  , get_disp_venta(in_art => V_ARTICULO, in_emp => V_EMPRESA ) ) ; 
           
           
       ELSE
           
           AP.SV('P48_IMPU_PORC'     , NULL                 ) ; 
           AP.SV('P48_ART_UN_MED'    , NULL                 ) ; 
           AP.SV('P48_PRECIO_UN'     , NULL                 ) ; 
           AP.SV('P48_IMP_TOT_DETA'  , NULL                 ) ; 
           AP.SV('P48_CANT_DISP_VENTA'  , NULL                 ) ; 
       END IF;
              
  END;
  --======================================================================================  
  PROCEDURE PP_VALIDAR_PRECIO IS
      V_PRECIO          NUMBER  ; 
  BEGIN
      
      PP_BUSCAR_PERMISO_OPER ; 
      
      V_PRECIO         :=  NVL(AP.GETNC('P48_PRECIO_UN'),0)  ; 
      
      IF R_OPER.OPER_EDITAR_PRE = 'N' THEN 
         
         PP_BUSCAR_PRECIO_MP ; 
          
         IF R_PRECIO.ART_CODIGO IS NULL THEN 
            RAISE_APPLICATION_ERROR( -20001,  'Error al buscar el precio del articulo. PP_VALIDAR_PRECIO!');          
         END IF;
          
         IF V_PRECIO > R_PRECIO.AREM_PREC_MAX_MP AND R_PRECIO.AREM_PREC_MAX_MP > 0 THEN 
            RAISE_APPLICATION_ERROR( -20001,  'Precio de Venta no puede ser MAYOR A ' || 
                                               UT.GETNUMFM(R_PRECIO.AREM_PREC_MAX_MP, 2) 
                                    );  
         END IF;
          
         IF V_PRECIO < R_PRECIO.AREM_PREC_MIN_MP AND R_PRECIO.AREM_PREC_MIN_MP > 0 THEN 
             RAISE_APPLICATION_ERROR( -20001,  'Precio de Venta no puede ser MENOR A ' || 
                                               UT.GETNUMFM(R_PRECIO.AREM_PREC_MIN_MP, 2) 
                                    );           
         END IF;
         
      END IF;
      
      /*      
      RAISE_APPLICATION_ERROR( -20001,  'PP_VALIDAR_PRECIO: ' || CHR(10) || 
                                         'P48_PED_MON = ' ||  AP.V('P48_PED_MON') || CHR(10) || 
                                         'AREM_MON  = ' ||  R_PRECIO.AREM_MON || CHR(10) || 
                                         
                                         'ART_DESC = ' ||  R_PRECIO.ART_DESC || CHR(10) || 
                                         'AREM_PRECIO_MIN  = ' ||  R_PRECIO.AREM_PRECIO_MIN || CHR(10) || 
                                         'AREM_PRECIO_MAX  = ' ||  R_PRECIO.AREM_PRECIO_MAX || CHR(10) || 
                                         'AREM_PREC_MIN_MP = ' ||  R_PRECIO.AREM_PREC_MIN_MP || CHR(10) || 
                                         'AREM_PREC_MAX_MP = ' ||  R_PRECIO.AREM_PREC_MAX_MP 
                             ) ; 
      */ 
            
  END PP_VALIDAR_PRECIO;
  --======================================================================================  
  PROCEDURE PP_BUSCAR_LINEA_DISP IS
      ---------------------------------------------------------------------------------------
      CURSOR CUR_LINEA IS 
      SELECT LC.LINC_CLAVE               LINC_CLAVE      , 
             LC.LINC_PERSONA             LINC_PERSONA    ,
             NVL(LC.LINC_ESTADO, 'A')    LINC_ESTADO     , 
             PD.PROD_FECVTO_FAC_IN       PROD_VTO_LINEA  
             -- NVL(LC.LINC_FEC_LIM_OPER)   
             
        FROM ACO_PRODUCTO      PD , 
             FIN_LINEA_CREDITO LC 
       WHERE PD.PROD_EMPR     =     LC.LINC_EMPR             
         AND PD.PROD_CLAVE    =     LC.LINC_COSECHA          
         AND LC.LINC_EMPR     =     AP.V( 'P_EMPRESA'        ) 
         AND LC.LINC_PERSONA  =     AP.V( 'P48_PED_CLI'      ) 
         AND LC.LINC_COSECHA  =     AP.V( 'P48_PED_PRODUCTO' ) 
      ;
      R_LINEA      CUR_LINEA%ROWTYPE    ; 
      V_IMP_DISP   NUMBER               ; 
      
  BEGIN
       
       ---------------------------------------------------------------------------------------
       IF AP.V( 'P48_PED_CLI')       IS NOT NULL AND 
          AP.V( 'P48_PED_PRODUCTO' ) IS NOT NULL AND 
          AP.V( 'P48_PED_MON')       IS NOT NULL           
       THEN
          

          -------
          FOR R IN CUR_LINEA LOOP 
              R_LINEA := R ; 
          END LOOP; 
          -------
          V_IMP_DISP := 0 ; 
          -------
          /* 
          RAISE_APPLICATION_ERROR(-20001, 'PP_BUSCAR_LINEA_DISP.' || CHR(10) || 
                                          'P48_PED_CLI = > ' || AP.V( 'P48_PED_CLI') || CHR(10) || 
                                          'P48_PED_PRODUCTO = > ' || AP.V( 'P48_PED_PRODUCTO') || CHR(10) || 
                                          'P48_PED_MON = > ' || AP.V( 'P48_PED_MON') || CHR(10) ||     
                                          'LINC_CLAVE = > ' || R_LINEA.LINC_CLAVE || CHR(10) -- ||                                           
                                                                                                                          
                                 ); 
          */                                 
          -- IF R_LINEA.LINC_CLAVE IS NOT NULL THEN 
          IF R_LINEA.LINC_ESTADO  = 'A' THEN 
             
             PK_CU_PERSONA_LC.INICIAR(R_LINEA.LINC_PERSONA, NULL, 'DIA', NULL); 
            
             FIN_IMP_DISP_LINEA(  IN_NRO_LIN_CRED   =>    R_LINEA.LINC_CLAVE       , 
                                  IN_CONCEPTO_CRE   =>    2                        , 
                                  IN_MONEDA_REQ     =>    AP.V('P48_PED_MON')      , 
                                  OU_IMPORTE        =>    V_IMP_DISP               , 
                                  IN_EMPRESA        =>    AP.V('P_EMPRESA')        
                                );     
          END IF; 
          -- 1)Anticipo; 2)Venta Insumo; 3) Venta Combustible; 4)Venta Otros Rubros;   
          -------
       ELSE 
          V_IMP_DISP := 0 ; 
          -- RAISE_APPLICATION_ERROR(-20001, 'PP_BUSCAR_LINEA_DISP.02');           
       END IF; 
       ---------------------------------------------------------------------------------------
       AP.SV('P48_IMP_DISP_LINEA', V_IMP_DISP ) ;                
       ---------------------------------------------------------------------------------------     
  END;
  --======================================================================================  
  
  FUNCTION FP_CAB_TAB RETURN CAB_RT IS 
          
  BEGIN
        
        -- RAISE_APPLICATION_ERROR(-20001, 'P48_PED_CLAVE ' || AP.V('P48_PED_CLAVE') ); 
                           
        X_CAB                               :=               NULL                              ; 
        X_CAB.PED_EMPR                      :=               AP.V('P_EMPRESA')                 ; 
        X_CAB.PED_SUC                       :=               AP.V('P48_PED_SUC')               ; 
        X_CAB.PED_CLAVE                     :=               AP.V('P48_PED_CLAVE')             ; 
        X_CAB.PED_NRO                       :=               AP.V('P48_PED_NRO')               ; 
        
        X_CAB.PED_FECHA                     :=               AP.V('P48_PED_FECHA')             ; 
        X_CAB.PED_FEC_PEDIDO                :=               AP.V('P48_PED_FECHA')             ; 
        X_CAB.PED_FEC_ENTREG_REQ            :=               AP.V('P48_PED_FEC_ENTREG_REQ')    ; 
        
        X_CAB.PED_MON                       :=               AP.V('P48_PED_MON')               ; 
        X_CAB.PED_CLI                       :=               AP.V('P48_PED_CLI')               ; 
        X_CAB.PED_CLI_RUC                   :=               AP.V('P48_PED_CLI_RUC')           ; 
        X_CAB.PED_CLI_TEL                   :=               AP.V('P48_PED_CLI_TEL')           ; 
        X_CAB.PED_CLI_CONTACTO              :=               AP.V('P48_PED_CLI_CONTACTO')      ; 
        X_CAB.PED_VENDEDOR                  :=               AP.V('P48_PED_VENDEDOR')          ; 
        
        X_CAB.PED_TIPO_FAC                  :=               AP.V('P48_PED_TIPO_FAC')          ; 
        X_CAB.PED_COND_VENTA                :=               AP.V('P48_PED_COND_VENTA')        ; 
        X_CAB.PED_LUGAR_ENTREGA             :=               AP.V('P48_PED_LUGAR_ENTREGA')     ; 
        
        X_CAB.PED_MONTO_BONO_ASIG           :=               NVL(AP.GETNC('P48_PED_MONTO_BONO_ASIG'),0)   ; 
        ---- 
        X_CAB.PED_PRODUCTO                  :=               AP.GETNC( 'P48_PED_PRODUCTO')      ;  
        X_CAB.PED_OBS                       :=               AP.V('P48_PED_OBS')                ; 
        X_CAB.PED_IMP_TOTAL_MON             :=               AP.GETNC( 'P48_PED_IMP_TOTAL_MON') ; 

        -- X_CAB.PED_IMP_FACTURADO             :=               AP.GETNC( 'P48_PED_IMP_FACTURADO');
                
        RETURN X_CAB;
        
  END;  
  --====================================================================================== 
  FUNCTION FP_DETA_TAB RETURN DETA_TT IS 
       I                   NUMBER   ; 
       X_REC               DETA_RT  ; 
       X_TAB               DETA_TT  ; 
       
      CURSOR CUR_DETA IS 
      SELECT SEQ_ID                 SEQ_ID            , 
             C001                   DETA_EMPR         ,
             C002                   DETA_CLAVE_PED    , 
             C003                   DETA_ITEM         ,
             
             C004                   DETA_ART_COD      , 
             C005                   DETA_ART_DESC     , 
             C006                   DETA_UN_MED       , 
                          
             C007                   DETA_ART_IMPU     , 
             C008                   DETA_IMPU_PORC    , 
             C009                   DETA_IMPU_PORC_D  ,        
             
             C010                   DETA_CANT_PED     ,
             C011                   DETA_CANT_FAC     ,
             C012                   DETA_CANT_PEN_F   ,

             C020                   DETA_PRECIO_S     ,    -- 20
             C021                   DETA_IMP_TT_S     ,    -- 21 
                                       
             C040                   DETA_PRECIO       ,    -- 20
             C041                   DETA_IMP_TT       ,    -- 21 
             
             C022                   DETA_OBS            
             
        FROM APEX_collections
       WHERE collection_name = 'FACI240_DE' 
         AND NVL(C049,'X')   <> 'E' ;
                  
  BEGIN
        
       X_TAB  := FACI240_D.DET_TT();                        
                    
       FOR R IN CUR_DETA LOOP 
           
           -- 
           /*
           V_MENSAJE := 'R.DETA_PRECIO_S = ' || R.DETA_PRECIO_S || '   # ' || 
                        'R.DETA_PRECIO   = ' || R.DETA_PRECIO
                        ;
           RAISE_APPLICATION_ERROR(-20001, V_MENSAJE ); 
           */                              
           -- 
           X_REC.PDET_EMPR            :=    R.DETA_EMPR                   ;
           X_REC.PDET_CLAVE_PED       :=    R.DETA_CLAVE_PED              ;
           X_REC.PDET_NRO_ITEM        :=    R.DETA_ITEM                   ;
           X_REC.PDET_ART             :=    R.DETA_ART_COD                ;
           X_REC.PDET_UM_PED          :=    R.DETA_UN_MED                 ;
           X_REC.PDET_COD_IMPU        :=    R.DETA_ART_IMPU               ;
           
           X_REC.PDET_CANT_PED        :=    UT.GETNC(R.DETA_CANT_PED)     ; 
           X_REC.PDET_PRECIO          :=    UT.GETNC(R.DETA_PRECIO)       ; 
           X_REC.PDET_IMP_NETO_DET    :=    UT.GETNC(R.DETA_IMP_TT)       ; 
           X_REC.PDET_IMP_NETO_FINAL  :=    UT.GETNC(R.DETA_IMP_TT)       ; 
           X_REC.PDET_CANT_FACT       :=    UT.GETNC(R.DETA_CANT_FAC)     ; 
           
           X_REC.PDET_DESC_LARGA      :=    R.DETA_OBS                ;

           X_TAB.EXTEND();
           I                              :=       X_TAB.COUNT()       ;   
           
           X_TAB(I)                       :=       X_REC               ;      
                      
           /*         
           V_IMP_DETA                     :=       ROUND( R.DETA_CANTIDAD * R.DETA_PRECIO, V_DEC_MD ) ;             
           X_TAB(I).DETA_IMPORTE          :=       V_IMP_DETA          ;           
           */ 
           
       END LOOP;
       
       RETURN X_TAB ; 
       
                    
  END;
  --====================================================================================== 
  FUNCTION FP_DETA_ELIM_TAB RETURN DETA_TT IS 
       I                   NUMBER   ; 
       X_REC               DETA_RT  ; 
       X_TAB               DETA_TT  ; 
       
      CURSOR CUR_DETA IS 
      SELECT SEQ_ID                 SEQ_ID            , 
             C001                   DETA_EMPR         ,
             C002                   DETA_CLAVE_PED    , 
             C003                   DETA_ITEM         ,
             
             C004                   DETA_ART_COD      , 
             C005                   DETA_ART_DESC     , 
             C006                   DETA_UN_MED       , 
                          
             C007                   DETA_ART_IMPU     , 
             C008                   DETA_IMPU_PORC    , 
             C009                   DETA_IMPU_PORC_D  ,        
             
             C010                   DETA_CANT_PED     ,
             C011                   DETA_CANT_REC     ,
             C012                   DETA_CANT_PEN_R   ,

             C013                   DETA_CANT_FAC     ,
             C014                   DETA_CANT_PEN_F   ,
             
             C040                   DETA_PRECIO       ,    -- 20
             C041                   DETA_IMP_TT       ,    -- 21 
             
             C022                   DETA_OBS            
             
        FROM APEX_collections
       WHERE collection_name = 'FACI240_DE' 
         AND NVL(C049,'X')   = 'E' ;
                       
  BEGIN
       
       X_TAB  := FACI240_D.DET_TT();
       
       
       
       FOR R IN CUR_DETA LOOP 
           
           -- 
           X_REC.PDET_EMPR            :=    R.DETA_EMPR                   ;
           X_REC.PDET_CLAVE_PED       :=    R.DETA_CLAVE_PED              ;
           X_REC.PDET_NRO_ITEM        :=    R.DETA_ITEM                   ;
           X_REC.PDET_ART             :=    R.DETA_ART_COD                ;
           X_REC.PDET_UM_PED          :=    R.DETA_UN_MED                 ;
           X_REC.PDET_COD_IMPU        :=    R.DETA_ART_IMPU               ;
           
           X_REC.PDET_CANT_PED        :=    UT.GETNUM(R.DETA_CANT_PED  , ','  ) ; 
           X_REC.PDET_PRECIO          :=    UT.GETNUM(R.DETA_PRECIO    , ','  ) ; 
           X_REC.PDET_IMP_NETO_DET    :=    UT.GETNUM(R.DETA_IMP_TT    , ','  ) ; 
           X_REC.PDET_IMP_NETO_FINAL  :=    UT.GETNUM(R.DETA_IMP_TT    , ','  ) ; 
                      
           X_REC.PDET_DESC_LARGA      :=    R.DETA_OBS                ;

           X_TAB.EXTEND();
           I                              :=       X_TAB.COUNT()       ;   
           
           X_TAB(I)                       :=       X_REC               ;      
                      
           /*         
           V_IMP_DETA                     :=       ROUND( R.DETA_CANTIDAD * R.DETA_PRECIO, V_DEC_MD ) ;             
           X_TAB(I).DETA_IMPORTE          :=       V_IMP_DETA          ;           
           */ 
           
       END LOOP;
       
       RETURN X_TAB;
                    
  END;
  --====================================================================================== 
  FUNCTION FP_IMP_TT_DOCU RETURN NUMBER IS 
      T_DETA        DETA_TT             ; 
      V_RET         NUMBER              ; 
      V_MENSAJE     VARCHAR2(2000)      ;     
      X             FACI240_D.DET_RT    ;  
  BEGIN  
      
      T_DETA     :=    FACI240_D.DET_TT() ; 
      T_DETA     :=    FP_DETA_TAB        ; 
      V_RET      :=    0                  ; 
      
      --RAISE_APPLICATION_ERROR(-20001, 'FP_IMP_TT_DOCU: T_DETA.COUNT = ' || T_DETA.COUNT );      
      
      V_MENSAJE  := 'T_DETA = ' || chr(13)                 ;  
      FOR I IN 1..T_DETA.COUNT LOOP 
          V_RET      := V_RET +  T_DETA(I).PDET_IMP_NETO_DET ;
          X          := T_DETA(I);
          V_MENSAJE  := V_MENSAJE                          || 
                        'Seq '                             || i || '; ' || 
                        'Articulo = '                      || x.pdet_art  || '; ' || 
                        'Item = '                          || X.PDET_NRO_ITEM || '; '  || 
                        'Importe = '                       || X.PDET_IMP_NETO_DET || chr(13) ;
          
      END LOOP;
      -- V_MENSAJE := V_MENSAJE || ' #V_RET = ' || V_RET ;       
      --RAISE_APPLICATION_ERROR(-20001, V_MENSAJE );   
      RETURN V_RET;
      
  END;  
  --======================================================================================   
  PROCEDURE PP_CALC_TT_DETA IS 
      T_DETA        DETA_TT             ; 
      X             DETA_RT             ;
      V_M           VARCHAR2(2000)      ;      
  BEGIN  
      
      V_DEC_MD   :=    NVL(AP.GETNC('P48_MON_DEC_IMP'),0);      
      T_DETA     :=    FACI240_D.DET_TT() ; 
      T_DETA     :=    FP_DETA_TAB        ; 
      
      R_DETA_TT.IMP_TT_PED      :=     0    ; 
      R_DETA_TT.IMP_TT_FAC      :=     0    ; 
      R_DETA_TT.IMP_TT_PEN_F    :=     0    ; 
      
      FOR I IN 1..T_DETA.COUNT LOOP 
          
          X                         :=     T_DETA(I);
          R_DETA_TT.IMP_TT_PED      :=     R_DETA_TT.IMP_TT_PED + X.PDET_IMP_NETO_DET     ; 
                                                          
          R_DETA_TT.IMP_TT_FAC      :=     R_DETA_TT.IMP_TT_FAC + 
                                           ROUND( NVL(X.PDET_CANT_FACT,0) * 
                                                  NVL(X.PDET_PRECIO,0) , 
                                                  0 -- NVL(V_DEC_MD,0)  
                                                )   ;  
          
          R_DETA_TT.IMP_TT_PEN_F    :=     R_DETA_TT.IMP_TT_PED  -  R_DETA_TT.IMP_TT_FAC       ; 
          
      END LOOP;

      --RAISE_APPLICATION_ERROR(-20001, V_M ); 
          /*
          V_M := V_M || 
          'Seq '                             || i || '; ' || 
          'Articulo = '                      || x.pdet_art  || '; ' || 
          'Item = '                          || X.PDET_NRO_ITEM || '; '  || 
          'Cant.Ped = '                      || X.PDET_CANT_PED || '; '  || 
          'Cant.Fac = '                      || X.PDET_CANT_FAC || '; '  || 
          'Imp. Fac = '                      || ROUND( NVL(X.PDET_CANT_FAC,0) * NVL(X.PDET_PRECIO,0) , 0  )   
          || chr(13) 
          */
                                                -- NVL(V_DEC_MD,0)
          --'Importe = '                       || X.PDET_IMP_TOTAL                     
                                                      
                            
      /*
         V_M := '#R_DETA_TT.IMP_TT_PED = ' || R_DETA_TT.IMP_TT_PED || CHR(13) || 
                '#R_DETA_TT.IMP_TT_FAC = ' || R_DETA_TT.IMP_TT_FAC -- || CHR(13) || 
         ;
           */     
                 
      -- V_MENSAJE  := 'T_DETA = ' || chr(13)                 ;                                
      --RAISE_APPLICATION_ERROR(-20001, 'FP_IMP_TT_DOCU: T_DETA.COUNT = ' || T_DETA.COUNT );   
      -- V_MENSAJE := V_MENSAJE || ' #V_RET = ' || V_RET ;       
      --RAISE_APPLICATION_ERROR(-20001, V_MENSAJE );   
      /*
          X          := T_DETA(I);
          V_MENSAJE  := V_MENSAJE                          || 
                        'Seq '                             || i || '; ' || 
                        'Articulo = '                      || x.pdet_art  || '; ' || 
                        'Item = '                          || X.PDET_NRO_ITEM || '; '  || 
                        'Importe = '                       || X.PDET_IMP_TOTAL || chr(13) ;
      */
      
  END;  
  --======================================================================================     
  PROCEDURE PP_BUSCAR_CLIENTE IS
      CURSOR CUR_CLI IS 
      SELECT CL.CLI_CODIGO           CLI_CODIGO           , 
             CL.CLI_NOM              CLI_NOMBRE           , 
             CL.CLI_NOM              
             || ' [' || 
             CL.CLI_CODIGO || ']'
                                     CLI_NOMBRE_L         , 
             CL.CLI_PERS_CONTACTO    CLI_PERS_CONTACTO    , 
             CL.CLI_TEL              CLI_TEL              ,  
             CL.CLI_RUC              CLI_RUC              ,
             
             VE.VEND_LEGAJO          VEND_LEGAJO          , 
             VE.VEND_NOMBRE          VEND_NOMBRE          
             
        FROM FAC_VENDEDOR_AM_V  VE ,    
             FIN_PERSONA        PE , 
             FIN_CLIENTE        CL 
       WHERE VE.VEND_EMPR(+)    =    PE.PNA_EMPR
         AND VE.VEND_LEGAJO(+)  =    PE.PNA_VENDEDOR
         AND PE.PNA_EMPR        =    CL.CLI_EMPR          
         AND PE.PNA_CODIGO      =    CL.CLI_CODIGO        
         AND CL.CLI_EMPR        =    AP.V('P_EMPRESA')    
         AND CL.CLI_CODIGO      =    AP.V('P48_PED_CLI')  
       ; 
       
       R_CLI        CUR_CLI%ROWTYPE   ; 
       V_PED_CLI    NUMBER            ; 
       
  BEGIN

      V_PED_CLI  := AP.V('P48_PED_CLI') ;

     -- RAISE_APPLICATION_ERROR(-20001, 'XXX-1..P48_PED_CLI ' || V_PED_CLI );
           
      IF V_PED_CLI IS NULL THEN 
        RAISE_APPLICATION_ERROR(-20001,'Cliente no puede ser nulo!');
      END IF;
      
      FOR R IN CUR_CLI LOOP 
          R_CLI := R;
      END LOOP;      
      
      IF R_CLI.CLI_CODIGO IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'Cliente Inexistente! Codigo: ' || V_PED_CLI );
      END IF;      
      
      AP.SV('P48_PED_CLI'          , R_CLI.CLI_CODIGO          ) ; 
      AP.SV('P48_CLI_NOMBRE'       , R_CLI.CLI_NOMBRE          ) ; 
      AP.SV('P48_PED_CLI_CONTACTO' , R_CLI.CLI_PERS_CONTACTO   ) ; 
      AP.SV('P48_PED_CLI_TEL'      , R_CLI.CLI_TEL             ) ; 
      AP.SV('P48_PED_CLI_RUC'      , R_CLI.CLI_RUC             ) ;       
      
      AP.SV('P48_PED_VENDEDOR'     , R_CLI.VEND_LEGAJO         ) ; 
      AP.SV('P48_VEND_NOMBRE'      , R_CLI.VEND_NOMBRE         ) ; 
      
  END; 
  
  --======================================================================================  
  PROCEDURE PP_BUSCAR_VENDEDOR IS
      CURSOR CUR_VEND IS 
      SELECT VE.VEND_LEGAJO          VEND_LEGAJO          , 
             VE.VEND_NOMBRE          VEND_NOMBRE          , 
             VE.VEND_NOMBRE
             || ' [' || 
             VE.VEND_LEGAJO || ']'
                                     VEND_NOMBRE_L        
        FROM FAC_VENDEDOR_AM_V VE 
       WHERE VE.VEND_EMPR    =    AP.V('P_EMPRESA')
         AND VE.VEND_LEGAJO  =    AP.V('P48_PED_VENDEDOR')
       ; 
       R_VEND        CUR_VEND%ROWTYPE  ;  
       V_PED_VEND    NUMBER            ;   
  BEGIN
  
      V_PED_VEND  := AP.V('P48_PED_VENDEDOR') ;
      
      IF V_PED_VEND IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'Vendedor no puede ser nulo!');
      END IF;
      
      FOR R IN CUR_VEND LOOP 
          R_VEND := R;
      END LOOP;
      
      IF R_VEND.VEND_NOMBRE IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'Vendedor inexistente!');
      END IF;
      
      
      AP.SV('P48_PED_VENDEDOR', R_VEND.VEND_LEGAJO  ) ;       
      AP.SV('P48_VEND_NOMBRE' , R_VEND.VEND_NOMBRE  ) ; 
      
      
  END; 
  --======================================================================================
  PROCEDURE PP_BUSCAR_TIPO_FA IS
      V_TIPO_FAC      VARCHAR2(20);
      V_TIPO_FAC_DESC VARCHAR2(20);
  BEGIN
  
      V_TIPO_FAC  := AP.V('P48_PED_TIPO_FAC') ;
       
      IF V_TIPO_FAC IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'Tipo de factura no puede ser nulo!');
      END IF;
      
      IF V_TIPO_FAC NOT IN (1,2) THEN 
         RAISE_APPLICATION_ERROR(-20001,'Tipo de factura debe ser 1 o 2!');
      END IF;
      
      IF V_TIPO_FAC = 1 THEN 
         V_TIPO_FAC_DESC := 'CONTADO' ;
      ELSIF V_TIPO_FAC = 2 THEN 
         V_TIPO_FAC_DESC := 'CREDITO' ;       
      END IF;
      
      AP.SV('P48_PED_TIPO_FAC_DESC', V_TIPO_FAC_DESC ) ;             
      
      
  END; 
  --======================================================================================   
  PROCEDURE PP_BUSCAR_CONTRATO_BONO IS 
    
    V_NRO_CONTRATO      VARCHAR2(30)      ;  
    
    CURSOR CUR_CONTRATO IS 
    SELECT CO.CON_CLAVE    , 
           CO.CON_NRO      ,
           CO.CON_PRODUCTO ,
           CO.CON_MONEDA   
      FROM ACO_CONTRATO CO 
     WHERE CO.CON_EMPR       =   AP.V('P_EMPRESA') 
       AND CO.CON_PROVEEDOR  =   AP.V('P48_PED_CLI')
       /*AND CON_A?O 
           ||'-'||
           CO.CON_NRO        =   V_NRO_CONTRATO
    */;
    
    R_CON CUR_CONTRATO%ROWTYPE ; 
    
   CURSOR CUR_BONO IS 
   SELECT SUM(BO.AB_MONTO)  IMP_BONO 
     FROM ACO_CONTRATO  CT , 
          ACO_FIJACION  FJ , 
          ACO_BONOS     BO 
          
    WHERE CT.CON_EMPR          =     FJ.fij_empr
      and CT.CON_CLAVE         =     FJ.fij_clave_contrato       
      and BO.AB_CLAVE          =     FJ.fij_bono 
      and BO.AB_EMPR           =     FJ.FIJ_EMPR 
      
      and ct.con_empr          =     AP.V('P_EMPRESA')
      and ct.con_clave         =     R_CON.CON_CLAVE
      and NVL(
          BO.AB_ESTADO_INSUMO, 
          'N'
          )                    <>    'C' 
      ;
   
   R_BONO              CUR_BONO%ROWTYPE  ;
   

   CONTRATO_NULO       EXCEPTION         ;
     
  BEGIN

     ------ 
     -- RAISE_APPLICATION_ERROR(-20001, 'PP_BUSCAR_CONTRATO_BONO..! AP.V(P48_PED_MON) = ' || AP.V('P48_PED_MON') );         
     ------ 
     V_NRO_CONTRATO := AP.V('P48_PED_CONTRATO_NRO') ;
     ------ 
     IF V_NRO_CONTRATO IS NULL THEN  
        RAISE CONTRATO_NULO ; 
     END IF;
     ------ 
     IF AP.V('P48_PED_CLI') IS NULL THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Primero debe indicar EL CLIENTE del pedido!');
     END IF;
     ------ 
     IF AP.V('P48_PED_MON') IS NULL THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Primero debe indicar LA MONEDA del pedido!');
     END IF;
     ------      
     IF AP.V('P48_PED_PRODUCTO') IS NULL THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Primero debe indicar LA COSECHA del pedido!');       
     END IF;
     ------ 
     FOR R IN CUR_CONTRATO LOOP 
         R_CON := R;
     END LOOP; 
         
     IF R_CON.CON_CLAVE IS NULL THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Numero de contrato no existe o no corresponde al cliente del pedido!');
     END IF;
     ------
     IF R_CON.CON_PRODUCTO <> AP.V('P48_PED_PRODUCTO') THEN  
        RAISE_APPLICATION_ERROR(-20001, 'Contrato no corresponde a la zafra del pedido!');
     END IF;
     ------
     FOR R IN CUR_BONO LOOP 
         R_BONO := R; 
     END LOOP; 
     ------
     AP.SV('P48_PED_CONTRATO_NRO'    , V_NRO_CONTRATO   ) ; 
     AP.SV('P48_PED_CONTRATO_BONO'   , R_CON.CON_CLAVE  ) ; 
     AP.SV('P48_PED_MONTO_BONO_ASIG' , R_BONO.IMP_BONO  ) ; 
     ------     

  EXCEPTION 
      
      WHEN CONTRATO_NULO THEN    
           AP.SV('P48_PED_CONTRATO_NRO'    , NULL  ) ; 
           AP.SV('P48_PED_CONTRATO_BONO'   , NULL  ) ; 
           AP.SV('P48_PED_MONTO_BONO_ASIG' , NULL  ) ;            
      WHEN OTHERS THEN 
           RAISE_APPLICATION_ERROR(-20001, SQLERRM);

  END;
 --======================================================================================
  PROCEDURE PP_VALIDAR_FECHA IS
    P_EMPRESA                NUMBER     ;
    P_FEC_EMIS               DATE       ;
    V_FEC_INIC_SISTEMA       DATE          ;
    V_FEC_FIN_SISTEMA        DATE          ;
    
  BEGIN

    IF P_FEC_EMIS IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'La fecha no puede ser nulo!');
    END IF;

    BEGIN

      SELECT CONF_PER_ACT_INI, CONF_PER_SGTE_FIN
        INTO V_FEC_INIC_SISTEMA, V_FEC_FIN_SISTEMA
        FROM FIN_CONFIGURACION
       WHERE CONF_EMPR = P_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001,
                                'No fue cargada la tabla de configuracion del sistema de finanzas!.');

    END;

    IF P_FEC_EMIS NOT BETWEEN V_FEC_INIC_SISTEMA AND V_FEC_FIN_SISTEMA THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'Fecha debe estar comprendida en el rango de: ' ||
                              TO_CHAR(V_FEC_INIC_SISTEMA, 'DD/MM/YYYY') ||
                              ' a: ' ||
                              TO_CHAR(V_FEC_FIN_SISTEMA, 'DD/MM/YYYY') || '!');
    END IF;
    GENERAL.PL_VALIDAR_HAB_MES_STK(P_FEC_EMIS,
                                   P_EMPRESA,
                                   GEN_DEVUELVE_USER);
  END PP_VALIDAR_FECHA;
  
  PROCEDURE PP_VALID_REC_CAB IS 
  
  BEGIN
      NULL;
      /*
      IF R_CAB.DOC_SUC IS NULL THEN
         RAISE_APPLICATION_ERROR(-20001,'Sucursal no debe ser nulo.');
      END IF;
      
      IF R_CAB.DOC_DEPO IS NULL THEN
         RAISE_APPLICATION_ERROR(-20001,'Primero debe indicar el Deposito!');
      END IF;
      
      IF R_CAB.DOC_FECHA IS NULL THEN
         RAISE_APPLICATION_ERROR(-20001,'La Fecha no debe ser nulo.');
      END IF;
      
      --PP_VALIDAR_FECHA(  R_CAB.DOC_EMPR , R_CAB.DOC_FECHA ); 
      
      IF FP_TASA_US(R_CAB.DOC_EMPR , R_CAB.DOC_FECHA) IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'Primero ingrese la cotizacion Dolar para fecha ' || to_char(R_CAB.DOC_FECHA, 'dd-mm-yyyy'));         
      END IF;
      -- DOC_OBS
      */ 
      
      -- PP_VALIDAR_FECHA( R_CAB.DOC_EMPR, R_CAB.DOC_FECHA );
      
  END PP_VALID_REC_CAB;       
  --======================================================================================
  PROCEDURE PP_VALIDAR_CAB IS 
      
  BEGIN
       
       /*
       RAISE_APPLICATION_ERROR(-20001,   'P48_PED_CLAVE = '       ||   V_CLAVE_PED     ||  CHR(13) || 
                                         'P48_PED_FECHA = '       ||   V_FECHA         ||  CHR(13) || 
                                         'P48_PED_PRODUCTO = '    ||   V_CLAVE_ZAFRA   ||  CHR(13) || 
                                         'P48_PED_PRODUCTO_2 = '  ||   V_CLAVE_ZAFRA2  
                               ) ; 
       */
      --  NULL;     
        
      IF AP.V('P48_PED_FECHA') IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'Primero debe indicar la Fecha del pedido.');         
      END IF;
      
      --RAISE_APPLICATION_ERROR(-20001,'PP_VALIDAR_CAB. AP.V(P48_PED_CLI) = ' || AP.V('P48_PED_CLI') ); 
      
      IF AP.V('P48_PED_CLI') IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'Primero debe indicar el Cliente del pedido.');         
      END IF;
            
      IF AP.V('P48_PED_MON') IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'Primero debe indicar la Moneda del pedido.');         
      END IF;
      
      /*      
      IF AP.V('P48_PED_PRODUCTO') IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'Primero debe indicar la Zafra!.');         
      END IF;
      */
      
  END PP_VALIDAR_CAB;
  --======================================================================================          
  PROCEDURE PP_CALC_TT_AUXI IS  
      
      V_IMP_TT          NUMBER  ; 
      V_PRECIO          NUMBER  ; 
      V_CANT_PED        NUMBER  ; 

      V_CANT_FAC        NUMBER  ; 
      V_CANT_PEN_FAC    NUMBER  ; 
      
      V_DEC_IMP         NUMBER  ; 
  
                                   
  BEGIN
      
      V_DEC_IMP        :=  NVL(AP.GETNC('P48_MON_DEC_IMP'),0)        ; 
      V_PRECIO         :=  NVL(AP.GETNC('P48_PRECIO_UN'),0)          ;       
      V_CANT_PED       :=  NVL(AP.GETNC('P48_CANT_PED'),0)           ; 
      V_IMP_TT         :=  ROUND(V_CANT_PED  * V_PRECIO, V_DEC_IMP)  ; 
      
      --AP.SV( 'P48_PRECIO_UN'    , AP.V('P48_PRECIO_UN')  );
      AP.SV( 'P48_IMP_TOT_DETA' , V_IMP_TT) ; 
      
      V_CANT_FAC       :=  NVL(AP.GETNC('P48_CANT_FAC'),0)           ; 
      V_CANT_PEN_FAC   :=  V_CANT_PED  - V_CANT_FAC                  ; 
      AP.SV('P48_CANT_PEN_FAC', V_CANT_PEN_FAC)  ; 
                  
      -- RAISE_APPLICATION_ERROR( -20001,  'PP_CALC_TT_AUXI.V_CANT_PEN_FAC=' ||V_CANT_PEN_FAC );    
      /*     
      
      RAISE_APPLICATION_ERROR( -20001,  'PP_CALC_TT_AUXI ' || CHR(13) || 
                                        '# V_CANT_PED = '      ||  V_CANT_PED  || 
                                        '# V_CANT_FAC = '      ||  V_CANT_FAC  ||  
                                        '# V_CANT_PEN_FAC = '  ||  V_CANT_PEN_FAC  
                             ); 
      
      */
                               
  END;
  --======================================================================================  
  PROCEDURE PP_BUSCAR_DEC_MON IS
             
  BEGIN
     
     FOR R IN CUR_MON LOOP 
         R_MON := R;
     END LOOP;

     IF R_MON.MON_CODIGO IS NULL AND AP.V('P48_PED_MON') IS NOT NULL THEN 
        RAISE_APPLICATION_ERROR( -20001, 'Moneda inexistente! Codigo ' || AP.V('P48_PED_MON') );  
     END IF;
          
     AP.SV('P48_MON_DEC_IMP', NVL(R_MON.MON_DEC_IMP,0) );
     AP.SV('P48_MON_DESC'   , R_MON.MON_DESC    );     
     
     
  END;
  --======================================================================================  
  PROCEDURE PP_BUSCAR_ZAFRA IS
      
      V_PED_FECHA   DATE;
      COSECHA_NULO  EXCEPTION;
       
      CURSOR CUR_COSECHA IS 
      SELECT PD.PROD_CLAVE           PROD_CLAVE     , 
             PD.PROD_CODIGO          PROD_CODIGO    ,
             PD.PROD_DESC            PROD_DESC      ,
             PD.PROD_FECVTO_FAC_IN   PROD_VENCIM 
        FROM ACO_PRODUCTO PD 
       WHERE PD.PROD_EMPR    =  AP.V('P_EMPRESA') 
         AND PD.PROD_CODIGO  =  AP.V('P48_PROD_CODIGO') ;         
       
       R_PROD        CUR_COSECHA%ROWTYPE;  

       CURSOR CUR_LINEA IS 
       SELECT LC.LINC_CLAVE         LINC_CLAVE   , 
              LC.LINC_ESTADO        LINC_ESTADO  
         FROM FIN_LINEA_CREDITO LC
        WHERE LC.LINC_EMPR      =  AP.GETNC('P_EMPRESA')  
          AND LC.LINC_PERSONA   =  AP.GETNC('P48_PED_CLI') 
          AND LC.LINC_COSECHA   =  R_PROD.PROD_CLAVE  ; 
       
       R_LIN  CUR_LINEA%ROWTYPE;
       
  BEGIN
     
     --RAISE_APPLICATION_ERROR( -20001, '01' );  
     
     IF AP.V('P48_PROD_CODIGO') IS NULL THEN 
        RAISE COSECHA_NULO;
     END IF;    
     
     IF AP.V('P48_PED_FECHA') IS NOT NULL THEN 
        V_PED_FECHA := TO_DATE(AP.V('P48_PED_FECHA'), 'DD/MM/YYYY') ;
     END IF;      
     
     FOR R IN CUR_COSECHA LOOP 
         R_PROD := R;
     END LOOP;
     
     IF R_PROD.PROD_CLAVE IS NULL THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Zafra inexistente! Codigo ' || AP.V('P48_PROD_CODIGO'));  
     END IF;
       
     IF R_PROD.PROD_VENCIM < V_PED_FECHA THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Zafra vencida para la fecha del pedido '  || 
                                        to_char(V_PED_FECHA, 'dd/mm/yyyy')    ||            
                                        chr(10) || 
                                        ' Producto: ' || r_prod.prod_desc || 
                                        chr(10) || 
                                        'Vencimiento: ' || to_char(r_prod.prod_vencim, 'dd/mm/yyyy')                                         
                               );  
     END IF;
     
     IF AP.V('P48_PED_TIPO_FAC') = 2 THEN 
         
         FOR R IN CUR_LINEA LOOP 
             R_LIN := R;
         END LOOP;
         
         IF R_LIN.LINC_CLAVE IS NULL  THEN 
            RAISE_APPLICATION_ERROR(-20001, 'El cliente ' || AP.V('P48_PED_CLI') || 
                                            ' no posee linea de credito para la cosecha  ' || 
                                            r_prod.prod_desc  
                                            -- ||  CHR(10) || 
                                            -- 'Clave Prod ' || R_PROD.PROD_CLAVE
                                   ) ;   
         END IF;

         IF R_LIN.LINC_ESTADO = 'I' THEN 
            RAISE_APPLICATION_ERROR(-20001, 'Linea de credito inactiva para cliente ' || AP.V('P48_PED_CLI') || ' en cosecha ' || r_prod.prod_desc );  
         END IF; 

         /*
          RAISE_APPLICATION_ERROR(-20001, 
          'P_EMPRESA ' || AP.V('P_EMPRESA') || chr(10) || 
          'P48_PED_CLI ' || AP.V('P48_PED_CLI') || chr(10) || 
          'Clave Prod ' || R_PROD.PROD_CLAVE || chr(10) ||  
          'LINC_CLAVE ' || R_LIN.LINC_CLAVE
          ); 
          */ 
                       
     END IF;
     
     AP.SV('P48_PROD_CODIGO'  , NVL(R_PROD.PROD_CODIGO  , 0 ) ) ;      
     AP.SV('P48_PED_PRODUCTO' , NVL(R_PROD.PROD_CLAVE   , 0 ) ) ; 
     AP.SV('P48_PROD_DESC'    , NVL(R_PROD.PROD_DESC    , 0 ) ) ; 
     AP.SV('P48_PED_VENC'     , R_PROD.PROD_VENCIM            ) ; 
  EXCEPTION 
     WHEN COSECHA_NULO THEN 
          AP.SV('P48_PROD_CODIGO'  , NULL  ) ;      
          AP.SV('P48_PED_PRODUCTO' , NULL  ) ; 
          AP.SV('P48_PROD_DESC'    , NULL  ) ; 
          AP.SV('P48_PED_VENC'     , NULL  ) ; 
  END;
  --======================================================================================    
  PROCEDURE PP_LIMPIAR_AUX IS 
  
  BEGIN
      
      NULL;
      
      -- CL.GUARDAR('FACI240_DE'); 
      
  END PP_LIMPIAR_AUX; 
  --======================================================================================
  PROCEDURE PP_CONFIG_REPORTE IS 
      
      V_URL                 VARCHAR2(100); 
      V_PARAMETROS          VARCHAR2(32767);
      V_IDENTIFICADOR       VARCHAR2(2) := '&'; --SE UTILIZA PARA QUE AL COMPILAR NO LO TOME COMO PARAMETROS
      V_DESC_EMPRESA        VARCHAR2(60);
      
      --( P_EMPRESA IN NUMBER, P_CLAVE IN NUMBER ) IS
      
  BEGIN
      
      -- IMPRESION DE REPORTES.. 
      
      -- V_URL    :=   APEX_UTIL.PREPARE_URL ( P_URL => 'f?p=100:3010:&APP_SESSION.:::::', P_CHECKSUM_TYPE => 'SESSION' ) ; 
      
      
      V_URL    :=   APEX_UTIL.PREPARE_URL ( P_URL => 'f?p=100:3010:' || v('APP_SESSION') ||  ':::::', P_CHECKSUM_TYPE => 'SESSION' ) ; 
      
      /*
      DECLARE
          l_url varchar2(2000);
          l_app number := v('APP_ID');
          l_session number := v('APP_SESSION');
      BEGIN
          l_url := APEX_UTIL.PREPARE_URL(
              p_url => 'f? p=' || l_app || ':1:'||l_session||'::NO::P1_ITEM:xyz',
              p_checksum_type => 'SESSION');
      END;
      */
      
      AP.SV( 'P48_URL_REP'  , V_URL  ) ;
      AP.SV( 'P48_URL_DESC' , 'Imprimir Pedido # ' || X_CAB.PED_NRO ) ; 
      
      BEGIN
          SELECT D.EMPR_RAZON_SOCIAL
            INTO V_DESC_EMPRESA
            FROM GEN_EMPRESA D
           WHERE D.EMPR_CODIGO=X_CAB.PED_EMPR;
      EXCEPTION WHEN OTHERS THEN
           NULL;
      END;
      
      -- APEX_UTIL.get_session_state
      --RAISE_APPLICATION_ERROR(-20001,'PP_CONFIG_REPORTE =>  V_URL : '|| V_URL );
      
      V_PARAMETROS := 'P_FORMATO=' || URL_ENCODE('pdf');
      /*
      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DOC_NRO=' ||
                      URL_ENCODE(P_NRO_DOC);
                      
      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                      URL_ENCODE(P_EMPRESA);

      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_FECHA=' ||
                      URL_ENCODE(P_FECHA);
                      
      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_SUCURSAL=' ||
                      URL_ENCODE(P_SUCURSAL);
                      
      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_OBS=' ||
                      URL_ENCODE(P_OBS);
                      
      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DEPOSITO=' ||
                      URL_ENCODE(P_DEPOSITO);
       */     
                 
       V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                      URL_ENCODE(X_CAB.PED_EMPR);
                             
       V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                      URL_ENCODE(X_CAB.PED_CLAVE);
      
       V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_PROGRAMA=' ||
                      URL_ENCODE('FACI240');
                                            
      /*                
      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DESC_EMPRESA=' ||
                      URL_ENCODE(V_DESC_EMPRESA) 
      */                
      --;
      
      DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = GEN_DEVUELVE_USER;
      
      INSERT INTO GEN_PARAMETROS_REPORT
             ( PARAMETROS    ,  USUARIO           , NOMBRE_REPORTE   , FORMATO_SALIDA )
      VALUES ( V_PARAMETROS  ,  GEN_DEVUELVE_USER , 'FACI240'        , 'pdf'   );      
      
  EXCEPTION
      WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20001, SQLERRM);
                      
  END PP_CONFIG_REPORTE ; 
  --======================================================================================    
  PROCEDURE PP_CONFIG_REP  IS     
  BEGIN
      
      X_CAB.PED_EMPR   :=   AP.V('P48_PED_EMPR');
      X_CAB.PED_CLAVE  :=   AP.V('P48_PED_CLAVE');      
      PP_CONFIG_REPORTE;
      
  END;
  --======================================================================================  
  PROCEDURE PP_CARGAR_PED_DETA IS             
      
      
      R              ANEX_DETA_RT  ; 
      V_M            VARCHAR2(500) ;
      V_RECUEN       NUMBER        ;
      SALIR          EXCEPTION ; 
      V_CLAVE_PED    NUMBER ;
         
      CURSOR CUR_DATOS IS 
      SELECT DE.PDET_EMPR                             PDET_EMPR        , 
             DE.PDET_CLAVE_PED                        PDET_CLAVE_PED   ,
             DE.PDET_NRO_ITEM                         PDET_NRO_ITEM    ,
             
             AR.ART_CODIGO                            ART_CODIGO       ,
             AR.ART_DESC                              ART_DESC         ,
             DE.PDET_DESC_LARGA                       PDET_DESC_LARGA  ,
             
             DE.PDET_UM_PED                           PDET_UM_PED      ,
             DE.PDET_COD_IMPU                         PDET_COD_IMPU    ,
             IM.IMPU_PORCENTAJE                       IMPU_PORC        , 
             IM.IMPU_PORCENTAJE || ' %'               IMPU_PORC_D      ,
             
             DE.PDET_CANT_PED                         PDET_CANT_PED    ,
             DE.PDET_CANT_FACT                        PDET_CANT_FAC    , 
             DE.PDET_CANT_PED - 
             NVL(DE.PDET_CANT_FACT,0)                 PDET_CANT_PEN_F  ,
                          
             DE.PDET_PRECIO                           PDET_PRECIO      ,
             DE.PDET_IMP_NETO_DET                     PDET_IMP_TOTAL   ,
             DE.PDET_IMP_FACTU                        PDET_IMP_FACTU   ,
             DE.PDET_IMP_NETO_DET - 
             NVL(DE.PDET_IMP_FACTU,0)                 PDET_IMP_PEND_FA ,
             
             MO.MON_DEC_IMP                           MON_DEC_IMP      , 
             CASE 
             WHEN DE.PDET_CANT_FACT > 0 AND 
                  DE.PDET_CANT_FACT < DE.PDET_CANT_PED 
             THEN 'PA' 
             WHEN DE.PDET_CANT_FACT = 0 
             THEN 'NO'
             ELSE 'TT' 
             END                                      PDET_IND_FACTU     
             
        FROM GEN_MONEDA        MO , 
             FAC_PEDIDO        PE , 
             STK_ARTICULO      AR , 
             GEN_IMPUESTO      IM ,              
             FAC_PEDIDO_DET    DE 
             
       WHERE MO.MON_EMPR          =    PE.PED_EMPR  
         AND MO.MON_CODIGO        =    PE.PED_MON  
             
         AND PE.PED_EMPR          =    PE.PED_EMPR 
         AND PE.PED_CLAVE         =    PE.PED_CLAVE 
                        
         AND PE.PED_EMPR          =    DE.PDET_EMPR 
         AND PE.PED_CLAVE         =    DE.PDET_CLAVE_PED
         
         AND AR.ART_EMPR          =    DE.PDET_EMPR
         AND AR.ART_CODIGO        =    DE.PDET_ART
         
         AND IM.IMPU_EMPR         =    DE.PDET_EMPR
         AND IM.IMPU_CODIGO       =    DE.PDET_COD_IMPU
         
         AND DE.PDET_EMPR         =    AP.V('P_EMPRESA')
         AND DE.PDET_CLAVE_PED    =    V_CLAVE_PED
       ORDER BY DE.PDET_NRO_ITEM ASC 
       ; 
         
  BEGIN
      
      -- RAISE_APPLICATION_ERROR(-20001,'REQUEST = ' || AP.V('REQUEST'));
      /* 
      RAISE_APPLICATION_ERROR(-20001,
        'X-P_EMPRESA = ' || AP.V('P_EMPRESA') || CHR(10) || 
        'P48_PED_CLAVE = ' || AP.V('P48_PED_CLAVE')         
      ) ;             
      */ 
      
      V_RECUEN       :=     0                     ; 
      V_CLAVE_PED    :=     AP.V('P48_PED_CLAVE') ; 
      
      FOR X IN CUR_DATOS LOOP 
          
          V_RECUEN := V_RECUEN + 1 ;            
          
          V_DEC_MD := X.MON_DEC_IMP;
          
          R.SEQ := APEX_COLLECTION.ADD_MEMBER 
                   (
                    P_COLLECTION_NAME   =>   'FACI240_DE',
                    P_C001              =>   X.PDET_EMPR            , 
                    P_C002              =>   X.PDET_CLAVE_PED       , 
                    P_C003              =>   X.PDET_NRO_ITEM        , 
                                                
                    P_C004              =>   X.ART_CODIGO           , 
                    P_C005              =>   X.ART_DESC             , 
                    P_C006              =>   X.PDET_UM_PED          , 
                                                
                    P_C007              =>   X.PDET_COD_IMPU        , 
                    P_C008              =>   X.IMPU_PORC            , 
                    P_C009              =>   X.IMPU_PORC_D          ,  
                    ------------------------------------------------------------------------------------------------------
                    P_C010              =>   X.PDET_CANT_PED        , -- UT.GETNUMFM(X.PDET_CANT_PED    ,  2 ) , -- X.PDET_CANT_PED        , 
                    P_C011              =>   X.PDET_CANT_FAC        , -- UT.GETNUMFM(X.PDET_CANT_FAC    ,  2 ) , -- X.PDET_CANT_FAC        , 
                    P_C012              =>   X.PDET_CANT_PEN_F      , -- UT.GETNUMFM(X.PDET_CANT_PEN_R  ,  2 ) , -- X.PDET_CANT_PEN_R      , 
                    ------------------------------------------------------------------------------------------------------
                    P_C020              =>   UT.GETNUMFM(X.PDET_PRECIO    ,  X.MON_DEC_IMP ) , 
                    P_C021              =>   UT.GETNUMFM(X.PDET_IMP_TOTAL ,  X.MON_DEC_IMP ) ,
                    
                    P_C040              =>   X.PDET_PRECIO            , 
                    P_C041              =>   X.PDET_IMP_TOTAL         , 
                    ------------------------------------------------------------------------------------------------------                                                                  
                    P_C022              =>   X.PDET_DESC_LARGA        , 
                    P_C023              =>   X.PDET_IND_FACTU         ,
                    ------------------------------------------------------------------------------------------------------
                    P_C049              =>   'C'                      -- STATUS DE LA FILA C=CONSULTADO;I=INSERTADO; E=ELIMINADO; M=MODIFICADO
                    ) ; 
                    
         END LOOP;
         
         -- CL.GUARDAR('FACI240_DE');
                           
         PP_CALC_TT_DETA ; 
         AP.SV( 'P48_PED_IMP_TOTAL_MON_AUX'  , R_DETA_TT.IMP_TT_PED   ); 
         AP.SV( 'P48_PED_IMP_AFACTURAR_AUX'  , R_DETA_TT.IMP_TT_PEN_F ); 
                 
         V_M := '#R_DETA_TT.IMP_TT_PED = ' || R_DETA_TT.IMP_TT_PED || CHR(13) || 
                '#R_DETA_TT.IMP_TT_FAC = ' || R_DETA_TT.IMP_TT_FAC -- || CHR(13) || 
         ;
              
          -- RAISE_APPLICATION_ERROR(-20001,'DETA.V_RECUEN = ' || V_RECUEN );
          
          /*
          RAISE_APPLICATION_ERROR(-20001,
            'P_EMPRESA = ' || AP.V('P_EMPRESA') || CHR(10) || 
            'P48_PED_CLAVE = ' || AP.V('P48_PED_CLAVE')         
          ) ;             
          */ 
        
         --RAISE_APPLICATION_ERROR(-20001, V_M );
                 
         -- AP.SV('P48_PED_IMP_FACTURADO'   , R_DETA_TT.IMP_TT_FAC    ) ; 
         
         -- AP.SV('P48_PED_IMP_TT_A_RECIB'  , R_DETA_TT.IMP_TT_PEN_R  ) ; 
         -- AP.SV('P48_IMP_TT_A_FACTU'      , R_DETA_TT.IMP_TT_PEN_F  ) ;          
                           
         --AP.SV('P48_PED_IMP_TT_RECIB'   , FP_IMP_TT_DOCU) ;  
         -- AP.SV('P48_PED_IMP_TOTAL_MON', FP_IMP_TT_DOCU) ;            
         -- AP.SV('P48_PED_IMP_TOTAL_MON', FP_IMP_TT_DOCU) ;  
         
         
         /* 
         
         R_DETA_TT.IMP_TT_PED      :=     X.PDET_IMP_TOTAL     ; 
         R_DETA_TT.IMP_TT_FAC      :=     X.PDET_IMP_FACTU     ; 
         R_DETA_TT.IMP_TT_PEN_F    :=     R_DETA_TT.IMP_TT_PED  -  R_DETA_TT.IMP_TT_FAC  ; 
         
         */ 
         
  EXCEPTION 
      WHEN SALIR THEN 
           NULL;                 
  END PP_CARGAR_PED_DETA ;   
  --======================================================================================  
  PROCEDURE PP_CARGAR_CUENTAS_CLI IS 
      CURSOR CUR_CUENTAS IS 
              SELECT -- DECODE(DOC_TIPO_MOV, 9, 1, 10, 1, 31, 2) TIPO,
                     ------------------------------------------------------------------------------------ 
                     SUM( DECODE( DOC_TIPO_MOV, 9, 1, 10, 1, 0 ) * 
                          DECODE( GREATEST(SYSDATE - CUO_FEC_VTO, 0), 0, 0, 1) *
                          DECODE( DOC_MON,
                                  2,
                                  CUO_SALDO_MON,
                                  ROUND( CUO_SALDO_LOC / (NVL(COT_TASA, MON_TASA_COMP)), MON_DEC_IMP ) 
                                ) 
                        ) FAC_SALDO_VENCIDO,
                     ------------------------------------------------------------------------------------ 
                     SUM( DECODE( DOC_TIPO_MOV, 31, 1, 0 ) * 
                          DECODE( GREATEST(SYSDATE - CUO_FEC_VTO, 0), 0, 0, 1) *
                          DECODE( DOC_MON,
                                2,
                                CUO_SALDO_MON,
                                ROUND(CUO_SALDO_LOC / (NVL(COT_TASA, MON_TASA_COMP)), MON_DEC_IMP)
                                ) 
                        ) ADE_SALDO_VENCIDO,                        
                     ------------------------------------------------------------------------------------ 
                     SUM( DECODE( DOC_TIPO_MOV, 9, 1, 10, 1, 0 ) * 
                          DECODE(GREATEST(SYSDATE - CUO_FEC_VTO, 0), 0, 1, 0) *
                          DECODE(DOC_MON, 2, CUO_SALDO_MON,
                                ROUND(CUO_SALDO_LOC / (NVL(COT_TASA, MON_TASA_COMP)), MON_DEC_IMP) )
                        ) FAC_SALDO_AVENCER   ,
                     ------------------------------------------------------------------------------------ 
                     SUM( DECODE( DOC_TIPO_MOV, 31, 1, 0 ) * 
                          DECODE(GREATEST(SYSDATE - CUO_FEC_VTO, 0), 0, 1, 0) *
                          DECODE(DOC_MON, 2, CUO_SALDO_MON,
                                ROUND(CUO_SALDO_LOC / (NVL(COT_TASA, MON_TASA_COMP)), MON_DEC_IMP) )
                        ) ADE_SALDO_AVENCER 
                     ------------------------------------------------------------------------------------
                                                           
                FROM FIN_DOCUMENTO DO,
                     FIN_CUOTA     CU,
                     (SELECT MO.MON_TASA_COMP   MON_TASA_COMP , 
                             MO.MON_DEC_IMP     MON_DEC_IMP   , 
                             CO.COT_TASA        COT_TASA      
                        FROM GEN_CONFIGURACION GC , 
                             GEN_MONEDA        MO , 
                             ( SELECT CO.COT_MON, CO.COT_TASA, CO.COT_EMPR
                                 FROM STK_COTIZACION CO
                                WHERE COT_EMPR  =  AP.V( 'P_EMPRESA' )
                                  AND COT_FEC   =  SYSDATE
                             ) CO 
                       WHERE CO.COT_EMPR(+)   =   MO.MON_EMPR 
                         AND CO.COT_MON(+)    =   MO.MON_CODIGO 
                         AND GC.CONF_MON_US   =   MO.MON_CODIGO 
                         AND GC.CONF_EMPR     =   MO.MON_EMPR 
                         AND MO.MON_EMPR      =   AP.V('P_EMPRESA') 
                     ) 
               WHERE DOC_EMPR     =     CUO_EMPR
                 AND DOC_CLAVE    =     CUO_CLAVE_DOC
                 AND DOC_EMPR     =     AP.V( 'P_EMPRESA' )
                 AND ( ( DOC_TIPO_MOV IN (9, 10)  AND DOC_CLI  = AP.V('P48_PED_CLI') ) 
                       OR
                       ( DOC_TIPO_MOV IN (31)     AND DOC_PROV = AP.V('P48_PED_CLI') )
                     )                     
            --  GROUP BY DECODE(DOC_TIPO_MOV, 9, 1, 10, 1, 31, 2 ) ; 
           ;
           
           R_CUENTA CUR_CUENTAS%ROWTYPE ; 
                                 
      BEGIN
          
          FOR R IN CUR_CUENTAS LOOP
              R_CUENTA := R ; 
          END LOOP;

          
          -- RAISE_APPLICATION_ERROR( -20001,  'P48_PED_CLI ' || AP.V('P48_PED_CLI') ) ; 
                          
          AP.SV('P48_IMP_AD_VENCIDO_USD' , UT.GETNUMFM(R_CUENTA.ADE_SALDO_VENCIDO,2)  ) ;           
          AP.SV('P48_IMP_AD_AVENCER_USD' , UT.GETNUMFM(R_CUENTA.ADE_SALDO_AVENCER,2)  ) ; 
          
          AP.SV('P48_IMP_FA_VENCIDO_USD' , UT.GETNUMFM(R_CUENTA.FAC_SALDO_VENCIDO,2)  ) ;
          AP.SV('P48_IMP_FA_AVENCER_USD' , UT.GETNUMFM(R_CUENTA.FAC_SALDO_AVENCER,2)  ) ; 
          
          -- EAS 
          
  END PP_CARGAR_CUENTAS_CLI;
  --======================================================================================    
  PROCEDURE PP_CARGAR_DATOS IS
 
  BEGIN 
      
      -- APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(P_COLLECTION_NAME => 'FACI240_DE');             
      
      PP_BUSCAR_PERMISO_OPER ; 
      
      AP.SV('P48_OPER_EDITAR_PED', R_OPER.OPER_EDITAR_PED )     ; 
      AP.SV('P48_OPER_EDITAR_PRE', R_OPER.OPER_EDITAR_PRE )     ; 
                    
      IF AP.V('P48_PED_CLAVE') IS NULL THEN 
         AP.SV('P48_PED_SUC'     , AP.V('P_SUCURSAL'))               ; 
         AP.SV('P48_PED_FECHA'   , TO_CHAR(SYSDATE, 'DD/MM/YYYY'))   ;       
         
         AP.SV('P48_IMP_AD_VENCIDO_USD' , NULL               )       ; 
         AP.SV('P48_IMP_AD_AVENCER_USD' , NULL               )       ; 
         AP.SV('P48_IMP_FA_VENCIDO_USD' , NULL               )       ; 
         AP.SV('P48_IMP_FA_AVENCER_USD' , NULL               )       ; 
         AP.SV('P48_IMP_DISP_LINEA'     , NULL               )       ; 
                   
      ELSE 
         PP_CARGAR_PED_DETA      ; 
         PP_CARGAR_CUENTAS_CLI   ; 
         PP_BUSCAR_LINEA_DISP    ; 
      END IF;      
            
      -- RAISE_APPLICATION_ERROR( -20001,  'PP_CARGAR_DATOS.. P48_OPER_PERM_EDIT_PED- ' || AP.V('P48_OPER_PERM_EDIT_PED') ) ; 
      -- RAISE_APPLICATION_ERROR( -20001,  'XX02') ; 
      
  END PP_CARGAR_DATOS;
  --======================================================================================  
  PROCEDURE MOSTRAR_FILA_EDIT IS 
      V_SEQ_ID  NUMBER; 
      CURSOR CUR_DATOS IS 
      SELECT SEQ_ID                 SEQ_ID            ,   
             C004                   DETA_ART_COD      ,                     
             C003                   DETA_NRO_ITEM     , 
             C005                   DETA_ART_DESC     ,

             C006                   DETA_UN_MED       , 
             C007                   DETA_COD_IMPU     , 
             C008                   DETA_PORC_IMPU    , 
             C009                   DETA_PORC_IMPU_D  , 
                                                                                                                  
             C010                   DETA_CANT_PED     , 
             C011                   DETA_CANT_FAC     , 
             C012                   DETA_CANT_PEN_F   , 
             
             C020                   DETA_PRECIO       , 
             C021                   DETA_IMP_TT       , 
             C022                   DETA_OBS             
             
        FROM APEX_collections
       WHERE collection_name = 'FACI240_DE'  
         AND SEQ_ID          =  V_SEQ_ID 
         ;
         
    X       CUR_DATOS%ROWTYPE;
    V_SUC   NUMBER ;
    V_ART   NUMBER ;
    
  BEGIN
      
      
      V_SEQ_ID := AP.V('P48_SEQ_ID_UPDATE');
      
      FOR R IN CUR_DATOS LOOP 
          X := R ;  
      END LOOP;
      
      AP.SV('P48_ART_CODIGO'      ,  X.DETA_ART_COD          )        ; 
      
      AP.SV('P48_ART_IMPU'        ,  X.DETA_COD_IMPU         )        ; 
      AP.SV('P48_IMPU_PORC'       ,  X.DETA_PORC_IMPU        )        ; 
      AP.SV('P48_IMPU_PORC_DESC'  ,  X.DETA_PORC_IMPU_D      )        ; 
      AP.SV('P48_ART_UN_MED'      ,  X.DETA_UN_MED           )        ; 
                                  
      AP.SV('P48_CANT_FAC'        ,  X.DETA_CANT_FAC         )        ; 
      AP.SV('P48_CANT_PEN_FAC'    ,  X.DETA_CANT_PEN_F       )        ; 
      
      AP.SV('P48_CANT_PED'        ,  X.DETA_CANT_PED         )        ; 
            
      AP.SV('P48_PRECIO_UN'       ,  X.DETA_PRECIO           )        ; 
      AP.SV('P48_IMP_TOT_DETA'    ,  X.DETA_IMP_TT           )        ;   
                 
      AP.SV('P48_OBS_DETA'        ,  X.DETA_OBS              )        ; 
      
      AP.SV('P48_NRO_ITEM_AUX'    ,  X.DETA_NRO_ITEM         )        ; 
      AP.SV('P48_ART_CODIGO_AUX'  ,  X.DETA_ART_COD          )        ; 
      AP.SV('P48_ART_CODIGO_INI'  ,  X.DETA_ART_COD          )        ; 
      AP.SV('P48_ART_DESC_AUX'    ,  X.DETA_ART_DESC         )        ; 
      AP.SV('P48_PRECIO_UN_AUX'   ,  X.DETA_PRECIO           )        ; 
      AP.SV('P48_OPER_AUX'        , 'M'                      )        ; 

      V_SUC   := AP.V('P48_PED_SUC')                                  ; 
      V_ART   := X.DETA_ART_COD                                       ; 
      /*
      RAISE_APPLICATION_ERROR( -20001,  'MOSTRAR_FILA_EDIT ' || CHR(13) || 
                                        '# V_SUC  '      || V_SUC  || 
                                        '# V_ART = '  || V_ART
                                                                                                               
                             ); 
      */                             
      AP.SV('P48_CANT_EXIST'      , FP_EXIST_ART_SUC( V_SUC, V_ART ) );
           
      --CL.GUARDAR('FACI240_DE');
      
      /*
      RAISE_APPLICATION_ERROR( -20001,  'MOSTRAR_FILA_EDIT ' || CHR(13) || 
                                        '# P48_CANT_PED = '      ||  X.DETA_CANT_PED || 
                                        '# P48_CANT_PEN_FAC = '  ||  X.DETA_CANT_PEN_F 
                                                                                                               
                             ); 
      */
      
      
      -- RAISE_APPLICATION_ERROR( -20001,  'MOSTRAR_FILA_EDIT. DETA_CANT_PEN_R = ' ||  X.DETA_CANT_PEN_R );      
      
      -- RAISE_APPLICATION_ERROR( -20001,  'P48_ART_CODIGO => X.DETA_ART_COD => ' || X.DETA_ART_COD );
      -- AP.SV('P48_ART_UN_MED')      ; 
      -- AP.SV('P48_ART_IMPU')        ; 
      -- AP.SV('P48_IMPU_PORC')       ; 
      -- AP.SV('P48_IMPU_PORC_DESC')  ;            
      
  END;
  --======================================================================================    
  PROCEDURE PP_BORRAR_ITEM(I_SEQ_ID IN NUMBER) IS
    CURSOR CUR_DATOS IS 
    SELECT SEQ_ID                   SEQ_ID        ,  
           TO_NUMBER(C003)          PDET_NRO_ITEM ,
           NVL(TO_NUMBER(C011),0)   PDET_CANT_FAC  
      FROM APEX_COLLECTIONS CO 
     WHERE COLLECTION_NAME   =  'FACI240_DE' 
       AND CO.SEQ_ID         =  I_SEQ_ID
       --AND CO.C003           =  P_NRO_ITEM 
       ;
    X CUR_DATOS%ROWTYPE;
  BEGIN
        
        FOR R IN CUR_DATOS LOOP            
            X := R;
        END LOOP ; 
        
        IF X.SEQ_ID IS NULL THEN 
           RAISE_APPLICATION_ERROR( -20001, 
                                    'No se pudo elimar el registro de la coleccion. ' ||
                                    'Seq. Nro. ' || I_SEQ_ID || ' no encontrada!' 
                                  );
        END IF;

        -- TO_NUMBER(C003)          PDET_NRO_ITEM ,
        -- NVL(TO_NUMBER(C011),0)   PDET_CANT_REC 
                   
        IF X.PDET_CANT_FAC > 0 THEN 
           RAISE_APPLICATION_ERROR( -20001, 'No se puede elimar registro. Ya esta facturado!!' );
        END IF;        
        
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE
        (  P_COLLECTION_NAME   => 'FACI240_DE'   ,
           P_SEQ               =>  I_SEQ_ID      ,
           P_ATTR_NUMBER       =>  49            ,
           P_ATTR_VALUE        =>  'E'           
        );
        
        PP_CALC_TT_DETA;
        AP.SV( 'P48_PED_IMP_TOTAL_MON_AUX'  , R_DETA_TT.IMP_TT_PED   ); 
        AP.SV( 'P48_PED_IMP_AFACTURAR_AUX'  , R_DETA_TT.IMP_TT_PEN_F ); 
                
        -- APEX_COLLECTION.DELETE_MEMBER( P_COLLECTION_NAME => 'FACI240_DE', P_SEQ => P_NRO_ITEM ); 
        -- APEX_COLLECTION.RESEQUENCE_COLLECTION(P_COLLECTION_NAME => 'FACI240_DE'               ); 
        
  END PP_BORRAR_ITEM;
  --======================================================================================   
  PROCEDURE PP_AGREGAR_DETA IS             
      V_IMP_TT      NUMBER        ; 
      R             ANEX_DETA_RT  ; 
      V_MENSAJE     VARCHAR2(300) ; 
  BEGIN
      
      R                     :=         NULL                        ; 
      
      R.EMPR                :=         AP.V('P_EMPRESA')           ; 
      R.ART_CODIGO          :=         AP.V('P48_ART_CODIGO')      ; 
      R.ART_UN_MED          :=         AP.V('P48_ART_UN_MED')      ; 
      
      R.ART_IMPU            :=         AP.V('P48_ART_IMPU')        ; 
      R.IMPU_PORC           :=         AP.V('P48_IMPU_PORC')       ; 
      R.IMPU_PORC_DESC      :=         AP.V('P48_IMPU_PORC_DESC')  ; 
      
      R.CANT_PED            :=         AP.GETNC('P48_CANT_PED')    ; 
      R.CANT_FAC            :=         0                           ; -- AP.GETNC('P48_CANT_FAC')     ; 
      R.CANT_PEN_F          :=         R.CANT_PED                  ; -- AP.GETNC('P48_CANT_PEN_FAC') ;  
      R.PRECIO_UN           :=         AP.GETNC('P48_PRECIO_UN')   ;  -- UT.GETNUM( AP.V('P48_PRECIO_UN')    , ',' )    ; 
      
      R.IMPORTE_TT          :=         AP.V('P48_IMP_TOT_DETA')    ;  -- UT.GETNUM( AP.V('P48_IMP_TOT_DETA') , ',' )    ;      
      R.OBS_DETA            :=         AP.V('P48_OBS_DETA')        ; 
      
      --R.DETA_ITEM           :=         999;
                                
      ----------------------------------------------------------------------------------------------------
      
      IF R.EMPR IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'Empresa no puede ser nulo');
      END IF;
                  
      IF R.ART_CODIGO IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'Debe ingresar el Producto a agregar!.');
      END IF;
      
            
      IF NOT FP_EXIS_ARTICULO(R.EMPR, R.ART_CODIGO) THEN 
         RAISE_APPLICATION_ERROR(-20001,'Articulo Inexistente! Codigo ' || R.ART_CODIGO || '.');
      END IF ; 
      ----------------------------------------------------------------------------------------------------            
      R.ART_DESC    :=  R_ARTICULO.ART_DESC;                   
                      
      IF R.ART_IMPU IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'No se pudo obtener el tipo de impuesto del articulo!.');
      END IF;      
      
      IF NVL(UT.GETNUM(R.CANT_PED, ','),0) <= 0 THEN 
         RAISE_APPLICATION_ERROR(-20001,'Debe ingresar un valor de CANTIDAD valido!');
      END IF;
      ----------------------------------------------------------------------------------------------------                
      IF NVL(UT.GETNUM(R.PRECIO_UN, ','),0) <= 0 THEN -- <= 
         RAISE_APPLICATION_ERROR(-20001,'Precio debe ser mayor a cero!');
      END IF;
      ---------------------------------------------------------------------------------------------------- 
      R.SEQ := APEX_COLLECTION.ADD_MEMBER(
                                              P_COLLECTION_NAME   =>   'FACI240_DE',
                                              P_C001              =>   R.EMPR                 ,
                                              P_C002              =>   R.DETA_CLAVE_PED       ,
                                              P_C003              =>   R.DETA_ITEM            , 
                                              
                                              P_C004              =>   R.ART_CODIGO           , 
                                              P_C005              =>   R.ART_DESC             , 
                                              P_C006              =>   R.ART_UN_MED           ,
                                              
                                              P_C007              =>   R.ART_IMPU             , 
                                              P_C008              =>   R.IMPU_PORC            , 
                                              P_C009              =>   R.IMPU_PORC_DESC       ,
                                              ------------------------------------------------------------                                                
                                              P_C010              =>   R.CANT_PED             ,                                               
                                              P_C011              =>   R.CANT_FAC             , 
                                              P_C012              =>   R.CANT_PEN_F           ,                                                                                                          
                                              ------------------------------------------------------------  
                                              P_C020              =>   R.PRECIO_UN            , 
                                              P_C021              =>   R.IMPORTE_TT           , 
                                              
                                              P_C040              =>   UT.GETNUM(R.PRECIO_UN, ',')    ,  
                                              P_C041              =>   UT.GETNUM(R.IMPORTE_TT, ',')   ,  
                                              ------------------------------------------------------------                                                
                                              P_C022              =>   R.OBS_DETA             ,      
                                              P_C023              =>   'NO'                   , -- V_IND_RECIBIDO 
                                              ------------------------------------------------------------
                                              P_C049              =>   'I'                    -- STATUS DE LA FILA 
                                                                                              -- C=CONSULTADO;I=INSERTADO; E=ELIMINADO; M=MODIFICADO   
                                              
                                              );
      ----------------------------------------------------------------------------------------------------       
      PP_CALC_TT_DETA;
      AP.SV( 'P48_PED_IMP_TOTAL_MON_AUX'  , R_DETA_TT.IMP_TT_PED   ); 
      AP.SV( 'P48_PED_IMP_AFACTURAR_AUX'  , R_DETA_TT.IMP_TT_PEN_F ); 

      V_MENSAJE :=  'PP_AGERGAR_DETA: ' || CHR(10) || 
                '#R_DETA_TT.IMP_TT_PED = ' || R_DETA_TT.IMP_TT_PED || CHR(10) || 
                '#R_DETA_TT.IMP_TT_FAC = ' || R_DETA_TT.IMP_TT_FAC || CHR(10) || 
                '#R_DETA_TT.IMP_TT_FAC = ' || R_DETA_TT.IMP_TT_PEN_F -- || CHR(13) ||                 
       ;
              
       -- RAISE_APPLICATION_ERROR(-20001, V_MENSAJE);
          
                        
      --V_MENSAJE := V_MENSAJE || ' #V_RET = ' || V_RET ; 
                  
      ----------------------------------------------------------------------------------------------------
      
      /*
      APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'FACI240_DE',
                                              P_SEQ             => P_SEQ,
                                              P_ATTR_NUMBER     => 7,
                                              P_ATTR_VALUE      => P_DETA_ART);
      */ 
      
  END PP_AGREGAR_DETA ;   
  --======================================================================================  
  PROCEDURE PP_MODIFICAR_DETA IS             
      V_SEQ_ID                NUMBER        ; 
      V_IMP_TT                NUMBER        ; 
      R                       ANEX_DETA_RT  ; 
      V_IND_FACTURADO         VARCHAR2(2)   ;
      
      CURSOR CUR_DATOS IS 
      SELECT SEQ_ID                   SEQ_ID        ,  
             TO_NUMBER(C003)          PDET_NRO_ITEM ,
             NVL(TO_NUMBER(C011),0)   PDET_CANT_FAC  
        FROM APEX_COLLECTIONS CO 
       WHERE COLLECTION_NAME   =  'FACI240_DE' 
         AND CO.SEQ_ID         =  V_SEQ_ID 
         --AND CO.C003           =  P_NRO_ITEM 
         ;
      X CUR_DATOS%ROWTYPE;
      V_MENSAJE            VARCHAR2(300);            
  BEGIN
      
      V_SEQ_ID                :=         AP.V('P48_SEQ_ID_UPDATE')   ;
                
      FOR R IN CUR_DATOS LOOP            
          X := R;
      END LOOP ; 
        
      IF X.SEQ_ID IS NULL THEN          
         RAISE_APPLICATION_ERROR( -20001,  'No se pudo encontrar el registro en la coleccion. ' ||
                                           'Seq. Nro. ' || V_SEQ_ID || ' no encontrada!'  ) ;          
      END IF;
              
      R                     :=         NULL                        ; 
      R.SEQ                 :=         V_SEQ_ID                    ;  
      
      R.EMPR                :=         AP.V('P_EMPRESA')           ; 
      R.DETA_CLAVE_PED      :=         AP.V('P48_PED_CLAVE')       ; 
      
      R.ART_CODIGO          :=         AP.V('P48_ART_CODIGO')      ; 
      R.ART_UN_MED          :=         AP.V('P48_ART_UN_MED')      ; 

      R.ART_IMPU            :=         AP.V('P48_ART_IMPU')        ; 
      R.IMPU_PORC           :=         AP.V('P48_IMPU_PORC')       ; 
      R.IMPU_PORC_DESC      :=         AP.V('P48_IMPU_PORC_DESC')  ; 
      
      R.CANT_PED            :=         AP.GETNC('P48_CANT_PED')    ; 
      R.CANT_FAC            :=         AP.GETNC('P48_CANT_FAC')         ; 
      R.CANT_PEN_F          :=         AP.GETNC('P48_CANT_PEN_FAC')     ; 
      R.PRECIO_UN           :=         AP.GETNC('P48_PRECIO_UN')                          ; -- UT.GETNUM( AP.V('P48_PRECIO_UN')    , ',' )
      
      R.IMPORTE_TT          :=         AP.V('P48_IMP_TOT_DETA')                       ; -- UT.GETNUM( AP.V('P48_IMP_TOT_DETA') , ',' )    ;            
      
      R.OBS_DETA            :=         AP.V('P48_OBS_DETA')         ;       
      R.SEQ                 :=         V_SEQ_ID                     ; 
      R.ART_CODIGO_INI      :=         AP.V('P48_ART_CODIGO_AUX')   ; 
      R.PRECIO_UN_INI       :=         AP.GETNC('P48_PRECIO_UN_AUX')    ;       
      R.DETA_ITEM           :=         AP.V('P48_NRO_ITEM_AUX')    ; 
            
      ----------------------------------------------------------------------------------------------------
      
      IF R.EMPR IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'Empresa no puede ser nulo');
      END IF;
                  
      IF R.ART_CODIGO IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'Debe ingresar el Producto a agregar!.');
      END IF;
                  
      IF NOT FP_EXIS_ARTICULO(R.EMPR, R.ART_CODIGO) THEN 
         RAISE_APPLICATION_ERROR(-20001,'Articulo Inexistente! Codigo ' || R.ART_CODIGO || '.');
      END IF ; 
      ----------------------------------------------------------------------------------------------------            
      R.ART_DESC    :=  R_ARTICULO.ART_DESC;                   
                      
      IF R.ART_IMPU IS NULL THEN 
         RAISE_APPLICATION_ERROR(-20001,'No se pudo obtener el tipo de impuesto del articulo!.');
      END IF;      
      
      IF NVL( R.CANT_PED ,0 ) <= 0 THEN 
         RAISE_APPLICATION_ERROR(-20001,'Debe ingresar un valor de CANTIDAD valido!');
      END IF;      
      
      IF NVL( R.CANT_PED ,0 ) < NVL( R.CANT_FAC ,0 ) THEN         
         
         V_MENSAJE := 'CANTIDAD PEDIDO no puede ser menor a la CANTIDAD FACTURADA!' || chr(10) || 
                      -- 'Articulo " ' || R.ART_DESC  || '" ya tiene factura. ' || chr(10) || 
                      'Cantidad facturada : ' || R.CANT_FAC ;                                             
         RAISE_APPLICATION_ERROR(-20001,V_MENSAJE);
         
      END IF ;            
      ----------------------------------------------------------------------------------------------------                
      IF NVL(R.PRECIO_UN,0) <= 0 THEN -- <= 
         RAISE_APPLICATION_ERROR(-20001,'Precio debe ser mayor a cero!');
      END IF;
      --## 
      IF NVL(R.CANT_PED,0) < NVL(R.CANT_FAC,0)  THEN 
         V_MENSAJE := 'Cantidad no puede ser menor a la cantidad facturada igual a ' || 
                      AP.V('P48_CANT_FAC') ||  '!' ; 
                    -- 'Articulo " ' || R.ART_DESC  || '" ya tiene factura.          
         RAISE_APPLICATION_ERROR(-20001, V_MENSAJE );
      END IF ; 
      --##
      IF NVL( R.PRECIO_UN ,0 ) <> NVL( R.PRECIO_UN_INI ,0 ) AND NVL( R.CANT_FAC ,0 ) > 0 THEN 
         RAISE_APPLICATION_ERROR(-20001,'No se puede modifcar el precio cuando ya esta facturado! ' || 
                                         'Precio INICIAL = ' || R.PRECIO_UN_INI || '; ' || 
                                         'Precio NUEVO = '   || R.PRECIO_UN 
                                        ) ; 
      END IF;
      --## 
      IF NVL( R.ART_CODIGO_INI,0 ) <> NVL( R.ART_CODIGO,0 ) AND NVL(R.CANT_FAC,0) > 0 THEN 
         RAISE_APPLICATION_ERROR(-20001,'No se puede el articulo modificar el articulo, pues ya tiene factura!');
      END IF;

      -- RAISE_APPLICATION_ERROR( -20001, 'NN' );            
      
      V_IND_FACTURADO       :=    'NO'    ;
      
      IF NVL( R.CANT_FAC,0) = NVL( R.CANT_PED ,0) THEN 
         V_IND_FACTURADO := 'TT';      
      
      ELSIF NVL( R.CANT_FAC ,0) > 0 THEN 
         V_IND_FACTURADO := 'PA';      
      ELSE 
         V_IND_FACTURADO := 'NO';               
      END IF;
      ---------------------------------------------------------------------------------------------------- 
      -- P_C004            =>   R.ART_CODIGO ;
      /*
      APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'FACI240_DE'   ,
                                              P_SEQ             => V_SEQ_ID       ,
                                              P_ATTR_NUMBER     => 4              ,
                                              P_ATTR_VALUE      => R.ART_CODIGO   );      
                                              
      APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'FACI240_DE'   ,
                                              P_SEQ             => V_SEQ_ID       ,
                                              P_ATTR_NUMBER     => 4              ,
                                              P_ATTR_VALUE      => R.ART_CODIGO   );      
                                              
      APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'FACI240_DE'   ,
                                              P_SEQ             => V_SEQ_ID       ,
                                              P_ATTR_NUMBER     => 4              ,
                                              P_ATTR_VALUE      => R.ART_CODIGO   );      
                                              
      APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'FACI240_DE'   ,
                                              P_SEQ             => V_SEQ_ID       ,
                                              P_ATTR_NUMBER     => 4              ,
                                              P_ATTR_VALUE      => R.ART_CODIGO   );      
                                                                                                                                                                                        
*/
      ---------------------------------------------------------------------------------------------------- 
      

      ----------------------------------------------------------------------------------------------------                   
              APEX_COLLECTION.update_member  (
                                              P_COLLECTION_NAME   =>   'FACI240_DE'           , 
                                              p_seq               =>   V_SEQ_ID               , 
                                              P_C001              =>   R.EMPR                 , 
                                              P_C002              =>   R.DETA_CLAVE_PED       , 
                                              P_C003              =>   R.DETA_ITEM            , 
                                              
                                              P_C004              =>   R.ART_CODIGO           , 
                                              P_C005              =>   R.ART_DESC             , 
                                              P_C006              =>   R.ART_UN_MED           , 
                                              
                                              P_C007              =>   R.ART_IMPU             , 
                                              P_C008              =>   R.IMPU_PORC            , 
                                              P_C009              =>   R.IMPU_PORC_DESC       , 
                                              ------------------------------------------------------------                                                
                                              P_C010              =>   R.CANT_PED             , 
                                              P_C011              =>   R.CANT_FAC             , 
                                              P_C012              =>   R.CANT_PEN_F           , 
                                              ------------------------------------------------------------  
                                              P_C020              =>   R.PRECIO_UN            , 
                                              P_C021              =>   R.IMPORTE_TT           , 
                                              
                                              P_C040              =>   UT.GETNUM(R.PRECIO_UN, ',')    ,  
                                              P_C041              =>   UT.GETNUM(R.IMPORTE_TT, ',')   ,  
                                              ------------------------------------------------------------                                                
                                              P_C022              =>   R.OBS_DETA             ,                                               
                                              P_C023              =>   V_IND_FACTURADO        ,
                                              P_C049              =>   'M'                    -- STATUS DE LA FILA                                                                                               -- C=CONSULTADO;I=INSERTADO; E=ELIMINADO; M=MODIFICADO   
                                              
                                              );
      ----------------------------------------------------------------------------------------------------       
      PP_CALC_TT_DETA;
      
      AP.SV( 'P48_PED_IMP_TOTAL_MON_AUX'  , R_DETA_TT.IMP_TT_PED   ); 
      AP.SV( 'P48_PED_IMP_AFACTURAR_AUX'  , R_DETA_TT.IMP_TT_PEN_F ); 

      V_MENSAJE :=  'PP_MODIFICAR_DETA: ' || CHR(10) || 
                '#R_DETA_TT.IMP_TT_PED = ' || R_DETA_TT.IMP_TT_PED || CHR(10) || 
                '#R_DETA_TT.IMP_TT_FAC = ' || R_DETA_TT.IMP_TT_FAC || CHR(10) || 
                '#R_DETA_TT.IMP_TT_FAC = ' || R_DETA_TT.IMP_TT_PEN_F -- || CHR(13) ||                 
       ;
              
      -- RAISE_APPLICATION_ERROR(-20001, V_MENSAJE);
       
            
      --V_MENSAJE := V_MENSAJE || ' #V_RET = ' || V_RET ;                   
      ----------------------------------------------------------------------------------------------------
      
      /*
      APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'FACI240_DE',
                                              P_SEQ             => P_SEQ,
                                              P_ATTR_NUMBER     => 7,
                                              P_ATTR_VALUE      => P_DETA_ART);
      */ 
      
  END PP_MODIFICAR_DETA ;   
  --======================================================================================  
  PROCEDURE PP_ACT_MON_DOCU IS             
      R                       ANEX_DETA_RT  ; 
      V_DECIM                 NUMBER        ; 
      V_IMP_TT                NUMBER        ; 
      
      CURSOR CUR_DATOS IS 
      SELECT SEQ_ID                        SEQ_ID           , 
             TO_NUMBER(C003)               PDET_NRO_ITEM    , 
             C004                          ART_CODIGO       , 
             C005                          ART_DESC         , 
             ----------------------------------------------------             
             C010                          CANT_PED         , 
             C011                          CANT_FAC         , 
             C040                          PRECIO           , 
             C041                          IMP_TOTAL        , 
             ----------------------------------------------------
             SUM( NVL(UT.GETNC(C011),0)    
                )                          
             OVER()                        TT_FACTU         
             ----------------------------------------------------                                                                              
        FROM APEX_COLLECTIONS CO 
       WHERE COLLECTION_NAME   =  'FACI240_DE' 
         AND NVL(CO.C049,'X')  <> 'E' 
       ;
       
      X CUR_DATOS%ROWTYPE;
            
  BEGIN
      
      V_DECIM               :=         AP.V('P48_MON_DEC_IMP')   ;
      --RAISE_APPLICATION_ERROR( -20001, 'PP_ACT_MON_DOCU... [P48_MON_DEC_IMP = ' || V_DECIM  || ' ]' );  
                     
      FOR X IN CUR_DATOS LOOP            
          
          IF X.TT_FACTU > 0 THEN 
             RAISE_APPLICATION_ERROR(-20001, 'El pedido ya esta facturado, no se puede modificar la moneda!');            
          END IF;
          
          R                     :=         NULL                           ; 
          R.SEQ                 :=         X.SEQ_ID                       ; 
          R.CANT_PED            :=         UT.GETNC(X.CANT_PED)           ; 
          R.CANT_FAC            :=         UT.GETNC(X.CANT_FAC )          ;           
          R.PRECIO_UN           :=         UT.GETNC(X.PRECIO)             ; 
          
          R.IMPORTE_TT          :=         ROUND( R.CANT_PED * R.PRECIO_UN , V_DECIM ) ;
                    
          APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'FACI240_DE'   ,
                                                  P_SEQ             => R.SEQ          ,
                                                  P_ATTR_NUMBER     => 21             ,
                                                  P_ATTR_VALUE      => UT.GETNF(R.IMPORTE_TT, V_DECIM)
                                                  ) ; 
           
          APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'FACI240_DE'   ,
                                                  P_SEQ             => R.SEQ          ,
                                                  P_ATTR_NUMBER     => 41             ,
                                                  P_ATTR_VALUE      => R.IMPORTE_TT   );   
                                                            
      END LOOP ; 
      ----------------------------------------------------------------------------------------------------    
      -- CL.GUARDAR('FACI240_DE');
               
      V_IMP_TT :=  FP_IMP_TT_DOCU; 
      
      AP.SV('P48_PED_IMP_TOTAL_MON_AUX', V_IMP_TT ) ;  -- P48_PED_IMP_TOTAL_MON 
      --V_MENSAJE := V_MENSAJE || ' #V_RET = ' || V_RET ;                   

      
      ----------------------------------------------------------------------------------------------------
      -- RAISE_APPLICATION_ERROR( -20001, 'PP_ACT_MON_DOCU... [V_IMP_TT = ' || V_IMP_TT  || ' ]' );  
      /* 
          RAISE_APPLICATION_ERROR(-20001, 
          'Seq: '          || R.SEQ          || '; ' || 
          'R.CANT_PED: '   || R.CANT_PED     || '; ' || 
          'R.CANT_REC: '   || R.CANT_REC     || '; ' || 
          
          'R.PRECIO_UN: '  || R.PRECIO_UN    || '; ' || 
          'R.IMPORTE_TT: ' || R.IMPORTE_TT   || '; ' ||  
          
          'X.CANT_PED: '   || X.CANT_PED     || '; ' || 
          'X.PRECIO: '     || X.PRECIO       --|| '; ' ||           
          --'X.IMPORTE_TT: ' || X.IMPORTE_TT   || '; '   
                              
          );            
      */     
      /*
      APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'FACI240_DE',
                                              P_SEQ             => P_SEQ,
                                              P_ATTR_NUMBER     => 7,
                                              P_ATTR_VALUE      => P_DETA_ART);
      */ 
      
  END PP_ACT_MON_DOCU ;   
  --======================================================================================    
  PROCEDURE PP_ACTU_DETA IS
  BEGIN
          
     --  RAISE_APPLICATION_ERROR( -20001, 'PP_ACTU_DETA [P48_OPER_AUX=' || AP.V('P48_OPER_AUX') || ' ]' );              
     
     IF AP.V('P48_OPER_AUX') = 'I' THEN 
        PP_AGREGAR_DETA   ;        
     ELSIF AP.V('P48_OPER_AUX') = 'M' THEN 
        PP_MODIFICAR_DETA ; 
     ELSE 
        RAISE_APPLICATION_ERROR(-20001, 'No se puede actualizar! Operacion no valida');                 
     END IF;
     
  END ; 
  --======================================================================================    
  PROCEDURE GUARDAR_NUEVO IS 
  BEGIN
       
       X_CAB              :=  FP_CAB_TAB        ; 
       X_DETA             :=  FP_DETA_TAB       ; 
       
       -- valida Disponibilidad de la empresa
       if not user_modify_unavailability then
          val_new_sales_det;
       end if;
       
       FACI240_D.GUARDAR_NUEVO (X_CAB, X_DETA)  ; 
       PP_CONFIG_REPORTE                        ; 
       
  END;
  --======================================================================================  
  PROCEDURE APLICAR_CAMBIOS IS 
    
  BEGIN
       
       X_CAB              :=  FP_CAB_TAB        ; 
       X_DETA             :=  FP_DETA_TAB       ; 
       X_DETA_E           :=  FP_DETA_ELIM_TAB  ; 
       
       -- valida Disponibilidad de la empresa
       if not user_modify_unavailability then
          val_new_sales_det;
       end if;
       
       FACI240_D.APLICAR_CAMBIOS( X_CAB    , 
                                  X_DETA   , 
                                  X_DETA_E 
                                 );
       PP_CONFIG_REPORTE                        ; 
       
  END;
  --======================================================================================
  PROCEDURE ELIMINAR_PEDIDO IS 
    
  BEGIN
        
      X_CAB.PED_EMPR                      :=               AP.V('P_EMPRESA')             ;         
      X_CAB.PED_CLAVE                     :=               AP.V('P48_PED_CLAVE')         ;
      
      FACI240_D.ELIMINAR_PEDIDO(X_CAB.PED_EMPR, X_CAB.PED_CLAVE);
      
  END;
  --======================================================================================  
  
END FACI240_P ;
/
