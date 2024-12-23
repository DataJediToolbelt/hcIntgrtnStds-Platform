DROP TABLE IF EXISTS REFDATA_STATUS;
CREATE TABLE REFDATA_STATUS
(
    STATUS_ID     VARCHAR(10)  PRIMARY KEY,
    STATUS_DESC        VARCHAR(40),
    CREATED_DATE   DATE DEFAULT GETDATE()
);

DROP TABLE IF EXISTS REFDATA_MESSAGETYPE;
CREATE TABLE REFDATA_MESSAGETYPE
(
    MESSAGETYPE_ID     VARCHAR(10)  PRIMARY KEY,
    MESSAGETYPE_DESC VARCHAR(40),
    STATUS_ID     VARCHAR(10),
    CREATED_DATE   DATE DEFAULT GETDATE()
);

ALTER TABLE REFDATA_MESSAGETYPE
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

DROP TABLE IF EXISTS REFDATA_MESSAGETYPE_EVENT;
CREATE TABLE REFDATA_MESSAGETYPE_EVENT
(
    MESSAGETYPE_EVENT_ID     VARCHAR(20)  PRIMARY KEY,
    MESSAGETYPE_EVENT_DESC VARCHAR(40),
    STATUS_ID     VARCHAR(10),
    CREATED_DATE   DATE DEFAULT GETDATE()
);

ALTER TABLE REFDATA_MESSAGETYPE_EVENT
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

DROP TABLE IF EXISTS REFDATA_APPLICATIONS;
CREATE TABLE REFDATA_APPLICATIONS
(
    APPLICATION_ID     VARCHAR(38)  DEFAULT NEWID() PRIMARY KEY,
    APPLICATION_NAME       VARCHAR(40),
    STATUS_ID     VARCHAR(10),
    CREATED_DATE   DATE DEFAULT GETDATE()
);

ALTER TABLE REFDATA_APPLICATIONS
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

DROP TABLE IF EXISTS REFDATA_ORGANIZATIONS;
CREATE TABLE REFDATA_ORGANIZATIONS
(
    ORGANIZATION_ID     VARCHAR(10)  DEFAULT NEWID() PRIMARY KEY,
    ORGANIZATION_NAME       VARCHAR(40),
    STATUS_ID     VARCHAR(10),
    CREATED_DATE   DATE DEFAULT GETDATE()
);

ALTER TABLE REFDATA_ORGANIZATIONS
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);


DROP TABLE IF EXISTS INTEGRATIONS;
CREATE TABLE INTEGRATIONS
(
    INTEGRATIONS_ID     VARCHAR(38)  DEFAULT NEWID() PRIMARY KEY,
    MESSAGE_TYPE        VARCHAR(10),
    MESSAGE_TYPE_EVENT    VARCHAR(20),
    APPLICATION        VARCHAR(38),
    ORGANIZATION    VARCHAR(10),
    STATUS_ID VARCHAR(10) DEFAULT 'Active',
    CREATED_DATE   DATE DEFAULT GETDATE(),
    EXPIRATION_DATE DATE DEFAULT DATEADD(YEAR, 5, GETDATE())
);

ALTER TABLE INTEGRATIONS
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

ALTER TABLE INTEGRATIONS
    ADD FOREIGN KEY (APPLICATION)
        REFERENCES REFDATA_APPLICATIONS(APPLICATION_ID);

ALTER TABLE INTEGRATIONS
    ADD FOREIGN KEY (ORGANIZATION)
        REFERENCES REFDATA_ORGANIZATIONS(ORGANIZATION_ID);

ALTER TABLE INTEGRATIONS
    ADD FOREIGN KEY (MESSAGE_TYPE)
        REFERENCES REFDATA_MESSAGETYPE (MESSAGETYPE_ID);

ALTER TABLE INTEGRATIONS
    ADD FOREIGN KEY (MESSAGE_TYPE_EVENT)
        REFERENCES REFDATA_MESSAGETYPE_EVENT (MESSAGETYPE_EVENT_ID);

DROP TABLE IF EXISTS INTEGRATIONS_TARGETIDENT;
CREATE TABLE INTEGRATIONS_TARGETIDENT
(
    TARGET_IDENT_ID     VARCHAR(38)    DEFAULT NEWID() PRIMARY KEY,
    INTEGRATIONS_ID     VARCHAR(38),
    MESSAGE_TYPE        VARCHAR(10),
    MESSAGE_TYPE_EVENT    VARCHAR(20),
    APPLICATION        VARCHAR(38),
    ORGANIZATION    VARCHAR(10),
    ENDPOINT VARCHAR(40),
    STATUS_ID VARCHAR(10) DEFAULT 'Active',
    CREATED_DATE   DATE DEFAULT GETDATE(),
    EXPIRATION_DATE DATE DEFAULT DATEADD(YEAR, 5, GETDATE())
);
ALTER TABLE INTEGRATIONS_TARGETIDENT
    ADD FOREIGN KEY (INTEGRATIONS_ID)
        REFERENCES INTEGRATIONS(INTEGRATIONS_ID);

ALTER TABLE INTEGRATIONS_TARGETIDENT
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

ALTER TABLE INTEGRATIONS_TARGETIDENT
    ADD FOREIGN KEY (APPLICATION)
        REFERENCES REFDATA_APPLICATIONS(APPLICATION_ID);

ALTER TABLE INTEGRATIONS_TARGETIDENT
    ADD FOREIGN KEY (ORGANIZATION)
        REFERENCES REFDATA_ORGANIZATIONS(ORGANIZATION_ID);

ALTER TABLE INTEGRATIONS_TARGETIDENT
    ADD FOREIGN KEY (MESSAGE_TYPE)
        REFERENCES REFDATA_MESSAGETYPE (MESSAGETYPE_ID);

ALTER TABLE INTEGRATIONS_TARGETIDENT
    ADD FOREIGN KEY (MESSAGE_TYPE_EVENT)
        REFERENCES REFDATA_MESSAGETYPE_EVENT (MESSAGETYPE_EVENT_ID);


DROP TABLE IF EXISTS INTEGRATIONS_TRANSFORMATIONS;
CREATE TABLE INTEGRATIONS_TRANSFORMATIONS
(
    TRANSFORMATION_ID     VARCHAR(38)    DEFAULT NEWID() PRIMARY KEY,
    INTEGRATIONS_ID     VARCHAR(38),
    MESSAGE_TYPE        VARCHAR(10),
    MESSAGE_TYPE_EVENT    VARCHAR(20),
    APPLICATION        VARCHAR(38),
    ORGANIZATION    VARCHAR(10),
    TRANSFORMATION_NAME VARCHAR(75),
    ENDPOINT VARCHAR(40),
    STATUS_ID VARCHAR(10) DEFAULT 'Active',
    CREATED_DATE   DATE DEFAULT GETDATE(),
    EXPIRATION_DATE DATE DEFAULT DATEADD(YEAR, 5, GETDATE())
);
ALTER TABLE INTEGRATIONS_TRANSFORMATIONS
    ADD FOREIGN KEY (INTEGRATIONS_ID)
        REFERENCES INTEGRATIONS(INTEGRATIONS_ID);

ALTER TABLE INTEGRATIONS_TRANSFORMATIONS
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

ALTER TABLE INTEGRATIONS_TRANSFORMATIONS
    ADD FOREIGN KEY (APPLICATION)
        REFERENCES REFDATA_APPLICATIONS(APPLICATION_ID);

ALTER TABLE INTEGRATIONS_TRANSFORMATIONS
    ADD FOREIGN KEY (ORGANIZATION)
        REFERENCES REFDATA_ORGANIZATIONS(ORGANIZATION_ID);

ALTER TABLE INTEGRATIONS_TRANSFORMATIONS
    ADD FOREIGN KEY (MESSAGE_TYPE)
        REFERENCES REFDATA_MESSAGETYPE (MESSAGETYPE_ID);

ALTER TABLE INTEGRATIONS_TRANSFORMATIONS
    ADD FOREIGN KEY (MESSAGE_TYPE_EVENT)
        REFERENCES REFDATA_MESSAGETYPE_EVENT (MESSAGETYPE_EVENT_ID);

DROP TABLE IF EXISTS INTEGRATIONS_DELIVERY;
CREATE TABLE INTEGRATIONS_DELIVERY
(
    DELIVERY_ID     VARCHAR(38)    DEFAULT NEWID() PRIMARY KEY,
    INTEGRATIONS_ID     VARCHAR(38),
    MESSAGE_TYPE        VARCHAR(10),
    MESSAGE_TYPE_EVENT    VARCHAR(20),
    APPLICATION        VARCHAR(38),
    ORGANIZATION    VARCHAR(10),
    CONNECTIVITY_DTLS VARCHAR(75),
    ENDPOINT VARCHAR(40),
    STATUS_ID VARCHAR(10) DEFAULT 'Active',
    CREATED_DATE   DATE DEFAULT GETDATE(),
    EXPIRATION_DATE DATE DEFAULT DATEADD(YEAR, 5, GETDATE())
);

ALTER TABLE INTEGRATIONS_DELIVERY
    ADD FOREIGN KEY (INTEGRATIONS_ID)
        REFERENCES INTEGRATIONS(INTEGRATIONS_ID);

ALTER TABLE INTEGRATIONS_DELIVERY
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

ALTER TABLE INTEGRATIONS_DELIVERY
    ADD FOREIGN KEY (APPLICATION)
        REFERENCES REFDATA_APPLICATIONS(APPLICATION_ID);

ALTER TABLE INTEGRATIONS_DELIVERY
    ADD FOREIGN KEY (ORGANIZATION)
        REFERENCES REFDATA_ORGANIZATIONS(ORGANIZATION_ID);

ALTER TABLE INTEGRATIONS_DELIVERY
    ADD FOREIGN KEY (MESSAGE_TYPE)
        REFERENCES REFDATA_MESSAGETYPE (MESSAGETYPE_ID);

ALTER TABLE INTEGRATIONS_DELIVERY
    ADD FOREIGN KEY (MESSAGE_TYPE_EVENT)
        REFERENCES REFDATA_MESSAGETYPE_EVENT (MESSAGETYPE_EVENT_ID);
