CREATE TABLE [staging].[LH_EXCEPTION] (
    [Exception_id]         VARCHAR (255) NULL,
    [Application_id]       VARCHAR (255) NULL,
    [Schedule_id]          VARCHAR (255) NULL,
    [Schedule_name]        VARCHAR (255) NULL,
    [Schedule_type]        VARCHAR (255) NULL,
    [Exception_duration]   VARCHAR (255) NULL,
    [Exception_opened]     VARCHAR (255) NULL,
    [Exception_created_at] VARCHAR (255) NULL,
    [Exception_updated_at] VARCHAR (255) NULL,
    [Area_id]              VARCHAR (255) NULL,
    [Area_name]            VARCHAR (255) NULL,
    [Area_location_id]     VARCHAR (255) NULL,
    [Area_location_name]   VARCHAR (255) NULL,
    [Area_building_id]     VARCHAR (255) NULL,
    [Area_building_name]   VARCHAR (255) NULL,
    [md_filename]          VARCHAR (255) NULL,
    [md_dateLastModified]  DATETIME      NULL,
    [md_etlJob]            BIGINT        NULL,
    [md_etlExecution]      BIGINT        NULL,
    [md_etlRun]            BIGINT        NULL
);

