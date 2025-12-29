CREATE TABLE [ods].[LKP_ADDRESS] (
    [address_id]          NUMERIC (18)     NOT NULL,
    [full_address_number] VARCHAR (50)     NOT NULL,
    [full_road_name]      VARCHAR (50)     NOT NULL,
    [suburb_locality]     VARCHAR (50)     NULL,
    [town_city]           VARCHAR (50)     NULL,
    [gd2000_xcoord]       NUMERIC (18, 10) NOT NULL,
    [gd2000_ycoord]       NUMERIC (18, 10) NOT NULL,
    CONSTRAINT [PK_LKP_ADDRESS] PRIMARY KEY CLUSTERED ([address_id] ASC)
);

