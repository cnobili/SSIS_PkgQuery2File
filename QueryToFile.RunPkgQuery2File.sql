if object_id('QueryToFile.RunPkgQuery2File') is not null
  drop procedure QueryToFile.RunPkgQuery2File
  
go

create procedure QueryToFile.RunPkgQuery2File
(
  @FolderName      varchar(256)
, @ProjectName     varchar(256)
, @PackageName     varchar(256)
, @GroupName       varchar(256) = 'ALL'
, @DataExtractName varchar(256) = 'ALL'
)
-- -----------------------------------------------------------------------------
--
-- procedure: QueryToFile.RunPkgQuery2File
--
-- purpose: Runs SSIS Package PkgQuery2File that is deployed in the SSISDB Catalog.
--
-- -----------------------------------------------------------------------------
--
-- rev log
--
-- date:  07-AUG-2015
-- author:  Craig Nobili
-- desc: original
--
-- ---------------------------------------------------------------------------  
as
begin

  declare @Extracts table
  (  
    DataExtractDefKey      bigint 
  , ExtractName            varchar(256)
  , LogToDbConnStr         varchar(256)
  , SourceDbType           varchar(25)
  , SourceDbConnStr        varchar(256)
  , SourceDbQuery          varchar(4000)
  , OutputFile             varchar(256)
  , Delimiter              varchar(1)
  , ColumnHeaderFlg        varchar(1)
  , Used                   bit default 0
  ) 
  -- Use nvarchar as these will be passed to SSIS Package String parameters
  declare @DataExtractDefkey bigint
  declare @ExtractName       nvarchar(256)
  declare @LogToDbConnStr    nvarchar(256)
  declare @SourceDbType      nvarchar(25)
  declare @SourceDbConnStr   nvarchar(256)
  declare @SourceDbQuery     nvarchar(4000)
  declare @OutputFile        nvarchar(256)
  declare @Delimiter         nvarchar(1)
  declare @ColumnHeaderFlg   nvarchar(1)
    
  declare @ExecutionId bigint
  
  insert into @Extracts
  select
    DataExtractDefKey
  , ExtractName
  , LogToDbConnStr
  , SourceDbType
  , SourceDbConnStr
  , substring(SourceDbQuery, 1, 4000) as SourceDbQuery
  , OutputFile
  , Delimiter
  , ColumnHeaderFlg
  , 0  as Used
  from
    QueryToFile.DataExtractDef
  where 1 = 1
    and ActiveFlg = 'Y'
    and GroupName = iif(@GroupName = 'ALL', GroupName, @GroupName)                 -- filter by GroupName or select every record if ALL
    and ExtractName = iif(@DataExtractName = 'ALL', ExtractName, @DataExtractName) -- filter by ExtractName or select every record if ALL
  order by
    DataExtractDefKey
  ;
  
  select top 1
    @DataExtractDefKey = DataExtractDefKey
  , @ExtractName       = ExtractName
  , @LogToDbConnStr    = LogToDbConnStr
  , @SourceDbType      = SourceDbType
  , @SourceDbConnStr   = SourceDbConnStr
  , @SourceDbQuery     = SourceDbQuery
  , @OutputFile        = OutputFile
  , @Delimiter         = Delimiter
  , @ColumnHeaderFlg   = ColumnHeaderFlg
  from
    @Extracts
  where 1 = 1
    and Used = 0
  ;
 
  while @@ROWCOUNT <> 0 and @DataExtractDefKey is not null
  begin
  
    -- Perform your processing here  
    --print @DataExtractDefKey
    
    exec SSISDB.catalog.create_execution
      @folder_name     = @FolderName
    , @project_name    = @ProjectName
    , @package_name    = @PackageName
    , @reference_id    = null
    , @use32bitruntime = 1
    , @execution_id    = @ExecutionId output
      
    --
    -- Set Parameters
    --
    exec SSISDB.catalog.set_execution_parameter_value
      @ExecutionID
    , @object_type     = 20          -- 20 is project parm and 30 is package param
    , @parameter_name  = N'MetaData_dbconn_str'
    , @parameter_value = @LogToDbConnStr

    exec SSISDB.catalog.set_execution_parameter_value
      @ExecutionID
    , @object_type     = 30          -- 20 is project parm and 30 is package param
    , @parameter_name  = N'dbConnType'
    , @parameter_value = @SourceDbType

    exec SSISDB.catalog.set_execution_parameter_value
      @ExecutionID
    , @object_type     = 30          -- 20 is project parm and 30 is package param
    , @parameter_name  = N'dbConnStr'
    , @parameter_value = @SourceDbConnStr

    exec SSISDB.catalog.set_execution_parameter_value
      @ExecutionID
    , @object_type     = 30          -- 20 is project parm and 30 is package param
    , @parameter_name  = N'dbQuery'
    , @parameter_value = @SourceDbQuery

    exec SSISDB.catalog.set_execution_parameter_value
      @ExecutionID
    , @object_type     = 30          -- 20 is project parm and 30 is package param
    , @parameter_name  = N'outputFilePath'
    , @parameter_value = @OutputFile

    exec SSISDB.catalog.set_execution_parameter_value
      @ExecutionID
    , @object_type     = 30          -- 20 is project parm and 30 is package param
    , @parameter_name  = N'delimiter'
    , @parameter_value = @Delimiter

    exec SSISDB.catalog.set_execution_parameter_value
      @ExecutionID
    , @object_type     = 30          -- 20 is project parm and 30 is package param
    , @parameter_name  = N'ColumnHeaderFlg'
    , @parameter_value = @ColumnHeaderFlg

    exec SSISDB.catalog.set_execution_parameter_value
      @ExecutionID
    , @object_type     = 30          -- 20 is project parm and 30 is package param
    , @parameter_name  = N'ExtractName'
    , @parameter_value = @ExtractName

    exec SSISDB.catalog.set_execution_parameter_value
      @ExecutionID
    , @object_type     = 30          -- 20 is project parm and 30 is package param
    , @parameter_name  = N'DataExtractDefKey'
    , @parameter_value = @DataExtractDefKey
          
    exec SSISDB.catalog.start_execution @ExecutionId
      
    --print @ExecutionId
    --select * from SSISDB.catalog.executions where execution_id = @ExecutionId;

    --Update the record to "used" 
    update @Extracts set Used = 1 where DataExtractDefKey = @DataExtractDefKey;

     --Get the next record  
     select top 1
       @DataExtractDefKey = DataExtractDefKey
     , @ExtractName       = ExtractName
     , @LogToDbConnStr    = LogToDbConnStr
     , @SourceDbType      = SourceDbType
     , @SourceDbConnStr   = SourceDbConnStr
     , @SourceDbQuery     = SourceDbQuery
     , @OutputFile        = OutputFile
     , @Delimiter         = Delimiter
     , @ColumnHeaderFlg   = ColumnHeaderFlg
     from
       @Extracts
     where 1 = 1
       and Used = 0
     ;
     
  end
  
end
