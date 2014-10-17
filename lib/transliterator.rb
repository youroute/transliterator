class Transliterator
  EN_RU_RULE = {
    "a"=>["А","а"], "b"=>["Б","б"], "v"=>["В","в"], "g"=>["Г","г"], "d"=>["Д","д"], "e"=>["Е","е"], "jo"=>["Ё","ё"], "yo"=>["Ё","ё"], "ö"=>["Ё","ё"], "zh"=>["Ж","ж"],
    "z"=>["З","з"], "i"=>["И","и"], "j"=>["Й","й"], "k"=>["К","к"], "l"=>["Л","л"], "m"=>["М","м"], "n"=>["Н","н"], "o"=>["О","о"], "p"=>["П","п"], "r"=>["Р","р"],
    "s"=>["С","с"], "t"=>["Т","т"], "u"=>["У","у"], "f"=>["Ф","ф"], "h"=>["Х","х"], "x"=>["Кс","кс"], "c"=>["Ц","ц"], "ch"=>["Ч","ч"], "sh"=>["Ш","ш"], "w"=>["В","в"],
    "shh"=>["Щ","щ"], "sch"=>["Щ","щ"], "#"=>["Ъ","ъ"], "y"=>["Ы","ы"], "'"=>["Ь","ь"], "je"=>["Э","э"], "ä"=>["Э","э"], "ju"=>["Ю","ю"], "yu"=>["Ю","ю"],
    "ü"=>["Ю","ю"], "ya"=>["Я","я"], "ja"=>["Я","я"], "q"=>["Я","я"]
  }

  attr_reader :rule

  def initialize(rule = EN_RU_RULE)
    @rule = rule
  end

  def convert!(string, to: nil)
    input_locale = input_locale(string, to: to)

    mapping = send(input_locale).sort_by { |k, v| v.length <=> k.length }

    mapping.each do |translit_key, translit_value|
      string.gsub!(translit_key.capitalize, translit_value.first)
      string.gsub!(translit_key, translit_value.last)
    end

    string
  end

  def convert(string, to: nil)
    convert!(string.dup, to: to)
  end

private

  def input_locale(string, to:)
    if to
      to == :en ? :ru : :en
    else
      detect_input_locale(string)
    end
  end

  def reverse_mapping(rule)
    rule.inject({}) do |result, key_value|
      value = key_value.first
      upcase, downcase = key_value.last
      result[upcase] ? result[upcase] << value.capitalize : result[upcase] = [value.capitalize]
      result[downcase] ? result[downcase] << value : result[downcase] = [value]
      result
    end
  end

  def detect_input_locale(string)
    first_letter = string.split(/\s+/).first
    first_letter.scan(/\w+/).empty? ? :ru : :en
  end

  def en
    rule
  end

  def ru
    @ru ||= reverse_mapping(rule)
  end
end
