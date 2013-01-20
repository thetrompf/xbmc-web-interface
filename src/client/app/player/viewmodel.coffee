define [
	"base/viewmodel"
	"xbmc/clients/wsclient"
	"xbmc/api/player"
	"text!app/player/player.html"
], (ViewModelBase, WSClient, Player, template) ->
	
	class PlayerViewModel extends ViewModelBase

		bindingContext: "#player-container"
		$el: "#player-container"
		template: template
		template = null

		properties: () ->
			playerid: @observable -1
			isPlaying: @observable no
			currentTitle: @observable ""

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

		stop: () ->
			@player.Stop
				callback: (data) -> return
				playerid: @playerid()

		forward: () ->


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
					if data.speed > 0
						@isPlaying yes
					@getItemInfo()
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

		getItemInfo: () ->
			@player.GetItem
				playerid: @playerid()
				properties: [
					"title"
					"season"
					"episode"
					"plot"
					"runtime"
					"showtitle"
					"thumbnail"
				]
				callback:
					success: (data) ->
						@currentTitle data.item.title
					error: (data) -> debugger
				context: @

		initEventListiners: () ->
			@player.bind "OnPlay", (data) ->
				@playerid data.player.playerid
				@isPlaying yes
				@getItemInfo()
			, @
			@player.bind "OnStop", (data) ->
				@playerid -1
				@isPlaying no
				@currentTitle ""
			, @
			@player.bind "OnPause", (data) ->
				@isPlaying no
			, @

		dispose: () ->
			super
			@player.dispose()