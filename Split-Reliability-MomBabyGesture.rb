require 'Datavyu_API.rb'
begin

   gesture_rel = getColumn("gesture_rel")
   
   momgesture_rel = create_new_column("momgesture_rel", "gesture_p-s-i-c")
   babygesture_rel = create_new_column("babygesture_rel", "gesture_p-s-i-c")
   
   for gesturecell in gesture_rel.cells
    if gesturecell.source_mb == 'm'
     momgesturecell = momgesture_rel.make_new_cell()
     momgesturecell.change_code("onset", gesturecell.onset)
     momgesturecell.change_code("offset", gesturecell.onset)
     momgesturecell.change_code("gesture_p-s-i-c", gesturecell.gesture_psic)
    end
    if gesturecell.source_mb == 'b'
     babygesturecell = babygesture_rel.make_new_cell()
     babygesturecell.change_code("onset", gesturecell.onset)
     babygesturecell.change_code("offset", gesturecell.onset)
     babygesturecell.change_code("gesture_p-s-i-c", gesturecell.gesture_psic)
    end
   end

  set_column("momgesture_rel",momgesture_rel)
  set_column("babygesture_rel",babygesture_rel)

  
end
   