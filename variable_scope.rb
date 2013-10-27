#loca variable modified by the block

a = 13

(1..3).each do |value| 
	a = value
	puts a 
 end

 puts a

#call a variable defined in a block and return error

(1..3).each do |value| 
	b = 14
	b = value
	puts b
 end

 puts b #error


#nested blocks

 (1..3).each do |value| 
	b = value
	puts "b now is #{b}"
	(1..b).each { |value2| puts b+13}
	
 end

