define [
	"base/viewmodel"
	"xbmc/api/player"
	"xbmc/api/util"
	"text!app/player/player.html"
	"app/config"
], (ViewModelBase, Player, Util, template, config) ->

	class PlayerViewModel extends ViewModelBase

		bindingContext: "#player-container"
		$el: "#player-container"
		template: template
		template = null

		properties: () ->
			playerid: @observable -1
			isPlaying: @observable no
			currentTitle: @observable ""
			thumbnail: @observable ""

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
			@player = new Player options.client

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
					"starttime"
					"endtime"
				]
				callback:
					success: (data) ->
						if data.item.type is "episode"
							@currentTitle @formatTVShowTitle data.item
						else
							@currentTitle data.item.title
						@thumbnail Util.parseImageResource data.item.thumbnail, config.resources, "w92"
					error: (data) -> debugger
				context: @

		formatTVShowTitle: (item) ->
			"#{item.showtitle} #{@formatSeasonInfo item} #{item.title}"

		formatSeasonInfo: (item) ->
			res = "S"
			if item.season.toString().length is 1
				res += 0
			res += item.season+"E"
			if item.episode.toString().length is 1
				res += 0
			res += item.episode

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
