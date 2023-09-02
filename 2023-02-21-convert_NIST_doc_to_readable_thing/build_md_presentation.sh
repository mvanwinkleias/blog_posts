#!/bin/bash

mkdir -p build
grep -vE '\s*>' > build/ssdf_presentation.md
