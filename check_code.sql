CREATE PROCEDURE [dbo].[check_code]
    @Code VARCHAR(8),
    @IsValid INT OUTPUT
AS
BEGIN
    DECLARE @ValidCharacters VARCHAR(23) = 'ACDEFGHKLMNPRTXYZ234579';
    DECLARE @IsValidCode INT = 1;
    DECLARE @Position INT = 1;

    WHILE @Position <= 8
    BEGIN
        IF CHARINDEX(SUBSTRING(@Code, @Position, 1), @ValidCharacters) = 0
        BEGIN
            SET @IsValidCode = 0;
            BREAK;
        END;
        SET @Position = @Position + 1;
    END;

    SET @IsValid = @IsValidCode;
END
GO

