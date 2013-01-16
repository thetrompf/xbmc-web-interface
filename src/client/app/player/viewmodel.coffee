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
			playerVisible: @observable no
			isPlaying: @observable no

		computedProperties: () ->
			playButtonContent: @computed () ->
				if @isPlaying()
					return '<icon class="icon-pause"></icon> Pause'
				else
					return '<icon class="icon-play"></icon> Play'

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
			@player.GetActivePlayers
				callback:
					success: (data) ->
						debugger if data.length > 1
						if (p = data[0])?
							@playerid p.playerid
							@player.GetProperties
								playerid: p.playerid
								properties: [ "speed" ]
								callback: (data) ->
									@isPlaying yes if data.speed > 0
								context: @
					error: (data) ->
						console.error "An error occured when retreiving active players"
				context: @
			@initEventListiners()

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