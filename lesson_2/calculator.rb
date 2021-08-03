cease = false
while cease == false
  Kernel.print("First number --> ")
  num1 = Kernel.gets().chomp().to_i()
  print "Second number --> "
  num2 = gets.chomp.to_i
  print "Operation? Options: add - subtract - multiply - divide -> "
  operation = gets.chomp.downcase


  case operation
  when "add" then puts num1 + num2
  when "subtract" then puts num1 - num2
  when "multiply" then puts num1 * num2
  when "divide" then puts num1.to_f / num2.to_f
  end

  print "Cease? Y/N --> "
  cease = gets.chomp.downcase
  unless cease == "y"
    cease = false
  else
    cease = true
  end 
end
