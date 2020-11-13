TRANSLATIONS="it"

all: messages

messages:
	for i in "$(TRANSLATIONS)"; do echo "Building localization $${i}"; msgfmt po/$${i}.po --output-file po/$${i}.mo; done

translations: clean
	xgettext --from-code=utf-8 -L Python -j -o po/messages.pot --package-name=pulputils \
		/usr/lib/python3.5/argparse.py \
		src/pulputils/* \
		src/fixnames \
		src/link2file \
		src/dedup
	for i in "$(TRANSLATIONS)"; do msgmerge --update po/$${i}.po po/messages.pot; done

.PHONY: mypy
mypy:
	cd src; mypy dedup

.PHONY: clean
clean:
	rm -rf src/pulputils/__pycache__
	rm -f po/*.mo

.PHONY: install
install:
	#Install py files
	install -D src/fixnames $${DESTDIR:-/}/usr/share/pulputils/fixnames
	install -D src/link2file $${DESTDIR:-/}/usr/share/pulputils/link2file
	install -D src/dedup $${DESTDIR:-/}/usr/share/pulputils/dedup
	install -D -m644 src/pulputils/__init__.py $${DESTDIR:-/}/usr/share/pulputils/pulputils/__init__.py
	#Install links
	install -d $${DESTDIR:-/}/usr/bin/
	ln -fs "../share/pulputils/fixnames" $${DESTDIR:-/}/usr/bin/fixnames
	ln -fs "../share/pulputils/link2file" $${DESTDIR:-/}/usr/bin/link2file
	ln -fs "../share/pulputils/dedup" $${DESTDIR:-/}/usr/bin/dedup
	#Install translations
	for i in "$(TRANSLATIONS)"; do install -m644 -D po/$${i}.mo $${DESTDIR:-/}/usr/share/locale/$${i}/LC_MESSAGES/pulputils.mo; done

.PHONY: dist
dist: clean
	cd ..; tar -czvvf pulputils/pulputils_`pulputils/src/dedup --version | grep pulputils | cut -d\  -f3`.orig.tar.gz \
	    pulputils/po/*.po \
	    pulputils/po/*.pot \
	    pulputils/Makefile \
	    pulputils/README.md \
	    pulputils/CHANGELOG \
	    pulputils/COPYING \
	    pulputils/src/pulputils/*.py \
	    pulputils/src/dedup \
	    pulputils/src/fixnames \
	    pulputils/src/link2file
	gpg --detach-sign -a *.orig.tar.gz

.PHONY: deb-pkg
deb-pkg: dist
	mv pulputils_*orig.tar.gz /tmp
	cd /tmp; tar -xf pulputils_*.orig.tar.gz
	cp -r debian /tmp/pulputils/
	cd /tmp/pulputils/; dpkg-buildpackage --changes-option=-S
	mkdir deb-pkg
	mv /tmp/pulputils_* deb-pkg
	$(RM) -r /tmp/pulputils
