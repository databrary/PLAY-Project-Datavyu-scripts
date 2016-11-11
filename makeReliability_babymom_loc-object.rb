# Insert a coding column for Datavyu
# Creates one new column with nested arguments

require 'Datavyu_API.rb'

begin
	#Create new column
	babyloc_rel = createNewColumn("babyloc_rel", "loc_lfhc")
  momloc_rel = createNewColumn("momloc_rel", "loc_lf")
  babyobject_rel = createNewColumn("babyobject_rel", "object")
  momobject_rel = createNewColumn("momobject_rel", "object")

  #Write the new column to Datavyu's spreadsheet
	setColumn(babyloc_rel)
	setColumn(momloc_rel)
	setColumn(babyobject_rel)
	setColumn(momobject_rel)

end
