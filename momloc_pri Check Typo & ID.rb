### Typo check for pri mom locomotion coding.

## Parameters
map_mom = { 'momloc' => { 'loc_lf' => %w(l f . x) } }

cell_thresh = 3000 #threshold for between coded cells

#list of all "codes" within ID column
id_map = {'loc_id_mom' => %w[lab_id momloc_coder momloc_date momloc_mins]}

#list of all lab_id possible
lab_id_list = %w[BOSTU_1 BRKLN_1 CSUFL_1 CMUNI_2 CHOPH_1 CORNL_1 CUNYS_1 GEORG_1
  HRVDU_1 INDNA_1 LEHUN_1 MICHS_1 MICHS_2 MTALL_1 NYUNI_1 NYUNI_2 OHIOS_1 PENNS_2
  PENNS_4 PENNS_5 PLAYT_1 PRINU_1 PURDU_1 PURDU_2 RUTGU_1 STANF_1 TEXAM_1 TULNU_1 UCDAV_1
  UCLOS_1 UCMER_1 UCRIV_1 UCRIV_2 UCSCR_1 UCONN_1 UCONN_2 UGEOR_1 UHOUS_1 UMIAM_1
  UOREG_1 UPITT_1 UPITT_2 USCAL_1 UTAUS_1 UTAUS_2 UTORS_1 UWATR_1 VBLTU_1 VBLTU_2 VCOMU_1 WILLC_1]

## Body

require 'Datavyu_API.rb'

#Check mom column
puts "Wrong Codes:"
check_valid_codes3(map_mom)
puts

# Do additional checks on timestamps
puts "Wrong Duration:"
momloc=getColumn("momloc")
prevcell=nil #ref to previous col

# Loop over all the movement cells
momloc.cells.each do |momloccell|
  ordinal = momloccell.ordinal.to_i
  onset = momloccell.onset.to_i
  offset = momloccell.offset.to_i

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

  l_cell_thresh = 1000 # minimum number of ms between consecutive walk cells

  if (!prevcell.nil? &&
    prevcell.loc_lf==momloccell.loc_lf &&
    (momloccell.onset-prevcell.offset).abs<l_cell_thresh)

    puts("CELLS #{prevcell.ordinal} and #{momloccell.ordinal} are walking bouts with less than #{l_cell_thresh}ms interval")
  end

  missing_cell_thresh = 1000 # minimum number of ms that a missing cell can last

  if momloccell.loc_lf == "." and offset-onset<missing_cell_thresh
    puts ("CELL #{ordinal} IS MISSING BUT <1s IN DURATION")
  end

  prevcell = momloccell
end
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
