.PHONY: all default

all: stackexchange.css myschoolapp.css supersite.css cardcastgame.css pretendyourexyzzy.css webassign.css gitlab.css

stackexchange.css: stackexchange.scss
	scss stackexchange.scss stackexchange.css --style compressed

myschoolapp.css: myschoolapp.scss
	scss myschoolapp.scss myschoolapp.css --style compressed

supersite.css: supersite.scss
	scss supersite.scss supersite.css --style compressed

cardcastgame.css: cardcastgame.scss
	scss cardcastgame.scss cardcastgame.css --style compressed

pretendyourexyzzy.css: pretendyourexyzzy.scss
	scss pretendyourexyzzy.scss pretendyourexyzzy.css --style compressed

webassign.css: webassign.scss
	scss webassign.scss webassign.css --style compressed

gitlab.css: gitlab.scss
	scss gitlab.scss gitlab.css --style compressed

default:
	echo '@-moz-document regexp("https?://(discuss\\.area51\\.|((?!chat|area51|blog|business)[^.]+\\.)*)((stackoverflow|serverfault|superuser|stackapps|askubuntu|stackexchange)\\.com|mathoverflow\\.net).*") {' > stackexchange-all-default.css
	curl http://cdn.sstatic.net/Sites/beta/all.css | perl -pe 's=url\(["'\'']?((?!http|//)[^)"'\'']*)["'\'']?\)=url('\''http://cdn.sstatic.net/Sites/beta/$$1'\'')=g' >> stackexchange-all-default.css
	echo '}' >> stackexchange-all-default.css
	echo '@-moz-document domain("chat.stackexchange.com"), domain("chat.meta.stackexchange.com"), domain("chat.stackoverflow.com") {' > stackexchange-chat-default.css
	curl http://cdn-chat.sstatic.net/chat/css/chat.stackexchange.com.css | perl -pe 's=url\(["'\'']?((?!http|//)[^)"'\'']*)["'\'']?\)=url('\''http://cdn-chat.sstatic.net/chat/css/$$1'\'')=g' >> stackexchange-chat-default.css
	echo '}' >> stackexchange-chat-default.css
