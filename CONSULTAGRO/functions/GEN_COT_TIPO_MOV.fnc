CREATE OR REPLACE FUNCTION GEN_COT_TIPO_MOV(P_EMPRESA  IN NUMBER,
                                            P_MONEDA   IN NUMBER,
                                            P_TIPO_MOV IN NUMBER,
                                            P_FECHA    IN DATE)
  RETURN NUMBER IS
  V_COT_COMPRA NUMBER;
  V_COT_VENTA  NUMBER;
  V_IND_ER     VARCHAR(2);
BEGIN

  IF P_FECHA <= TO_DATE('31/12/2021') THEN
    --======EN EL HISTORICO SE USA ESTA FUNCION ---APERALTA
    RETURN FIN_BUSCAR_COTIZACION_FEC(FEC  => P_FECHA,
                                     MON  => P_MONEDA,
                                     EMPR => P_EMPRESA);
  
  ELSE
  
    --====ESTO EMPIEZA FUNCIONAR RECIEN APARTIR  DE ENERO 2022 
 

  SELECT TMOV_TIPO_COTIZACION
    INTO V_IND_ER
    FROM GEN_TIPO_MOV T
   WHERE T.TMOV_CODIGO = P_TIPO_MOV
     AND T.TMOV_EMPR = P_EMPRESA;
     
   IF V_IND_ER IS NULL THEN
     RAISE_APPLICATION_ERROR(-20001,'Falta asignar el tipo de tasa al movimiento '||P_TIPO_MOV ||'. Favor avisar al Dpto Administrativo!.');
     END IF;

  BEGIN
    
    SELECT CT.COT_COMPRA, CT.COT_VENTA
      INTO V_COT_COMPRA, V_COT_VENTA
      FROM STK_COTIZACION CT
     WHERE COT_FEC = NVL(TO_CHAR(TRUNC(TO_DATE(P_FECHA)),'DD/MM/YYYY'), TRUNC(SYSDATE))
       AND COT_MON = P_MONEDA
       AND COT_EMPR = 1; ---SE DEFINIO QUE TODA LAS COTIZACIONES SOLO VA A ESTIRAR DE LA EMPRESA 1
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      IF P_MONEDA = 1 THEN
        RETURN 1;
      ELSE
        BEGIN
          SELECT CT.COT_COMPRA, CT.COT_VENTA
            INTO V_COT_COMPRA, V_COT_VENTA
            FROM STK_COTIZACION CT
           WHERE COT_FEC = nvl(P_FECHA, TRUNC(SYSDATE))
             AND COT_MON = P_MONEDA
             AND COT_EMPR = 1;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
          
            RAISE_APPLICATION_ERROR(-20001,
                                    'Primero debe ingresar la cotizacion del dia ' ||
                                    P_FECHA || ' para la moneda ' ||
                                    P_MONEDA || '.!');
        END;
      END IF;
  END;

  
    IF V_IND_ER = 'C' THEN
      RETURN V_COT_COMPRA;
    ELSE
      RETURN V_COT_VENTA;
    END IF;

  END IF;

END GEN_COT_TIPO_MOV;
/
