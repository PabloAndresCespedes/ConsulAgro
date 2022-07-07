CREATE OR REPLACE PROCEDURE GEN_ENV_MAIL_BD ( IN_RECIPIENTS      IN VARCHAR2,
                                      IN_CC              IN VARCHAR2,
                                      IN_TEXT_TITULO     IN VARCHAR2,
                                      IN_TEXT_MENSAJE    IN VARCHAR2
                                    ) IS
BEGIN

     IF IN_CC IS NULL THEN
         utl_mail.send('dboracle@hilagro.com.py',
                            recipients => IN_RECIPIENTS, -- 'XXX@hotmail.com',
                            subject => IN_TEXT_TITULO,
                            message => IN_TEXT_MENSAJE
                           );
     ELSE
         utl_mail.send('dboracle@hilagro.com.py',
                           recipients => IN_RECIPIENTS, -- 'XXX@hotmail.com',
                           subject    => IN_TEXT_TITULO,
                           cc         => IN_CC,
                           message => IN_TEXT_MENSAJE
                           );
     END IF;


       --DBMS_OUTPUT.put_line('Activar utl_mail.' || IN_TEXT_CUERPO);

END;
/
