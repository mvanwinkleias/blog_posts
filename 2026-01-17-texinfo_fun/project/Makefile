SRC_DIR := src
TGT_DIR := build
SRC_EXT := texi
TGT_EXT := info
CONVERTER := makeinfo

reading_entry_point := main

# Find all source files recursively
# The 'shell' function executes the find command and captures its output
SRC_FILES := $(shell find $(SRC_DIR) -name '*.$(SRC_EXT)')

# Generate corresponding target file names in the target directory
# This uses string substitution: for each source file, replace SRC_DIR with TGT_DIR and SRC_EXT with TGT_EXT
TGT_FILES := $(patsubst $(SRC_DIR)/%.$(SRC_EXT),$(TGT_DIR)/%.$(TGT_EXT),$(SRC_FILES))

.PHONY: all clean

all: $(TGT_FILES)
	@echo "Conversion complete."

# Rule to create necessary subdirectories in the target tree
# 'sort' and 'dir' functions get unique directory names from the target files
# 'mkdir -p' creates directories and parents as needed
$(TGT_FILES): | $(sort $(dir $(TGT_FILES)))

$(sort $(dir $(TGT_FILES))):
	@mkdir -p $@

# Generic rule for converting files
# $@ is the target file, $< is the first prerequisite (source file)
# The command uses the defined converter
$(TGT_DIR)/%.$(TGT_EXT): $(SRC_DIR)/%.$(SRC_EXT)
	@echo "Converting $< to $@"
	$(CONVERTER) $< -o $@

read:
	info $(TGT_DIR)/main

clean:
	@echo "Cleaning up..."
	@rm -rf $(TGT_DIR)
