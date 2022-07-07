create or replace procedure PP_ENVIO_FEC_NAC_TA IS
  CURSOR REC_CUR IS
    SELECT PNA_NOMBRE,
           nvl(PNA_TELEFONO, 'Sin Datos') PNA_TELEFONO,
           nvl(PNA_EMAIL, 'Sin Datos') PNA_EMAIL,
           nvl(PNA_CELULAR, 'Sin Datos') PNA_CELULAR
      FROM FIN_PERSONA
     WHERE TO_CHAR(PNA_FEC_NAC, 'DD/MM') = TO_CHAR(TRUNC(SYSDATE), 'DD/MM')
       AND PNA_EMPR = 2
     ORDER BY PNA_NOMBRE;
  V_CHAR       VARCHAR2(2000);
  v_count      number := 0;
  DESTINATARIO VARCHAR2(600);
  COPIA        VARCHAR2(600);
  OCULTA       VARCHAR2(200);

BEGIN
  select t.co_para, t.co_cc, t.co_cco
    into DESTINATARIO, COPIA, OCULTA
    from gen_correos t
   where t.co_accion = 'Fecha_Nacimiento';

  PERI092.PP_VERIF_ADELANTOS_PEND(P_EMPRESA => 2); ---le liz villasanti
  --  PER_TABLERO_JSA;

  v_char := 'Personas con cumpleanhos en fecha de hoy (' || trunc(sysdate) || ')' ||
            chr(13) || chr(13);
  FOR RREC IN REC_CUR LOOP
    v_char  := v_char || '* ' || RREC.PNA_NOMBRE || ' -tel: ' ||
               RREC.PNA_TELEFONO || ' -cel: ' || RREC.PNA_CELULAR ||
               ' -email: ' || RREC.PNA_EMAIL || chr(13);
    v_count := v_count + 1;
  END LOOP;
  if DESTINATARIO is not null then
  if v_count > 0 then
    UTL_MAIL.SEND(sender     => 'noreply',
                      recipients => DESTINATARIO,
                      cc         => COPIA,
                      bcc        => OCULTA,
                      subject    => 'Cumpleanhos Personas',
                      message    => v_char,
                      mime_type  => 'text/plain');

  else
    UTL_MAIL.SEND(sender     => 'noreply',
                      recipients => DESTINATARIO,
                      cc         => COPIA,
                      bcc        => OCULTA,
                      subject    => 'Cumpleanhos Personas',
                      message    => 'No hay registro de cumpleanhos',
                      mime_type  => 'text/plain');
  end if;
  end if;
  -- RAISE_APPLICATION_ERROR(-20000,V_ERRORSQL);
  --EXCEPTION
  -- WHEN OTHERS THEN
  --   null;
END PP_ENVIO_FEC_NAC_TA;
/
