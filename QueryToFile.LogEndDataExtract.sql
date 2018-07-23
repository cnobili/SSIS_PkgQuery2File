if object_id('QueryToFile.LogEndDataExtract') is not null
  drop procedure QueryToFile.LogEndDataExtract
  
go

create procedure QueryToFile.LogEndDataExtract
(
  @DataExtractOutKey bigint
, @EndDateTime       datetime
, @Status            varchar(20) -- Success or Failure
, @NumRecs           bigint
, @FileSizeBytes     bigint
, @ErrorMsg          varchar(8000) = null
)
-- -----------------------------------------------------------------------------
--
-- procedure: QueryToFile.LogEndDataExtract
--
-- purpose: Logs the end of a data file extract.
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

  update QueryToFile.DataExtractOut set
    EndDateTime   = GetDate()
  , Status        = @Status
  , NumRecs       = @NumRecs
  , FileSizeBytes = @FileSizeBytes
  , ErrorMsg     = @ErrorMsg
  where DataExtractOutKey = @DataExtractOutKey
  ;

end
