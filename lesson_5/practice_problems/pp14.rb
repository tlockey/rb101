=begin
Given this data structure write some code
to return an array containing the colors
of the fruits and the sizes of the vegetables.
The sizes should be uppercase and the colors should
be capitalized.

input: hash
output: array with colors of the FRUITS (capitalized)
              and sizes of VEGETABLES (uppercase)

1. iterate over each hash value
2. check if fruit or vegetable
3. if fruit, for each color, iterate over array, capitalize, then 
   put in array
4. if vegetable,  upcase size and then put in the array

5. return array

expected return value:
[["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]
=end

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

arr = []
hsh.each_value do |value|
  if value[:type] == 'fruit'
    arr << value[:colors].each_with_object([]) do |color, c_arr| 
              c_arr << color.capitalize 
          end
  elsif value[:type] == 'vegetable'
    arr << value[:size].upcase
  end
end

p arr == [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]

# ahh I keep forgetting map is an option

new_arr =  hsh.map do |_,value|
            if value[:type] == 'fruit'
              value[:colors].map do |color|
                color.capitalize
              end
            elsif value[:type] == 'vegetable'
              value[:size].upcase
            end
          end
p new_arr
