#
# Makefile
# Author: Jose Antonio Quiñonero Gris
#
# === VARIABLES ===
#
# Select the compiler and flags
#
FC=gfortran
FFLAGS=-O2 -Wall -Wextra -std=legacy
# FFLAGS=-O2 -std=f2008
# FFLAGS=-O3 -Wall -Wextra
#
# Specify file name containing the main program in 'MAINPROG'
# The executable (without extension) and object (.o) are defined from it
# (I follow this way of defining objects throughout the Makefile)
#
MAINPROG=main.f90
MAINEX=${MAINPROG:.f90=}
MAINOBJ=${MAINPROG:.f90=.o}
#
# Specify path to the subroutines directory
# Note: all .f90 files in the SUBPATH folder are considered needed subroutines
#
SUBPATH=subroutines
SUBSRC=$(shell ls $(SUBPATH)/*.f90)
SUBOBJ=${SUBSRC:.f90=.o}
#
# Specify path to the modules directory
# IMPORTANT NOTE: NAME OF THE MODULE MUST BE THE SAME AS NAME OF FILE
# If it is not the case, change the definition of $(MODMOD) as
# MODMOD=mymodule1.mod mymodule2.mod ...
#
MODPATH=modules
MODSRC=$(shell ls $(MODPATH)/*.f90)
MODOBJ=${MODSRC:.f90=.o}
MODMOD=${MODSRC:.f90=.mod}
#
# I define a "general" variable containing all source files, 'SRC', and so
# the objects in 'OBJ'
#
SRC=$(SUBSRC) $(MODSRC) $(MAINPROG)
OBJ=${SRC:.f90=.o}
#
# Specify the command to create the library in 'AR'
# The path to the library in 'LIBPATH'
# The name of the library in 'LIB'
# In this case, I create a static library, so I use the variable 'STATLIB';
# the same can be accomplished for dynamic library by changing the extension
#
AR=ar rcs
LIBPATH=./
LIB=mylib
STATLIB=lib$(LIB).a
#
# Finally, I define some variables for the plots like
# the path to the directory of the plots in 'GRAPHDIR'
# the main script in 'GRAPHPROG' and all scripts in 'ALLGRAPHS'
# and the data for the script in 'GRAPHDATA'
#
GRAPHDIR=graph
GRAPHPROG=$(GRAPHDIR)/graph.py
ALLGRAPHS=$(shell ls $(GRAPHDIR)/*.py)
GRAPHDATA=$(GRAPHDIR)/out-graph.dat
#
# === COMMANDS ===
#
# Main compilation of all .f90
#
%.o: %.f90 $(MODMOD)
	$(FC) $(FFLAGS) -o $@ -c $< -J $(MODPATH)
#
# Create/update library
#
%.a: $(SUBOBJ)
	$(AR) $(STATLIB) $^
#
# Compile modules
#
%.mod: %.f90
	$(FC) $(FFLAGS) -c $^ -J $(MODPATH)
	@mv ${^F:.f90=.o} $(MODPATH)
#
# Create main executable
#
$(MAINEX): $(OBJ) $(STATLIB) $(MODMOD)
	$(FC) $(FFLAGS) -o $@ $(MODOBJ) $(MAINOBJ) -L$(LIBPATH) -l$(LIB)
#
# `make plot` to create/update the plot
# `make allplots` to create/update all plots
# `make cleanplots` to remove pdf plots
#
plot: $(GRAPHDATA)
	python3 $(GRAPHPROG)
allplots: $(GRAPHDATA)
	@for i in $(ALLGRAPHS); do \
		echo "python3 $$i"; \
		python3 $$i ; \
	done
cleanplots:
	@rm -f $(GRAPHDIR)/plots/*.pdf
#
# Clean
#
clean:
	@rm -f $(STATLIB) $(MODMOD) $(OBJ) *.o main
