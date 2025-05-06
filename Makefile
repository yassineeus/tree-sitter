VERSION := 1.0.0
DESCRIPTION := A tree-structured collection of mathematical research references
HOMEPAGE_URL := https://github.com/yassineeus/tree-sitter-reference

# Install directory layout
PREFIX ?= /usr/local
DOCDIR ?= $(PREFIX)/share/doc
RESOURCEDIR ?= $(PREFIX)/share/math-references

# Directories
FIELDSDIR := references/fields
TYPESDIR := references/types
DOCSDIR := docs
NOTESDIR := references/notes

# Files
README := README.md
LICENSE := LICENSE
DOCUMENTATION := documentation.md

# Define default targets
all: check-structure create-index

# Check if all required directories exist
check-structure:
	@echo "Checking repository structure..."
	@test -d $(FIELDSDIR) || mkdir -p $(FIELDSDIR)
	@test -d $(TYPESDIR) || mkdir -p $(TYPESDIR)
	@test -d $(DOCSDIR) || mkdir -p $(DOCSDIR)
	@test -d $(NOTESDIR) || mkdir -p $(NOTESDIR)
	@echo "Repository structure OK"

# Create index files for each directory
create-index: index-fields index-types index-docs

# Generate index for fields
index-fields:
	@echo "Creating fields index..."
	@echo "# Mathematical Fields Index\n" > $(FIELDSDIR)/index.md
	@echo "List of all mathematical fields covered in this reference collection:\n" >> $(FIELDSDIR)/index.md
	@for file in $$(find $(FIELDSDIR) -type f -name "*.md" ! -name "index.md"); do \
		name=$$(basename $$file .md); \
		title=$$(grep -m 1 "^# " $$file | sed 's/^# //'); \
		if [ -n "$$title" ]; then \
			echo "- [$$title]($$name.md)" >> $(FIELDSDIR)/index.md; \
		else \
			echo "- [$$name]($$name.md)" >> $(FIELDSDIR)/index.md; \
		fi; \
	done
	@echo "Fields index created"

# Generate index for types
index-types:
	@echo "Creating types index..."
	@echo "# Reference Types Index\n" > $(TYPESDIR)/index.md
	@echo "List of all reference types available in this collection:\n" >> $(TYPESDIR)/index.md
	@for file in $$(find $(TYPESDIR) -type f -name "*.md" ! -name "index.md"); do \
		name=$$(basename $$file .md); \
		title=$$(grep -m 1 "^# " $$file | sed 's/^# //'); \
		if [ -n "$$title" ]; then \
			echo "- [$$title]($$name.md)" >> $(TYPESDIR)/index.md; \
		else \
			echo "- [$$name]($$name.md)" >> $(TYPESDIR)/index.md; \
		fi; \
	done
	@echo "Types index created"

# Generate index for documentation
index-docs:
	@echo "Creating documentation index..."
	@echo "# Documentation Index\n" > $(DOCSDIR)/index.md
	@echo "List of all documentation guides:\n" >> $(DOCSDIR)/index.md
	@for file in $$(find $(DOCSDIR) -type f -name "*.md" ! -name "index.md"); do \
		name=$$(basename $$file .md); \
		title=$$(grep -m 1 "^# " $$file | sed 's/^# //'); \
		if [ -n "$$title" ]; then \
			echo "- [$$title]($$name.md)" >> $(DOCSDIR)/index.md; \
		else \
			echo "- [$$name]($$name.md)" >> $(DOCSDIR)/index.md; \
		fi; \
	done
	@echo "Documentation index created"

# Create a new reference entry
new-reference:
	@read -p "Reference type (book/paper/note): " type; \
	read -p "Field: " field; \
	read -p "Title: " title; \
	read -p "Author: " author; \
	read -p "Year: " year; \
	slug=$$(echo $$title | tr '[:upper:]' '[:lower:]' | tr ' ' '-'); \
	filename=""; \
	if [ "$$type" = "book" ]; then \
		filename="$(TYPESDIR)/books/$$slug.md"; \
	elif [ "$$type" = "paper" ]; then \
		filename="$(TYPESDIR)/papers/$$slug.md"; \
	elif [ "$$type" = "note" ]; then \
		filename="$(NOTESDIR)/$$slug.md"; \
	else \
		echo "Unknown type. Exiting."; \
		exit 1; \
	fi; \
	mkdir -p $$(dirname $$filename); \
	echo "# $$title\n" > $$filename; \
	echo "## Metadata" >> $$filename; \
	echo "- **Author(s):** $$author" >> $$filename; \
	echo "- **Year:** $$year" >> $$filename; \
	echo "- **Field:** $$field" >> $$filename; \
	echo "- **Tags:** #$$field #$$type" >> $$filename; \
	echo "\n## Description\n" >> $$filename; \
	echo "Add a brief description here.\n" >> $$filename; \
	echo "## Key Points\n" >> $$filename; \
	echo "- Important point 1" >> $$filename; \
	echo "- Important point 2" >> $$filename; \
	echo "- Important point 3\n" >> $$filename; \
	echo "## Notes\n" >> $$filename; \
	echo "Your personal notes about this reference.\n" >> $$filename; \
	echo "Created new reference at $$filename"

# Install the references to the system
install:
	@echo "Installing mathematics references to $(RESOURCEDIR)..."
	install -d '$(DESTDIR)$(RESOURCEDIR)'
	install -d '$(DESTDIR)$(DOCDIR)/math-references'
	cp -r $(FIELDSDIR) '$(DESTDIR)$(RESOURCEDIR)'/
	cp -r $(TYPESDIR) '$(DESTDIR)$(RESOURCEDIR)'/
	cp -r $(DOCSDIR) '$(DESTDIR)$(DOCDIR)/math-references/'
	cp -r $(NOTESDIR) '$(DESTDIR)$(RESOURCEDIR)'/
	install -m644 $(README) '$(DESTDIR)$(DOCDIR)/math-references/'
	install -m644 $(LICENSE) '$(DESTDIR)$(DOCDIR)/math-references/'
	install -m644 $(DOCUMENTATION) '$(DESTDIR)$(DOCDIR)/math-references/'
	@echo "Installation complete"

# Uninstall from the system
uninstall:
	$(RM) -r '$(DESTDIR)$(RESOURCEDIR)'
	$(RM) -r '$(DESTDIR)$(DOCDIR)/math-references'

# Clean generated files
clean:
	$(RM) $(FIELDSDIR)/index.md
	$(RM) $(TYPESDIR)/index.md
	$(RM) $(DOCSDIR)/index.md

# Development targets
validate:
	@echo "Validating Markdown files..."
	@for file in $$(find . -type f -name "*.md"); do \
		if ! grep -q "^# " $$file; then \
			echo "WARNING: $$file has no title (# Title)"; \
		fi; \
	done
	@echo "Validation complete"

# Check for broken links
check-links:
	@echo "Checking for broken internal links..."
	@for file in $$(find . -type f -name "*.md"); do \
		for link in $$(grep -o "\[.*\]([^)]*)" $$file | sed 's/.*(\(.*\))/\1/'); do \
			if [[ $$link != http* ]] && [[ $$link != www* ]]; then \
				target=$$(echo $$link | cut -d'#' -f1); \
				if [[ -n $$target ]] && [[ ! -f $$target ]] && [[ ! -f $$(dirname $$file)/$$target ]]; then \
					echo "Broken link in $$file: $$link"; \
				fi; \
			fi; \
		done; \
	done
	@echo "Link check complete"

.PHONY: all check-structure create-index index-fields index-types index-docs new-reference install uninstall clean validate check-links
