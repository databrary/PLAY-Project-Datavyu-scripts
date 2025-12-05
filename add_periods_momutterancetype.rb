## Parameters
# names of column in which to replace empty codes with periods
col_list = %w[momutterancetype]
# replace empty codes with this argument
replace_arg = '.'

## Body
require 'Datavyu_API.rb'

col_list.each do |colname|
  # get the column
  col = get_column(colname)

  # loop over cells in column
  col.cells.each do |c|
    # get a list of all the arguments for current cell
    c_args = c.get_codes(c.arglist)
    # check to see if all the codes are empty
    if c_args.map{ |a| a.empty? || a == '.' }.all?
      # print warning if all codes are empty
      puts "Cell #{c.ordinal} in column #{colname} has not been coded!"
    else
      # otherwise change any empty codes to '.'
      c.arglist.each do |a|
        if c.get_code(a).empty?
          c.change_code(a,replace_arg)
        end
      end
    end
  end

  # update changes in the spreadsheet
  set_column(colname,col)
end
