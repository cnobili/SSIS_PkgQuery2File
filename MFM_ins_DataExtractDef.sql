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
  'HC2MFM_CIN_Invoice'
, 'DSN=PNSQLDATA-HC;Trusted_Connection=yes;'
, 'SQL'  
, 'DSN=HCDBPRD;Trusted_Connection=yes;'
, 'select @@version'  -- put in valid SQL Statement or enter it via Management Studio table edit feature
, '\\MFMDBPRD\Refunds\CN\CN_PrepaymentInvoice_YYYY-MM-DD_PROD.txt'
, ''
, 'N'
, 'Y'
, 'HC'
, 'NONE'
, 'Craig.Nobili@johnmuirhealth.com'
);
