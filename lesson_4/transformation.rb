fruits = %w(apple banana pear)
transformed_elements = []
counter = 0 

loop do 
  p fruits[counter].object_id
  current_element = fruits[counter]
  p current_element.object_id
  transformed_elements << current_element
  p transformed_elements[counter].object_id
  counter += 1
  break if counter == fruits.size
end

puts transformed_elements
p transformed_elements.object_id
puts fruits
p fruits.object_id
å
counter = 0
loop do
  fruits[counter] << "s"
  p fruits[counter].object_id
  counter += 1
  break if counter == fruits.size
end
puts transformed_elements
puts fruits
