require 'JSON'
require 'Date'

#------Change to your own Coordinates------
HOME_LAT = 11.1111
HOME_LONG = -111.1111

HOME_LAT_1 = 11.1111111
HOME_LONG_1 = -112.222222

WORK_LAT = 11.11705
WORK_LONG = -112.1194

PRECISION = 0.0005 #0.001 allows for whole building and some gps inaccuracies

# Year, Month, Day, Hour, Minute, GMT correction **No leading zeros
START_DATE = DateTime.new(2018,9,1,18,0,0, '-7').to_time

END_DATE = DateTime.new(2018,9,21,17,8,0, '-7').to_time

file =  File.read('Location History.json')
data = JSON.parse(file)

locs = []
sample = data["locations"].reverse

sample.each do |l|
  lat = l["latitudeE7"]/1E7
  long = l["longitudeE7"]/1E7
  time = Time.at(l["timestampMs"].to_i/1000)

  next unless time > START_DATE
  next unless time < END_DATE if END_DATE

  if (lat - HOME_LAT).abs < PRECISION && (long - HOME_LONG).abs < PRECISION
    type = "HOME"
  elsif (lat - HOME_LAT_1).abs < PRECISION && (long - HOME_LONG_1).abs < PRECISION
    type = "HOME1"
  elsif (lat - WORK_LAT).abs < PRECISION && (long - WORK_LONG).abs < PRECISION
    type = "WORK"
  else
    type = "OUT"
  end

  loc = [type, time, lat, long, nil]

  if locs.last&.first == type
    diff = time - locs.last[1]
    diff = diff/60/60
    loc = [type, time, lat, long, diff]
  end

  locs << loc
end

hours = 0

billable = locs.collect {|l| l if l.first == "WORK" && hours += l&.last.to_f}

p "Hours at work: #{hours}"

