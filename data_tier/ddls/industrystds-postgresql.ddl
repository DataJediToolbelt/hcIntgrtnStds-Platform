-- 2025-01
-- Key Tables Needed as they have PK Relationsips
DROP TABLE IF EXISTS REFDATA_STATUS CASCADE;
CREATE TABLE REFDATA_STATUS
(
    STATUS_ID          VARCHAR(10) PRIMARY KEY,
    STATUS_DESCRIPTION VARCHAR(75),
    MAINTAINED_DATE    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS REFDATA_INDUSTRYSTD CASCADE;
CREATE TABLE REFDATA_INDUSTRYSTD
(
    INDUSTRY_STD            VARCHAR(10) PRIMARY KEY,
    INDUSTRYSTD_DESCRIPTION VARCHAR(75),
    STATUS_ID               VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE         TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE REFDATA_INDUSTRYSTD
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

DROP TABLE IF EXISTS REFDATA_FIELDS CASCADE;
CREATE TABLE REFDATA_FIELDS
(
    FIELD_ID        VARCHAR(10),
    FIELD_NAME      VARCHAR(99),
    FIELD_LENGTH    VARCHAR(7),
    FIELD_DATATYPE      VARCHAR(5),
    INDUSTRY_STD    VARCHAR(10),
    INDUSTRY_VRSN VARCHAR(10),
    STATUS_ID       VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE REFDATA_FIELDS
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

ALTER TABLE REFDATA_FIELDS
    ADD FOREIGN KEY (INDUSTRY_STD)
        REFERENCES REFDATA_INDUSTRYSTD (INDUSTRY_STD);

DROP TABLE IF EXISTS REFDATA_MESSAGES CASCADE;
CREATE TABLE REFDATA_MESSAGES
(
    MESSAGE_ID      VARCHAR(10),
    MESSAGE_EVENT VARCHAR(10),
    MESSAGE_EVENT_TYPE VARCHAR(10),
    MESSAGE_DTL     VARCHAR(249),
    INDUSTRY_STD    VARCHAR(10),
    INDUSTRY_VRSN    VARCHAR(10),
    STATUS_ID       VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE TIMESTAMP  DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE REFDATA_MESSAGES
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

ALTER TABLE REFDATA_MESSAGES
    ADD FOREIGN KEY (INDUSTRY_STD)
        REFERENCES REFDATA_INDUSTRYSTD (INDUSTRY_STD);

DROP TABLE IF EXISTS REFDATA_SEGMENTS CASCADE;
CREATE TABLE REFDATA_SEGMENTS
(
    SEGMENT_NAME        VARCHAR(10),
    SEGMENT_DESCRIPTION VARCHAR(99),
    INDUSTRY_STD        VARCHAR(10),
    INDUSTRY_VRSN         VARCHAR(10),
    STATUS_ID           VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE     TIMESTAMP  DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE REFDATA_SEGMENTS
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

ALTER TABLE REFDATA_SEGMENTS
    ADD FOREIGN KEY (INDUSTRY_STD)
        REFERENCES REFDATA_INDUSTRYSTD (INDUSTRY_STD);

DROP TABLE IF EXISTS REFDATA_DATATYPES CASCADE;
CREATE TABLE REFDATA_DATATYPES
(
    DATATYPE_ID          VARCHAR(10),
    DATATYPE_DESCRIPTION VARCHAR(129),
    INDUSTRY_STD         VARCHAR(10),
    INDUSTRY_VRSN         VARCHAR(10),
    SUBFIELDS VARCHAR(999),
    STATUS_ID            VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE REFDATA_DATATYPES
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

ALTER TABLE REFDATA_DATATYPES
    ADD FOREIGN KEY (INDUSTRY_STD)
        REFERENCES REFDATA_INDUSTRYSTD (INDUSTRY_STD);

DROP TABLE IF EXISTS DATA_VENDOR_SPECS CASCADE;
CREATE TABLE DATA_VENDOR_SPECS
(
    VENDOR_SPEC_ID       CHAR(38) DEFAULT GEN_RANDOM_UUID() NOT NULL PRIMARY KEY,
    VENDOR               VARCHAR(30),
    PRODUCT_NAME         VARCHAR(35),
    INDUSTRY_STD         VARCHAR(10),
    INDUSTRY_VRSN              VARCHAR(10),
    START_EFFECTIVE_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    END_EFFECTIVE_DATE   DATE DEFAULT CURRENT_TIMESTAMP + INTERVAL '1 year',
    MESSAGE_EVENTS       TEXT,
    MAINTAINED_DATE      TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,
    STATUS_ID            VARCHAR(10) DEFAULT 'Active'
);

ALTER TABLE DATA_VENDOR_SPECS
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

ALTER TABLE DATA_VENDOR_SPECS
    ADD FOREIGN KEY (INDUSTRY_STD)
        REFERENCES REFDATA_INDUSTRYSTD (INDUSTRY_STD);

DROP TABLE IF EXISTS DATA_VENDOR_SPECS_MESSAGES_FIELDS_DTL CASCADE;
CREATE TABLE DATA_VENDOR_SPECS_MESSAGES_FIELDS_DTL
(
    DATA_MESSAGES_FIELDS_DTL_ID BIGSERIAL,
    VENDOR_SPEC_ID              CHAR(38),
    INDUSTRY_STD                VARCHAR(10),
    SEGMENT_NAME                VARCHAR(10),
    INDUSTRY_VRSN                   VARCHAR(10),
    FIELD_ORDER_ID              INTEGER,
    FIELD_ID                    VARCHAR(10),
    REQUIRED                    VARCHAR(1),
    REPEAT                      VARCHAR(1),
    REPITITION_COUNT            VARCHAR(2),
    SEGMENT_FIELDORDER          VARCHAR(20),
    VENDOR                      VARCHAR(20),
    PRODUCT_NAME                VARCHAR(20),
    STATUS_ID                   VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE             TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE DATA_VENDOR_SPECS_MESSAGES_FIELDS_DTL
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

ALTER TABLE DATA_VENDOR_SPECS_MESSAGES_FIELDS_DTL
    ADD FOREIGN KEY (INDUSTRY_STD)
        REFERENCES REFDATA_INDUSTRYSTD (INDUSTRY_STD);

ALTER TABLE DATA_VENDOR_SPECS_MESSAGES_FIELDS_DTL
    ADD FOREIGN KEY (VENDOR_SPEC_ID)
        REFERENCES DATA_VENDOR_SPECS (VENDOR_SPEC_ID);

DROP TABLE IF EXISTS DATA_VENDOR_SPECS_MESSAGES_SEGMENTS_DTL CASCADE;
CREATE TABLE DATA_VENDOR_SPECS_MESSAGES_SEGMENTS_DTL
(
    DATA_MESSAGES_SEGMENTS_DTL_ID BIGSERIAL,
    VENDOR_SPEC_ID                CHAR(38),
    INDUSTRY_STD                  VARCHAR(10),
    MESSAGE_ID                    VARCHAR(10),
    INDUSTRY_VRSN                       VARCHAR(10),
    ORDER_ID                      VARCHAR(10),
    SEGMENT_NAME                  VARCHAR(10),
    SEGMENT_OPTIONAL              VARCHAR(1),
    SEGMENT_REPEATING             VARCHAR(1),
    SEGMENT_REQUIRED              VARCHAR(1),
    VENDOR                        VARCHAR(20),
    PRODUCT_NAME                  VARCHAR(20),
    STATUS_ID                     VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE               TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE DATA_VENDOR_SPECS_MESSAGES_SEGMENTS_DTL
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

ALTER TABLE DATA_VENDOR_SPECS_MESSAGES_SEGMENTS_DTL
    ADD FOREIGN KEY (INDUSTRY_STD)
        REFERENCES REFDATA_INDUSTRYSTD (INDUSTRY_STD);

ALTER TABLE DATA_VENDOR_SPECS_MESSAGES_SEGMENTS_DTL
    ADD FOREIGN KEY (VENDOR_SPEC_ID)
        REFERENCES DATA_VENDOR_SPECS (VENDOR_SPEC_ID);

-- The message_id can be altered to vc(10) after load
DROP TABLE IF EXISTS REFDATA_MESSAGES_SEGMENTS CASCADE;
CREATE TABLE REFDATA_MESSAGES_SEGMENTS
(
    REFDATA_MESSAGES_FIELDS_ID BIGSERIAL,
    MESSAGE_ID        VARCHAR(15),
    INDUSTRY_STD      VARCHAR(10),
    INDUSTRY_VRSN VARCHAR(10),
    ORDER_ID         INT,
    SEGMENT_NAME     VARCHAR(10),
    SEGMENT_OPTIONAL  VARCHAR(5),
    SEGMENT_REPEATING VARCHAR(5),
    SEGMENT_REQUIRED  VARCHAR(5),
    STATUS_ID         VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE REFDATA_MESSAGES_SEGMENTS
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

ALTER TABLE REFDATA_MESSAGES_SEGMENTS
    ADD FOREIGN KEY (INDUSTRY_STD)
        REFERENCES REFDATA_INDUSTRYSTD (INDUSTRY_STD);

DROP TABLE IF EXISTS REFDATA_SEGMENTS_FIELDS CASCADE;
CREATE TABLE REFDATA_SEGMENTS_FIELDS
(
    REFDATA_MESSAGES_FIELDS_ID BIGSERIAL ,
    SEGMENT_NAME   VARCHAR(10),
    INDUSTRY_STD   VARCHAR(10),
    INDUSTRY_VRSN VARCHAR(10),
    FIELD_ORDER_ID INTEGER,
    FIELD_ID       VARCHAR(10),
    REQUIRED       VARCHAR(5),
    REPEAT         VARCHAR(5),
    REPITITION_COUNT VARCHAR(5),
    SEGMENT_FIELDORDER VARCHAR(20),
    STATUS_ID         VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE REFDATA_SEGMENTS_FIELDS
    ADD FOREIGN KEY (STATUS_ID)
        REFERENCES REFDATA_STATUS (STATUS_ID);

ALTER TABLE REFDATA_SEGMENTS_FIELDS
    ADD FOREIGN KEY (INDUSTRY_STD)
        REFERENCES REFDATA_INDUSTRYSTD (INDUSTRY_STD);