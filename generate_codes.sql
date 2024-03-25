CREATE PROCEDURE [dbo].[generate_codes]
AS
BEGIN
    DECLARE @GeneratedCodes TABLE (Code VARCHAR(8));
    DECLARE @Counter INT = 1;
    DECLARE @GeneratedCode VARCHAR(8);

    WHILE @Counter <= 1000
    BEGIN
        SET @GeneratedCode = '';
        DECLARE @Position INT = 1;

        WHILE @Position <= 8
        BEGIN
            DECLARE @RandomIndex INT = CAST(RAND() * 23 AS INT) + 1;
            SET @GeneratedCode = @GeneratedCode + SUBSTRING('ACDEFGHKLMNPRTXYZ234579', @RandomIndex, 1);
            SET @Position = @Position + 1;
        END;

        INSERT INTO @GeneratedCodes (Code) VALUES (@GeneratedCode);
        SET @Counter = @Counter + 1;
    END;

    SELECT * FROM @GeneratedCodes;
END
GO

