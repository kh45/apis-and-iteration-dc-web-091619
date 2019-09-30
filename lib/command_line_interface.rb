def welcome
  puts "Welcomme to the Star Wars character database!!"
end

def get_character_from_user
  puts "please enter a character name"
  response = gets.chomp.downcase
  #api = RestClient.get('http://swapi.co/api/people')
end



#api[:results][i][:name].downcase