class HangpersonGame

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    if letter == '' or letter == nil or letter =~ /[^A-Za-z]/
      raise ArgumentError
    end

    letter.downcase!
    if (@guesses + @wrong_guesses).include? letter
      return false
    end
    if @word.include? letter
      @guesses += letter
    else
      @wrong_guesses += letter
    end
  end

  def word_with_guesses()
    res = "-" * @word.length

    for i in 0..@word.length - 1
      if guesses.include? word[i]
        res[i] = word[i]
      end
    end

    return res
  end

  def check_win_or_lose()
    if @wrong_guesses.length > 6
      return :lose
    elsif word_with_guesses.include? '-'
      return :play
    else
      return :win
    end
  end 

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
