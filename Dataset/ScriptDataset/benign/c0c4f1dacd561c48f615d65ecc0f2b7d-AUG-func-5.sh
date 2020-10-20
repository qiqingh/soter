        local delay_time
        delay_time="$2"
        [ "x$delay_time" = "x" ] && delay_time="0"

		local url="$1"
		
cat <<EOF
<HTML>
<HEAD><meta http-equiv="Refresh" content="$delay_time; url=$url">
<Meta http-equiv="Pragma" Content="no-cache">
<META HTTP-equiv="Cache-Control" content="no-cache">
<Meta http-equiv="Expires" Content="0">
<META http-equiv='Content-Type' content='text/html; charset=$(print_charset)'>
EOF
print_language_js
cat <<EOF
<link rel="stylesheet" href="/form.css">
</HEAD>
<BODY bgcolor=#ffffff>
<tr><td colspan=2><br><img src=/liteblue.gif width=100% height=12></td></tr>
<script>window.location.href="$url"</script>
</BODY>
</HTML>
EOF
