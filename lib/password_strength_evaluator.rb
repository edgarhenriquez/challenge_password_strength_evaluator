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

  def strengthen(password)
    @password = password.clone

    @password[-1] = random_alpha
    @password[-2] = random_digit
    @password[-3] = random_space
    @password[-4] = random_other

    replace_english_words

    while strength_without_replacing < 50
      @password << random_digit
    end

    @password
  end

  private

    def strength_without_replacing
      number_of_character_types * @password.length
    end

    def random_alpha
      ('a'..'z').to_a.sample
    end

    def random_digit
      (0..9).to_a.sample.to_s
    end

    def random_space
      " " # Not quite random yet
    end

    def random_other
      [ '.',
        '?',
        ':',
        '"',
        '^',
        '_',
        '-',
        '+',
        '&',
        '*',
        '/',
        '#'].sample
    end

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
        @password.gsub!(/#{word}/, random_alpha)
      end
    end

end
