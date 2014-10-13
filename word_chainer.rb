require 'set'

class WordChainer
  
  attr_reader :dictionary
  
  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name).map { |entry| entry.chomp })
  end
  
  def adjacent_words(word)
    same_length = @dictionary.select { |entry| entry.length == word.length }
    
    adj_words = []
    
    same_length.each do |entry|
      same_chars = 0
      word.length.times do |i|
        if entry[i] == word[i]
          same_chars += 1
        end
      end
      if same_chars == entry.length - 1
        adj_words << entry
      end
    end
    
    adj_words
  end
  
  def run(source, target)
    @current_words = [source]
    @all_seen_words = [source]
    
    until @current_words.empty?
      explore_current_words

    end
  end
  
  def explore_current_words
    new_current_words = []
    
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |word|
        unless @all_seen_words.include?(word)
          new_current_words << word 
          @all_seen_words << word
        end
      end
    end
    
    p new_current_words
    @current_words = new_current_words
  end
  
end


chainer = WordChainer.new('dictionary.txt')

p chainer.run("breath", "stupid")