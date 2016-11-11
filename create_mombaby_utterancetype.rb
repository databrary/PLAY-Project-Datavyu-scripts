require 'Datavyu_API.rb'
begin
  
   momutterancetype = create_new_column("momutterancetype","imperative-l-a-p","interrog-i-declar-d","filler-f","unintell-x")
   babyutterancetype = create_new_column("babyutterancetype","language-s-w","langlike-b-v","crygrunt-c-g","unintell-x")
    
   momspeech = getColumn("momspeech")
   babyvoc = getColumn("babyvoc")

   for momspeechcell in momspeech.cells
     momutterancetypecell = momutterancetype.make_new_cell()
     momutterancetypecell.change_code("onset", momspeechcell.onset)
     momutterancetypecell.change_code("offset", momspeechcell.onset)
   end
   for babyvoccell in babyvoc.cells
     babyutterancetypecell = babyutterancetype.make_new_cell()
     babyutterancetypecell.change_code("onset", babyvoccell.onset)
     babyutterancetypecell.change_code("offset", babyvoccell.onset)
   end 
   
  set_column("momutterancetype",momutterancetype)
  set_column("babyutterancetype",babyutterancetype)

  
end
   