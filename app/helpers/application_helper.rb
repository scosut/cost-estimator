module ApplicationHelper
  def format_currency(num)
		if (num) then
			num = sprintf("%.2f", num)
  		"$#{num.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
		else
			num
		end
	end
	
	def format_time(mins, secs)
		secs = secs < 10 ? "0#{secs.to_s}" : secs.to_s
		"#{mins.to_s}:#{secs}"
	end
end
