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

SRCS=$(SOURCEDIR)/QD2D.f90 $(SOURCEDIR)/MACHINARY.f90 $(SOURCEDIR)/VARIABLE.f90 $(LIBDIR)/fftpack5.1.f $(LIBDIR)/INTEGRATE.f

EXENAME=runQD2D

OBJS=bin/CONST.o bin/MACHINARY.o bin/VARIABLE.o bin/fftpack5.1.o bin/INTEGRATE.o bin/QD2D.o

$(EXENAME):$(OBJS)
	$(FC) -o $(EXENAME) $(FFLAGS) $(OMPFLAG) $(OBJS)

$(OBJDIR)/%.o : $(SOURCEDIR)/%.f90
	$(FC) $(FFLAGS)  -c -o $@  $<

$(OBJDIR)/%.o : $(LIBDIR)/%.f
	$(FC) $(FFLAGS)  -c -o $@  $<

clean:
	rm -fv $(EXENAME) $(OBJS) *.mod
