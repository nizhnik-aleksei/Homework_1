require 'pry'

x_point, y_point, x, y = ARGV

if x_point == x and y_point == y
  puts 'Точка найдена!'
elsif x_point == x
  puts 'х координата верна, y нет'
elsif y_point == y
  puts 'y координата верна, x нет'
else 
  puts 'Близко, но нет'
end
