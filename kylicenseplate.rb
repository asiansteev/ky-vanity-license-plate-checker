require "http"

previous_last_word = IO.readlines("./available_sixes.txt").last

File.open('./only_sixes.txt', 'r') do |in_file|
	File.open('./available_sixes.txt', 'a') do |out_file|
		go_time = false

		in_file.each_line do |char|
			if char == previous_last_word
				go_time = true
			elsif go_time
			  url = "https://secure.kentucky.gov/kytc/plates/web/LicensePlate/Verify?text=#{char.chomp}&licensePlateId=030af448-0201-471d-b561-d68376752ef6"
			  unless HTTP.get(url).to_s.include? 'not available'
			  	p "#{char.chomp}: available!"
					out_file.write(char)
			  end
			end
		end
	end
end