-- ���ν��� ����
-- TODO ���� : U
CREATE PROCEDURE TODO_U
(
	  @TODO_ID		INT
	, @TODO_STATUS  VARCHAR(8)
)
AS
BEGIN
	UPDATE TB_TODO
	SET TODO_STATUS = @TODO_STATUS
	WHERE TODO_ID = @TODO_ID;
END;
--==>> Commands completed successfully.