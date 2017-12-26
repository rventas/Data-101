USE ODS;

INSERT INTO ODS.ODS_DM_DEPARTAMENTOS_CC (DE_DEPARTAMENTO_CC, FC_INSERT, FC_MODIFICACION)
SELECT DISTINCT UPPER(TRIM(SERVICE))
, NOW(), NOW()
FROM STAGE.STG_CONTACTOS_IVR
WHERE TRIM(SERVICE)<>'';

COMMIT;

INSERT INTO ODS.ODS_DM_DEPARTAMENTOS_CC VALUES (98, 'NO APLICA', NOW(), NOW());
INSERT INTO ODS.ODS_DM_DEPARTAMENTOS_CC VALUES (99, 'DESCONOCIDO', NOW(), NOW());

COMMIT;

INSERT INTO ODS.ODS_DM_AGENTES_CC (DE_AGENTE_CC, FC_INSERT, FC_MODIFICACION)
SELECT DISTINCT UPPER(TRIM(AGENT)) DE_AGENTE_CC,
NOW(), NOW()
FROM STAGE.STG_CONTACTOS_IVR
WHERE TRIM(AGENT)<>'';

COMMIT;

INSERT INTO ODS.ODS_DM_AGENTES_CC VALUES (9998, 'NO APLICA', NOW(), NOW());
INSERT INTO ODS.ODS_DM_AGENTES_CC VALUES (9999, 'DESCONOCIDO', NOW(), NOW());

COMMIT;
/*
Tenemos que insertar en clientes el registro para el cliente 'DESCONOCIDO', para que no nos de este error:
Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`ODS`.`ODS_HC_LLAMADAS`, CONSTRAINT `FK_LLA_CLI` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `ODS_HC_CLIENTES` (`ID_CLIENTE`))
*/
INSERT INTO ODS.ODS_HC_CLIENTES VALUES (999999999, 'DESCONOCIDO', 'DESCONOCIDO','99-999-9999', 99, 999999,9999999999, 'DESCONOCIDO@DESCONOCIDO.ES',STR_TO_DATE('31/12/9999','%d/%m/%Y'),999,999,NOW(),STR_TO_DATE('31/12/9999','%d/%m/%Y'));

COMMIT;

INSERT INTO ODS.ODS_HC_LLAMADAS (ID_IVR, TELEFONO_LLAMADA, ID_CLIENTE, FC_INICIO_LLAMADA, FC_FIN_LLAMADA, ID_DEPARTAMENTO_CC, FLG_TRANSFERIDO,ID_AGENTE_CC, FC_INSERT, FC_MODIFICACION)
SELECT CAST(ID AS SIGNED INTEGER) ID_IVR
, CASE WHEN TRIM(LLA.PHONE_NUMBER)<>'' THEN CAST(TRIM(LLA.PHONE_NUMBER) AS SIGNED INTEGER) ELSE 9999999999 END TELEFONO_LLAMADA
, 999999999 ID_CLIENTE
, CASE WHEN TRIM(LLA.START_DATETIME)<>'' THEN STR_TO_DATE(TRIM(LLA.START_DATETIME),'%Y-%m-%d %H:%i:%s.%f') ELSE STR_TO_DATE('9999-12-31','%Y-%m-%d %H:%i:%s.%f') END FC_INICIO_LLAMADA
, CASE WHEN TRIM(LLA.END_DATETIME)<>'' THEN STR_TO_DATE(TRIM(LLA.END_DATETIME),'%Y-%m-%d %H:%i:%s.%f') ELSE STR_TO_DATE('9999-12-31','%Y-%m-%d %H:%i:%s.%f') END FC_FIN_LLAMADA
, DE.ID_DEPARTAMENTO_CC
, CASE WHEN UPPER(TRIM(LLA.FLG_TRANSFER)) = 'TRUE' THEN 1 ELSE 0 END FLG_TRANSFERIDO
, AGE.ID_AGENTE_CC
, NOW() FC_INSERT
, STR_TO_DATE('9998-12-31 00:00:00','%Y-%m-%d %H:%i:%s') FC_MODIFICA
FROM STAGE.STG_CONTACTOS_IVR LLA
INNER JOIN ODS.ODS_DM_DEPARTAMENTOS_CC DE ON CASE WHEN TRIM(LLA.SERVICE)<>'' THEN UPPER(TRIM(LLA.SERVICE)) ELSE 'DESCONOCIDO' END = DE.DE_DEPARTAMENTO_CC
INNER JOIN ODS.ODS_DM_AGENTES_CC AGE ON CASE WHEN TRIM(LLA.AGENT)<>'' THEN UPPER(TRIM(LLA.AGENT)) ELSE 'DESCONOCIDO' END = AGE.DE_AGENTE_CC;

COMMIT;
