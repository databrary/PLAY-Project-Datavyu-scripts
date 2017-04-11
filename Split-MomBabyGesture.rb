require 'Datavyu_API.rb'
begin

   gesture = getColumn("gesture")
   
   momgesture = create_new_column("momgesture", "gesture_p-s-i-c")
   babygesture = create_new_column("babygesture", "gesture_p-s-i-c")
   
   for gesturecell in gesture.cells
    if gesturecell.source_mb == 'm'
     momgesturecell = momgesture.make_new_cell()
     momgesturecell.change_code("onset", gesturecell.onset)
     momgesturecell.change_code("offset", gesturecell.onset)
     momgesturecell.change_code("gesture_p-s-i-c", gesturecell.gesture_psic)
    end
    if gesturecell.source_mb == 'b'
     babygesturecell = babygesture.make_new_cell()
     babygesturecell.change_code("onset", gesturecell.onset)
     babygesturecell.change_code("offset", gesturecell.onset)
     babygesturecell.change_code("gesture_p-s-i-c", gesturecell.gesture_psic)
    end
   end

  set_column("momgesture",momgesture)
  set_column("babygesture",babygesture)

  
end
   