# Makefile for mkinitcpio-chkeymap

VERSION=0.2.0

all:
	@echo "Just run make install..."

.PHONY: install
install:
	install -D -m0644 hook/chkeymap $(DESTDIR)/usr/lib/initcpio/hooks/chkeymap
	install -D -m0644 install/chkeymap $(DESTDIR)/usr/lib/initcpio/install/chkeymap

	install -D -m0644 etc/vconsole.conf $(DESTDIR)/etc/vconsole.conf
	install -D -m0644 etc/00-keyboard.conf $(DESTDIR)/etc/X11/xorg.conf.d/00-keyboard.conf

release:
	git archive --format=tar.xz --prefix=mkinitcpio-chkeymap-$(VERSION)/ $(VERSION) > mkinitcpio-chkeymap-$(VERSION).tar.xz
	gpg --armor --detach-sign --comment mkinitcpio-chkeymap-$(VERSION).tar.xz mkinitcpio-chkeymap-$(VERSION).tar.xz
	git notes --ref=refs/notes/signatures/tar add -C $$(git archive --format=tar --prefix=mkinitcpio-chkeymap-$(VERSION)/ $(VERSION) | gpg --armor --detach-sign --comment mkinitcpio-chkeymap-$(VERSION).tar | git hash-object -w --stdin) $(VERSION)
