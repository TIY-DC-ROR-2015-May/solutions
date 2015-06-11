require 'json'
require 'sinatra/base'

class SayServer < Sinatra::Base
  set :logging, true

  Voices = [
    "Agnes",
    "Kathy",
    "Princess",
    "Vicki",
    "Victoria",
    "Alex",
    "Bruce",
    "Fred",
    "Junior",
    "Ralph",
    "Albert",
    "Bad News",
    "Bahh",
    "Bells",
    "Boing",
    "Bubbles",
    "Cellos",
    "Deranged",
    "Good News",
    "Hysterical",
    "Pipe Organ",
    "Trinoids",
    "Whisper",
    "Zarvox"
  ]

  before do
    # This sets the content type in _every_ handler
    content_type :json
  end

  get '/voices' do
    Voices.to_json
  end

  def say_as voice, phrase
    halt(400, "Need a `phrase`") unless phrase
    system "say", "-v", voice, phrase
  end

  post "/say" do
    say_as "cellos", params[:phrase]
  end

  post "/say/random" do
    say_as Voice.sample, params[:phrase]
  end

  Voices.each do |voice|
    post "/say/#{voice}" do
      say_as voice, params[:phrase]
    end
  end
end

SayServer.run!
