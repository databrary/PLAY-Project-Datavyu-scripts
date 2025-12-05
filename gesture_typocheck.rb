## Parameters
map_gesture = {
  # match must return nil on this regular expression; otherwise the content
  # argument has a character that is not allowed
  'gesture' => {'gesture_psic' => %w(p s i c),
  'source_mc' => %w(m c),
}}

#list of all "codes" within ID column
id_map = {'gest_id' => %w[lab_id gest_coder gest_date gest_mins]}

#list of all lab_id possible
lab_id_list = %w[BRKLN_1 CORNL_1 HRVDU_1 NYUNI_2 STANF_1 UALAB_1 UCLOS_1 UHOUS_1 UOREG_1 UTAUS_2]
## Body

require 'Datavyu_API.rb'

#Check gesture column
puts "Wrong Codes:"
check_valid_codes3(map_gesture)
puts

#Check for typo in the lab_id under loc_id_child
#Check to see if it matches one of the labs listed above
puts "Wrong ID entry/format:"
id_col_list = id_map.keys
id_col_list.each do |col_name|
  code_list = id_map[col_name]
  col = get_column(col_name)
  code_list.each do |code_name|
    col.cells.each do |c|
      if code_name == 'lab_id'
        unless lab_id_list.include?( c.get_code(code_name) )
          puts "#{col_name} contains a typo for code <#{code_name}>"
        end
      elsif code_name.include?('coder')
        if c.get_code(code_name).match(/^(\A[a-zA-Z]*\z)$/).nil?
          puts "#{col_name} contain a typo for code <#{code_name}>"
        end
      elsif code_name.include?('date')
        if c.get_code(code_name).match(/^(?:(0?2)\/([12][0-9]|0?[1-9])|(0?[469]|11)\/(30|[12][0-9]|0?[1-9])|(0?[13578]|1[02])\/(3[01]|[12][0-9]|0?[1-9]))\/((?:[0-9]{2})?[0-9]{2})$/).nil?
          puts "#{col_name} contain a typo for code <#{code_name}>"
        end
      elsif code_name.include?('mins')
        if c.get_code(code_name).match(/^\d{3}$/).nil?
          puts "#{col_name} contain a typo for code <#{code_name}>"
          puts
        end
      end
    end
  end
end