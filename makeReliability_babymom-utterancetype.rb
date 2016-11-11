# Insert a coding column for Datavyu
# Creates one new column with nested arguments

require 'Datavyu_API.rb'

begin
	#Create new column
	babyutterancetype_rel = createNewColumn("babyutterancetype_rel", "language-s-w", "langlike-b-v", "crygrunt-c-g", "unintell-x")
  momutterancetype_rel = createNewColumn("momutterancetype_rel", "imperative-l-a-p", "interrog-i-declar-d", "filler-f", "unintell-x")

  #Write the new column to Datavyu's spreadsheet
	setColumn(babyutterancetype_rel)
	setColumn(momutterancetype_rel)

end
