if object_id('QueryToFile.LogBegDataExtract') is not null
  drop procedure QueryToFile.LogBegDataExtract
  
go

create procedure QueryToFile.LogBegDataExtract
(
  @ProgramName       varchar(256)
, @ExtractName       varchar(256)  
, @SqlStatement      varchar(8000)
, @BegDateTime       datetime
, @OutputFile        varchar(256)
, @Delimiter         varchar(1)
, @ColumnHeaderFlg   varchar(1)
, @DataExtractDefKey bigint = 0
)
-- -----------------------------------------------------------------------------
--
-- procedure: QueryToFile.LogBegDataExtract
--
-- purpose: Logs the beginning of a data file extract.
--
-- -----------------------------------------------------------------------------
--
-- rev log
--
-- date:  06-AUG-2015
-- author:  Craig Nobili
-- desc: original
--
-- ---------------------------------------------------------------------------  
as
begin

  insert into QueryToFile.DataExtractOut
  (
    ExtractName
  , ProgramName
  , SqlStatement
  , BegDateTime
  , Status
  , OutputFile
  , Delimiter
  , ColumnHeaderFlg
  , DataExtractDefKey  
  )
  output inserted.DataExtractOutKey
  values
  (
    @ExtractName
  , @ProgramName    
  , @SqlStatement
  , @BegDateTime
  , 'RUNNING'
  , @OutputFile
  , @Delimiter
  , @ColumnHeaderFlg
  , @DataExtractDefKey
  );
  
end
