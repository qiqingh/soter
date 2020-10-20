	lang_file="language/$GUI_Region.js"
	path="/www/$lang_file"

	if [ -f $path ]; then
		echo "<script language=javascript type=text/javascript src='./../$lang_file'></script>"
	else
		echo "<script language=javascript type=text/javascript src='./../language/English.js'></script>"
	fi

