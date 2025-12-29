CREATE TABLE [staging].[GHS_ACTIVITIES_STATISTIC] (
    [activity_id]               BIGINT     NULL,
    [duration_seconds]          BIGINT     NULL,
    [total_distance_metres]     BIGINT     NULL,
    [auto_checkin_count]        BIGINT     NULL,
    [manual_checkin_count]      BIGINT     NULL,
    [hashtag_checkin_count]     BIGINT     NULL,
    [gps_checkin_count]         BIGINT     NULL,
    [vehicle_checkin_count]     BIGINT     NULL,
    [estimated_distance_metres] BIGINT     NULL,
    [accuracy_avg_metres]       FLOAT (53) NULL,
    [altitude_avg_metres]       FLOAT (53) NULL,
    [altitude_med_metres]       FLOAT (53) NULL,
    [altitude_min_metres]       FLOAT (53) NULL,
    [altitude_max_metres]       FLOAT (53) NULL,
    [speed_avg_kmh]             FLOAT (53) NULL,
    [speed_med_kmh]             FLOAT (53) NULL,
    [speed_min_kmh]             FLOAT (53) NULL,
    [speed_max_kmh]             FLOAT (53) NULL
);

