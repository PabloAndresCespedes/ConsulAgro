create or replace procedure PP_ENVIAR_MAIL_TRASPASOS (P_SISTEMA IN NUMBER) is

  SALUDO VARCHAR2(15);
  HORA NUMBER;
  SISTEMA VARCHAR2(150);
  DESTINATARIO VARCHAR2(600);
  COPIA VARCHAR(600);
  OCULTA VARCHAR2(150);

  CURSOR SISTEMAS IS
    SELECT '* '||SIST_DESC||'.' SISTEMA
      FROM GEN_SISTEMA
     WHERE SIST_CODIGO IN (
    SELECT REGEXP_SUBSTR(P_SISTEMA, '[^:]+', 1, LEVEL) CANAL
      FROM DUAL
   CONNECT BY REGEXP_SUBSTR(P_SISTEMA, '[^:]+', 1, LEVEL) IS NOT NULL);

BEGIN
  SELECT TO_CHAR(SYSDATE,'HH24') INTO HORA FROM DUAL;
  SELECT T.CO_PARA, T.CO_CC, T.CO_CCO
    INTO DESTINATARIO, COPIA, OCULTA
    FROM GEN_CORREOS T
   WHERE T.CO_ACCION = 'Desarrollo_Produccion';
  if hora < 12 then
    saludo := 'Buenos dias';
  elsif hora >= 12 and hora < 18 then
    saludo := 'Buenas tardes';
  else
    saludo := 'Buenas noches';
  end if;

  FOR V IN SISTEMAS LOOP
    sistema := sistema ||'
'|| v.sistema;
  END LOOP;
if DESTINATARIO is not null then
    -- 01/07/2022 11:17:32 @PabloACespedes \(^-^)/
    -- Se_removio sys.UTL_MAIL >>UTL_MAIL
    UTL_MAIL.SEND(sender     => 'noreply', --'dboracle@hilagro.com.py',
                    recipients => DESTINATARIO,
                    cc         => COPIA,  --'gerenciati@hilagro.com.py, informatica@transagro.com.py',
                    bcc        => OCULTA,
                    subject    => 'Actualizacion de Modulos',
                    message    => saludo || '.

Se ha actualizado los siguientes modulos: ' || sistema,
                    mime_type  => 'text/plain');
end if;
EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('El siguiente error ha ocurrido: ' || sqlerrm);

end PP_ENVIAR_MAIL_TRASPASOS;
/
