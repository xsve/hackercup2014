def solve(str) 
  n = @f.readline.to_i - 1 
  a = []
  (0..n).each do |i|
  	s = @f.readline

  	a.push( s.chomp) if s.include?('#') # omit empty lines
  end

  return "NO" unless a.uniq.length == 1 # if contains exactly 1 square, all lines will be the same
  return "NO" if a[0] =~ /#\.+#/

  if a[0].count('#') == a.size
    return "YES" 
  else
    return "NO"
  end

  "SLIPTHROUGH when #{a}" # should never be reached
end

@f=File.open("input", 'r')
total = @f.readline.to_i

(1..total).each do |i|
  puts "Case #{i}: #{solve(nil)}"
end
@f.close
