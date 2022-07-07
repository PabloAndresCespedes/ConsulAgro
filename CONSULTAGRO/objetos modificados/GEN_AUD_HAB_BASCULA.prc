CREATE OR REPLACE PROCEDURE GEN_AUD_HAB_BASCULA AS
  /*CURSOR CUR_HABILITACIONES IS
  SELECT GAH_FECHA, GAH_LOGIN, GAH_MOTIVO, ROL_NOMBRE, SUC_CODIGO||'-'||SUC_DESC SUCURSAL
  FROM GEN_AUD_HABILITACION G , GEN_ROL R, GEN_OPERADOR_ROL OPRO, GEN_OPERADOR_EMPRESA OE, GEN_SUCURSAL
  WHERE G.GAH_GCTO_CODIGO=R.ROL_CODIGO
  AND G.GAH_EMPR=R.ROL_EMPR
  AND OPRO.OPRO_ROL=R.ROL_CODIGO
  AND OPRO.OPRO_EMPR=R.ROL_EMPR
  AND OPRO.OPRO_OPERADOR=OE.OPEM_OPER
  AND OPRO_EMPR=OPEM_EMPR
  AND OE.OPEM_SUC=SUC_CODIGO
  AND OE.OPEM_EMPR=SUC_EMPR
  AND OPEM_EMPR=SUC_EMPR
  --AND TO_CHAR(G.GAH_FECHA,'dd/mm/yyyy')=TO_CHAR(SYSDATE-1,'dd/mm/yyyy');
  AND TO_CHAR(G.GAH_FECHA,'dd/mm/yyyy')='01/06/2019';*/
  CURSOR CUR_HABILITACIONES IS
    SELECT '<tr align="left"><td id="izq" align="left">' ||
           TO_CHAR(GAH_FECHA, 'dd/mm/yyyy hh24:mm:ss') ||
           '</td><td id="izq" align="left">' || GAH_USER_HAB ||
           '</td><td id="izq" align="left">' || GAH_MOTIVO ||
           '</td><td id="izq" align="left">' || ROL_NOMBRE ||
           '</td><td id="izq" align="left">' || SUC_CODIGO || '-' ||
           SUC_DESC || '</td></tr>' REGISTRO
      FROM GEN_AUD_HABILITACION G,
           GEN_ROL              R,
           GEN_OPERADOR_ROL     OPRO,
           GEN_OPERADOR_EMPRESA OE,
           GEN_SUCURSAL
     WHERE G.GAH_GCTO_CODIGO = R.ROL_CODIGO
       AND G.GAH_EMPR = R.ROL_EMPR
       AND OPRO.OPRO_ROL = R.ROL_CODIGO
       AND OPRO.OPRO_EMPR = R.ROL_EMPR
       AND OPRO.OPRO_OPERADOR = OE.OPEM_OPER
       AND OPRO_EMPR = OPEM_EMPR
       AND OE.OPEM_SUC = SUC_CODIGO
       AND OE.OPEM_EMPR = SUC_EMPR
       AND OPEM_EMPR = SUC_EMPR
       AND TO_CHAR(G.GAH_FECHA, 'dd/mm/yyyy') =
           TO_CHAR(SYSDATE - 1, 'dd/mm/yyyy');
  --
  --AND TO_CHAR(G.GAH_FECHA, 'dd/mm/yyyy') = '26/03/2022';
  --
  V_MENSAJE    VARCHAR2(4000);
  V_HTML1      VARCHAR2(30000);
  V_HTM_BODY   VARCHAR2(30000);
  V_EXISTE     NUMBER := 0;
  DESTINATARIO VARCHAR2(600);
  COPIA        VARCHAR2(600);
  OCULTA       VARCHAR2(200);
BEGIN
  SELECT COUNT(*)
    INTO V_EXISTE
    FROM GEN_AUD_HABILITACION G,
         GEN_ROL              R,
         GEN_OPERADOR_ROL     OPRO,
         GEN_OPERADOR_EMPRESA OE,
         GEN_SUCURSAL
   WHERE G.GAH_GCTO_CODIGO = R.ROL_CODIGO
     AND G.GAH_EMPR = R.ROL_EMPR
     AND OPRO.OPRO_ROL = R.ROL_CODIGO
     AND OPRO.OPRO_EMPR = R.ROL_EMPR
     AND OPRO.OPRO_OPERADOR = OE.OPEM_OPER
     AND OPRO_EMPR = OPEM_EMPR
     AND OE.OPEM_SUC = SUC_CODIGO
     AND OE.OPEM_EMPR = SUC_EMPR
     AND OPEM_EMPR = SUC_EMPR
     AND TO_CHAR(G.GAH_FECHA, 'dd/mm/yyyy') =
         TO_CHAR(SYSDATE - 1, 'dd/mm/yyyy');

  select t.co_para, t.co_cc, t.co_cco
    into destinatario, copia, oculta
    from gen_correos t
   where t.co_accion = 'Pesaje_Manual';
  --
  --AND TO_CHAR(G.GAH_FECHA, 'dd/mm/yyyy') = '26/03/2022';
  --
  --V_MENSAJE:='FECHA'||CHR(9)||CHR(9)||'Habilitado por'||CHR(9)||CHR(9)||'Motivo'||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||'Solicitante'||CHR(9)||'Sucursal'||CHR(13);
  IF V_EXISTE <> 0 THEN
    V_HTML1 := '<!DOCTYPE html>
                                <head>
                                      <style>
                                              table {font-family: arial;border-collapse: collapse;width: 100%;}
                                              td, th { border: 1px solid black;text-align: left ;padding: 8px;}
                                              th {background:  #dddddd;text-align: left ;padding: 8px;}
                                              #der{text-align: right;}
                                              #izq{text-align: left;}
                                              #firma1 ,#firma2 ,#firma3 ,#firma4{font-size: 10px;margin: 0}
                                              #firma4{color: green}
                                              tr:nth-child(even) {background-color: #dddddd;text-align: left;}
                                      </style>
                                </head>
                              <body>
                                <table id="example" class="display nowrap" style="width:100%" style="text-align:center;">
                                <thead>
                                  <tr>
                                    <th id="Col1">FECHA</th>
                                    <th id="Col2">Habilitado por</th>
                                    <th id="Col3">Motivo</th>
                                    <th id="Col4">Solicitante</th>
                                    <th id="Col5">Sucursal</th>
                                  </tr></thead><tbody>';
    FOR H IN CUR_HABILITACIONES LOOP
      --DBMS_OUTPUT.PUT_LINE(H.GAH_MOTIVO);
      -- V_MENSAJE:=V_MENSAJE||TO_CHAR(H.GAH_FECHA,'dd/mm/yyyy')||CHR(9)||H.GAH_LOGIN||CHR(9)||CHR(9)||CHR(9)||H.GAH_MOTIVO||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||H.ROL_NOMBRE||CHR(9)||CHR(9)||H.SUCURSAL||CHR(13);
      V_HTML1 := V_HTML1 || H.REGISTRO;
    END LOOP;
    V_HTML1 := V_HTML1 || '</tbody></table><BR>
            </body></html>';
    --IF 1=0 THEN
    /*PARA PRUEBAS*/
    /*   SEND_EMAIL(P_SENDER     => 'programacion7@hilagro.com.py',
    P_RECIPIENTS => 'programacion1@transagro.com.py', --RONNY
    P_CC         => 'programacion1@transagro.com.py',
    P_BCC        => NULL,
    P_SUBJECT    => 'Habilitaciones de pesajes manuales para Basculas del dia ' ||
                    TO_CHAR(SYSDATE - 1, 'dd/mm/yyyy'),
    P_MESSAGE    => V_HTML1,
    P_MIME_TYPE  => 'text/html;');
    --REAL
    SEND_EMAIL(P_SENDER     => 'informatica@transagro.com.py',
               P_RECIPIENTS => 'ronny@transagro.com.py', --RONNY
               P_CC         => 'informatica@transagro.com.py',
               P_BCC        => NULL,
               P_SUBJECT    => 'Habilitaciones de pesajes manuales para Basculas del dia ' ||
                               TO_CHAR(SYSDATE - 1, 'dd/mm/yyyy'),
               P_MESSAGE    => V_HTML1,
               P_MIME_TYPE  => 'text/html;');

    SEND_EMAIL(P_SENDER     => 'informatica@transagro.com.py',
               P_RECIPIENTS => 'jonny.unger@transagro.com.py', --Jonny Unger
               P_CC         => 'informatica@transagro.com.py',
               P_BCC        => NULL,
               P_SUBJECT    => 'Habilitaciones de pesajes manuales para Basculas del dia ' ||
                               TO_CHAR(SYSDATE - 1, 'dd/mm/yyyy'),
               P_MESSAGE    => V_HTML1,
               P_MIME_TYPE  => 'text/html;');

    SEND_EMAIL(P_SENDER     => 'informatica@transagro.com.py',
               P_RECIPIENTS => 'planta@transagro.com.py', --Kenny
               P_CC         => 'informatica@transagro.com.py',
               P_BCC        => NULL,
               P_SUBJECT    => 'Habilitaciones de pesajes manuales para Basculas del dia ' ||
                               TO_CHAR(SYSDATE - 1, 'dd/mm/yyyy'),
               P_MESSAGE    => V_HTML1,
               P_MIME_TYPE  => 'text/html;');

    SEND_EMAIL(P_SENDER     => 'informatica@transagro.com.py',
               P_RECIPIENTS => 'admin@transagro.com.py', --Franz
               P_CC         => 'informatica@transagro.com.py',
               P_BCC        => NULL,
               P_SUBJECT    => 'Habilitaciones de pesajes manuales para Basculas del dia ' ||
                               TO_CHAR(SYSDATE - 1, 'dd/mm/yyyy'),
               P_MESSAGE    => V_HTML1,
               P_MIME_TYPE  => 'text/html;');

    SEND_EMAIL(P_SENDER     => 'informatica@transagro.com.py',
               P_RECIPIENTS => 'billie@transagro.com.py', --Billie
               P_CC         => 'informatica@transagro.com.py',
               P_BCC        => NULL,
               P_SUBJECT    => 'Habilitaciones de pesajes manuales para Basculas del dia ' ||
                               TO_CHAR(SYSDATE - 1, 'dd/mm/yyyy'),
               P_MESSAGE    => V_HTML1,
               P_MIME_TYPE  => 'text/html;');*/
    --END IF;
if DESTINATARIO is not null then
    UTL_MAIL.SEND(sender     => 'noreply',
                      recipients => DESTINATARIO,
                      cc         => COPIA,
                      bcc        => OCULTA,
                      subject    => 'Habilitaciones de pesajes manuales para Basculas del dia ' ||
                                    TO_CHAR(SYSDATE - 1, 'dd/mm/yyyy'),
                      message    => V_HTML1,
                      mime_type  => 'text/HTML');
end if;
  END IF;
END;
/
