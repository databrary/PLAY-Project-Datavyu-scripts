# Insert a coding column for Datavyu
# Creates one new column with nested arguments

require 'Datavyu_API.rb'

begin
	#Create new column
	babyemotion_rel = createNewColumn("babyemotion_rel", "emotion_p-n")
    momemotion_rel = createNewColumn("momemotion_rel", "emotion_p-n")

  #Write the new column to Datavyu's spreadsheet
	setColumn(babyemotion_rel)
	setColumn(momemotion_rel)

end
