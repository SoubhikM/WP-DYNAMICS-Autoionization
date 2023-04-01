#Choose your desired complier: ifort/gfortran

FC=ifort

ifeq ($(FC),ifort)
        FFLAGS=-O2 -g -traceback 
else ifeq ($(FC),gfortran)
        FFLAGS=-O2 -g -fbacktrace -w
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
