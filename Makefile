MD=$(shell find . -iname "*.md" -not -path '*_layouts*')
HTML=$(MD:.md=.html)
SITENAME=owlofathena.com

.PHONY = clean backup deploy all 
all:
	../stab/stab/stab.py

clean:
	@-/bin/rm $(HTML) 2>/dev/null

backup:
	tar --exclude=backup.tar.gz --exclude=.git/ \
		--exclude=venv/ --exclude=__pycache__/ \
		-czvf backup.tar.gz ./

deploy:
	../stab/stab/stab.py && \
	surge .
	$(MAKE) clean
