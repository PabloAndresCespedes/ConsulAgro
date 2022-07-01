create or replace procedure PP_ENVIAR_MAIL_PERI_ANT_FIN_DT(P_CLAVE       IN NUMBER DEFAULT NULL,
                                                           I_EMPRESA     IN NUMBER DEFAULT NULL,
                                                           V_IND         IN VARCHAR2 DEFAULT NULL,
                                                           I_ITEM        IN NUMBER DEFAULT NULL,
                                                           D_FEC_EMISION IN DATE DEFAULT NULL,
                                                           V_USER        IN VARCHAR2 DEFAULT NULL) IS
  SALUDO       VARCHAR2(15);
  HORA         NUMBER;
  DESTINATARIO VARCHAR2(600);
  COPIA        VARCHAR(600);
  OCULTA       VARCHAR2(150);
  TIPO         VARCHAR2(50);
  FECHA        DATE;
BEGIN
  ----------------------------------------------------------------------------------------
  SELECT TO_CHAR(SYSDATE, 'HH24') INTO HORA FROM DUAL;
  SELECT T.CO_PARA, T.CO_CC, T.CO_CCO
    INTO DESTINATARIO, COPIA, OCULTA
    FROM GEN_CORREOS T
   WHERE T.CO_ACCION = 'Apertura_Periodo_Cerrado'
     AND T.CO_EMPR = I_EMPRESA;
  if hora < 12 then
    saludo := 'Buenos dias';
  elsif hora >= 12 and hora < 18 then
    saludo := 'Buenas Tardes';
  else
    saludo := 'Buenas Noches';
  end if;

  IF V_IND = 'I' THEN
    TIPO := 'Insertado';
  ELSIF V_IND = 'U' THEN
    TIPO := 'Actualizado';
  else
    TIPO := 'Eliminado';
  end if;

  SELECT TO_DATE(SYSDATE, 'DD/MM/YYYY') INTO FECHA FROM DUAL;

  if DESTINATARIO is not null then
    -- 01/07/2022 11:15:14 @PabloACespedes \(^-^)/
    -- Se_removio SYS.UTL_MAIL >> UTL_MAIL
    UTL_MAIL.SEND(sender     => 'noreply',
                      recipients => DESTINATARIO,
                      cc         => COPIA,
                      bcc        => OCULTA,
                      subject    => 'ATENCION!! Abertura Periodo Cerrado',
                      message    => saludo || '.
Se a ' || TIPO ||
                                     ' Una Factura Detalle de Finanzas del Mes Anterior Tenga Cuidado,Para Que No Haya Diferencia. ' ||
                                     ' Nro de Documento: ' || P_CLAVE ||
                                     ' Nro de Item: ' || I_ITEM ||
                                     ' Fecha Ingresada: ' || FECHA ||
                                     ' Fecha Afectada: ' || D_FEC_EMISION ||
                                     ' Usuario: ' || V_USER,
                      mime_type  => 'text/plain');
  end if;
  /*
  EXCEPTION
    WHEN OTHERS THEN
      raise_application_error(-20010, 'DOC CLAVE ' ||P_CLAVE);

      raise_application_error(-20010,
                              'El siguiente error a ocurrido: ' || sqlerrm);*/
end PP_ENVIAR_MAIL_PERI_ANT_FIN_DT;
/
