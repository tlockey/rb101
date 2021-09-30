=begin
Using the each method, write some code
to output all of the vowels from the strings.
Questions:
output the vowels one one each line? or 
all at once as a single string?

1. set a constant array with vowels 
2. iterate over hash
3. iterate over array in hash
4. convert each string to an array of individual chars
5. iterate over each char, if that element is in the constant
6. print the element
=end

hsh = {first: ['the', 'quick'], 
       second: ['brown', 'fox'], 
       third: ['jumped'], 
       fourth: ['over', 'the', 'lazy', 'dog']}

VOWELS = %w(a e i o u)

hsh.each_value do |array|
  array.each do |string|
    string.chars.each do |char|
      puts char if VOWELS.include?(char)
    end
  end
end

        