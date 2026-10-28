PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin

SCRIPTS := $(notdir $(wildcard bin/*))

.PHONY: install uninstall lint

install:
	install -d $(DESTDIR)$(BINDIR)
	for s in $(SCRIPTS); do \
		install -m755 bin/$$s $(DESTDIR)$(BINDIR)/$$s; \
	done

uninstall:
	for s in $(SCRIPTS); do \
		rm -f $(DESTDIR)$(BINDIR)/$$s; \
	done

lint:
	shellcheck bin/*