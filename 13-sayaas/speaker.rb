require 'httparty'

class Speaker
  include HTTParty
  base_uri "http://localhost:4567" # change this to the actual server IP

  def initialize voice
    unless Speaker.voices.include? voice
      raise "Invalid voice choice: #{voice}"
    end
    @voice = voice
  end

  def self.voices
    get "/voices"
  end

  def say phrase
    path = URI.escape "/say/#{@voice}"
    self.class.post path, body: { phrase: phrase }
  end
end
