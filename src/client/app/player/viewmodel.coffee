define [
	"base/viewmodel"
	"xbmc/api/player"
	"xbmc/api/util"
	"xbmc/api/application"
	"text!app/player/templates/player.html"
], (ViewModelBase, Player, Util, Application, template) ->

	class PlayerViewModel extends ViewModelBase

		bindingContext: "#player-container"
		$el: "#player-container"
		template: template
		template = null

		properties: () ->
			currentlyPlaying: @observable null
			playerOpen: @observable(null).subscribeTo "Player.Open"
			isPlaying: @observable no
			playerId: @observable null


		subscriptions: () ->
			self = @
			@playerOpen.subscribe (newValue) ->
				self.play newValue

		togglePlay: () ->
			@player.PlayPause
				callback: (data) -> return
				playerid: @playerId()

		stop: () ->
			@player.Stop
				callback: (data) -> return
				playerid: @playerId()

		forward: () ->

		quit: () ->
			@application.Quit
				callback:
					success: (data) ->
					error: (msg) ->
						console.error msg

		play: (playable) ->
			throw new Error "A playable has to have a type defined. e.g. movie or episode" unless playable.type?
			item = {}
			typeId = playable['type']+"id"
			item[typeId] = (id = playable["#{playable['type']}id"])
			throw new Error "There is now id defined corresponding to the type: #{playable['type']}" unless id?
			@player.Open
				item: item
				callback:
					success: (msg) ->
					error: (err) -> console?.error err
				context: @

		initialize: (options) ->
			@player = new Player options.client
			@application = new Application options.client

		afterInitialize: (options) ->
			@initPlayer()
			@initEventListiners()

		initPlayerState: () ->
			@player.GetProperties
				playerid: @playerId()
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
							@playerId p.playerid
					error: (data) ->
						console.error "An error occured when retreiving active players"
				context: @

		getItemInfo: () ->
			@player.GetItem
				playerid: @playerId()
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
						@currentlyPlaying data.item
						# if data.item.type is "episode"
						# 	@currentTitle @formatTVShowTitle data.item
						# else
						# 	@currentTitle data.item.title
						# @thumbnail Util.parseImageResource data.item.thumbnail, @options.config.resources, "w92"
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
				@playerId data.player.playerid
				@isPlaying yes
				@getItemInfo()
			, @
			@player.bind "OnStop", (data) ->
				@playerId -1
				@isPlaying no
				@currentlyPlaying null
			, @
			@player.bind "OnPause", (data) ->
				@isPlaying no
			, @

		dispose: () ->
			super
			@player.dispose()
