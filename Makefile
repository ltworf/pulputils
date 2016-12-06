translations:
	xgettext --from-code=utf-8 -L Python -j -o po/messages.pot --package-name=pulputils \
		src/pulputils/* \
		src/fixnames
	msgmerge --update po/it.po po/messages.pot

clean:
	rm -rf src/pulputils/__pycache__

install:
	#Install py files
	install -D src/fixnames $${DESTDIR:-/}/usr/share/pulputils/fixnames
	install -D src/pulputils/__init__.py $${DESTDIR:-/}/usr/share/pulputils/pulputils/__init__.py
	#Install links
	install -d $${DESTDIR:-/}/usr/bin/
	ln -s "../share/pulputils/fixnames" $${DESTDIR:-/}/usr/bin/fixnames
