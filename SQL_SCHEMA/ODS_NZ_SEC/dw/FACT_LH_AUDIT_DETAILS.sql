CREATE TABLE [dw].[FACT_LH_AUDIT_DETAILS] (
    [PK_Audit_id]   VARCHAR (255) NULL,
    [P_group_name]  VARCHAR (255) NULL,
    [P_field_name]  VARCHAR (255) NULL,
    [P_field_value] VARCHAR (MAX) NULL,
    [P_field_type]  VARCHAR (255) NULL,
    [type]          VARCHAR (255) NULL
);

