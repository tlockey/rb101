require 'yaml'
language_options = <<-LANG
Enter 1, 2 or 3:
1 - English (standard)
2 - Japanese (sort of)
3 - Tagalog (informal)
LANG

puts language_options

loop do
  language = gets.chomp.downcase

  case language
  when "1"
    MESSAGES = YAML.load_file('calculator_messages.yml')
    break
  when "2"
    MESSAGES = YAML.load_file('calculator_messages_japanese.yml')
    break
  when "3"
    MESSAGES = YAML.load_file('calculator_messages_tagalog.yml')
    break
  else
    puts "Please enter 1, 2, or 3."
  end
end
def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i.to_s == num
end

def valid_operation?(input)
  options = ["add", "multiply", "subtract", "divide"]
  options.include?(input)
end

def operation_to_message(operation, num1, num2)
  message = case operation
            when "add" then "Adding #{num1} and #{num2} together..."
            when "subtract" then "Subtracting #{num2} from #{num1}..."
            when "multiply" then "Multiplying #{num1} and #{num2}..."
            when "divide" then "Dividing #{num1} by #{num2}..."
            end
  message
end
prompt(MESSAGES['welcome'])
name = ''
loop do
  name = Kernel.gets().chomp()
  if name.empty?
    prompt(MESSAGES['empty_name'])
  else
    break
  end
end

prompt "#{MESSAGES['greeting']} #{name}!"

loop do # main loop
  num1 = nil
  num2 = nil
  operation = nil

  loop do
    prompt MESSAGES["first_number"]
    num1 = Kernel.gets().chomp()

    if valid_number?(num1)
      num1 = num1.to_i
      break
    else
      prompt MESSAGES["number_error"]
    end
  end

  loop do
    prompt MESSAGES["second_number"]
    num2 = gets.chomp
    if valid_number?(num2)
      num2 = num2.to_i
      break
    else
      prompt MESSAGES["number_error"]
    end
  end
  operator_prompt = <<-MSG
    What operation would you like to perform?
    Add 
    Subtract 
    Multiply 
    Divide 
  MSG

  prompt(operator_prompt)
  loop do
    operation = gets.chomp.downcase
    if valid_operation?(operation)
      break
    else
      prompt MESSAGES["operation_error"]
    end
  end

  prompt(operation_to_message(operation, num1, num2))

  result = case operation
           when "add" then num1 + num2
           when "subtract" then num1 - num2
           when "multiply" then num1 * num2
           when "divide" then num1.to_f / num2.to_f
           end
  prompt(result)

  prompt MESSAGES["again"]
  answer = Kernel.gets().chomp().upcase()

  break unless answer.start_with?("Y")
end
prompt MESSAGES["goodbye"]
