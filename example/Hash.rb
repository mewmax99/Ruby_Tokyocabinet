require 'tokyocabinet'
include TokyoCabinet

# create the object
hdb = HDB::new

# open the database
if !hdb.open("Hash.tch", HDB::OWRITER | HDB::OCREAT)
  ecode = hdb.ecode
  STDERR.printf("open error: %s\n", hdb.errmsg(ecode))
end

# store records
hdb.put("Song", "Dear mama")
hdb.put("Artist", "2pac")
hdb.put("Type", "HipHop")

# traverse records
puts("After store record")
puts("\n")
hdb.iterinit
while key = hdb.iternext
  value = hdb.get(key)
  if value
    printf("%s:%s\n", key, value)
  end
end
puts("-------------------")

# Update Record 
puts("Update record update Song:Dear mama => Song:Keep ya")
puts("\n")
hdb.put("Song", "Keep ya")
hdb.iterinit
while key = hdb.iternext
  value = hdb.get(key)
  if key == "Song"
    printf("%s:%s\n", key, value)
  end
end
puts("-------------------")

puts("Store a record in asynchronous fashion. Other => Simple")
puts("\n")
hdb.putasync("Other","Simple")
hdb.iterinit
while key = hdb.iternext
  value = hdb.get(key)
  if value
    printf("%s:%s\n", key, value)
  end
end
puts("-------------------")

puts("Concatenate a value at the end of the existing record.")
puts("Song => Dear mama to Song => and Keep ya Head")
puts("\n")
hdb.putcat("Song"," and Keep ya Head")
hdb.iterinit
while key = hdb.iternext
  value = hdb.get(key)
  if key == "Song"
    printf("%s:%s\n", key, value)
  end
end
puts("-------------------")


puts("Retrieve a record.")
puts("\n")
puts(hdb.get("Song"))
puts("-------------------")

# Get the size of the value of a record.
puts("Size of the value of a record Song")
puts("\n")
puts(hdb.vsiz("Song"))
puts("-------------------")

# Get the number of records.
puts("The number of records ")
puts("\n")
puts(hdb.rnum())
puts("-------------------")
# Get the size of the database file.
puts("The size of the database file ")
puts("\n")
puts(hdb.fsiz())
puts("-------------------")



puts("Remove a record. Other")
puts("\n")
hdb.out("Other")
hdb.iterinit
while key = hdb.iternext
  value = hdb.get(key)
  if key
    printf("%s:%s\n", key, value)
  end
end
puts("-------------------")

# Remove all records.
hdb.vanish()
