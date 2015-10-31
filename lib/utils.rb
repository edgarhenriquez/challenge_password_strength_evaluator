module Utils

  @words = File.readlines('words.txt').each { |word| word.chomp! }

  def self.find_words(string)
    words = []

    (0..string.length-2).each do |i|
      next if not /[A-Za-z]/.match(string[i]) # Ignore non alpha characters
      (i+1..string.length-1).each do |j|
        break if not /[A-Za-z]/.match(string[j]) # Stop when finding a non alpha character
        words << string[i..j] if @words.include?(string[i..j])
      end
    end

    words
  end

end
