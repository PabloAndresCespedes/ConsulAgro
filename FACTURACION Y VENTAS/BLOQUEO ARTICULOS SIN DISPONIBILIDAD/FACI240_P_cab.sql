create or replace PACKAGE FACI240_P IS
  
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