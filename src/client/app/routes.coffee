define [], () ->
	[
			# url: url string or array of urls
			# path: module path # viewmodel # method
			url: [ "/", "home" ]
			path: "home"
		,
			url: "/home/subpage",
			path: "home#viewmodel#subpage"
		,
			url: "movies"
			path: "movies"
		,
			url: "tvshows"
			path: "tvshows"
		,
			url: "music"
			path: "music"
		,
			url: "remote"
			path: "remote"
		,
			url: "settings"
			path: "settings"
	]