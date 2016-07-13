.PHONY: all default

all: stackexchange.scss
	scss stackexchange.scss stackexchange.css --style compressed

default:
	echo '@-moz-document regexp("https?://(discuss\\.area51\\.|((?!chat|area51|blog|business)[^.]+\\.)*)((stackoverflow|serverfault|superuser|stackapps|askubuntu|stackexchange)\\.com|mathoverflow\\.net).*") {' > stackexchange-all-default.css
	curl http://cdn.sstatic.net/Sites/beta/all.css | perl -pe 's=url\(["'\'']?((?!http|//)[^)"'\'']*)["'\'']?\)=url('\''http://cdn.sstatic.net/Sites/beta/$$1'\'')=g' >> stackexchange-all-default.css
	echo '}' >> stackexchange-all-default.css
	echo '@-moz-document domain("chat.stackexchange.com"), domain("chat.meta.stackexchange.com"), domain("chat.stackoverflow.com") {' > stackexchange-chat-default.css
	curl http://cdn-chat.sstatic.net/chat/css/chat.stackexchange.com.css | perl -pe 's=url\(["'\'']?((?!http|//)[^)"'\'']*)["'\'']?\)=url('\''http://cdn-chat.sstatic.net/chat/css/$$1'\'')=g' >> stackexchange-chat-default.css
	echo '}' >> stackexchange-chat-default.css
