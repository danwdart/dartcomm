$(document).ready ->
	audio = ->
		window.AudioContext = window.AudioContext or window.webkitAudioContext
		context = new AudioContext
		return context
	mic = (stream)->
		navigator.getUserMedia = navigator.getUserMedia or navigator.webkitGetUserMedia or navigator.mozGetUserMedia or navigator.msGetUserMedia
		if not navigator.getUserMedia
			alert 'no getusermedia'
		return navigator.getUserMedia(
			audio: true
		, stream, ->
			alert 'fail'
		)
	loopback = ->
		context = audio()
		mic (stream) ->
			microphone = context.createMediaStreamSource stream
			# filter = context.createBiquadFilter()
			microphone.connect context.destination #filter
			#filter.connect context.destination
		return null
	synth = () ->
		context = audio()
		osc = context.createOscillator()
		osc.type = 'triangle'
		osc.frequency.value = 440

		gainNode = context.createGainNode()
		gainNode.gain.value = 0.1

		gainNode.connect context.destination
		osc.connect gainNode

		osc.start 0
		setInterval ->
			osc.stop 0
		, 2000
	modvoice = () ->
		context = audio()

		mic (stream) ->
			microphone = context.createMediaStreamSource stream

			mod = context.createOscillator()
			mod.type = 'sine'
			mod.frequency.value = 550

			gain = context.createGainNode()
			gain.gain.value = 2

			mod.connect gain

			microphone.connect mod
			gain.connect context.destination
			
			mod.noteOn 0

	modvoice()


