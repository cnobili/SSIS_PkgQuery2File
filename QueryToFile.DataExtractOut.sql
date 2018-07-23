if object_id('QueryToFile.DataExtractOut') is not null
  drop table QueryToFile.DataExtractOut

go

create table QueryToFile.DataExtractOut
(
  DataExtractOutKey      bigint primary key identity
, ExtractName            varchar(256)  
, ProgramName            varchar(256)
, SqlStatement           varchar(8000)
, BegDateTime            datetime
, EndDateTime            datetime
, Status                 varchar(20)
, OutputFile             varchar(2000)
, Delimiter              varchar(1)
, ColumnHeaderFlg        varchar(1)
, NumRecs                bigint
, FileSizeBytes          bigint
, DataExtractDefKey      bigint        default 0 -- links back to DataExtractDef.DataExtractDefKey (implied foreign key but optional to populate)
, ErrorMsg               varchar(8000) default null
, constraint DataExtractOut_CK1
  check (ColumnHeaderFlg in ('Y', 'N'))
, constraint DataExtractOut_CK2
  check (Status in ('RUNNING', 'SUCCESS', 'FAILURE'))
)
;
