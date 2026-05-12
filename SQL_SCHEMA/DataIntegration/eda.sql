CREATE SCHEMA [eda]
    AUTHORIZATION [dbo];


GO
GRANT UPDATE
    ON SCHEMA::[eda] TO [System.EDAApp];


GO
GRANT SELECT
    ON SCHEMA::[eda] TO [System.EDAApp];


GO
GRANT INSERT
    ON SCHEMA::[eda] TO [System.EDAApp];


GO
GRANT DELETE
    ON SCHEMA::[eda] TO [System.EDAApp];

