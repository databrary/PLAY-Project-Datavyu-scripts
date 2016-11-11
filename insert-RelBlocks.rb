# Insert coding and reliability blocks.

## Params
coding_blocks_column_name = 'coding_blocks'
reliability_blocks_column_name = 'reliability_blocks'
reference_column_name = 'id' # uses the first cell from this column to figure out the size of the video or coding region
block_size = 1.0/3.0#20*60*1000 # if this is a fraction less than 1, the reference cell is divided this size segments
reliability_size = 0.25#5*60*1000 # if this is a fraction, a rel block is created that is this fraction of the segment

## Body
require 'Datavyu_API.rb'

ref_cell = getVariable(reference_column_name).cells.first

t = ref_cell.onset
blocks_col = createVariable(coding_blocks_column_name, 'x')
rblocks_col = createVariable(reliability_blocks_column_name, 'x')
while t < ref_cell.offset
  onset = t
  size = (block_size <= 1.0)? (ref_cell.duration * block_size) : block_size
  offset = onset + size

  ncell = blocks_col.make_new_cell
  ncell.onset = onset
  ncell.offset = offset

  rb_size = (reliability_size <= 1.0)? (ncell.duration * reliability_size) : reliability_size
  rb_onset = rand(Range.new(ncell.onset, ncell.offset - rb_size))
  rb_offset = rb_onset + rb_size
  rb_cell = rblocks_col.make_new_cell
  rb_cell.onset = rb_onset
  rb_cell.offset = rb_offset

  t = offset
end

# setVariable(blocks_col)
setVariable(rblocks_col)
#setVariable('momloc_rel', rblocks_col)
