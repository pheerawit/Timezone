require 'sinatra'
require 'timezone'

get'/' do
  erb :form
end


post '/timezone' do
	input_city = params[:message]
	check_in = input_city.split(' ')
	if check_in[1] != nil 
		input_city = check_in[0] +"_"+ check_in[1]
	end
	timezones = Timezone::Zone.names
	find_zone = timezones.find { |e| /#{input_city}/ =~ e } 
	timezone = Timezone::Zone.new :zone => find_zone
	show_time = timezone.time Time.now
	date_time = show_time.to_s.split(' ')
	time =  date_time[1]
	sp_time = time.split(':')
	hours = sp_time[0]
	mins = sp_time[1]
	if hours.to_i > 12 
		new_hours = hours.to_i - 12
		suffix = "PM"
	else 
		new_hours = hours
		suffix = "AM"
	end
	 "The current time in #{params[:message]} is: " + "<br>" + "<br>" + "<br>" + new_hours.to_s + ":" + mins.to_s + suffix
end


