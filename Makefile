# Makefile based off of
# https://github.com/INTI-CMNB/kicad-ci-test-spora/blob/master/pcb_main/Makefile

#!/usr/bin/make
DEBUG=
MAK=kibot.mk
PRJ_DIR=FrogBoard/
CONFIG=$(PRJ_DIR)/FrogBoard.kibot.yml
SCH=$(PRJ_DIR)/FrogBoard.kicad_sch
PCB=$(PRJ_DIR)/FrogBoard.kicad_pcb
DEST=Output

all: erc drc fab

.PHONY: clean

$(MAK): $(CONFIG)
	kibot -e $(SCH) -b $(PCB) -c $< -d $(DEST) -m $@

erc: $(MAK)
	$(MAKE) -f $(MAK) run_erc

drc: $(MAK)
	$(MAKE) -f $(MAK) run_drc

fab: $(MAK) 
	$(MAKE) -f $(MAK) print_sch JLCPCB Elecrow

clean:
	rm -rf $(DEST) $(MAK)
