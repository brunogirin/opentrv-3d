#  The OpenTRV project licenses this file to you
#  under the Apache Licence, Version 2.0 (the "Licence");
#  you may not use this file except in compliance
#  with the Licence. You may obtain a copy of the Licence at
#  
#  http://www.apache.org/licenses/LICENSE-2.0
#  
#  Unless required by applicable law or agreed to in writing,
#  software distributed under the Licence is distributed on an
#  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#  KIND, either express or implied. See the Licence for the
#  specific language governing permissions and limitations
#  under the Licence.
#  
#  Author(s) / Copyright (s): Bruno Girin 2013

# --------------------------------
# ---- Primary build targets -----
# --------------------------------

#
# Default target that creates STL files for all objects in
# the repository, including main and playpen areas.
#
all: main

#
# Main boxes. The objects in this list have been printed by a
# number of different people and have been confirmed to be fit
# for purpose.
#
MAIN_OBJECTS =stl/main/boiler_control_relay-rev1.stl
MAIN_OBJECTS+=stl/main/boiler_control_ssr-v0p2_rev1.stl
MAIN_OBJECTS+=stl/main/radiator_control-v0p2_rev1.stl
MAIN_OBJECTS+=stl/main/radiator_control-v0p2_rev2.stl
MAIN_OBJECTS+=stl/main/radiator_control-v0p2_rev3.stl

main: $(MAIN_OBJECTS)

#
# Playpen boxes. The objects in this list are early iterations
# of various boxes or parts thereof. They will be migrated to
# the main area once they have been printed by several people
# and have been confirmed fit for purpose.
#
PLAYPEN_OBJECTS =stl/playpen/box-v0_09.stl
PLAYPEN_OBJECTS+=stl/playpen/box-dd1.stl
PLAYPEN_OBJECTS+=stl/playpen/m30-connector.stl
PLAYPEN_OBJECTS+=stl/playpen/trv-connector.stl

playpen: includes $(PLAYPEN_OBJECTS)

# -----------------------
# ---- Clean targets ----
# -----------------------

clean:
	rm -rf src/include
	rm -rf stl

# --------------------------
# ---- Internal targets ----
# --------------------------

# STL file target

# explicit wildcard expansion suppresses errors when no files are found
include $(wildcard *.deps)

stl/%.stl: src/%.scad
	mkdir -p stl/main
	mkdir -p stl/playpen
	openscad -m make -o $@ -d $@.deps $<

# Includes and dependencies
includes: submodules
	mkdir -p src/include
	submodules/nuts-n-bolts/build.sh
	cp submodules/nuts-n-bolts/build/scad/iso261-extended.scad src/include
	cp submodules/nuts-n-bolts/build/scad/screw.scad src/include

submodules:
	git submodule init
	git submodule update

