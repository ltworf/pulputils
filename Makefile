TRANSLATIONS="it"

messages:
	for i in "$(TRANSLATIONS)"; do echo "Building localization $${i}"; msgfmt po/$${i}.po --output-file po/$${i}.mo; done

translations:
	xgettext --from-code=utf-8 -L Python -j -o po/messages.pot --package-name=pulputils \
		src/pulputils/* \
		src/fixnames \
		src/link2file
	for i in "$(TRANSLATIONS)"; do msgmerge --update po/$${i}.po po/messages.pot; done

clean:
	rm -rf src/pulputils/__pycache__
	rm -f po/*.mo

install:
	#Install py files
	install -D src/fixnames $${DESTDIR:-/}/usr/share/pulputils/fixnames
	install -D src/link2file $${DESTDIR:-/}/usr/share/pulputils/link2file
	install -D src/pulputils/__init__.py $${DESTDIR:-/}/usr/share/pulputils/pulputils/__init__.py
	#Install links
	install -d $${DESTDIR:-/}/usr/bin/
	ln -fs "../share/pulputils/fixnames" $${DESTDIR:-/}/usr/bin/fixnames
	ln -fs "../share/pulputils/link2file" $${DESTDIR:-/}/usr/bin/link2file
	#Install translations
	for i in "$(TRANSLATIONS)"; do install -D po/$${i}.mo $${DESTDIR:-/}/usr/share/locale/$${i}/LC_MESSAGES/pulputils.mo; done
