class MetroTrain
  attr_reader :line, :cars, :direction, :min

  def initialize api_data
    @line       = api_data.fetch "Line"
    @cars       = api_data.fetch "Car"
    @direction  = api_data.fetch "DestinationName"
    @min        = api_data.fetch "Min"
    @fetched_at = Time.now
  end

  def time
    unless %( ARR BRD --- ).include? @min
      @fetched_at + @min.to_i.minutes
    end
  end
end
