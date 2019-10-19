require "http"

in_filename = './valid_words.txt'
out_filename = './available_words.txt'

FileUtils.touch(out_filename) unless File.exist? out_filename
previous_last_word = IO.readlines(out_filename).last
go_time = previous_last_word.nil? ? true : false

File.open(in_filename, 'r') do |in_file|
	File.open(out_filename, 'a') do |out_file|
		in_file.each_line do |word|
			if word == previous_last_word
				go_time = true
			elsif go_time
			  url = "https://secure.kentucky.gov/kytc/plates/web/LicensePlate/Verify?text=#{word.chomp}&licensePlateId=030af448-0201-471d-b561-d68376752ef6"
			  unless HTTP.get(url).to_s.include? 'not available'
			  	p "#{word.chomp}: available!"
					out_file.write(word)
			  end
			end
		end
	end
end