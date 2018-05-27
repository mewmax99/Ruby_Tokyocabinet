require 'tokyocabinet'
include TokyoCabinet

# create the object
fdb = FDB::new

# open the database
if !fdb.open("Fix.tcf", FDB::OWRITER | FDB::OCREAT)
  ecode = fdb.ecode
  STDERR.printf("open error: %s\n", fdb.errmsg(ecode))
end

#store record
fdb.put(1, "one")
fdb.put(12, "twelve")
fdb.put(144, "one forty four")

# traverse records
puts("After store record")
fdb.iterinit
while key = fdb.iternext
  value = fdb.get(key)
  if value
    printf("%s:%s\n", key, value)
  end
end
puts("\n-------------------")
# Update Record 
puts("Update record update 12:twelve => 12:one two")
fdb.put(12,"one two")
fdb.iterinit
while key = fdb.iternext
  value = fdb.get(key)
  if key == "12"
    printf("%s:%s\n", key, value)
  end
end
puts("\n-------------------")

# If duplicate data is not saved
puts("If duplicate data is not saved 144:one forty four => 144:one_forty_four")
fdb.putkeep(144,"one_forty_four")
fdb.iterinit
while key = fdb.iternext
  value = fdb.get(key)
  if key == "144"
    printf("%s:%s\n", key, value)
  end
end
puts("\n-------------------")

# Concatenate a value at the end of the existing record.
puts("Concatenate a value at the end of the existing record.")
puts("144:one forty four => 144:one forty four by barry")
fdb.putcat(144," by barry")
fdb.iterinit
while key = fdb.iternext
  value = fdb.get(key)
  if key == "144"
    printf("%s:%s\n", key, value)
  end
end
puts("\n-------------------")

puts("Retrieve a record.")
puts(fdb.get(144))
puts("\n-------------------")

# Get the size of the value of a record.
puts("Size of the value of a record 144")
puts(fdb.vsiz(144))
puts("\n-------------------")

# Get the number of records.
puts("The number of records ")
puts(fdb.rnum())
puts("\n-------------------")
# Get the size of the database file.
puts("The size of the database file ")
puts(fdb.fsiz())
puts("\n-------------------")

# Remove all records.
fdb.vanish()


