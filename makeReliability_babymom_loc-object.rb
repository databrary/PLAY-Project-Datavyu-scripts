# Insert a coding column for Datavyu
# Creates one new column with nested arguments

require 'Datavyu_API.rb'

begin
	#Create new column
	babyloc_rel = createNewColumn("babyloc_rel", "loc_l-f-h-c")
  momloc_rel = createNewColumn("momloc_rel", "loc_l-f")
  babyobject_rel = createNewColumn("babyobject_rel", "o")
  momobject_rel = createNewColumn("momobject_rel", "o")

  #Write the new column to Datavyu's spreadsheet
	setColumn(babyloc_rel)
	setColumn(momloc_rel)
	setColumn(babyobject_rel)
	setColumn(momobject_rel)

end
