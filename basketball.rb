def solve(str) 
  n, m , p = @f.readline.strip.split(/\s+/).map(&:to_i)
  
  players = []
  (1..n).each do |i|
    name, perc, h = @f.readline.strip.split(/\s+/)
    players.push({name: name, shot: perc.to_i, h: h.to_i, played: 0 })
  end

  draft = players.sort_by do |player|
    [player[:shot], player[:h]]
  end
  
  draft.reverse!

  draft.each_index {|i| draft[i][:draft_num] = i}

  a = draft

  teams = [a.values_at(* a.each_index.select {|i| i.even?}), a.values_at(* a.each_index.select {|i| i.odd?})]

  final = teams.map{|t| play(t,p,m).map{|r| r[:name]}}

  return final.flatten.sort.join(' ')
end

def play(t, p, m)
   #    Each team starts the game with the P players who have the lowest draft numbers.
  f = t[0, p]
  b = t[p,5000]

  (1..m).each do |l|
    if !b.empty? then
      f.each {|x| x[:played] += 1}
      #If there are more than P players on a team after each minute of the game the player with the highest total time played leaves the playing field. Ties are broken by the player with the higher draft number leaving first.
      f.sort_by! {|player| [player[:played], player[:draft_num]]}
      
      #To replace her the player on the bench with the lowest total time played joins the game. Ties are broken by the player with the lower draft number entering first.
      b.sort_by! {|player| [player[:played], player[:draft_num]]}
      b.reverse!

      leaves = f.pop
      joins = b.pop      

      f.push joins
      b.push leaves
    end
  end

  return f
end

@f=File.open("input", 'r')
total = @f.readline.to_i
(1..total).each do |i|
  puts "Case #{i}: #{solve(nil)}"
end
@f.close
