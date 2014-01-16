def make_output_row(line):
	# output is an an array
	# that represents 1 row of our output csv
	row = []

	# split csv into columns
	cols = line.split(',')

	# we take the time, eeg readings + story id for our output
	row.extend(cols[:4])

	# figure out if the user reported interested in this story
	story_index = int(cols[3])
	# if so, we add a 1 to extend
	if story_index in was_interested:
		row.append(1)
	# if not, we add a 0
	else:
		row.append(0) 

	return row	




id = '1389903621'

# a list of the story indicies in which the user was interested 
was_interested = []

# read groundtruth file, 
# assemble indicies in which the user was interested
try:
	with open('groundtruth/' + id + '-groundtruth.txt', 'r') as g:
		lines = g.readlines()
		for line in lines:
			was_interested.append(int(line.strip('\n')))
		print was_interested 
except:
	print 'no groundtruth log found for this id.'


# our cleaned output file will be a 2D array
output = []

# open the eeg log
try:
	with open('eeg/' + id + '-eeg.csv', 'r') as e:

	 	lines = e.readlines()

	 	# build a 2d array of cleaned rows
	 	output = [make_output_row(line) for line in lines]

except:
 	print 'no eeg log found for this id'

# write a new file
with open('output/' + id + '-cleaned.csv', 'w') as o:
	for row in output:
		for col in row:
			o.write(str(col) + ',')
		o.write('\n')

print 'all done (' + id + ')'
