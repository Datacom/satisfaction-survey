$ ->
	$('.report-smiley').on 'click', -> 
		score = $(@).attr('data-value')
		$('.smiley-container').removeClass("selected")
		$(@).parent().toggleClass("selected")
		$('#daily_report_score').val(score)

	$('#js-update-report').on 'click', ->
		inputs =  $('#daily-report').serialize()
		$.post($('#daily-report').attr('action') + "?#{inputs}", ->
	  		).success ->
	  		    $("#daily-report").remove()
	  			$('#success-message').toggleClass('hidden')