# https://github.com/kdewald/itba-e3-verilog-snippets/blob/master/08-counter/makefile

# project name (generate executable with this name)
TARGET   = fsm

GTKWAVE = gtkwave
VCD_OUTPUT = output.vcd

EXECUTOR = vvp
COMPILER = iverilog
CFLAGS   = 

STDDIR   = standard_modules
TSTDIR   = tests
TGTMOD   = modules/fsm_sequence_mux.v # change with ..._fancy.v for the other style
BINDIR   = bin

STD_SOURCES  := $(wildcard $(STDDIR)/*.v)
TST_SOURCES  := $(wildcard $(TSTDIR)/*.v)
OBJECTS      := $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
rm           = rm -f

$(BINDIR)/$(TARGET): $(SOURCES)
	@mkdir -p bin
	@$(COMPILER) $(STD_SOURCES) $(TST_SOURCES) $(TGTMOD) $(CFLAGS) -o $@
	@echo "Compilation complete!"

.PHONY: run
run: $(BINDIR)/$(TARGET)
	@echo "Running simulation!"
	@$(EXECUTOR) $(BINDIR)/$(TARGET) +VCD_PATH=$(BINDIR)/$(VCD_OUTPUT)

.PHONY: view
view: run
	@echo "Viewing simulation!"
	@$(GTKWAVE) $(BINDIR)/$(VCD_OUTPUT) >/dev/null 2>&1 &

.PHONY: clean
clean: 
	@$(rm) $(BINDIR)/$(TARGET)
	@echo "Executable removed!"

.PHONY: clean
purge: clean
	@$(rm) -rf $(BINDIR)
	@echo "Purge complete!"
