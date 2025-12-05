### Typo check for pri mom object coding.

##Parameters
map_mom = { 'momobj' => { 'obj_o' => %w(o .)}}

cell_thresh = 3000 #threshold for between coded cells

#list of all "codes" within ID column
id_map = {'obj_id_mom' => %w[lab_id momobj_coder momobj_date momobj_mins] }

#list of all lab_id possible
lab_id_list = %w[BOSTU_1 BRKLN_1 CSUFL_1 CMUNI_2 CHOPH_1 CORNL_1 CUNYS_1 GEORG_1
  HRVDU_1 INDNA_1 LEHUN_1 MICHS_1 MICHS_2 MTALL_1 NYUNI_1 NYUNI_2 OHIOS_1 PENNS_2
  PENNS_4 PENNS_5 PLAYT_1 PRINU_1 PURDU_1 PURDU_2 RUTGU_1 STANF_1 TEXAM_1 TULNU_1 UCDAV_1
  UCLOS_1 UCMER_1 UCRIV_1 UCRIV_2 UCSCR_1 UCONN_1 UCONN_2 UGEOR_1 UHOUS_1 UMIAM_1
  UOREG_1 UPITT_1 UPITT_2 UTAUS_1 UTAUS_2 UTORS_1 UWATR_1 VBLTU_1 VCOMU_1 WILLC_1]

## Body

require 'Datavyu_API.rb'

#Check mom column
puts "Wrong Codes:"
check_valid_codes3(map_mom)
puts

# Do additional checks on timestamps
puts "Wrong Duration:"
mom_code=getColumn("momobj")
prevcell=nil #ref to previous col
mom_code.cells.each do |mom_code_cell|
  ordinal = mom_code_cell.ordinal.to_i
  onset = mom_code_cell.onset
  offset = mom_code_cell.offset

  if onset >= offset
    puts("CELL #{ordinal} ONSET >= OFFSET")
  end

  if offset-onset<34
    puts("CELL #{ordinal} DURATION < 1 FRAME")
  end

  if (!prevcell.nil? && onset < prevcell.offset.to_i)
    puts("CELL #{ordinal} ONSET < PREVIOUS OFFSET")
  end

		# This check identifies consecutive loc cells that are less than l_cell_thresh apart

  if (!prevcell.nil? && mom_code_cell.obj_o=='o' &&
       prevcell.obj_o==mom_code_cell.obj_o &&
       (mom_code_cell.onset-prevcell.offset).abs<cell_thresh)

    puts("CELLS #{prevcell.ordinal} and #{mom_code_cell.ordinal} are objects with less than #{cell_thresh}ms interval")
  end
  prevcell=mom_code_cell
end
puts

#Check for typo in the lab_id under obj_id_mom
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
