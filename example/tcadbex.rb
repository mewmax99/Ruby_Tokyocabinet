require 'tokyocabinet'
include TokyoCabinet

# create the object
adb = ADB::new

# open the database
if !adb.open("casket.tch")
  STDERR.printf("open error\n")
end

# store records
if !adb.put("foo", "hop") ||
    !adb.put("bar", "step") ||
    !adb.put("baz", "jump")
  STDERR.printf("put error\n")
end

# retrieve records
value = adb.get("foo")
if value
  printf("value is %s\n", value)
else
  STDERR.printf("get error\n")
end

puts("before")
puts("===================")
# traverse records
adb.iterinit
while key = adb.iternext
  value = adb.get(key)
  if value
    printf("%s:%s\n", key, value)
  end
end

#adb.put("test", "bew")
#adb.out("test")
puts("\nafter")
puts("===================")
# traverse records
adb.iterinit
while key = adb.iternext
  value = adb.get(key)
  if value
    printf("%s:%s\n", key, value)
  end
end

puts("==================")
#Size on value
puts("Size on value")
puts("==================")
size = adb.vsiz("bar")
puts(size)

#Remove all Record
#adb.vanish()

#adb.out("test")
# close the database
if !adb.close
  STDERR.printf("close error\n")
end
