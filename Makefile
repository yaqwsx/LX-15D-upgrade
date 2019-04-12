.SECONDARY:

BOARDS = $(shell find . -name *.kicad_pcb ! -name _autosave*)

.PHONY: ele_manu clean

ele_manu: export_gerber.py $(BOARDS:.kicad_pcb=-gerber.zip)

export_gerber.py:
	rm -f $@
	wget https://raw.githubusercontent.com/paradise-fi/RoFI/master/util/export_gerber.py
	chmod +x $@

clean:
	echo "Clean run"
	rm -rf $(BOARDS:.kicad_pcb=-gerber)
	rm -rf $(BOARDS:.kicad_pcb=-gerber.zip)

%-gerber: %.kicad_pcb
	./export_gerber.py $< $@

%-gerber.zip: %-gerber
	zip -j $@ `find $<`



