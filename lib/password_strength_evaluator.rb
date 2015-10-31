require_relative 'utils'

class PasswordStrengthEvaluator

  def initialize
    @password = nil
  end

  def strength(password)
    @password = password.clone

    replace_english_words

    strength = number_of_character_types * @password.length
  end

  def friendly_strength(password)
    strength_verbose = case strength(password)
                       when 0..10 then 'Unacceptable'
                       when 11..49 then 'Weak'
                       else 'Strong'
                       end
  end

  private

    def number_of_character_types
      n = 0
      n += 1 if has_alphabet_characters?
      n += 1 if has_digit_characters?
      n += 1 if has_whitespace_characters?
      n += 1 if has_other_characters?
      n
    end

    def has_alphabet_characters?
      !/[A-Za-z]/.match(@password).nil?
    end

    def has_digit_characters?
      !/\d/.match(@password).nil?
    end

    def has_whitespace_characters?
      !/\s/.match(@password).nil?
    end

    def has_other_characters?
      !/[^\A-Za-z\d\s]/.match(@password).nil?
    end

    def replace_english_words
      english_words = Utils.find_words(@password)

      english_words.sort! { |x,y| y.length <=> x.length } # Sort by word length from longest to shortest

      english_words.each do |word|
        replace_character = ('a'..'z').to_a.sample
        @password.gsub!(/#{word}/, replace_character)
      end
    end

end
