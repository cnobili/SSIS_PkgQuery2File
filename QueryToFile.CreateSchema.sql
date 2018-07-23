if not exists (select name from sys.schemas where name = 'QueryToFile')
begin
  exec('create schema QueryToFile') -- create schema must run in its own batch
end
