USE ODS;


ALTER TABLE ODS.ODS_HC_SERVICIOS ADD INDEX FK_SER_CLI_IDX (ID_CLIENTE ASC);
ALTER TABLE ODS.ODS_HC_SERVICIOS ADD CONSTRAINT FK_SER_CLI FOREIGN KEY (ID_CLIENTE)
  REFERENCES ODS.ODS_HC_CLIENTES (ID_CLIENTE);


ALTER TABLE ODS.ODS_HC_SERVICIOS ADD INDEX FK_SER_PRO_IDX (ID_PRODUCTO ASC);
ALTER TABLE ODS.ODS_HC_SERVICIOS CHANGE COLUMN ID_PRODUCTO ID_PRODUCTO INT(10) UNSIGNED;
ALTER TABLE ODS.ODS_HC_SERVICIOS ADD CONSTRAINT FK_SER_PRO FOREIGN KEY (ID_PRODUCTO)
  REFERENCES ODS.ODS_DM_PRODUCTOS (ID_PRODUCTO);

ALTER TABLE ODS.ODS_HC_SERVICIOS CHANGE COLUMN ID_CANAL ID_CANAL INT(10) UNSIGNED;
ALTER TABLE ODS.ODS_HC_SERVICIOS ADD INDEX FK_SER_CANAL_IDX (ID_CANAL ASC);
ALTER TABLE ODS.ODS_HC_SERVICIOS ADD CONSTRAINT FK_SER_CANAL FOREIGN KEY (ID_CANAL)
  REFERENCES ODS.ODS_DM_CANALES (ID_CANAL);

ALTER TABLE ODS.ODS_HC_SERVICIOS CHANGE COLUMN ID_DIRECCION_SERVICIO ID_DIRECCION_SERVICIO INT(10) UNSIGNED;
ALTER TABLE ODS.ODS_HC_SERVICIOS ADD INDEX FK_SER_DIR_IDX (ID_DIRECCION_SERVICIO ASC);
ALTER TABLE ODS.ODS_HC_SERVICIOS ADD CONSTRAINT FK_SER_DIR FOREIGN KEY (ID_DIRECCION_SERVICIO)
  REFERENCES ODS.ODS_HC_DIRECCIONES (ID_DIRECCION);
  
  