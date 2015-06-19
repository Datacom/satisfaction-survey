module ApplicationHelper

  FACES = {
    1 => "happy.png",
    2 => "neutral.png",
    3 => "sad.png"
  }

	def faces(report, ration=100)
    image_tag FACES[report.score], width: "#{ration}%"
	end

end
