require 'rubygems'
require 'riot'
$:.unshift "#{File.dirname(__FILE__)}/../lib"
require 'transliterator'

context "Translit#convert" do
  should("transliterate English to Cyrillic") do
    Transliterator.convert("Jeto prostoj test")
  end.equals("Это простой тест")

  should("transliterate Cyrillic to English") do
    Transliterator.convert("Это простой тест")
  end.equals("Jeto prostoj test")

  should("leave input unmodified by default") do
    str = "Это простой тест"
    Transliterator.convert(str)
    str
  end.equals("Это простой тест")
end

context "Translit#convert!" do
  should("transliterate input in place") do
    str = "Это простой тест"
    Transliterator.convert!(str)
    str
  end.equals("Jeto prostoj test")
end

context "Translit#convert with enforced language" do
  should("transliterate to that language") { Transliterator.convert("test", :english)}.equals("test")
  should("keep it the same if language matched the text") {Transliterator.convert("test", :russian)}.equals("тест")

  should("transliterate to english language if input language is mixed") { Transliterator.convert("test тест", :english)}.equals("test test")
  should("transliterate to russian language if input language is mixed") { Transliterator.convert("test тест", :russian)}.equals("тест тест")
end
