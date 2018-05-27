require 'tokyocabinet'
include TokyoCabinet

# create the object
bdb = BDB::new

# open the database
if !bdb.open("btree.tcb", BDB::OWRITER | BDB::OCREAT)
    ecode = bdb.ecode
    STDERR.printf("open error: %s\n", bdb.errmsg(ecode))
end

#store record
bdb.put("name", "mewmax")
bdb.put("age", "20")
bdb.put("power", "fast run")

#Store record more value with array
bdb.putlist("JV",["Ohm","Golf"])



# Traverse records
puts("\n After insert record")
puts("===================")
cur = BDBCUR::new(bdb)
cur.first
while key = cur.key
  value = cur.val
  if value
    printf("%s:%s\n", key, value)
  end
  cur.next
end

# Get list
puts("\nGet record list")
puts("===================")
puts(bdb.getlist("JV"))


# update record
puts("\nUpdate Record")
puts("name => Allen , age => 10 power => Ving Bab P Toon")
puts("===================")
bdb.put("name", "Allen")
bdb.put("age", "10")
bdb.put("power", "Ving Bab P Toon")
cur = BDBCUR::new(bdb)
cur.first
while key = cur.key
  value = cur.val
  if key == "name" || key == "age" || key == "power"
    printf("%s:%s\n", key, value)
  end
  cur.next
end




# Store a record with allowing duplication of keys.
bdb.putdup("age","30")

puts("\nConcatenate a value at the end of the existing record.")
puts("name => Barry")
puts("===================")
bdb.putcat("name"," Barry")
cur = BDBCUR::new(bdb)
cur.first
while key = cur.key
  value = cur.val
  if key == "name"
    printf("%s:%s\n", key, value)
  end
  cur.next
end




# If duplicate data is not saved
puts("\nIf duplicate data is not saved name => The Flash")
puts("===================")
bdb.putkeep("name", "The Flash")
cur = BDBCUR::new(bdb)
cur.first
while key = cur.key
  value = cur.val
  if key == "name"
    printf("%s:%s\n", key, value)
  end
  cur.next
end



# Remove a record.
puts("\nRemove a record power")
puts("===================")
bdb.out("power")
cur = BDBCUR::new(bdb)
cur.first
while key = cur.key
  value = cur.val
  if value
    printf("%s:%s\n", key, value)
  end
  cur.next
end

# Get the number of records corresponding a key.
puts("\nNumber of records name ")
puts("===================")
puts(bdb.vnum("name"))

# Get the size of the value of a record.
puts("\nSize of the value of a record name")
puts("===================")
puts(bdb.vsiz("name"))

# Get the number of records.
puts("\nThe number of records ")
puts("===================")
puts(bdb.rnum())

# Get the size of the database file.
puts("\nThe size of the database file ")
puts("===================")
puts(bdb.fsiz())

# Remove all records.
bdb.vanish()




