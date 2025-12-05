### Typo check for pri child emotion coding.

## Parameters
map_child = { 'childemo' => { 'emotion_pn' => %w(p n .) } }

cell_thresh = 167 #threshold for between coded cells

#list of all "codes" within ID column
id_map = {'emo_id_child' => %w[lab_id childemo_coder childemo_date childemo_mins]}

#list of all lab_id possible
lab_id_list = %w[BOSTU_1 BRKLN_1 CSUFL_1 CMUNI_2 CHOPH_1 CORNL_1 CUNYS_1 GEORG_1
  HRVDU_1 INDNA_1 LEHUN_1 MICHS_1 MICHS_2 MTALL_1 NYUNI_1 NYUNI_2 OHIOS_1 PENNS_2
  PENNS_4 PENNS_5 PLAYT_1 PRINU_1 PURDU_1 PURDU_2 RUTGU_1 STANF_1 TEXAM_1 TULNU_1 UCDAV_1
  UCLOS_1 UCMER_1 UCRIV_1 UCRIV_2 UCSCR_1 UCONN_1 UCONN_2 UGEOR_1 UHOUS_1 UMIAM_1
  UOREG_1 UPITT_1 UPITT_2 UTAUS_1 UTAUS_2 UTAUS_4 UTORS_1 UWATR_1 VBLTU_1 VCOMU_1 WILLC_1]

## Body

require 'Datavyu_API.rb'

#Check child column
puts "Wrong Codes:"
check_valid_codes3(map_child)
puts

# Do additional checks on timestamps
puts "Wrong Duration:"
childemo=getColumn("childemo")
prevcell=nil #ref to previous col

# Loop over all the emotion cells
childemo.cells.each do |childemocell|
  ordinal = childemocell.ordinal.to_i
  onset = childemocell.onset.to_i
  offset = childemocell.offset.to_i

  if onset >= offset
    puts("CELL #{ordinal} ONSET >= OFFSET")
  end

  if offset-onset<34
    puts("CELL #{ordinal} DURATION < 1 FRAME")
  end

  if (!prevcell.nil? && onset < prevcell.offset.to_i)
    puts("CELL #{ordinal} ONSET < PREVIOUS OFFSET")
  end

		# This check identifies consecutive emo cells that are less than cell_thresh apart

    if (!prevcell.nil? &&
    prevcell.emotion_pn==childemocell.emotion_pn &&
    (childemocell.onset-prevcell.offset).abs<cell_thresh)

    puts("CELLS #{prevcell.ordinal} and #{childemocell.ordinal} are emotion bouts with less than 5 frames interval")
  end

  prevcell = childemocell
end

set_column(childemo)

puts

#Check for typo in the lab_id under emo_id_child
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
        if c.get_code(code_name).match(/\A[a-zA-Z]*\z/).nil?
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
