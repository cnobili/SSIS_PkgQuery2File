if object_id('QueryToFile.DataExtractDef') is not null
  drop table QueryToFile.DataExtractDef

go

create table QueryToFile.DataExtractDef
(
  DataExtractDefKey      bigint primary key identity
, ExtractName            varchar(256)                 not null
, LogToDbConnStr         varchar(256)                 not null
, SourceDbType           varchar(25)                  not null
, SourceDbConnStr        varchar(256)                 not null
--, SourceDbQuery          varchar(8000)              not null
, SourceDbQuery          varchar(max)                 not null
, OutputFile             varchar(2000)                not null
, Delimiter              varchar(2)                   not null
, ColumnHeaderFlg        varchar(1)                   not null
, ActiveFlg              varchar(1)                   not null
, GroupName              varchar(256)
, SendEmailOn            varchar(20)                  not null
, Emails                 varchar(8000)                -- comma separated 
, constraint DataExtractDef_UK1
  unique (ExtractName)
, constraint DataExtractDef_CK1
  check (ColumnHeaderFlg in ('Y', 'N'))
, constraint DataExtractDef_CK2
  check (ActiveFlg in ('Y', 'N'))
, constraint DataExtractDef_CK3
  check (SourceDbType in ('SQL', 'ORA', 'ODBC'))
, constraint DataExtractDef_CK4
  check (SendEmailOn in ('NONE', 'SUCCESS', 'FAILURE', 'BOTH'))
)
;
