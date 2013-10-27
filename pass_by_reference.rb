puts
puts "First exercise"
puts


def swap(a,b)
	a,b = b,a
	puts "#{a},#{b}" 
end

c= 1
d= 2

puts "#{c},#{d}"
swap(c,d)
 
puts
puts "Second exercise"
puts


def push_array(array)
	array << 15
end

a= [1,2,3,4]

puts "before call the method the array is #{a}"
puts "i call the method and the result is #{push_array(a)}"
puts "after the method my array is #{a}"


