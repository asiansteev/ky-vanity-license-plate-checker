in_filename = './words.txt'
out_filename = './valid_words.txt'

FileUtils.touch(out_filename) unless File.exist? out_filename
previous_last_word = IO.readlines(out_filename).last
go_time = previous_last_word.nil? ? true : false

def valid_chars? str
  chars = ('A'..'Z').to_a + (0..9).to_a
  str.chars.detect {|ch| !chars.include?(ch)}.nil?
end

File.open(in_filename, 'r') do |in_file|
	File.open(out_filename, 'w') do |out_file|
		in_file.each_line do |word|
			if word == previous_last_word
				go_time = true
			elsif go_time
				if (word.chomp.length < 7) && valid_chars?(word.chomp.upcase)
					p word.upcase
					out_file.write(word.upcase)
				end
			end
		end
	end
end