return {
    parse("expandme", "-- hello there"),
	parse_eval("weeknum", "`strftime('%U')`"),
    parse_eval("today", "`strftime('%Y-%m-%d')`"),
}, {}
