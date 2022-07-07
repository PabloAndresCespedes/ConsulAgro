create or replace procedure Mail_reclamos_nuevo(in_reclamo in number,
                                                in_empresa in number) is
  v_usuario     varchar2(8);
  v_descripcion varchar2(4000);
  v_cliente     varchar2(100);
  v_ingeniero   varchar2(100);
  v_estado      varchar2(100);
  DESTINATARIO  VARCHAR2(600);
  COPIA         VARCHAR2(600);
  OCULTA        VARCHAR2(200);
begin
  select rec_user,
         b.recd_desc,
         cli_codigo || '-' || Cli_nom Cliente,
         empl_nombre || ' ' || empl_ape Ingeniero,
         decode(rec_estado, 'A', 'ABIERTO', 'CERRADO')
    into v_usuario, v_descripcion, v_cliente, v_ingeniero, v_estado
    from aco_reclamos_ing     a,
         aco_reclamos_ing_det b,
         fin_cliente,
         per_empleado
   where a.rec_nro = b.recd_nro
     and a.rec_empr = b.recd_empr
     and a.rec_empr = cli_empr
     and a.rec_empr = empl_empresa
     and a.rec_cliente = cli_codigo
     and a.rec_ingeniero = empl_legajo
     and a.rec_empr = in_empresa
     and a.rec_nro = in_reclamo;

  SELECT T.CO_PARA, T.CO_CC, T.CO_CCO
    INTO DESTINATARIO, COPIA, OCULTA
    FROM GEN_CORREOS T
   WHERE T.CO_ACCION = 'Reclamos_Ingenieros';

  IF DESTINATARIO IS NOT NULL THEN
  UTL_MAIL.SEND(sender     => 'noreply',
                    recipients => DESTINATARIO,
                    cc         => COPIA,
                    bcc        => OCULTA,
                    subject    => 'Nuevo Reclamo de Clientes',
                    message    => 'Cliente:' || v_cliente || chr(13) ||
                                  'Estado: ' || v_estado || chr(13) ||
                                  'Reclamo: ' || v_descripcion || chr(13) ||
                                  'Ing: ' || v_ingeniero || chr(13) || chr(13) ||
                                  chr(13) ||
                                  'Mensaje de correo electronico enviado automaticamente desde ACOI032-Reclamos(11-2-155).',
                    mime_type  => 'text/plain');

  END IF;
end Mail_reclamos_nuevo;
/
