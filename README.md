Import from parse:
>use greenbot
>db.dropDatabase()

$for f in  _User Scripts Settings Dids Networks Rooms  Sessions ; do  mongoimport -d greenbot -c "$f" --file "$f".json --jsonArray ; done  

>load("/root/code/greenbot-admin/.db_migrations/fix_parse_import.js");


