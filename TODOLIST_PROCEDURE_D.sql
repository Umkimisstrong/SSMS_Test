-- 橇肺矫历 积己
-- TODO 昏力 : D
CREATE PROCEDURE TODO_D
(
	@TODO_ID	INT
)
AS
BEGIN
	UPDATE TB_TODO
	SET TODO_STATUS = 'D'
	WHERE TODO_ID = @TODO_ID;
END;
--==>> Commands completed successfully.