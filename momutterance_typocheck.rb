## Parameters
map_mom = {
  # match must return nil on this regular expression; otherwise the content
  # argument has a character that is not allowed
  'momutterancetype' => {'directives_look_l_do_d_comm_c' => %w(l d c .),
  'prohibitions_p' => %w(p .),
  'provideinfo_i_maintainengage_m' => %w(i m .),
  'read_r_sing_s' => %w(r s .),
  'filleraffirmation_f' => %w(f .),
  'unintell_x_notchild_z' => %w(x z .)
}}

#list of all "codes" within ID column
id_map = {'utt_id_mom' => %w[lab_id momutt_coder momutt_date momutt_mins]}

#list of all lab_id possible
lab_id_list = %w[BRKLN_1 CORNL_1 HRVDU_1 NYUNI_2 STANF_1 UALAB_1 UCLOS_1 UHOUS_1 UOREG_1 UTAUS_2]
## Body
## Body

require 'Datavyu_API.rb'

#Check mom column
puts "Wrong Codes:"
check_valid_codes3(map_mom)
puts
col=get_column('momutterancetype')
# loop through cells in a column called col
col.cells.each do |c|
      # return list of all arguments for current cell
      args = c.get_codes(c.arglist)
      not_period = args.map{ |a| !(a=='.') }
      num_not_period = 0
      not_period.each do |x|
        if x
          num_not_period+=1
        end
      end
      unless num_not_period == 1
        "Cell #{c.ordinal} does not have exactly 1 code that's not a period"
      end

      # loop through each coded argument
      args.each do |a|
            # print a typo message unless the argument is exactly 1 character
            unless a.length == 1
                  puts "Cell #{c.ordinal} has an argument that is not 1 character"
            end
      end
end

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