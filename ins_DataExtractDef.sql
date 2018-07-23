truncate table QueryToFile.DataExtractDef;

insert into QueryToFile.DataExtractDef
(
  ExtractName
, LogToDbConnStr
, SourceDbType
, SourceDbConnStr
, SourceDbQuery
, OutputFile
, Delimiter
, ColumnHeaderFlg
, ActiveFlg
, GroupName
, SendEmailOn
, Emails
)
values
(
  'DRG1'
, 'DSN=HCDBTST;Trusted_Connection=yes;'
, 'SQL'  
, 'DSN=HCDBTST;Trusted_Connection=yes;'
, 'select DRGRecordID + '','' + DRGNM from Epic.Reference.DRGBASE'
, 'C:\Temp\drg1.txt'
, ''
, 'N'
, 'Y'
, 'HC'
, 'BOTH'
, 'Craig.Nobili@johnmuirhealth.com'
);

insert into QueryToFile.DataExtractDef
(
  ExtractName
, LogToDbConnStr
, SourceDbType
, SourceDbConnStr
, SourceDbQuery
, OutputFile
, Delimiter
, ColumnHeaderFlg
, ActiveFlg
, GroupName
, SendEmailOn
, Emails
)
values
(
  'DRG2'
, 'DSN=HCDBTST;Trusted_Connection=yes;'
, 'SQL'  
, 'DSN=HCDBTST;Trusted_Connection=yes;'
, 'select DRGRecordID + '','' + DRGNM from Epic.Reference.DRGBASE'
, 'C:\Temp\drg2.txt'
, ''
, 'N'
, 'Y'
, 'HC'
, 'BOTH'
, 'Craig.Nobili@johnmuirhealth.com'
);
