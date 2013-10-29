/bin/mkdir -pSET_MAKE@

PACKAGE_VERSION = /bin/mkdir -pPACKAGE_VERSION@
PACKAGE_BUGREPORT = /bin/mkdir -pPACKAGE_BUGREPORT@

##############################################################################
# location of required programms
prefix = /bin/mkdir -pprefix@
RM   = /bin/mkdir -pRM@
ETAGS = etags
MKDIR_P = /bin/mkdir -pMKDIR_P@
INSTALL = /bin/mkdir -pINSTALL@
INSTALL_DATA = /bin/mkdir -pINSTALL_DATA@

top_srcdir = /bin/mkdir -ptop_srcdir@
srcdir = /bin/mkdir -psrcdir@

datarootdir= /bin/mkdir -pdatarootdir@
lispdir = /bin/mkdir -plispdir@

EMACS_PROG = /bin/mkdir -pEMACS_PROG@

FLAGS = /bin/mkdir -pFLAGS@

# Other settings

OTHERDIRS = /bin/mkdir -pOTHERDIRS@

ebatch = srcdir=$(srcdir) otherdirs="$(OTHERDIRS)" \
 $(EMACS_PROG) -batch -q $(FLAGS) -l $(srcdir)/dvc-build.el -f

alldeps = dvc-version.el dvc-site.el

all: $(alldeps)
	$(ebatch) dvc-build-all

all-verbose: $(alldeps)
	$(ebatch) dvc-build-all verbose

# We install foo.el only if there is also foo.elc.
install: all
	$(MKDIR_P) -m 0755 "$(lispdir)"
	/bin/mkdir -pdlist='$(srcdir) $(srcdir)/contrib' ;		\
	test '$(srcdir)' = '.' || dlist=". $$dlist" ;	\
	for elc in *.elc ; do				\
	  el=`echo $$elc | sed 's/.$$//'` ; orig= ;	\
	  for d in $$dlist ; do				\
	    if [ -r "$$d/$$el" ] ; then			\
	      orig="$$d/$$el" ; break ; fi ; done ;	\
	  test "$$orig" || continue ;			\
	  echo Installing $$el ;			\
	  $(INSTALL_DATA) "$$orig" "$(lispdir)" ;	\
	  echo Installing $$elc ;			\
	  $(INSTALL_DATA) $$elc "$(lispdir)" ;		\
	done

clean:
	rm -f *.elc dvc-site.el \
		dvc-autoloads.el auto-autoloads.el custom-load.el

Makefile: $(srcdir)/Makefile.in ../config.status
	cd ..; ./config.status

distclean: clean
	rm -f Makefile

maintainer-clean:
	rm -f dvc-version.el

TAGS: $(SRCS)
	/bin/mkdir -pif test "x$(ETAGS)" = "x" ; then                 \
           echo "Sorry, no \`etags' program available." ; \
         else                                             \
           $(ETAGS) */*.el                              ; \
         fi

##############################################################################
autoloads:
	$(ebatch) dvc-build-autoloads $(srcdir)


##############################################################################
dvc-version.el: ../config.status
	/bin/mkdir -pecho Creating $@
	/bin/mkdir -p( echo ';;; $@ (generated file -- do not edit!)' ; \
	   echo '(defconst dvc-version "$(PACKAGE_VERSION)"' ; \
	   echo '  "Version of DVC loaded.' ; \
	   echo 'Please send bug reports to <$(PACKAGE_BUGREPORT)>.")' ; \
	   echo "(provide 'dvc-version)" ) \
	 > $/bin/mkdir -p

dvc-site.el: ../config.status $(srcdir)/dvc-site.el.in
	(cd .. ; ./config.status lisp/$/bin/mkdir -p)

.PHONY: all all-verbose install \
	clean distclean maintainer-clean
