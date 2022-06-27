create or replace package STKM011_GRAL is

  PROCEDURE PP_BUSCAR_MONEDA (P_MONEDA IN OUT NUMBER,
                              P_MON_DESC OUT VARCHAR2);

  PROCEDURE PP_BUSCAR_COTIZACION (P_MONEDA      IN NUMBER,
                                  P_COT_FEC     IN DATE,
                                  P_COT_COMPRA  OUT NUMBER,
                                  P_S_COMPRA    OUT VARCHAR2,
                                  P_COT_VENTA   OUT NUMBER,
                                  P_S_VENTA     OUT VARCHAR2,
                                  P_TIPO_REG    OUT VARCHAR2);

  PROCEDURE PP_VALIDAR_MONTO (P_MONTO IN OUT VARCHAR2,
                              P_COT_MONTO OUT NUMBER);

  PROCEDURE PP_ACTUALIZAR_REGISTRO (P_COT_FEC                IN DATE,
                                    P_MONEDA                 IN NUMBER,
                                    P_PREC_COMPRA            IN NUMBER,
                                    P_PREC_VENTA             IN NUMBER,
                                    P_TIPO_REG               IN VARCHAR2,
                                    P_LOGIN                  IN VARCHAR2);


end STKM011_GRAL;
/
create or replace package body STKM011_GRAL is


  PROCEDURE PP_BUSCAR_MONEDA (P_MONEDA IN OUT  NUMBER,
                              P_MON_DESC OUT VARCHAR2)IS

  BEGIN
    IF P_MONEDA IS NOT NULL THEN
     BEGIN
       SELECT DISTINCT DECODE(MON_CODIGO,
                              1,
                              'GUARANIES',
                              2,
                              'DOLARES AMERICANOS',
                              3,
                              'REALES',
                              4,
                              'PESO ARGENTINO',
                              5,
                              'LIRA ITALIANA') MONEDA
         INTO P_MON_DESC
         FROM GEN_MONEDA
        WHERE MON_CODIGO = P_MONEDA;
        P_MONEDA := P_MONEDA;
     EXCEPTION
       WHEN NO_DATA_FOUND THEN
          RAISE_APPLICATION_ERROR (-20001, 'El tipo de moneda no existe');
         P_MONEDA := NULL;
      END;
  END IF;
  END PP_BUSCAR_MONEDA;


  PROCEDURE PP_BUSCAR_COTIZACION (P_MONEDA     IN NUMBER,
                                  P_COT_FEC     IN DATE,
                                  P_COT_COMPRA  OUT NUMBER,
                                  P_S_COMPRA    OUT VARCHAR2,
                                  P_COT_VENTA   OUT NUMBER,
                                  P_S_VENTA     OUT VARCHAR2,
                                  P_TIPO_REG    OUT VARCHAR2) IS

    V_VENTA NUMBER;
    V_COMPRA  NUMBER;
  BEGIN
        IF P_COT_FEC < '20/09/2019' THEN
            RAISE_APPLICATION_ERROR (-20001, 'En este programa no puede realizar mofidicaciones de fechas anteriores al 20/09/2019.Datos unificados a partir de la fecha 20/09/2019');
        ELSE
             BEGIN
                SELECT DISTINCT  A.COT_COMPRA, A.COT_VENTA
                  INTO  V_COMPRA, V_VENTA
                  FROM STK_COTIZACION A
                 WHERE A.COT_FEC = P_COT_FEC
                   AND A.COT_MON = P_MONEDA;

                   P_COT_COMPRA :=  V_COMPRA;
                   P_S_COMPRA :=  TO_CHAR (V_COMPRA, '999G999G999G999G990D99');
                   P_COT_VENTA :=  V_VENTA;
                   P_S_VENTA :=  TO_CHAR (V_VENTA, '999G999G999G999G990D99');
                   P_TIPO_REG := 'EDITAR';

               EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                      NULL;
                      P_TIPO_REG := 'GUARDAR';
                   WHEN TOO_MANY_ROWS THEN
                      RAISE_APPLICATION_ERROR (-20001, 'Avise al administrador, ');
                      P_TIPO_REG := NULL;
               END;
        END IF;


  END PP_BUSCAR_COTIZACION;

  PROCEDURE PP_VALIDAR_MONTO (P_MONTO IN OUT VARCHAR2,
                              P_COT_MONTO OUT NUMBER) IS
  BEGIN
       IF P_MONTO IS NOT NULL AND P_MONTO < 1 THEN
             RAISE_APPLICATION_ERROR (-20001, 'El monto no puede ser negativo, ni cero');
       ELSIF P_MONTO IS NOT NULL AND P_MONTO > 0 THEN
             P_COT_MONTO := P_MONTO;
             P_MONTO := TO_CHAR(P_MONTO, '999G999G999G999G990D99');
       ELSIF P_MONTO IS NULL THEN
             RAISE_APPLICATION_ERROR (-20001, 'El monto no puede quedar vacio');
             P_COT_MONTO := NULL;
             P_MONTO := NULL;
       END IF;




  END PP_VALIDAR_MONTO;

  PROCEDURE PP_ACTUALIZAR_REGISTRO (P_COT_FEC                IN DATE,
                                    P_MONEDA                 IN NUMBER,
                                    P_PREC_COMPRA            IN NUMBER,
                                    P_PREC_VENTA             IN NUMBER,
                                    P_TIPO_REG               IN VARCHAR2,
                                    P_LOGIN                  IN VARCHAR2) IS




    CURSOR MON_COTIZACION IS SELECT MON_EMPR
                               FROM GEN_MONEDA
                              WHERE MON_CODIGO = P_MONEDA
                              ORDER BY 1;

        COTI_TASA NUMBER;
   BEGIN

     IF P_COT_FEC IS NULL THEN
       RAISE_APPLICATION_ERROR (-20001, 'La fecha no puede quedar vacia');
     END IF;

     IF P_MONEDA IS NULL THEN
       RAISE_APPLICATION_ERROR (-20001, 'El tipo de moneda no puede quedar vacia');
     END IF;

     IF P_PREC_COMPRA IS NULL THEN
       RAISE_APPLICATION_ERROR (-20001, 'El precio de compra no puede quedar vacio');
     END IF;

     IF P_PREC_VENTA IS NULL THEN
       RAISE_APPLICATION_ERROR (-20001, 'El precio de venta no puede quedar vacio');
     END IF;

     IF P_PREC_COMPRA > P_PREC_COMPRA THEN
       RAISE_APPLICATION_ERROR (-20001, 'El precio de venta no puede ser menor que el precio de compra');
     END IF;

     IF P_COT_FEC < '14/08/2019' THEN
            RAISE_APPLICATION_ERROR (-20001, 'Datos unificados a partir de la fecha 14/08/2019');
     END IF;

     --COTI_TASA := ROUND(((P_PREC_COMPRA + P_PREC_VENTA)/2),2);  -- ESTA COTIZACION ES VALIDA PARA TODAS LAS EMPRESAS EXCEPTO TRANSAGRO
                                                                 -- EN TRANSAGRO SE GUARDA EN COT_TASA EL PRECIO DE VENTA;




     IF P_TIPO_REG = 'GUARDAR' THEN

        FOR V IN MON_COTIZACION LOOP
                COTI_TASA := 0;
                IF V.MON_EMPR = 2 THEN
                   COTI_TASA := ROUND(P_PREC_VENTA);
                ELSE
                   COTI_TASA  := ROUND(((P_PREC_COMPRA + P_PREC_VENTA)/2));
                END IF;
               BEGIN
                  INSERT INTO STK_COTIZACION
                    (COT_FEC,
                     COT_MON,
                     COT_TASA,
                     COT_EMPR,
                     COT_FEC_INGRESO,
                     COT_LOGIN_INGRESO,
                     COT_COMPRA,
                     COT_VENTA)
                  VALUES
                    (TO_DATE(P_COT_FEC, 'DD/MM/YYYY'),
                     P_MONEDA,
                     COTI_TASA,
                     V.MON_EMPR,
                     SYSDATE,
                     'ADCS',
                     P_PREC_COMPRA,
                     P_PREC_VENTA);
               EXCEPTION
                 WHEN OTHERS THEN
                  RAISE_APPLICATION_ERROR (-20001, 'Error al insertar, avise al departamento de informatica');
               END;
               
               -- 27/06/2022 16:11:55 @PabloACespedes \(^-^)/
               -- inserta en consultagro
               <<ins_cagro>>  
               declare
               l_error varchar2(32000);
               begin
                 insert into stk_cotizacion_cagro
                    (cot_fec,
                     cot_mon,
                     cot_tasa,
                     cot_empr,
                     cot_fec_ingreso,
                     cot_login_ingreso,
                     cot_compra,
                     cot_venta)
                  values
                    (to_date(p_cot_fec, 'DD/MM/YYYY'),
                     p_moneda,
                     coti_tasa,
                     v.mon_empr,
                     sysdate,
                     'ADCS',
                     p_prec_compra,
                     p_prec_venta
                     );
               exception
                 when others then
                 l_error := SQLERRM;
                       
                 insert into STK_ERROR_COTIZACION(moneda,
                                              error)
                 values(p_moneda,
                        l_error                         
                    );
               end ins_cagro;  
        END LOOP;
      ELSE
          FOR V IN MON_COTIZACION LOOP

                IF V.MON_EMPR = 2 THEN
                   COTI_TASA := ROUND(P_PREC_VENTA);
                 else
                   COTI_TASA := ROUND(((P_PREC_COMPRA + P_PREC_VENTA)/2));
                END IF;
                   UPDATE STK_COTIZACION
                     SET COT_TASA = COTI_TASA,
                         COT_FEC_INGRESO = SYSDATE,
                         COT_LOGIN_INGRESO = P_LOGIN,
                         COT_COMPRA = P_PREC_COMPRA,
                         COT_VENTA = P_PREC_VENTA
                   WHERE COT_MON = P_MONEDA
                     AND COT_FEC = P_COT_FEC
                     AND COT_EMPR = V.MON_EMPR;
                   
                   -- 27/06/2022 16:11:55 @PabloACespedes \(^-^)/
                   -- actualiza consultagro
                   <<upd_cagro>> 
                   declare
                   l_error varchar2(32000);
                   begin
                     update stk_cotizacion_cagro
                     set cot_tasa = coti_tasa,
                         cot_fec_ingreso = sysdate,
                         cot_login_ingreso = p_login,
                         cot_compra = p_prec_compra,
                         cot_venta = p_prec_venta
                     where cot_mon = p_moneda
                       and cot_fec = p_cot_fec
                       and cot_empr = v.mon_empr;
                   exception
                     when others then
                       l_error := SQLERRM;
                       
                       insert into STK_ERROR_COTIZACION(moneda,
                                                    error)
                       values(p_moneda,
                              l_error                         
                          );
                   end upd_cagro;  

          END LOOP;
      END IF;

   END PP_ACTUALIZAR_REGISTRO;

end STKM011_GRAL;
/
