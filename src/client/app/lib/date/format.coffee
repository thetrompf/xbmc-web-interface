define [], () ->
	'use strict'
	dateFormat = (() ->
		token = /d{1,4}|m{1,4}|yy(?:yy)?|([HhMsTt])\1?|[LloSZ]|"[^"]*"|'[^']*'/g
		timezone = /\b(?:[PMCEA][SDP]T|(?:Pacific|Mountain|Central|Eastern|Atlantic) (?:Standard|Daylight|Prevailing) Time|(?:GMT|UTC)(?:[-+]\d{4})?)\b/g
		timezoneClip = /[^-+\dA-Z]/g
		pad = (val, len) ->
			val = String val
			len = len || 2;
			while val.length < len
				val = "0" + val
			return val

		# Regexes and supporting functions are cached through closure
		return (date, mask, utc) ->
			dF = dateFormat
			# You can't provide utc if you skip other args (use the "UTC:" mask prefix)
			if arguments.length is 1 and Object.prototype.toString.call(date) is "[object String]" and !/\d/.test(date)
				mask = date
				date = undefined

			# Passing date through Date applies Date.parse, if necessary
			date = if date then new Date date else new Date
			throw SyntaxError "invalid date" if isNaN date

			mask = String(dF.masks[mask] or mask or dF.masks["default"])

			# Allow setting the utc argument via the mask
			if mask.slice(0, 4) is "UTC:"
				mask = mask.slice 4
				utc = true

			pfx = if utc then "getUTC" else "get"
			d = do date[pfx + "Date"]
			D = do date[pfx + "Day"]
			m = do date[pfx + "Month"]
			y = do date[pfx + "FullYear"]
			H = do date[pfx + "Hours"]
			M = do date[pfx + "Minutes"]
			s = do date[pfx + "Seconds"]
			L = do date[pfx + "Milliseconds"]
			o = if utc then 0 else do date.getTimezoneOffset
			flags =
				d:    d
				dd:   pad d
				ddd:  dF.i18n.dayNames[D]
				dddd: dF.i18n.dayNames[D + 7]
				m:    m + 1
				mm:   pad m + 1
				mmm:  dF.i18n.monthNames[m]
				mmmm: dF.i18n.monthNames[m + 12]
				yy:   (String y).slice 2
				yyyy: y
				h:    H % 12 or 12
				hh:   pad H % 12 or 12
				H:    H
				HH:   pad H
				M:    M
				MM:   pad M
				s:    s
				ss:   pad s
				l:    pad L, 3
				L:    pad if L > 99 then Math.round L / 10 else L
				t:    if H < 12 then "a" else "p"
				tt:   if H < 12 then "am" else "pm"
				T:    if H < 12 then "A" else "P"
				TT:   if H < 12 then "AM" else "PM"
				Z:    if utc then "UTC" else (String(date).match(timezone) || [""]).pop().replace timezoneClip, ""
				o:    (if o > 0 then "-" else "+") + pad(Math.floor(Math.abs(o) / 60) * 100 + Math.abs(o) % 60, 4)
				S:    ["th", "st", "nd", "rd"][if d % 10 > 3 then 0 else (d % 100 - d % 10 != 10) * d % 10]

			return mask.replace token, ($0) ->
				return flags[$0] if flags[$0]?
				return $0.slice 1, $0.length - 1
	)()

	dateFormat.masks =
		default:        "ddd mmm dd yyyy HH:MM:ss"
		shortDate:      "m/d/yy"
		mediumDate:     "mmm d, yyyy"
		longDate:       "mmmm d, yyyy"
		fullDate:       "dddd, mmmm d, yyyy"
		shortTime:      "h:MM TT"
		mediumTime:     "h:MM:ss TT"
		longTime:       "h:MM:ss TT Z"
		isoDate:        "yyyy-mm-dd"
		isoTime:        "HH:MM:ss"
		isoDateTime:    "yyyy-mm-dd'T'HH:MM:ss"
		isoUtcDateTime: "UTC:yyyy-mm-dd'T'HH:MM:ss'Z'"

	# Internationalization strings
	dateFormat.i18n =
		dayNames: [
			"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat",
			"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
		]
		monthNames: [
			"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
			"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
		]

	# For convenience...
	Date::format = (mask, utc) ->
		return dateFormat @, mask, utc

	return dateFormat
