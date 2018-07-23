grant select on QueryToFile.DataExtractDef to [EXCHANGE\HCEDWLOADER-SRVC]
grant insert on QueryToFile.DataExtractDef to [EXCHANGE\HCEDWLOADER-SRVC]
grant update on QueryToFile.DataExtractDef to [EXCHANGE\HCEDWLOADER-SRVC]

grant select on QueryToFile.DataExtractOut to [EXCHANGE\HCEDWLOADER-SRVC]
grant insert on QueryToFile.DataExtractOut to [EXCHANGE\HCEDWLOADER-SRVC]
grant update on QueryToFile.DataExtractOut to [EXCHANGE\HCEDWLOADER-SRVC]

grant execute on QueryToFile.LogBegDataExtract to [EXCHANGE\HCEDWLOADER-SRVC]
grant execute on QueryToFile.LogEndDataExtract to [EXCHANGE\HCEDWLOADER-SRVC]

grant connect to [EXCHANGE\HCEDWLOADER-SRVC]
