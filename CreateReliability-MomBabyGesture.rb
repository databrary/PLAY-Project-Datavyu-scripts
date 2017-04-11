# Insert a coding column for Datavyu
# Creates one new column with nested arguments

require 'Datavyu_API.rb'

begin
	#Create new column
	babygesture_rel = createNewColumn("babygesture_rel", "gesture_p-s-i-c")
    momgesture_rel = createNewColumn("momgesture_rel", "gesture_p-s-i-c")

  #Write the new column to Datavyu's spreadsheet
	setColumn(babygesture_rel)
	setColumn(momgesture_rel)

end
