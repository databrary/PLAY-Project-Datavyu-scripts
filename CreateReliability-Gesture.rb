# Insert a coding column for Datavyu
# Creates one new column with nested arguments

require 'Datavyu_API.rb'

begin
	#Create new column
	gesture_rel = createNewColumn("gesture_rel","source_m-b","gesture_p-s-i-c")

  #Write the new column to Datavyu's spreadsheet
	setColumn(gesture_rel)

end
