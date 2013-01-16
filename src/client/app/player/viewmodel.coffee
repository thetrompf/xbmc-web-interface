define [
	"base/viewmodel"
	"xbmc/clients/wsclient"
	"xbmc/api/player"
	"text!app/player/player.html"
], (ViewModelBase, WSClient, Player, template) ->
	
	class PlayerViewModel extends ViewModelBase

		bindingContext: "#player-container"
		template: template
		template = null

		properties: () ->
			playerid: @observable -1
			isPlaying: @observable no

		computedProperties: () ->
			playButtonContent: @computed () ->
				if @isPlaying()
					return '<icon class="icon-pause"></icon>'
				else
					return '<icon class="icon-play"></icon>'

		togglePlay: () ->
			@player.PlayPause
				callback: (data) -> return
				playerid: @playerid()

		toggleStop: () ->
			@player.Stop
				callback: (data) -> return
				playerid: @playerid()

		initialize: (options) ->
			@client = WSClient.get()
			@player = new Player @client

		afterInitialize: (options) ->
			@initPlayer()
			@initEventListiners()

		initPlayerState: () ->
			@player.GetProperties
				playerid: @playerid()
				properties: [ "speed" ]
				callback: (data) ->
					@isPlaying yes if data.speed > 0
				context: @

		initPlayer: () ->
			@player.GetActivePlayers
				callback:
					success: (data) ->
						if (p = data[0])?
							@playerid p.playerid
							@initPlayerState p.playerid
					error: (data) ->
						console.error "An error occured when retreiving active players"
				context: @

		initEventListiners: () ->
			@player.bind "OnPlay", (data) ->
				@playerid data.player.playerid
				@isPlaying yes
			, @
			@player.bind "OnStop", (data) ->
				@playerid -1
				@isPlaying no
			, @
			@player.bind "OnPause", (data) ->
				@isPlaying no
			, @

		dispose: () ->
			super
			@player.dispose()