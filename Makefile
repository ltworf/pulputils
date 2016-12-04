translations:
	xgettext --from-code=utf-8 -L Python -j -o po/messages.pot --package-name=pulputils \
		src/pulputils/* \
		src/fixnames
	msgmerge po/it.po po/messages.pot

clean:
	rm -rf src/pulputils/__pycache__
