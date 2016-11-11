require 'Datavyu_API.rb'
begin

   trans = getColumn("transcribe")
   time = 500
   for cell in trans.cells
      cell.change_code("offset",cell.onset+time)
   end
   
setColumn("transcribe",trans)

end
   