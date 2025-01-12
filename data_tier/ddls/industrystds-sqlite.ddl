-- Key Tables Needed as they have PK Relationsips
DROP TABLE IF EXISTS REFDATA_STATUS;
CREATE TABLE REFDATA_STATUS
(
    STATUS_ID          VARCHAR(10) PRIMARY KEY,
    STATUS_DESCRIPTION VARCHAR(35),
    MAINTAINED_DATE VARCHAR(20) DEFAULT (DATETIME('NOW', 'LOCALTIME'))
);

DROP TABLE IF EXISTS REFDATA_INDUSTRYSTD;
CREATE TABLE REFDATA_INDUSTRYSTD
(
    INDUSTRY_STD            VARCHAR(10) PRIMARY KEY,
    INDUSTRYSTD_DESCRIPTION VARCHAR(35),
    STATUS_ID               VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE VARCHAR(20) DEFAULT (DATETIME('NOW', 'LOCALTIME')),
     FOREIGN KEY(STATUS_ID) REFERENCES REFDATA_STATUS(STATUS_ID)
);

-- Reference Data for Industry Standards
DROP TABLE IF EXISTS REFDATA_DATATYPES;
CREATE TABLE REFDATA_DATATYPES
(
    DATATYPE_ID          VARCHAR(10),
    DATATYPE_DESCRIPTION VARCHAR(129),
    INDUSTRY_STD         VARCHAR(10),
    INDUSTRY_VRSN VARCHAR(10),
    SUBFIELDS TEXT,
    STATUS_ID            VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE VARCHAR(20) DEFAULT (DATETIME('NOW', 'LOCALTIME')),
    FOREIGN KEY(STATUS_ID) REFERENCES REFDATA_STATUS(STATUS_ID),
    FOREIGN KEY(INDUSTRY_STD) REFERENCES REFDATA_INDUSTRYSTD(INDUSTRY_STD)
);

DROP TABLE IF EXISTS REFDATA_FIELDS;
CREATE TABLE REFDATA_FIELDS
(
    FIELD_ID     VARCHAR(10),
    FIELD_NAME   VARCHAR(99),
    FIELD_LENGTH VARCHAR(7),
    FIELD_DATATYPE   VARCHAR(5),
    INDUSTRY_STD VARCHAR(10),
    INDUSTRY_VRSN VARCHAR(10),
    STATUS_ID      VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE VARCHAR(20) DEFAULT (DATETIME('NOW', 'LOCALTIME')),
    FOREIGN KEY(STATUS_ID) REFERENCES REFDATA_STATUS(STATUS_ID),
    FOREIGN KEY(INDUSTRY_STD) REFERENCES REFDATA_INDUSTRYSTD(INDUSTRY_STD)
);

DROP TABLE IF EXISTS REFDATA_MESSAGES;
CREATE TABLE REFDATA_MESSAGES
(
    MESSAGE_ID   VARCHAR(10),
    MESSAGE_EVENT VARCHAR(10),
    MESSAGE_EVENT_TYPE VARCHAR(10),
    MESSAGE_DTL  VARCHAR(249),
    STATUS_ID       VARCHAR(10) DEFAULT 'Active',
    INDUSTRY_STD VARCHAR(10),
    INDUSTRY_VRSN VARCHAR(10),
    MAINTAINED_DATE VARCHAR(20) DEFAULT (DATETIME('NOW', 'LOCALTIME')),
     FOREIGN KEY(STATUS_ID) REFERENCES REFDATA_STATUS(STATUS_ID),
     FOREIGN KEY(INDUSTRY_STD) REFERENCES REFDATA_INDUSTRYSTD(INDUSTRY_STD)
);


DROP TABLE IF EXISTS REFDATA_SEGMENTS;
CREATE TABLE REFDATA_SEGMENTS
(
    SEGMENT_NAME        VARCHAR(10),
    SEGMENT_DESCRIPTION VARCHAR(99),
    INDUSTRY_STD        VARCHAR(10),
    INDUSTRY_VRSN VARCHAR(10),
    STATUS_ID           VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE VARCHAR(20) DEFAULT (DATETIME('NOW', 'LOCALTIME')),
     FOREIGN KEY(STATUS_ID) REFERENCES REFDATA_STATUS(STATUS_ID),
    FOREIGN KEY(INDUSTRY_STD) REFERENCES REFDATA_INDUSTRYSTD(INDUSTRY_STD)
);

--Data for Specification Building and Data Building
DROP TABLE IF EXISTS DATA_VENDOR_SPECS;
CREATE TABLE DATA_VENDOR_SPECS
(
    VENDOR_SPEC_ID CHAR(38) DEFAULT (LOWER(HEX(RANDOMBLOB(16)))) PRIMARY KEY,
    VENDOR         VARCHAR(30),
    PRODUCT_NAME   varchar(35),
    INDUSTRY_STD   VARCHAR(10),
    VERSION        VARCHAR(10),
    START_EFFECTIVE_DATE  VARCHAR(20) DEFAULT (DATETIME('NOW', 'LOCALTIME')),
    END_EFFECTIVE_DATE  VARCHAR(20) DEFAULT (DATETIME('NOW', 'LOCALTIME')),
    MESSAGE_EVENTS TEXT,
    MAINTAINED_DATE VARCHAR(20) DEFAULT (DATETIME('NOW', 'LOCALTIME')),
    STATUS_ID         VARCHAR(10) DEFAULT 'Active',
    FOREIGN KEY(STATUS_ID) REFERENCES REFDATA_STATUS(STATUS_ID)
);

DROP TABLE IF EXISTS DATA_VENDOR_SPECS_MESSAGES_FIELDS_DTL;
CREATE TABLE DATA_VENDOR_SPECS_MESSAGES_FIELDS_DTL
(
    DATA_MESSAGES_FIELDS_DTL_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    VENDOR_SPEC_ID CHAR(38),
    INDUSTRY_STD   VARCHAR(10),
    SEGMENT_NAME   VARCHAR(10),
    VERSION        VARCHAR(10),
    FIELD_ORDER_ID INTEGER,
    FIELD_ID       VARCHAR(10),
    REQUIRED       VARCHAR(5),
    REPEAT         VARCHAR(5),
    REPITITION_COUNT VARCHAR(2),
    SEGMENT_FIELDORDER VARCHAR(20),
    VENDOR VARCHAR(20),
    PRODUCT_NAME VARCHAR(20),
    STATUS_ID         VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE VARCHAR(20) DEFAULT (DATETIME('NOW', 'LOCALTIME')),
    FOREIGN KEY(STATUS_ID) REFERENCES REFDATA_STATUS(STATUS_ID),
    FOREIGN KEY(INDUSTRY_STD) REFERENCES REFDATA_INDUSTRYSTD(INDUSTRY_STD)
);

DROP TABLE IF EXISTS DATA_VENDOR_SPECS_MESSAGES_SEGMENTS_DTL;
CREATE TABLE DATA_VENDOR_SPECS_MESSAGES_SEGMENTS_DTL
(
    DATA_MESSAGES_SEGMENTS_DTL_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    VENDOR_SPEC_ID VARCHAR(38),
    MESSAGE_ID        VARCHAR(10),
    INDUSTRY_STD      VARCHAR(10),
    INDUSTRY_VRSN           VARCHAR(10),
    ORDER_ID          VARCHAR(10),
    SEGMENT_NAME     VARCHAR(10),
    SEGMENT_OPTIONAL  VARCHAR(5),
    SEGMENT_REPEATING  VARCHAR(5),
    SEGMENT_REQUIRED  VARCHAR(5),
    VENDOR VARCHAR(20),
    PRODUCT_NAME VARCHAR(20),
    STATUS_ID         VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE VARCHAR(20) DEFAULT (DATETIME('NOW', 'LOCALTIME')),
    FOREIGN KEY(STATUS_ID) REFERENCES REFDATA_STATUS(STATUS_ID),
    FOREIGN KEY(INDUSTRY_STD) REFERENCES REFDATA_INDUSTRYSTD(INDUSTRY_STD)
);

-- Master Data That Lays out core assets: Segments to Fields or Message To Event Type
DROP TABLE IF EXISTS REFDATA_SEGMENTS_FIELDS
CREATE TABLE REFDATA_SEGMENTS_FIELDS
(
    REFDATA_MESSAGES_FIELDS_ID INTEGER PRIMARY KEY AUTOINCREMENT ,
    SEGMENT_NAME   VARCHAR(10),
    INDUSTRY_STD   VARCHAR(10),
    INDUSTRY_VRSN VARCHAR(10),
    FIELD_ORDER_ID INTEGER,
    FIELD_ID       VARCHAR(10),
    REQUIRED       VARCHAR(5),
    REPEAT         VARCHAR(5),
    REPITITION_COUNT VARCHAR(2),
    SEGMENT_FIELDORDER VARCHAR(20),
    STATUS_ID         VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE VARCHAR(20) DEFAULT (DATETIME('NOW', 'LOCALTIME')),
    FOREIGN KEY(STATUS_ID) REFERENCES REFDATA_STATUS(STATUS_ID),
    FOREIGN KEY(INDUSTRY_STD) REFERENCES REFDATA_INDUSTRYSTD(INDUSTRY_STD)
);

DROP TABLE IF EXISTS REFDATA_MESSAGES_SEGMENTS
CREATE TABLE REFDATA_MESSAGES_SEGMENTS
(
    REFDATA_MESSAGES_FIELDS_ID INTEGER PRIMARY KEY AUTOINCREMENT ,
    MESSAGE_ID        VARCHAR(10),
    INDUSTRY_STD      VARCHAR(10),
    INDUSTRY_VRSN VARCHAR(10),
    ORDER_ID         INT,
    SEGMENT_NAME     VARCHAR(10),
    SEGMENT_OPTIONAL  VARCHAR(5),
    SEGMENT_REPEATING VARCHAR(5),
    SEGMENT_REQUIRED  VARCHAR(5),
    STATUS_ID         VARCHAR(10) DEFAULT 'Active',
    MAINTAINED_DATE VARCHAR(20) DEFAULT (DATETIME('NOW', 'LOCALTIME')),
     FOREIGN KEY(STATUS_ID) REFERENCES REFDATA_STATUS(STATUS_ID),
     FOREIGN KEY(INDUSTRY_STD) REFERENCES REFDATA_INDUSTRYSTD(INDUSTRY_STD)
);
