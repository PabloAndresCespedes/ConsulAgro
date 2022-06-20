CREATE OR REPLACE PACKAGE FACM070 IS

  -- AUTHOR  : PROGRAMACION4
  -- CREATED : 29/06/2021 11:10:10
  -- PURPOSE : LISTA DE PRECIO

  PROCEDURE PP_CARGAR_CONSULTA(I_EMPRESA    IN NUMBER,
                               I_SUC_COD    varchar2,
                               I_CANAL_COD  IN varchar2,
                               I_ART_LINEA  IN varchar2,
                               I_ART_GRUPO  IN NUMBER,
                               I_ART_ENVASE IN NUMBER,
                               I_ART_CODIGO IN NUMBER,
                               I_MONEDA     IN NUMBER,
                               I_REPOSITOR  IN VARCHAR2,
                               O_NRO_LISTA  OUT VARCHAR2);
  PROCEDURE PP_ACT_REG;
  PROCEDURE PP_GUARDAR_CAMBIOS(I_EMPRESA    IN NUMBER,
                               I_SUC_CODIGO IN varchar2,
                               I_CANAL_BETA IN varchar2,
                               I_MON_CODIGO IN NUMBER,
                               I_REPOSITOR  IN VARCHAR2);

  PROCEDURE PP_COPIAR_LISTA(I_EMPRESA     IN NUMBER,
                            I_DE_SUCURSAL IN NUMBER,
                            I_DE_CANAL    IN NUMBER,
                            I_A_SUCURSAL  IN NUMBER,
                            I_A_CANAL     IN NUMBER,
                            I_DE_PRECIO   IN NUMBER,
                            I_A_PRECIO    IN NUMBER,
                            I_DE_LINEA    IN NUMBER,
                            I_GRUPO       IN NUMBER,
                            in_articulo   in number := null
                            );

  PROCEDURE PP_IMPRIMIR_LPRECIO(I_EMPRESA    IN NUMBER,
                                I_ART_ENVASE IN NUMBER,
                                I_ART_LINEA  IN VARCHAR2,
                                I_NRO_LISTA  IN VARCHAR2
                                );

  /*
    Author  : @PabloACespedes \(^-^)/
    Created : 20/06/2022 13:14:50
    comprueba si la lista se encuetra para automatizacion
  */
  function is_automated_list(
    in_lista_origen in number,
    in_linea        in number,
    in_empresa      in number 
  )return boolean;
  
END FACM070;
/
CREATE OR REPLACE PACKAGE BODY FACM070 IS
  PROCEDURE PP_CARGAR_CONSULTA(I_EMPRESA    IN NUMBER,
                               I_SUC_COD    in varchar2,
                               I_CANAL_COD  IN varchar2,
                               I_ART_LINEA  IN varchar2,
                               I_ART_GRUPO  IN NUMBER,
                               I_ART_ENVASE IN NUMBER,
                               I_ART_CODIGO IN NUMBER,
                               I_MONEDA     IN NUMBER,
                               I_REPOSITOR  IN VARCHAR2,
                               O_NRO_LISTA  OUT VARCHAR2) AS
    --================26/04/2022===========================
    CURSOR CUR_LIST(IC_NRO_LISTA IN number /*varchar2*/) IS --fas
      SELECT T.LIPR_ART,
             T.LIPR_EMPR,
             T.LIPR_NRO_LISTA_PRECIO,
             T.LIPR_PRECIO_UNITARIO,
             T.LIPR_PRECIO_US,
             T.LIPR_LINEA,
             T.LIPR_GRUPO,
             T.LIPR_ART_ALFANUMERICO,
             T.LIPR_PREC_UNI_ANTERIOR,
             T.LIPR_COSTO,
             T.LIPR_GAN_MARG,
             T.LIPR_LOR,
             T.LIPR_REDONDEO,
             T.LIPR_SUC,
             SA.ART_CODIGO,
             SA.ART_COD_ALFANUMERICO,
             SA.ART_LINEA,
             SA.ART_GRUPO,
             SA.ART_COD_BARRA,
             sa.art_empr,
             sa.art_suc
      
      /*
      FROM \*(SELECT *
                                                                                                              FROM FAC_LISTA_PRECIO_DET
                                                                                                             WHERE LIPR_NRO_LISTA_PRECIO  IN
                                                                                                                   (SELECT REGEXP_SUBSTR(IC_NRO_LISTA, '[^,]+', 1, LEVEL) A
                                                                                                                      FROM DUAL
                                                                                                                    CONNECT BY REGEXP_SUBSTR(IC_NRO_LISTA,
                                                                                                                                             '[^,]+',
                                                                                                                                             1,
                                                                                                                                             LEVEL) IS NOT NULL))*\
           FAC_LISTA_PRECIO_DET T,
           STK_ARTICULO         SA*/
      
        FROM FAC_LISTA_PRECIO_DET T, STK_ARTICULO SA
       WHERE LIPR_NRO_LISTA_PRECIO(+) = IC_NRO_LISTA
         AND (SA.ART_LINEA = I_ART_LINEA OR I_ART_LINEA IS NULL)
         AND (SA.ART_GRUPO_PRESUP = I_ART_GRUPO OR I_ART_GRUPO IS NULL)
         AND (SA.ART_ENVASE = I_ART_ENVASE OR I_ART_ENVASE IS NULL)
         AND (SA.ART_CODIGO = I_ART_CODIGO OR I_ART_CODIGO IS NULL)
         AND SA.ART_EST = 'A'
         AND SA.ART_EMPR = I_EMPRESA
         AND (SA.ART_MARCA IN (3, 11, 2, 14, 7, 13) OR
              (SA.ART_MARCA IN (10, 8, 4, 5, 8, 13, 6) AND
              NVL(SA.ART_INCL_LISTA_PRECIO, 'N') = 'S'))
         AND SA.ART_CODIGO = T.LIPR_ART(+)
         AND SA.ART_EMPR = T.LIPR_EMPR(+);
  
    v_sql         VARCHAR2(1000);
    v_cont        number := 0;
    V_NRO_LPRECIO NUMBER;
    v_desc        VARCHAR2(1000);
    v_nro         VARCHAR2(1000);
  BEGIN
  
    IF I_SUC_COD IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010, 'Sucursal no puede quedar vacio');
    END IF;
  
    IF I_CANAL_COD IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010, 'Canal no puede quedar vacio');
    END IF;
  
    IF I_MONEDA IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010, 'Moneda no puede quedar vacio');
    END IF;
  
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(P_COLLECTION_NAME => 'FACM070-NROLISTA');
  
    FOR L IN (SELECT SUCURSAL, CANAL
                FROM (SELECT REGEXP_SUBSTR(I_SUC_COD, '[^,]+', 1, LEVEL) SUCURSAL
                        FROM DUAL
                      CONNECT BY REGEXP_SUBSTR(I_SUC_COD, '[^,]+', 1, LEVEL) IS NOT NULL) SUCURSAL,
                     (SELECT REGEXP_SUBSTR(I_CANAL_COD, '[^,]+', 1, LEVEL) CANAL
                        FROM DUAL
                      CONNECT BY REGEXP_SUBSTR(I_CANAL_COD, '[^,]+', 1, LEVEL) IS NOT NULL) CANAL) LOOP
      BEGIN
      
        SELECT t.lipe_nro_lista_precio
          INTO V_NRO_LPRECIO
          FROM FAC_LISTA_PRECIO T
         WHERE t.lipe_suc = L.SUCURSAL
           AND LIPE_CANAL = L.CANAL
           AND T.LIPE_REPOSITOR = I_REPOSITOR
           AND LIPE_MON = I_MONEDA;
      EXCEPTION
        WHEN NO_dATA_FOUND THEN
          /* INSERT*/
        
          V_NRO_LPRECIO := 0;
      END;
      APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'FACM070-NROLISTA',
                                 P_N001            => V_NRO_LPRECIO);
    END LOOP;
  
    /*   BEGIN
        --raise_application_error(-20010,I_SUC_COD);
        SELECT WMSYS.WM_CONCAT(t.lipe_nro_lista_precio)
          INTO V_SQL
          FROM FAC_LISTA_PRECIO T
         WHERE LIPE_SUC IN
               (SELECT REGEXP_SUBSTR(I_SUC_COD, '[^,]+', 1, LEVEL) A
                  FROM DUAL
                CONNECT BY REGEXP_SUBSTR(I_SUC_COD, '[^,]+', 1, LEVEL) IS NOT NULL)
           AND LIPE_CANAL IN
               (SELECT REGEXP_SUBSTR(I_CANAL_COD, '[^,]+', 1, LEVEL) A
                  FROM DUAL
                CONNECT BY REGEXP_SUBSTR(I_CANAL_COD, '[^,]+', 1, LEVEL) IS NOT NULL)
           AND T.LIPE_REPOSITOR = I_REPOSITOR
           AND LIPE_MON = I_MONEDA;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
    
      END;
    */
  
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(P_COLLECTION_NAME => 'FACM070-LISTA');
  
    FOR X IN (SELECT N001 NRO_LISTA
                FROM APEX_COLLECTIONS A
               WHERE A.collection_name = 'FACM070-NROLISTA') LOOP
    
      FOR C IN CUR_LIST(IC_NRO_LISTA => x.nro_lista /*v_sql*/) LOOP
        begin
          select nvl(lipe_desc, 0)
            into v_desc
            from fac_lista_precio s
           where s.lipe_empr = c.lipr_empr
             and s.lipe_nro_lista_precio = x.nro_lista;
        exception
          when no_data_found then
            v_desc := '';
          
        end;
        APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'FACM070-LISTA',
                                   P_C001            => C.ART_CODIGO,
                                   P_C002            => C.ART_COD_ALFANUMERICO,
                                   P_C003            => C.LIPR_PRECIO_UNITARIO,
                                   P_C004            => NVL(C.LIPR_PREC_UNI_ANTERIOR,
                                                            0),
                                   P_C005            => NVL(C.LIPR_PRECIO_UNITARIO,
                                                            0),
                                   P_C006            => x.nro_lista,
                                   P_C007            => c.art_empr,
                                   P_C008            => C.ART_LINEA,
                                   P_C009            => C.ART_GRUPO,
                                   P_C010            => c.lipr_nro_lista_precio,
                                   P_C011            => C.ART_COD_BARRA,
                                   p_c012            => v_desc,
                                   p_c013            => c.art_suc);
      
      --  v_cont := v_cont + 1;
      end loop;
      v_nro := x.nro_lista;
    END LOOP;
  
    O_NRO_LISTA := v_nro;
  
  END PP_CARGAR_CONSULTA;

  PROCEDURE PP_ACT_LISTA_PREC_DET(I_LP_DET IN FAC_LISTA_PRECIO_DET%ROWTYPE) AS
  BEGIN
    NULL;
  
    UPDATE FAC_LISTA_PRECIO_DET
       SET LIPR_PREC_UNI_ANTERIOR = LIPR_PRECIO_UNITARIO,
           LIPR_PRECIO_UNITARIO   = I_LP_DET.LIPR_PRECIO_UNITARIO,
           LIPR_ART_ALFANUMERICO  = I_LP_DET.LIPR_ART_ALFANUMERICO
     WHERE LIPR_ART = I_LP_DET.LIPR_ART
       AND LIPR_NRO_LISTA_PRECIO = I_LP_DET.LIPR_NRO_LISTA_PRECIO /*IN
                                                                                   (SELECT REGEXP_SUBSTR(I_LP_DET.LIPR_NRO_LISTA_PRECIO, '[^,]+', 1, LEVEL) A
                                                                                      FROM DUAL
                                                                                    CONNECT BY REGEXP_SUBSTR(I_LP_DET.LIPR_NRO_LISTA_PRECIO, '[^,]+', 1, LEVEL) IS NOT NULL)*/
          
       AND LIPR_EMPR = I_LP_DET.LIPR_EMPR;
  
    --raise_application_error(-20001,I_LP_DET.LIPR_NRO_LISTA_PRECIO|| '-' ||I_LP_DET.LIPR_PRECIO_UNITARIO  );
    IF SQL%NOTFOUND THEN
      INSERT INTO FAC_LISTA_PRECIO_DET
        (LIPR_EMPR,
         LIPR_NRO_LISTA_PRECIO,
         LIPR_ART,
         LIPR_PRECIO_UNITARIO,
         LIPR_PREC_UNI_ANTERIOR,
         LIPR_PRECIO_US,
         LIPR_LINEA,
         LIPR_GRUPO,
         LIPR_ART_ALFANUMERICO)
      VALUES
        (I_LP_DET.LIPR_EMPR,
         I_LP_DET.LIPR_NRO_LISTA_PRECIO,
         I_LP_DET.LIPR_ART,
         I_LP_DET.LIPR_PRECIO_UNITARIO,
         I_LP_DET.LIPR_PREC_UNI_ANTERIOR,
         I_LP_DET.LIPR_PRECIO_US,
         I_LP_DET.LIPR_LINEA,
         I_LP_DET.LIPR_GRUPO,
         I_LP_DET.LIPR_ART_ALFANUMERICO);
    END IF;
  
  END PP_ACT_LISTA_PREC_DET;

  PROCEDURE PP_ACT_REG AS
    --V_ART_CODIGO      NUMBER := V('ART_CODIGO');
    V_ART_PRECIO_UNIR NUMBER := V('LIPR_PRECIO_UNITARIO');
    V_SEQ_ID          NUMBER := V('SEQ_ID');
    V_PRECIO_ACTUAL   NUMBER := V('PRECIO_ACTUAL');
    v_precio          number := V('LIPR_PRECIO_UNITARIO');
    v_prueba          number := V('SEQ_ID');
  
  BEGIN
    --  raise_application_error ( -20001,v_prueba ) ;
    --v_id := v_prueba;
    -- v_precio_u := v_precio;
    -- v_art := V_ART_CODIGO;
    APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'FACM070-LISTA',
                                            P_SEQ             => V_SEQ_ID,
                                            P_ATTR_NUMBER     => 4,
                                            P_ATTR_VALUE      => V_PRECIO_ACTUAL);
  
    APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'FACM070-LISTA',
                                            P_SEQ             => V_SEQ_ID,
                                            P_ATTR_NUMBER     => 3,
                                            P_ATTR_VALUE      => V_ART_PRECIO_UNIR);
  
    APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'FACM070-LISTA',
                                            P_SEQ             => V_SEQ_ID,
                                            P_ATTR_NUMBER     => 5,
                                            P_ATTR_VALUE      => V_ART_PRECIO_UNIR);
  
  END PP_ACT_REG;

  PROCEDURE PP_LISTA_PRECIO(I_EMPRESA    IN NUMBER,
                            I_SUC_CODIGO IN varchar2,
                            I_CANAL_BETA IN varchar2,
                            I_MON_CODIGO IN NUMBER,
                            I_REPOSITOR  IN VARCHAR2,
                            O_NRO_LISTA  OUT VARCHAR2) AS
    v_sql     FAC_LISTA_PRECIO%ROWTYPE;
    V_FLP     varchar2(210); --FAC_LISTA_PRECIO%ROWTYPE;
    V_SUC     GEN_SUCURSAL%ROWTYPE;
    V_FCB     FAC_CANAL_VENTA_BETA%ROWTYPE;
    V_NRO_MAX NUMBER;
    V_DESC    VARCHAR2(50);
  BEGIN
    SELECT WMSYS.WM_CONCAT(t.lipe_nro_lista_precio)
      INTO V_FLP
      FROM FAC_LISTA_PRECIO T
     WHERE LIPE_SUC IN
           (SELECT REGEXP_SUBSTR(I_SUC_CODIGO, '[^,]+', 1, LEVEL) A
              FROM DUAL
            CONNECT BY REGEXP_SUBSTR(I_SUC_CODIGO, '[^,]+', 1, LEVEL) IS NOT NULL)
       AND LIPE_CANAL IN
           (SELECT REGEXP_SUBSTR(I_CANAL_BETA, '[^,]+', 1, LEVEL) A
              FROM DUAL
            CONNECT BY REGEXP_SUBSTR(I_CANAL_BETA, '[^,]+', 1, LEVEL) IS NOT NULL)
       AND T.LIPE_MON = I_MON_CODIGO
       AND T.LIPE_REPOSITOR = I_REPOSITOR
       AND T.LIPE_EMPR = I_EMPRESA;
    O_NRO_LISTA := V_FLP;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
    
      SELECT NVL(MAX(T.LIPE_NRO_LISTA_PRECIO), 1000) + 1 A
        INTO V_NRO_MAX
        FROM FAC_LISTA_PRECIO T
       WHERE T.LIPE_EMPR = I_EMPRESA
         AND T.LIPE_NRO_LISTA_PRECIO > 998;
      --==f
      SELECT * --SUC_EMPR, SUC_CODIGO, SUC_DESC, SUC_DESC_ABREV
        INTO V_SUC
        FROM GEN_SUCURSAL S
       WHERE S.SUC_EMPR = I_EMPRESA
         AND SUC_CODIGO IN
             (SELECT REGEXP_SUBSTR(I_SUC_CODIGO, '[^,]+', 1, LEVEL) A
                FROM DUAL
              CONNECT BY REGEXP_SUBSTR(I_SUC_CODIGO, '[^,]+', 1, LEVEL) IS NOT NULL);
    
      SELECT *
        INTO V_FCB
        FROM FAC_CANAL_VENTA_BETA B
       WHERE B.CANB_EMPR = I_EMPRESA
         AND CANB_CODIGO IN
             (SELECT REGEXP_SUBSTR(I_CANAL_BETA, '[^,]+', 1, LEVEL) A
                FROM DUAL
              CONNECT BY REGEXP_SUBSTR(I_CANAL_BETA, '[^,]+', 1, LEVEL) IS NOT NULL);
    
      v_sql.lipe_empr             := I_EMPRESA;
      v_sql.lipe_nro_lista_precio := V_NRO_MAX;
      v_sql.lipe_mon              := I_MON_CODIGO;
    
      V_DESC := SUBSTR(V_SUC.SUC_DESC_ABREV, 0, 20);
      IF I_REPOSITOR = 'S' THEN
        V_DESC := V_DESC || ' - ' || 'REPOS';
      END IF;
      V_DESC := V_DESC || ' - ' || SUBSTR(V_FCB.CANB_DESC, 0, 10);
    
      v_sql.LIPE_DESC := SUBSTR(V_DESC, 0, 30);
    
      /*SUBSTR(V_SUC.SUC_DESC_ABREV || ' - ' || ,
      0,
      20);*/
    
      --V_FLP.LIPE_TASA,
      v_sql.LIPE_SUC       := I_SUC_CODIGO;
      v_sql.LIPE_CANAL     := I_CANAL_BETA;
      V_sql.LIPE_REPOSITOR := I_REPOSITOR;
    
      INSERT INTO FAC_LISTA_PRECIO VALUES v_sql;
    
      O_NRO_LISTA := V_NRO_MAX;
    
  END PP_LISTA_PRECIO;
  --
  PROCEDURE PP_GUARDAR_CAMBIOS(I_EMPRESA    IN NUMBER,
                               I_SUC_CODIGO IN varchar2,
                               I_CANAL_BETA IN varchar2,
                               I_MON_CODIGO IN NUMBER,
                               I_REPOSITOR  IN VARCHAR2) AS
  
    cursor collection is
      select A.C010 nro_lista_precio,
             a.c001 art_codigo,
             a.c002 cod_alfanumerico,
             a.c003 precio_actual,
             a.c004 precio_anterior,
             a.c007 empresa,
             a.C008 LINEA,
             c009   GRUPO,
             c006   nro_lista
      
        FROM APEX_COLLECTIONS A
       WHERE A.COLLECTION_NAME = 'FACM070-LISTA';
    v_cont   number := 0;
    I_LP_DET FAC_LISTA_PRECIO_DET%ROWTYPE;
  BEGIN
    --raise_application_error (-20001,I_LP_DET.LIPR_NRO_LISTA_PRECIO);
    /*PP_LISTA_PRECIO(I_EMPRESA    => I_EMPRESA,
      I_SUC_CODIGO => I_SUC_CODIGO,
      I_CANAL_BETA => I_CANAL_BETA,
      I_MON_CODIGO => I_MON_CODIGO,
      I_REPOSITOR  => I_REPOSITOR,
      O_NRO_LISTA  => V_NRO_LISTA);
      FOR C IN CUR_DATOS LOOP
        I_LP_DET.LIPR_EMPR              := I_EMPRESA;
        I_LP_DET.LIPR_NRO_LISTA_PRECIO  := V_NRO_LISTA;
        I_LP_DET.LIPR_ART               := C.ART_CODIGO;
        I_LP_DET.LIPR_PRECIO_UNITARIO   := C.LIPR_PRECIO_UNITARIO;
        I_LP_DET.LIPR_PREC_UNI_ANTERIOR := C.LIPR_PREC_UNI_ANTERIOR;
        I_LP_DET.LIPR_PRECIO_US         := 0;
        I_LP_DET.LIPR_LINEA             := C.ART_LINEA;
        I_LP_DET.LIPR_GRUPO             := C.ART_GRUPO;
        I_LP_DET.LIPR_ART_ALFANUMERICO  := C.ART_COD_ALFANUMERICO;
    
       PP_ACT_LISTA_PREC_DET(I_LP_DET => I_LP_DET);
    END LOOP;*/
  
    for c in collection loop
    
      UPDATE FAC_LISTA_PRECIO_DET
         SET LIPR_PREC_UNI_ANTERIOR = LIPR_PRECIO_UNITARIO,
             LIPR_PRECIO_UNITARIO   = c.precio_actual,
             LIPR_ART_ALFANUMERICO  = c.cod_alfanumerico
       WHERE LIPR_ART = c.art_codigo
         AND LIPR_NRO_LISTA_PRECIO = c.nro_lista_precio
         AND LIPR_EMPR = c.empresa;
    
      IF SQL%NOTFOUND THEN
        --raise_application_error(-20001, c.nro_lista );
        INSERT INTO FAC_LISTA_PRECIO_DET
          (LIPR_EMPR,
           LIPR_NRO_LISTA_PRECIO,
           LIPR_ART,
           LIPR_PRECIO_UNITARIO,
           LIPR_PREC_UNI_ANTERIOR,
           LIPR_PRECIO_US,
           LIPR_LINEA,
           LIPR_GRUPO,
           LIPR_ART_ALFANUMERICO)
        VALUES
          (c.empresa,
           c.nro_lista,
           c.art_codigo,
           c.precio_actual,
           c.precio_anterior,
           0,
           c.linea,
           c.grupo,
           c.cod_alfanumerico);
      end if;
      
      /*
        Author  : @PabloACespedes \(^-^)/
        Created : 20/06/2022 13:34:11
        comprueba si es para automatizar el cambio en la otra lista
        configurada
        y hace una copia para el cambio de precio
      */
      if is_automated_list(in_lista_origen => c.nro_lista_precio,
                           in_linea        => c.linea,
                           in_empresa      => c.empresa
                           )
      then
        <<upd_list_target>>
        for i in 
          (select f.lista_destino_nro destino, 
                  f.grupo_destino_cod grupo
           from fac_conf_copia_lista_precio f
           where f.lista_origen_nro          = c.nro_lista_precio
           and   nvl(f.linea_cod, 1)         = nvl(c.linea, 1)
           and   f.empresa_cod               = c.empresa
          )
        loop
          pp_copiar_lista(i_empresa     => c.empresa,
                          i_de_sucursal => null,
                          i_de_canal    => null,
                          i_a_sucursal  => null,
                          i_a_canal     => null,
                          i_de_precio   => c.nro_lista_precio,
                          i_a_precio    => i.destino,
                          i_de_linea    => c.linea,
                          i_grupo       => i.grupo,
                          in_articulo   => c.art_codigo
                          );
        end loop upd_list_target;
      end if;
                           
    end loop;
  
  END PP_GUARDAR_CAMBIOS;

  PROCEDURE PP_COPIAR_LISTA(I_EMPRESA     IN NUMBER,
                            I_DE_SUCURSAL IN NUMBER,
                            I_DE_CANAL    IN NUMBER,
                            I_A_SUCURSAL  IN NUMBER,
                            I_A_CANAL     IN NUMBER,
                            I_DE_PRECIO   IN NUMBER,
                            I_A_PRECIO    IN NUMBER,
                            I_DE_LINEA    IN NUMBER,
                            I_GRUPO       IN NUMBER,
                            in_articulo   in number := null
                            ) AS
  
    CURSOR CUR_LIST(IC_NRO_LISTA IN NUMBER) IS
      SELECT T.LIPR_EMPR,
             T.LIPR_NRO_LISTA_PRECIO,
             T.LIPR_ART,
             T.LIPR_PRECIO_UNITARIO,
             T.LIPR_PRECIO_US,
             T.LIPR_LINEA,
             T.LIPR_GRUPO,
             T.LIPR_ART_ALFANUMERICO,
             T.LIPR_PREC_UNI_ANTERIOR,
             T.LIPR_COSTO,
             T.LIPR_GAN_MARG,
             T.LIPR_LOR,
             T.LIPR_REDONDEO,
             T.LIPR_SUC,
             SA.ART_CODIGO,
             SA.ART_COD_ALFANUMERICO,
             SA.ART_LINEA,
             SA.ART_GRUPO
        FROM FAC_LISTA_PRECIO_DET T, STK_ARTICULO SA
       WHERE LIPR_NRO_LISTA_PRECIO(+) = IC_NRO_LISTA
         AND SA.ART_EST = 'A'
         AND SA.ART_EMPR = I_EMPRESA
         and (in_articulo is null or sa.art_codigo = in_articulo) --> todos o uno en especifico
         AND (SA.ART_LINEA = I_DE_LINEA OR I_DE_LINEA IS NULL)
         AND (SA.ART_MARCA IN (3, 11, 2, 14, 7, 13) OR
              (SA.ART_MARCA IN (10, 8, 4, 5, 8, 13, 6) AND
              NVL(SA.ART_INCL_LISTA_PRECIO, 'N') = 'S'))
         AND SA.ART_CODIGO = T.LIPR_ART(+)
         AND SA.ART_EMPR = T.LIPR_EMPR(+)
         AND (SA.ART_GRUPO_PRESUP = I_GRUPO OR I_GRUPO IS NULL);
  
    V_NRO_LISTA_ORIGEN  NUMBER;
    V_NRO_LISTA_DESTINO NUMBER;
    I_LP_DET            FAC_LISTA_PRECIO_DET%ROWTYPE;
  
  BEGIN
  
    /*PP_LISTA_PRECIO(I_EMPRESA    => I_EMPRESA,
    I_SUC_CODIGO => I_A_SUCURSAL,
    I_CANAL_BETA => I_A_CANAL,
    I_MON_CODIGO => 1,
    O_NRO_LISTA  => V_NRO_LISTA_DESTINO);*/
    
   --raise_application_error ( -20001,  I_DE_LINEA ) ;
    IF I_DE_PRECIO IS NULL OR I_A_PRECIO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Favor completar todos los datos para hacer la copia');
    END IF;
    V_NRO_LISTA_ORIGEN  := I_DE_PRECIO;
    V_NRO_LISTA_DESTINO := I_A_PRECIO;
  
    FOR C IN CUR_LIST(IC_NRO_LISTA => V_NRO_LISTA_ORIGEN) LOOP
      I_LP_DET.LIPR_EMPR              := I_EMPRESA;
      I_LP_DET.LIPR_NRO_LISTA_PRECIO  := V_NRO_LISTA_DESTINO;
      I_LP_DET.LIPR_ART               := C.ART_CODIGO;
      I_LP_DET.LIPR_PRECIO_UNITARIO   := C.LIPR_PRECIO_UNITARIO;
      I_LP_DET.LIPR_PREC_UNI_ANTERIOR := C.LIPR_PREC_UNI_ANTERIOR;
      I_LP_DET.LIPR_PRECIO_US         := 0;
      I_LP_DET.LIPR_LINEA             := C.ART_LINEA;
      I_LP_DET.LIPR_GRUPO             := C.ART_GRUPO;
      I_LP_DET.LIPR_ART_ALFANUMERICO  := C.ART_COD_ALFANUMERICO;
    
      PP_ACT_LISTA_PREC_DET(I_LP_DET => I_LP_DET);
    
    END LOOP;
  
  END PP_COPIAR_LISTA;

  PROCEDURE PP_IMPRIMIR_LPRECIO(I_EMPRESA    IN NUMBER,
                                I_ART_ENVASE IN NUMBER,
                                I_ART_LINEA  IN VARCHAR2,
                                I_NRO_LISTA  IN VARCHAR2) AS
  
    V_PARAMETROS    VARCHAR2(600);
    V_IDENTIFICADOR VARCHAR2(2) := '&'; --SE UTILIZA PARA QUE AL COMPILAR NO LO TOME COMO PARAMETROS
    I_REPORT        VARCHAR2(40) := 'FACM070_LISTA_PRECIO';
  
  BEGIN
  
    V_PARAMETROS := 'P_FORMATO=' || URL_ENCODE('pdf');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                    URL_ENCODE(I_EMPRESA);
    IF I_ART_ENVASE IS NOT NULL THEN
      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_ART_ENVASE=' ||
                      URL_ENCODE(I_ART_ENVASE);
    END IF;
  
    IF I_ART_LINEA IS NOT NULL THEN
      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_ART_LINEA=' ||
                      URL_ENCODE(I_ART_LINEA);
    END IF;
  
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_NRO_LISTA=' ||
                    URL_ENCODE(I_NRO_LISTA);
  
    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = GEN_DEVUELVE_USER;
  
    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
    VALUES
      (V_PARAMETROS, GEN_DEVUELVE_USER, I_REPORT, 'pdf');
  
  END PP_IMPRIMIR_LPRECIO;
  
  function is_automated_list(
    in_lista_origen in number,
    in_linea        in number,
    in_empresa      in number 
  )return boolean is
  l_c number;
  begin
              
    select distinct 1 into l_c
    from fac_conf_copia_lista_precio f
    where f.empresa_cod       = in_empresa
    and   f.lista_origen_nro  = in_lista_origen
    and   nvl(f.linea_cod, 1) = nvl(in_linea, 1);
    
    return true;
    
  exception
    when no_data_found then
      return false;
  end is_automated_list;
  
END FACM070;
/
