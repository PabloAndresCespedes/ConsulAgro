CREATE OR REPLACE PROCEDURE "CREATE_SCHEMA_AUDIT_RULES" (
   p_schema   IN   VARCHAR2
) IS

begin
  -- 01/07/2022 11:11:33 @PabloACespedes \(^-^)/
  -- deshabilitado, no lo utilizan en Hilagro ni holding, 
  -- error agregado para notificar donde llama el proceso
  Raise_application_error(-20000, 'PRC. CREATE_SCHEMA_AUDIT_RULES: Esquema enviado: '||p_schema||' >> PROCEDIMIENTO DESHABILITADO. COMUNIQUESE CON TI');
/*
   -- Audit tables
   FOR i IN (
                SELECT T.OWNER || '.' || T.TABLE_NAME AS TABLE_ON
                FROM DBA_TABLES T
                WHERE T.OWNER = p_schema
                AND NOT EXISTS (
                        SELECT 1 FROM DBA_OBJ_AUDIT_OPTS A
                        WHERE A.OWNER = T.OWNER
                        AND A.OBJECT_NAME = T.TABLE_NAME
                        AND A.OBJECT_TYPE = 'TABLE'
                    )
                AND NOT EXISTS (
                        SELECT 1 FROM ADCS.AUDIT_OBJ_EXCLUDE E
                        WHERE E.OBJ_OWNER = T.OWNER
                        AND E.OBJ_NAME = T.TABLE_NAME
                )
    )
   LOOP

        EXECUTE IMMEDIATE 'AUDIT UPDATE,DELETE ON '|| i.TABLE_ON ||' BY ACCESS';

   END LOOP;
*/
   -- Audit Views
     /* FOR i IN (
                SELECT T.OWNER || '.' || T.VIEW_NAME AS TABLE_ON
                FROM DBA_VIEWS T
                WHERE T.OWNER = p_schema
                AND NOT EXISTS (
                        SELECT 1 FROM DBA_OBJ_AUDIT_OPTS A
                        WHERE A.OWNER = T.OWNER
                        AND A.OBJECT_NAME = T.VIEW_NAME
                        AND A.OBJECT_TYPE = 'VIEW'
                    )
    )
   LOOP

        EXECUTE IMMEDIATE 'AUDIT SELECT ON '|| i.TABLE_ON ||' BY ACCESS';

   END LOOP;*/

END CREATE_SCHEMA_AUDIT_RULES;
/
