=begin
A UUID is a type of identifier often used as a way 
to uniquely identify items...which may not all be 
created by the same system. That is, without any form 
of synchronization, two or more separate computer systems 
can create new items and label them with a UUID with no 
significant chance of stepping on each other's toes.

It accomplishes this feat through massive randomization. 
The number of possible UUID values is approximately 3.4 X 10E38.

Each UUID consists of 32 hexadecimal characters, and 
is typically broken into 5 sections like this 8-4-4-4-12 and 
represented as a string.

It looks like this: "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"

Write a method that returns one UUID when called with no parameters.

input: method call with no parameters
output: a string of 5 sections of size 8-4-4-4-12
        with random characters between 0-9 and a-f
        each section is delimited by a '-'

1. create array to hold each section (arr)
2. arr << create first section (size = 8)
3. arr << create second, third, fourth section (size = 4)
4. arr << create fifth section (size = 12)
5. join array with '-'

string_creator
options = [0,1,2,3,4,5,6,7,8,9,'a','b','c','e','f']
=end

OPTIONS = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f)

def make_uuid()
  uuid = []
  uuid << OPTIONS.sample(8).join
  3.times {uuid << OPTIONS.sample(4).join}
  uuid << OPTIONS.sample(12).join
  uuid.join('-')
end
p make_uuid
