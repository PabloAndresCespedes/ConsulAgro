PROCEDURE PP_ACTUALIZAR_PAG IS



BEGIN
-- ingresar pagos para notas de credito y adelantos
GO_BLOCK('BFINDOC');
FIRST_RECORD;
GO_BLOCK('BCNCR');
FIRST_RECORD;
LOOP
IF :BCNCR.S_MARCA IS NOT NULL
AND :BCNCR.S_MARCA <> '.' THEN
:BPAGO.PAG_CLAVE_DOC := :BCNCR.CUO_CLAVE_DOC;
:BPAGO.PAG_FEC_VTO := :BCNCR.CUO_FEC_VTO;
:BPAGO.PAG_CLAVE_PAGO := :BFINDOC.DOC_CLAVE;
:BPAGO.PAG_FEC_PAGO := :BDOC.DOC_FEC_OPER;
:BPAGO.PAG_IMP_LOC := :BCNCR.S_IMP_PAGO_LOC;
:BPAGO.PAG_IMP_MON := :BCNCR.S_IMP_PAGO_MON;
:BPAGO.PAG_LOGIN := USER;
:BPAGO.PAG_FEC_GRAB := SYSDATE;
:BPAGO.PAG_SIST := :BFINDOC.DOC_SIST;
:BPAGO.PAG_EMPR := :PARAMETER.P_EMPRESA;
GO_BLOCK('BPAGO');
NEXT_RECORD; --para habilitar el siguiente registro
GO_BLOCK('BCNCR');
END IF;
EXIT WHEN :SYSTEM.LAST_RECORD = 'TRUE';
NEXT_RECORD;
END LOOP;
--
--
-- ingresar pagos para facturas credito y notas debito
GO_BLOCK('BFINDOC');
FIRST_RECORD;
NEXT_RECORD;
GO_BLOCK('BCFACT');
FIRST_RECORD;
LOOP
IF :BCFACT.S_MARCA IS NOT NULL
AND :BCFACT.S_MARCA <> '.' THEN
:BPAGO.PAG_CLAVE_DOC := :BCFACT.CUO_CLAVE_DOC;
:BPAGO.PAG_FEC_VTO := :BCFACT.CUO_FEC_VTO;
:BPAGO.PAG_CLAVE_PAGO := :BFINDOC.DOC_CLAVE;
:BPAGO.PAG_FEC_PAGO := :BDOC.DOC_FEC_OPER;
:BPAGO.PAG_IMP_LOC := :BCFACT.S_IMP_PAGO_LOC;
:BPAGO.PAG_IMP_MON := :BCFACT.S_IMP_PAGO_MON;
:BPAGO.PAG_LOGIN := :BENCA.S_USUARIO;
:BPAGO.PAG_FEC_GRAB := SYSDATE;
:BPAGO.PAG_SIST := :BFINDOC.DOC_SIST;
:BPAGO.PAG_EMPR := :PARAMETER.P_EMPRESA;
GO_BLOCK('BPAGO');
NEXT_RECORD; --para habilitar el siguiente registro
GO_BLOCK('BCFACT');
END IF;
IF :SYSTEM.LAST_RECORD = 'TRUE' THEN
EXIT;
END IF;
NEXT_RECORD;
END LOOP;
--
EXCEPTION
WHEN FORM_TRIGGER_FAILURE THEN
RAISE FORM_TRIGGER_FAILURE;
WHEN OTHERS THEN
PL_EXHIBIR_ERROR_PLSQL;
END;