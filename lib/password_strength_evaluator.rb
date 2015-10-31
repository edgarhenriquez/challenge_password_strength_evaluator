class PasswordStrengthEvaluator

  def initialize
    @password = nil
  end

  def strength(password)
    @password = password

    strength = number_of_character_types * @password.length
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

end
