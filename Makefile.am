###############################################################################
## Makefile for apertium-hyw
###############################################################################

LANG1=hyw
VAR1=hyw
VAR2=hye
LANG1VAR1=$(LANG1)@$(VAR1)
LANG1VAR2=$(LANG1)@$(VAR2)
BASENAME=apertium-$(LANG1)

LEXD_FILES=  \
             lexd_components/$(LANG1)-nouns_paradigms.lexd \
	   lexd_components/$(LANG1)-verbs_paradigms_with_lex.lexd  \
	   lexd_components/$(LANG1)-verbs_obs.lexd  \
	   lexd_components/$(LANG1)-verbs_irreg.lexd \
	   lexd_components/$(LANG1)-verbs_reg.lexd \
	   lexd_components/$(LANG1)-verbs_kouyoumdjian.lexd \
	   lexd_components/$(LANG1)-nouns_lex_irreg.lexd \
       lexd_components/$(LANG1)-nouns_lex_suffixbased.lexd \
       lexd_components/$(LANG1)-numbers-v2.lexd \
       lexd_components/$(LANG1)-names.lexd \
       lexd_components/$(LANG1)-names_hyebased.lexd \
       lexd_components/$(LANG1)-pronouns.lexd \
       lexd_components/$(LANG1)-adpositions.lexd \
       lexd_components/$(LANG1)-punctuation.lexd \
	   lexd_components/$(LANG1)-adjective_adverb_list.lexd \
	   lexd_components/$(LANG1)-nouns_regular_list.lexd \
	   lexd_components/$(LANG1)-other.lexd   \
	   lexd_components/$(LANG1)-names_bible.lexd \
	   lexd_components/$(LANG1)-added_essayan.lexd \
	   lexd_components/$(LANG1)-abbr_affix.lexd \
	   lexd_components/$(LANG1)-added_bible.lexd \
	   lexd_components/$(LANG1)-added_kogian.lexd \
	   lexd_components/$(LANG1)-added_kantsasar.lexd \
	   lexd_components/$(LANG1)-added_kayayan.lexd \
	   lexd_components/$(LANG1)-added_wikipedia.lexd


TARGETS_COMMON =			\
	$(LANG1).automorf.hfst		\
	$(LANG1).automorf.bin		\
	$(LANG1).automorf.att.gz	\
	$(LANG1).autogen.hfst		\
	$(LANG1).autogen.bin		\
	$(LANG1).autogen.att.gz		\
	$(LANG1VAR1).automorf.hfst		\
	$(LANG1VAR1).automorf.bin		\
	$(LANG1VAR1).automorf.att.gz	\
	$(LANG1VAR1).autogen.hfst		\
	$(LANG1VAR1).autogen.bin		\
	$(LANG1VAR1).autogen.att.gz		\
	$(LANG1VAR2).automorf.hfst		\
	$(LANG1VAR2).automorf.bin		\
	$(LANG1VAR2).automorf.att.gz	\
	$(LANG1VAR2).autogen.hfst		\
	$(LANG1VAR2).autogen.bin		\
	$(LANG1VAR2).autogen.att.gz		\
	$(LANG1).autopgen.bin		\
	$(LANG1).rlx.bin

# This include defines goals for install-modes, .deps/.d, autobil.prefixes and .mode files:
@ap_include@

###############################################################################
## hyw transducer
###############################################################################
$(BASENAME).$(LANG1).lexd: $(LEXD_FILES)
	cat $^ > $@

.deps/$(LANG1).twol.hfst: $(BASENAME).$(LANG1).twol .deps/.d
	hfst-twolc $< -o $@

.deps/$(LANG1).spellrelax.hfst: $(BASENAME).$(LANG1).spellrelax .deps/.d
	hfst-regexp2fst -S -o $@ $<

.deps/$(LANG1).RL.lexd: $(BASENAME).$(LANG1).lexd .deps/.d
	cat $< | grep -v 'Dir/LR' > $@

.deps/$(LANG1).LR.lexd: $(BASENAME).$(LANG1).lexd .deps/.d
	cat $< | grep -v 'Dir/RL' > $@

.deps/$(LANG1).RL.lexd.hfst: .deps/$(LANG1).RL.lexd
	lexd $< .deps/$(LANG1).RL.lexd.att
	hfst-txt2fst .deps/$(LANG1).RL.lexd.att -o $@ -v

.deps/$(LANG1).LR.lexd.hfst: .deps/$(LANG1).LR.lexd
	lexd $< .deps/$(LANG1).LR.lexd.att
	hfst-txt2fst .deps/$(LANG1).LR.lexd.att -o $@ -v

.deps/$(LANG1).punctuation.hfst: lexd_components/$(LANG1)-infixal_punctuation.lexd .deps/.d
	lexd $< .deps/$(LANG1).punctuation.att
	hfst-txt2fst .deps/$(LANG1).punctuation.att -o $@ -v

.deps/$(LANG1).punct-gen.hfst: $(BASENAME).$(LANG1)-punct.twol .deps/.d
	hfst-twolc $< -o $@

.deps/$(LANG1).punct-morf.hfst: $(BASENAME).$(LANG1)-punct.lexd .deps/.d
	lexd $< > .deps/$(LANG1).punct-morf.att
	hfst-txt2fst .deps/$(LANG1).punct-morf.att -o $@ -v

.deps/$(LANG1).RL.lexd-punct.hfst: .deps/$(LANG1).RL.lexd.hfst .deps/$(LANG1).punctuation.hfst
	hfst-concatenate -1 $< -2 .deps/$(LANG1).punctuation.hfst -o $@ -v

.deps/$(LANG1).LR.lexd-punct.hfst: .deps/$(LANG1).LR.lexd.hfst .deps/$(LANG1).punctuation.hfst
	hfst-concatenate -1 $< -2 .deps/$(LANG1).punctuation.hfst -o $@ -v

.deps/$(LANG1).RL.lexd-punct-twol.hfst: .deps/$(LANG1).RL.lexd-punct.hfst .deps/$(LANG1).twol.hfst
	hfst-compose-intersect -1 .deps/$(LANG1).RL.lexd-punct.hfst -2 .deps/$(LANG1).twol.hfst -o $@

.deps/$(LANG1).LR.lexd-punct-twol.hfst: .deps/$(LANG1).LR.lexd-punct.hfst .deps/$(LANG1).twol.hfst
	hfst-compose-intersect -1 .deps/$(LANG1).LR.lexd-punct.hfst -2 .deps/$(LANG1).twol.hfst -o $@

.deps/$(LANG1).RL.hfst: .deps/$(LANG1).RL.lexd-punct-twol.hfst .deps/$(LANG1).punct-gen.hfst
	hfst-compose-intersect -1 .deps/$(LANG1).RL.lexd-punct-twol.hfst -2 .deps/$(LANG1).punct-gen.hfst -o $@

.deps/$(LANG1).LR.hfst: .deps/$(LANG1).LR.lexd-punct-twol.hfst .deps/$(LANG1).punct-morf.hfst
	hfst-compose -1 .deps/$(LANG1).LR.lexd-punct-twol.hfst -2 .deps/$(LANG1).punct-morf.hfst -o $@

$(LANG1).autogen.hfst: .deps/$(LANG1).RL.hfst
	hfst-fst2fst -O $< -o $@

$(LANG1).automorf.hfst: .deps/$(LANG1).LR.hfst .deps/$(LANG1).spellrelax.hfst
	hfst-compose -1 $< -2 .deps/$(LANG1).spellrelax.hfst | hfst-invert | hfst-fst2fst -O -o $@

$(LANG1).autogen.att.gz: $(LANG1).autogen.hfst
	hfst-fst2txt $< | gzip -9 -c -n > $@

$(LANG1).automorf.att.gz: $(LANG1).automorf.hfst
	hfst-fst2txt $< | gzip -9 -c -n > $@

$(LANG1).autogen.bin: $(LANG1).autogen.att.gz .deps/.d
	zcat < $< > .deps/$(LANG1).autogen.att
	lt-comp lr .deps/$(LANG1).autogen.att $@

$(LANG1).automorf.bin: $(LANG1).automorf.att.gz .deps/.d
	zcat < $< > .deps/$(LANG1).automorf.att
	lt-comp lr .deps/$(LANG1).automorf.att $@

$(LANG1).autopgen.bin: $(BASENAME).post-$(LANG1).dix
	lt-comp lr $< $@

###############################################################################
## hyw transducer
###############################################################################
.deps/$(LANG1VAR1).lexd: $(BASENAME).$(LANG1).lexd .deps/.d
	grep -v "Var/$(VAR2)" $^ > $@

.deps/$(LANG1VAR1).twol: $(BASENAME).$(LANG1).twol .deps/.d
	grep -v "Var/$(VAR2)" $^ > $@

.deps/$(LANG1VAR1).twol.hfst: .deps/$(LANG1VAR1).twol .deps/.d
	hfst-twolc $< -o $@

#.deps/$(LANG1).spellrelax.hfst: $(BASENAME).$(LANG1).spellrelax .deps/.d
#	hfst-regexp2fst -S -o $@ $<

.deps/$(LANG1VAR1).RL.lexd: .deps/$(LANG1VAR1).lexd .deps/.d
	cat $< | grep -v 'Dir/LR' > $@

.deps/$(LANG1VAR1).LR.lexd:.deps/$(LANG1VAR1).lexd .deps/.d
	cat $< | grep -v 'Dir/RL' > $@

.deps/$(LANG1VAR1).RL.lexd.hfst: .deps/$(LANG1VAR1).RL.lexd
	lexd $< .deps/$(LANG1VAR1).RL.lexd.att
	hfst-txt2fst .deps/$(LANG1VAR1).RL.lexd.att -o $@ -v

.deps/$(LANG1VAR1).LR.lexd.hfst: .deps/$(LANG1VAR1).LR.lexd
	lexd $< .deps/$(LANG1VAR1).LR.lexd.att
	hfst-txt2fst .deps/$(LANG1VAR1).LR.lexd.att -o $@ -v

#.deps/$(LANG1).punctuation.hfst: lexd_components/$(LANG1)-infixal_punctuation.lexd .deps/.d
#	lexd $< .deps/$(LANG1).punctuation.att
#	hfst-txt2fst .deps/$(LANG1).punctuation.att -o $@ -v

#.deps/$(LANG1).punct-gen.hfst: $(BASENAME).$(LANG1)-punct.twol .deps/.d
#	hfst-twolc $< -o $@

#.deps/$(LANG1).punct-morf.hfst: $(BASENAME).$(LANG1)-punct.lexd .deps/.d
#	lexd $< > .deps/$(LANG1).punct-morf.att
#	hfst-txt2fst .deps/$(LANG1).punct-morf.att -o $@ -v

#.deps/$(LANG1).RL.lexd-punct.hfst: .deps/$(LANG1).RL.lexd.hfst .deps/$(LANG1).punctuation.hfst
#	hfst-concatenate -1 $< -2 .deps/$(LANG1).punctuation.hfst -o $@ -v

#.deps/$(LANG1).LR.lexd-punct.hfst: .deps/$(LANG1).LR.lexd.hfst .deps/$(LANG1).punctuation.hfst
#	hfst-concatenate -1 $< -2 .deps/$(LANG1).punctuation.hfst -o $@ -v

.deps/$(LANG1VAR1).RL.lexd-punct-twol.hfst: .deps/$(LANG1).RL.lexd-punct.hfst .deps/$(LANG1VAR1).twol.hfst
	hfst-compose-intersect -1 .deps/$(LANG1).RL.lexd-punct.hfst -2 .deps/$(LANG1VAR1).twol.hfst -o $@

.deps/$(LANG1VAR1).LR.lexd-punct-twol.hfst: .deps/$(LANG1).LR.lexd-punct.hfst .deps/$(LANG1VAR1).twol.hfst
	hfst-compose-intersect -1 .deps/$(LANG1).LR.lexd-punct.hfst -2 .deps/$(LANG1VAR1).twol.hfst -o $@

.deps/$(LANG1VAR1).RL.hfst: .deps/$(LANG1VAR1).RL.lexd-punct-twol.hfst .deps/$(LANG1).punct-gen.hfst
	hfst-compose-intersect -1 .deps/$(LANG1VAR1).RL.lexd-punct-twol.hfst -2 .deps/$(LANG1).punct-gen.hfst -o $@

.deps/$(LANG1VAR1).LR.hfst: .deps/$(LANG1VAR1).LR.lexd-punct-twol.hfst .deps/$(LANG1).punct-morf.hfst
	hfst-compose -1 .deps/$(LANG1VAR1).LR.lexd-punct-twol.hfst -2 .deps/$(LANG1).punct-morf.hfst -o $@

$(LANG1VAR1).autogen.hfst: .deps/$(LANG1VAR1).RL.hfst
	hfst-fst2fst -O $< -o $@

$(LANG1VAR1).automorf.hfst: .deps/$(LANG1VAR1).LR.hfst .deps/$(LANG1).spellrelax.hfst
	hfst-compose -1 $< -2 .deps/$(LANG1).spellrelax.hfst | hfst-invert | hfst-fst2fst -O -o $@

$(LANG1VAR1).autogen.att.gz: $(LANG1VAR1).autogen.hfst
	hfst-fst2txt $< | gzip -9 -c -n > $@

$(LANG1VAR1).automorf.att.gz: $(LANG1VAR1).automorf.hfst
	hfst-fst2txt $< | gzip -9 -c -n > $@

$(LANG1VAR1).autogen.bin: $(LANG1VAR1).autogen.att.gz .deps/.d
	zcat < $< > .deps/$(LANG1VAR1).autogen.att
	lt-comp lr .deps/$(LANG1VAR1).autogen.att $@

$(LANG1VAR1).automorf.bin: $(LANG1VAR1).automorf.att.gz .deps/.d
	zcat < $< > .deps/$(LANG1).automorf.att
	lt-comp lr .deps/$(LANG1).automorf.att $@

###############################################################################
## hye transducer
###############################################################################
.deps/$(LANG1VAR2).lexd: $(BASENAME).$(LANG1).lexd .deps/.d
	grep -v "Var/$(VAR1)" $^ > $@

.deps/$(LANG1VAR2).twol: $(BASENAME).$(LANG1).twol .deps/.d
	grep -v "Var/$(VAR1)" $^ > $@

.deps/$(LANG1VAR2).twol.hfst: .deps/$(LANG1VAR2).twol .deps/.d
	hfst-twolc $< -o $@

#.deps/$(LANG1).spellrelax.hfst: $(BASENAME).$(LANG1).spellrelax .deps/.d
#	hfst-regexp2fst -S -o $@ $<

.deps/$(LANG1VAR2).RL.lexd: .deps/$(LANG1VAR2).lexd .deps/.d
	cat $< | grep -v 'Dir/LR' > $@

.deps/$(LANG1VAR2).LR.lexd:.deps/$(LANG1VAR2).lexd .deps/.d
	cat $< | grep -v 'Dir/RL' > $@

.deps/$(LANG1VAR2).RL.lexd.hfst: .deps/$(LANG1VAR2).RL.lexd
	lexd $< .deps/$(LANG1VAR2).RL.lexd.att
	hfst-txt2fst .deps/$(LANG1VAR2).RL.lexd.att -o $@ -v

.deps/$(LANG1VAR2).LR.lexd.hfst: .deps/$(LANG1VAR2).LR.lexd
	lexd $< .deps/$(LANG1VAR2).LR.lexd.att
	hfst-txt2fst .deps/$(LANG1VAR2).LR.lexd.att -o $@ -v

#.deps/$(LANG1).punctuation.hfst: lexd_components/$(LANG1)-infixal_punctuation.lexd .deps/.d
#	lexd $< .deps/$(LANG1).punctuation.att
#	hfst-txt2fst .deps/$(LANG1).punctuation.att -o $@ -v

#.deps/$(LANG1).punct-gen.hfst: $(BASENAME).$(LANG1)-punct.twol .deps/.d
#	hfst-twolc $< -o $@

#.deps/$(LANG1).punct-morf.hfst: $(BASENAME).$(LANG1)-punct.lexd .deps/.d
#	lexd $< > .deps/$(LANG1).punct-morf.att
#	hfst-txt2fst .deps/$(LANG1).punct-morf.att -o $@ -v

#.deps/$(LANG1).RL.lexd-punct.hfst: .deps/$(LANG1).RL.lexd.hfst .deps/$(LANG1).punctuation.hfst
#	hfst-concatenate -1 $< -2 .deps/$(LANG1).punctuation.hfst -o $@ -v

#.deps/$(LANG1).LR.lexd-punct.hfst: .deps/$(LANG1).LR.lexd.hfst .deps/$(LANG1).punctuation.hfst
#	hfst-concatenate -1 $< -2 .deps/$(LANG1).punctuation.hfst -o $@ -v

.deps/$(LANG1VAR2).RL.lexd-punct-twol.hfst: .deps/$(LANG1).RL.lexd-punct.hfst .deps/$(LANG1VAR2).twol.hfst
	hfst-compose-intersect -1 .deps/$(LANG1).RL.lexd-punct.hfst -2 .deps/$(LANG1VAR2).twol.hfst -o $@

.deps/$(LANG1VAR2).LR.lexd-punct-twol.hfst: .deps/$(LANG1).LR.lexd-punct.hfst .deps/$(LANG1VAR2).twol.hfst
	hfst-compose-intersect -1 .deps/$(LANG1).LR.lexd-punct.hfst -2 .deps/$(LANG1VAR2).twol.hfst -o $@

.deps/$(LANG1VAR2).RL.hfst: .deps/$(LANG1VAR2).RL.lexd-punct-twol.hfst .deps/$(LANG1).punct-gen.hfst
	hfst-compose-intersect -1 .deps/$(LANG1VAR2).RL.lexd-punct-twol.hfst -2 .deps/$(LANG1).punct-gen.hfst -o $@

.deps/$(LANG1VAR2).LR.hfst: .deps/$(LANG1VAR2).LR.lexd-punct-twol.hfst .deps/$(LANG1).punct-morf.hfst
	hfst-compose -1 .deps/$(LANG1VAR2).LR.lexd-punct-twol.hfst -2 .deps/$(LANG1).punct-morf.hfst -o $@

$(LANG1VAR2).autogen.hfst: .deps/$(LANG1VAR2).RL.hfst
	hfst-fst2fst -O $< -o $@

$(LANG1VAR2).automorf.hfst: .deps/$(LANG1VAR2).LR.hfst .deps/$(LANG1).spellrelax.hfst
	hfst-compose -1 $< -2 .deps/$(LANG1).spellrelax.hfst | hfst-invert | hfst-fst2fst -O -o $@

$(LANG1VAR2).autogen.att.gz: $(LANG1VAR2).autogen.hfst
	hfst-fst2txt $< | gzip -9 -c -n > $@

$(LANG1VAR2).automorf.att.gz: $(LANG1VAR2).automorf.hfst
	hfst-fst2txt $< | gzip -9 -c -n > $@

$(LANG1VAR2).autogen.bin: $(LANG1VAR2).autogen.att.gz .deps/.d
	zcat < $< > .deps/$(LANG1VAR2).autogen.att
	lt-comp lr .deps/$(LANG1VAR2).autogen.att $@

$(LANG1VAR2).automorf.bin: $(LANG1VAR2).automorf.att.gz .deps/.d
	zcat < $< > .deps/$(LANG1).automorf.att
	lt-comp lr .deps/$(LANG1).automorf.att $@

###############################################################################
## Debugging transducers (for testvoc)
###############################################################################

debug: .deps/$(LANG1).LR-debug.hfst .deps/$(LANG1).lexd.hfst

.deps/$(LANG1).LR-debug.hfst: $(BASENAME).$(LANG1).lexd .deps/.d
	cat $< | grep -v 'Dir/RL' | grep -v 'Use/Circ' > .deps/$(LANG1).LR-debug.lexd
	lexd .deps/$(LANG1).LR-debug.lexd | hfst-txt2fst -o .deps/$(LANG1).LR-debug.lexd.hfst -v
	hfst-compose-intersect -1 .deps/$(LANG1).LR-debug.lexd.hfst -2 .deps/$(LANG1).twol.hfst -o $@

.deps/$(LANG1).lexd.hfst: .deps/$(LANG1).RL.lexd.hfst
	hfst-fst2fst -O -i $< -o $@

###############################################################################
## Disambiguation rules
###############################################################################

$(LANG1).rlx.bin: $(BASENAME).$(LANG1).rlx
	cg-comp $< $@

###############################################################################
## Spell checker
###############################################################################

$(LANG1).zhfst: .deps/acceptor.default.hfst .deps/errmodel.default.hfst
	rm -f $@
	zip -j $@ .deps/acceptor.default.hfst .deps/errmodel.default.hfst speller/index.xml

.deps/errmodel.default.hfst: .deps/words.default.hfst .deps/strings.default.hfst
	python dev/editdist.py -v -s -d 1 -e '@0@' -i speller/editdist.default.txt -a .deps/acceptor.default.hfst \
	| hfst-txt2fst  -e '@0@' -o .deps/editdist.default.hfst
	hfst-disjunct .deps/strings.default.hfst .deps/editdist.default.hfst \
	| hfst-minimise | hfst-repeat -f 1 -t 2 -o .deps/editstrings.default.hfst
	hfst-disjunct .deps/words.default.hfst .deps/editstrings.default.hfst \
	| hfst-fst2fst  -f olw -o $@

.deps/words.default.hfst: speller/words.default.txt
	grep -v -e "^#" -e "^$$" $< | hfst-strings2fst  -j -o $@

.deps/strings.default.hfst: speller/strings.default.txt .deps/anystar.hfst
	grep -v -e "^#" -e "^$$" $< | hfst-strings2fst  -j | hfst-concatenate .deps/anystar.hfst - |\
	hfst-concatenate - .deps/anystar.hfst -o $@

.deps/anystar.hfst:
	echo "?*;" | hfst-regexp2fst -S -o $@

.deps/acceptor.default.hfst: $(LANG1).autogen.hfst
	cat $< | hfst-fst2fst -t | hfst-project  --project=lower | hfst-minimise |hfst-fst2fst  -f olw -o $@

###############################################################################
## Distribution
###############################################################################

EXTRA_DIST=$(BASENAME).$(LANG1).lexd		\
		$(BASENAME).$(LANG1).twol	\
		$(BASENAME).$(LANG1).rlx	\
		$(BASENAME).post-$(LANG1).dix	\
		modes.xml

###############################################################################
## Installation stuff
###############################################################################
#
#   apertium_hyw_dir: This is where the compiled binaries go
#   apertium_hyw_srcdir: This is where the source files go

apertium_hywdir=$(prefix)/share/apertium/$(BASENAME)/
apertium_hyw_srcdir=$(prefix)/share/apertium/$(BASENAME)/

EXTRA_TARGETS=

if HAVE_HFSTOSPELL
EXTRA_TARGETS += $(LANG1).zhfst
endif # HAVE_HFSTOSPELL

apertium_hyw_DATA=$(TARGETS_COMMON) $(EXTRA_TARGETS)

pkgconfigdir = $(prefix)/share/pkgconfig
pkgconfig_DATA = $(BASENAME).pc

noinst_DATA=modes/$(LANG1)-morph.mode

install-data-local: install-modes
	$(INSTALL_DATA) $(BASENAME).$(LANG1).lexd $(DESTDIR)$(apertium_hyw_srcdir)
	$(INSTALL_DATA) $(BASENAME).$(LANG1).twol $(DESTDIR)$(apertium_hyw_srcdir)
	$(INSTALL_DATA) $(BASENAME).$(LANG1).rlx $(DESTDIR)$(apertium_hyw_srcdir)
	$(INSTALL_DATA) $(BASENAME).post-$(LANG1).dix $(DESTDIR)$(apertium_hyw_srcdir)

###############################################################################
## Cleanup
###############################################################################

CLEANFILES = $(TARGETS_COMMON)
clean-local:
	-rm -rf .deps modes

###############################################################################
## Test
###############################################################################

test: all
	apertium-regtest test
SHELL=/bin/bash -o pipefail
