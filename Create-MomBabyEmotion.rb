require 'Datavyu_API.rb'
begin
  
   momemotion = create_new_column("momemotion","emotion_p-n")
   babyemotion = create_new_column("babyemotion","emotion_p-n")
  
  set_column("momemotion",momemotion)
  set_column("babyemotion",babyemotion)

  
end