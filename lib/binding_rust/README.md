# Mathematics Research References
[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![Documentation](https://img.shields.io/badge/docs-reference-blue?style=flat-square)](./documentation.md)

A tree-structured repository for organizing mathematical research references, inspired by Tree-sitter's hierarchical parsing approach.

## Basic Usage

First, navigate the repository structure:

```
references/
├── fields/           # References organized by mathematical field
├── types/            # References organized by document type
└── docs/             # Documentation and guides
```

Then, find references by field:

```
fields/
├── algebraic-geometry.md
├── category-theory.md
├── lie-theory.md
├── symplectic-geometry.md
└── tqft.md
```

Or browse by document type:

```
types/
├── books.md
├── papers.md
├── notes.md
└── preprints.md
```

### Adding References

Once you have the structure, you can add your own references:

```markdown
# Title of Reference

## Metadata
- **Author(s):** Name(s)
- **Year:** Publication year
- **Source:** Journal/Publisher
- **Tags:** #tag1 #tag2 #tag3

## Description
Brief description of the reference.

## Key Points
- Important point 1
- Important point 2
- Important point 3
```

### Editing

To update an existing reference when new information becomes available:

```markdown
## Updates
- **Date:** May 2025
- **Change:** Added new section on related works
- **Notes:** This reference has been updated with recent developments in the field
```

### Organization by Field

The field-based organization allows for quick navigation through mathematical topics:

```markdown
# Algebraic Geometry References

## Overview
Algebraic geometry is the study of geometrical objects defined by polynomial equations.

## Key Books
- [Hartshorne - Algebraic Geometry](../types/books.md#algebraic-geometry)
- [Griffiths & Harris - Principles of Algebraic Geometry](../types/books.md#algebraic-geometry)

## Important Papers
- [Grothendieck & Dieudonné - Éléments de géométrie algébrique](../types/papers.md#algebraic-geometry)
```

## Features

- **Hierarchical Organization** - Tree-structured repository similar to how Tree-sitter parses code
- **Cross-References** - Links between related mathematical concepts and references
- **Searchable** - Easy to find specific references using GitHub search
- **Extensible** - Simple to add new mathematical fields and references
- **Documentation** - Comprehensive guides on how to use and contribute

## Documentation

See [documentation.md](./documentation.md) for full details on the organization system.

## License

This repository is licensed under the GNU Affero General Public License v3.0 - see the [LICENSE](LICENSE) file for details.
