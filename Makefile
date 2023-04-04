#Choose your desired complier: ifort/gfortran
FC=gfortran#ifort

ifeq ($(FC),ifort)
        FFLAGS=-O2 -g -traceback 
else ifeq ($(FC),gfortran)
# if gfortran version >10, adding '-fallow-argument-mismatch' flag
		GCCVERSIONGTEQ4 := $(shell expr `gcc -dumpversion | cut -f1 -d.` \>= 10)
		CFLAGS=
		ifeq "$(GCCVERSIONGTEQ4)" "1"
    		CFLAGS += -fallow-argument-mismatch
		endif
		
        FFLAGS=-O2 -g -fbacktrace -w $(CFLAGS)
endif

OBJDIR=bin
SOURCEDIR=src
LIBDIR=libs

OMPFLAG=-fopenmp
EXENAME=runQD2D

OBJS=$(OBJDIR)/CONST.o $(OBJDIR)/MACHINARY.o $(OBJDIR)/VARIABLE.o $(OBJDIR)/fftpack5.1.o $(OBJDIR)/INTEGRATE.o $(OBJDIR)/QD2D.o

$(EXENAME):$(OBJS)
	$(FC) -o $(EXENAME) $(FFLAGS) $(OMPFLAG) $(OBJS)

$(OBJDIR)/%.o : $(SOURCEDIR)/%.f90
	$(FC) $(FFLAGS)  -c -o $@  $<

$(OBJDIR)/%.o : $(LIBDIR)/%.f
	$(FC) $(FFLAGS)  -c -o $@  $<

clean:
	rm -fv $(EXENAME) $(OBJS) *.mod
