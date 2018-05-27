require 'tokyocabinet'
include TokyoCabinet

# create the object
tdb = TDB::new

# open the database
if !tdb.open("T.tct", TDB::OWRITER | TDB::OCREAT)
  ecode = tdb.ecode
  STDERR.printf("open error: %s\n", tdb.errmsg(ecode))
end

# store a record
cols = { "name" => "mikio", "age" => "30", "lang" => "ja,en,c" }
tdb.put("X-men",cols)
cols2 = { "name" => "Barry", "age" => "31", "lang" => "th", "skill" => "cook,blog" }
tdb.put("barry", cols2)
cols2 = { "name" => "Ohm", "age" => "99", "lang" => "c", "skill" => "walk" }
tdb.put("allen", cols2)


puts("After store record")
puts("\n")
qry = TDBQRY::new(tdb)
qry.addcond("age", TDBQRY::QCNUMGE, "20")
qry.addcond("lang", TDBQRY::QCSTROR, "ja,en,th,c")
qry.setorder("name", TDBQRY::QOSTRASC)
qry.setlimit(10)
res = qry.search
res.each do |rkey|
  rcols = tdb.get(rkey)
  printf("name:%s\n", rcols["name"])
  printf("age:%s\n", rcols["age"])
  printf("skill:%s\n", rcols["skill"])
  printf("---\n")
end
puts("-------------------")
#TDBQRY::QCNUMGE :  การกำหนดตัวเลขที่แสดงต้องมากกว่าที่ตั้งไว้
#TDBQRY::QCSTROR :  การกำหนดประเภทของข้อมูลที่จะแสดงถ้ามีตามที่กำหนดก็จะแสดงได้
#TDBQRY::QOSTRASC : การกำหนดลำดับการแสดงข้อมูล
#setorder : Set the order of the result. กำนดลำดับการแสดง
#addcond : Add a narrowing condition การ sort ข้อมูล

puts("Update record")
puts("X-men : name => mikio, age => 30, lang => ja,en,c To name => Javis, age => 100, lang => ja , skill => Fly ")
puts("\n")
cols2 = { "name" => "Javis", "age" => "100", "lang" => "ja", "skill" => "Fly" }
tdb.put("X-men",cols2)
qry = TDBQRY::new(tdb)
qry.addcond("age", TDBQRY::QCNUMGE, "20")
qry.addcond("lang", TDBQRY::QCSTROR, "ja,en,th,c")
qry.setorder("name", TDBQRY::QOSTRASC)
qry.setlimit(10)
res = qry.search
res.each do |rkey|
  rcols = tdb.get(rkey)
  printf("name:%s\n", rcols["name"])
  printf("age:%s\n", rcols["age"])
  printf("skill:%s\n", rcols["skill"])
  printf("---\n")
end
puts("-------------------")

puts("If duplicate promary key is not saved ")
puts("X-men : name => mikio, age => 30, lang => ja,en,c")
puts("\n")
cols2 = { "name" => "mikio", "age" => "30", "lang" => "ja,en,c"}
tdb.putkeep("X-men",cols2)
qry = TDBQRY::new(tdb)
qry.addcond("age", TDBQRY::QCNUMGE, "20")
qry.addcond("lang", TDBQRY::QCSTROR, "ja,en,th,c")
qry.setorder("name", TDBQRY::QOSTRASC)
qry.setlimit(10)
res = qry.search
res.each do |rkey|
  rcols = tdb.get(rkey)
  printf("name:%s\n", rcols["name"])
  printf("age:%s\n", rcols["age"])
  printf("skill:%s\n", rcols["skill"])
  printf("---\n")
end
puts("-------------------")


puts("Retrieve a record.")
puts(tdb.get("X-men"))
puts("\n-------------------")

# Get the size of the value of a record.
puts("Size of the value of a record Primary Key 'allen'")
puts(tdb.vsiz("allen"))
puts("\n-------------------")

# Get the number of records.
puts("The number of records ")
puts(tdb.rnum())
puts("\n-------------------")
# Get the size of the database file.
puts("The size of the database file ")
puts(tdb.fsiz())
puts("\n-------------------")


puts("Remove a record. Primary Key 'X-men'")
tdb.out("X-men")
qry = TDBQRY::new(tdb)
qry.addcond("age", TDBQRY::QCNUMGE, "20")
qry.addcond("lang", TDBQRY::QCSTROR, "ja,en,th,c")
qry.setorder("name", TDBQRY::QOSTRASC)
qry.setlimit(10)
res = qry.search
res.each do |rkey|
  rcols = tdb.get(rkey)
  printf("name:%s\n", rcols["name"])
  printf("age:%s\n", rcols["age"])
  printf("skill:%s\n", rcols["skill"])
  printf("---\n")
end
puts("-------------------") 


# Remove all records.
tdb.vanish()