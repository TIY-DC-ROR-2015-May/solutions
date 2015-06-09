require "faker"

require_relative "./speaker"

Speaker.voices.sample(3).each do |voice|
  speaker = Speaker.new voice

  phrase = Faker::Company.bs
  puts "About to say '#{phrase}' as '#{voice}'"
  speaker.say phrase
end
