require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  7.times do |i|
    next_page = RestClient.get("http://www.swapi.co/api/people/?page=#{i+2}")
    next_page_parsed = JSON.parse(next_page)
    response_hash["results"] << next_page_parsed["results"]
  end
  
  # binding.pry

  film_urls = response_hash["results"].flatten.select do 
    |result| result["name"].downcase == character_name 
    
  end 
    
 

  film_urls2 = film_urls[0]["films"]


  
  film_cleaner(film_urls2)

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def film_cleaner(film_urls)
  films_info = film_urls.map do |film| 
    result = RestClient.get(film) 
    JSON.parse(result)
    end    
    films_info
end

def print_movies(films)
  films.each { |film| puts film["title"] }# some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
