CREATE OR REPLACE PROCEDURE "WWZZYY" IS
  m varchar2(2500);
  function mon_gs(valor in number) return varchar2 is
  begin
    return to_char(valor,
                   '999G999G999G999',
                   'NLS_NUMERIC_CHARACTERS = '',.''');
  end;
  procedure agregar_texto(texto in varchar2) is
  begin
    if m is null then
      m := texto;
    else
      m := m || chr(13) || texto;
    end if;
  end;
begin
  agregar_texto('Este es un mensaje automatico.');
  agregar_texto(lpad(' ', 20, '-'));
  agregar_texto('que info necesitas enviar diariamente?');
  agregar_texto('Algo basico para empezar, y los destinatarios;');
  agregar_texto(mon_gs(123456));
  agregar_texto(lpad(' ', 20, '-'));
  agregar_texto(to_char(sysdate,'dd/mm/yyyy hh24:mi'));
  utl_mail.send(sender => 'dboracle@hilagro.com.py',
                   recipients => 'jose.jarolin@gmail.com',
                   cc => 'josejarolin@gmail.com',
                   subject => 'Envio de correo automatico de servidor Century',
                   message => m );
end;
/
