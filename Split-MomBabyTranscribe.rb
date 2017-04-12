require 'Datavyu_API.rb'
begin

   trans = getColumn("transcribe")
   
   momspeech = create_new_column("momspeech", "content")
   babyvoc = create_new_column("babyvoc", "content")
   
   for transcell in trans.cells
    if transcell.source_mb == 'm'
     momspeechcell = momspeech.make_new_cell()
     momspeechcell.change_code("onset", transcell.onset)
     momspeechcell.change_code("offset", transcell.onset)
     momspeechcell.change_code("content", transcell.content)
    end
    if transcell.source_mb == 'b'
     babyvoccell = babyvoc.make_new_cell()
     babyvoccell.change_code("onset", transcell.onset)
     babyvoccell.change_code("offset", transcell.onset)
     babyvoccell.change_code("content", transcell.content)
    end
   end

  set_column("momspeech",momspeech)
  set_column("babyvoc",babyvoc)

  
end
   