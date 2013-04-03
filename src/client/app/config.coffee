define [], () ->
	jsonrpc:
		protocol: "ws://"
		host: "192.168.0.2"#"localhost"
		port: 9090
	resources:
		username: "xbmc"
		password: "xbmc"
		protocol: "http://"
		host: "192.168.0.2"#"localhost"
		port: 8080
		useCached: false
	i18n:
		#longDateFormat: "dddd, MMMM, yyyy | HH:MM"
		longDateFormat: "dddd, mmmm dd, yyyy | HH:MM TT"
		utc: false
