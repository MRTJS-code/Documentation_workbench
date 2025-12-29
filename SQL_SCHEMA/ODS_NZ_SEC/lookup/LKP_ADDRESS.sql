CREATE TABLE [lookup].[LKP_ADDRESS] (
    [address_id]          NUMERIC (18)     NULL,
    [full_address_number] VARCHAR (50)     NULL,
    [full_road_name]      VARCHAR (50)     NULL,
    [suburb_locality]     VARCHAR (50)     NULL,
    [town_city]           VARCHAR (50)     NULL,
    [gd2000_xcoord]       NUMERIC (18, 10) NULL,
    [gd2000_ycoord]       NUMERIC (18, 10) NULL
);

