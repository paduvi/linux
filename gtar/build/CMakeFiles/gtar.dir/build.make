# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.3

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/taprosoft/gtar

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/taprosoft/gtar/build

# Include any dependencies generated for this target.
include CMakeFiles/gtar.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/gtar.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/gtar.dir/flags.make

src/add_progress.c: vala.stamp


src/extract-dialog.c: src/add_progress.c
	@$(CMAKE_COMMAND) -E touch_nocreate src/extract-dialog.c

src/file_viewer.c: src/add_progress.c
	@$(CMAKE_COMMAND) -E touch_nocreate src/file_viewer.c

src/main.c: src/add_progress.c
	@$(CMAKE_COMMAND) -E touch_nocreate src/main.c

src/progress.c: src/add_progress.c
	@$(CMAKE_COMMAND) -E touch_nocreate src/progress.c

src/properties_window.c: src/add_progress.c
	@$(CMAKE_COMMAND) -E touch_nocreate src/properties_window.c

src/verify_window.c: src/add_progress.c
	@$(CMAKE_COMMAND) -E touch_nocreate src/verify_window.c

vala.stamp: ../src/add_progress.vala
vala.stamp: ../src/extract-dialog.vala
vala.stamp: ../src/file_viewer.vala
vala.stamp: ../src/main.vala
vala.stamp: ../src/progress.vala
vala.stamp: ../src/properties_window.vala
vala.stamp: ../src/verify_window.vala
vala.stamp: ../vapi/config.vapi
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/taprosoft/gtar/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating src/add_progress.c, src/extract-dialog.c, src/file_viewer.c, src/main.c, src/progress.c, src/properties_window.c, src/verify_window.c"
	/usr/bin/valac -C -b /home/taprosoft/gtar -d /home/taprosoft/gtar/build --pkg=atk --pkg=cairo --pkg=gdk-3.0 --pkg=gdk-pixbuf-2.0 --pkg=gio-2.0 --pkg=glib-2.0 --pkg=gobject-2.0 --pkg=gtk+-3.0 --pkg=pango --pkg=pangocairo --pkg=posix --pkg=x11 --thread --target-glib 2.46.1 /home/taprosoft/gtar/src/add_progress.vala /home/taprosoft/gtar/src/extract-dialog.vala /home/taprosoft/gtar/src/file_viewer.vala /home/taprosoft/gtar/src/main.vala /home/taprosoft/gtar/src/progress.vala /home/taprosoft/gtar/src/properties_window.vala /home/taprosoft/gtar/src/verify_window.vala /home/taprosoft/gtar/vapi/config.vapi
	/usr/bin/cmake -E touch vala.stamp

CMakeFiles/gtar.dir/src/add_progress.c.o: CMakeFiles/gtar.dir/flags.make
CMakeFiles/gtar.dir/src/add_progress.c.o: src/add_progress.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/taprosoft/gtar/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/gtar.dir/src/add_progress.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/gtar.dir/src/add_progress.c.o   -c /home/taprosoft/gtar/build/src/add_progress.c

CMakeFiles/gtar.dir/src/add_progress.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/gtar.dir/src/add_progress.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /home/taprosoft/gtar/build/src/add_progress.c > CMakeFiles/gtar.dir/src/add_progress.c.i

CMakeFiles/gtar.dir/src/add_progress.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/gtar.dir/src/add_progress.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /home/taprosoft/gtar/build/src/add_progress.c -o CMakeFiles/gtar.dir/src/add_progress.c.s

CMakeFiles/gtar.dir/src/add_progress.c.o.requires:

.PHONY : CMakeFiles/gtar.dir/src/add_progress.c.o.requires

CMakeFiles/gtar.dir/src/add_progress.c.o.provides: CMakeFiles/gtar.dir/src/add_progress.c.o.requires
	$(MAKE) -f CMakeFiles/gtar.dir/build.make CMakeFiles/gtar.dir/src/add_progress.c.o.provides.build
.PHONY : CMakeFiles/gtar.dir/src/add_progress.c.o.provides

CMakeFiles/gtar.dir/src/add_progress.c.o.provides.build: CMakeFiles/gtar.dir/src/add_progress.c.o


CMakeFiles/gtar.dir/src/extract-dialog.c.o: CMakeFiles/gtar.dir/flags.make
CMakeFiles/gtar.dir/src/extract-dialog.c.o: src/extract-dialog.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/taprosoft/gtar/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/gtar.dir/src/extract-dialog.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/gtar.dir/src/extract-dialog.c.o   -c /home/taprosoft/gtar/build/src/extract-dialog.c

CMakeFiles/gtar.dir/src/extract-dialog.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/gtar.dir/src/extract-dialog.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /home/taprosoft/gtar/build/src/extract-dialog.c > CMakeFiles/gtar.dir/src/extract-dialog.c.i

CMakeFiles/gtar.dir/src/extract-dialog.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/gtar.dir/src/extract-dialog.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /home/taprosoft/gtar/build/src/extract-dialog.c -o CMakeFiles/gtar.dir/src/extract-dialog.c.s

CMakeFiles/gtar.dir/src/extract-dialog.c.o.requires:

.PHONY : CMakeFiles/gtar.dir/src/extract-dialog.c.o.requires

CMakeFiles/gtar.dir/src/extract-dialog.c.o.provides: CMakeFiles/gtar.dir/src/extract-dialog.c.o.requires
	$(MAKE) -f CMakeFiles/gtar.dir/build.make CMakeFiles/gtar.dir/src/extract-dialog.c.o.provides.build
.PHONY : CMakeFiles/gtar.dir/src/extract-dialog.c.o.provides

CMakeFiles/gtar.dir/src/extract-dialog.c.o.provides.build: CMakeFiles/gtar.dir/src/extract-dialog.c.o


CMakeFiles/gtar.dir/src/file_viewer.c.o: CMakeFiles/gtar.dir/flags.make
CMakeFiles/gtar.dir/src/file_viewer.c.o: src/file_viewer.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/taprosoft/gtar/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object CMakeFiles/gtar.dir/src/file_viewer.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/gtar.dir/src/file_viewer.c.o   -c /home/taprosoft/gtar/build/src/file_viewer.c

CMakeFiles/gtar.dir/src/file_viewer.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/gtar.dir/src/file_viewer.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /home/taprosoft/gtar/build/src/file_viewer.c > CMakeFiles/gtar.dir/src/file_viewer.c.i

CMakeFiles/gtar.dir/src/file_viewer.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/gtar.dir/src/file_viewer.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /home/taprosoft/gtar/build/src/file_viewer.c -o CMakeFiles/gtar.dir/src/file_viewer.c.s

CMakeFiles/gtar.dir/src/file_viewer.c.o.requires:

.PHONY : CMakeFiles/gtar.dir/src/file_viewer.c.o.requires

CMakeFiles/gtar.dir/src/file_viewer.c.o.provides: CMakeFiles/gtar.dir/src/file_viewer.c.o.requires
	$(MAKE) -f CMakeFiles/gtar.dir/build.make CMakeFiles/gtar.dir/src/file_viewer.c.o.provides.build
.PHONY : CMakeFiles/gtar.dir/src/file_viewer.c.o.provides

CMakeFiles/gtar.dir/src/file_viewer.c.o.provides.build: CMakeFiles/gtar.dir/src/file_viewer.c.o


CMakeFiles/gtar.dir/src/main.c.o: CMakeFiles/gtar.dir/flags.make
CMakeFiles/gtar.dir/src/main.c.o: src/main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/taprosoft/gtar/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object CMakeFiles/gtar.dir/src/main.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/gtar.dir/src/main.c.o   -c /home/taprosoft/gtar/build/src/main.c

CMakeFiles/gtar.dir/src/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/gtar.dir/src/main.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /home/taprosoft/gtar/build/src/main.c > CMakeFiles/gtar.dir/src/main.c.i

CMakeFiles/gtar.dir/src/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/gtar.dir/src/main.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /home/taprosoft/gtar/build/src/main.c -o CMakeFiles/gtar.dir/src/main.c.s

CMakeFiles/gtar.dir/src/main.c.o.requires:

.PHONY : CMakeFiles/gtar.dir/src/main.c.o.requires

CMakeFiles/gtar.dir/src/main.c.o.provides: CMakeFiles/gtar.dir/src/main.c.o.requires
	$(MAKE) -f CMakeFiles/gtar.dir/build.make CMakeFiles/gtar.dir/src/main.c.o.provides.build
.PHONY : CMakeFiles/gtar.dir/src/main.c.o.provides

CMakeFiles/gtar.dir/src/main.c.o.provides.build: CMakeFiles/gtar.dir/src/main.c.o


CMakeFiles/gtar.dir/src/progress.c.o: CMakeFiles/gtar.dir/flags.make
CMakeFiles/gtar.dir/src/progress.c.o: src/progress.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/taprosoft/gtar/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object CMakeFiles/gtar.dir/src/progress.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/gtar.dir/src/progress.c.o   -c /home/taprosoft/gtar/build/src/progress.c

CMakeFiles/gtar.dir/src/progress.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/gtar.dir/src/progress.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /home/taprosoft/gtar/build/src/progress.c > CMakeFiles/gtar.dir/src/progress.c.i

CMakeFiles/gtar.dir/src/progress.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/gtar.dir/src/progress.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /home/taprosoft/gtar/build/src/progress.c -o CMakeFiles/gtar.dir/src/progress.c.s

CMakeFiles/gtar.dir/src/progress.c.o.requires:

.PHONY : CMakeFiles/gtar.dir/src/progress.c.o.requires

CMakeFiles/gtar.dir/src/progress.c.o.provides: CMakeFiles/gtar.dir/src/progress.c.o.requires
	$(MAKE) -f CMakeFiles/gtar.dir/build.make CMakeFiles/gtar.dir/src/progress.c.o.provides.build
.PHONY : CMakeFiles/gtar.dir/src/progress.c.o.provides

CMakeFiles/gtar.dir/src/progress.c.o.provides.build: CMakeFiles/gtar.dir/src/progress.c.o


CMakeFiles/gtar.dir/src/properties_window.c.o: CMakeFiles/gtar.dir/flags.make
CMakeFiles/gtar.dir/src/properties_window.c.o: src/properties_window.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/taprosoft/gtar/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building C object CMakeFiles/gtar.dir/src/properties_window.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/gtar.dir/src/properties_window.c.o   -c /home/taprosoft/gtar/build/src/properties_window.c

CMakeFiles/gtar.dir/src/properties_window.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/gtar.dir/src/properties_window.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /home/taprosoft/gtar/build/src/properties_window.c > CMakeFiles/gtar.dir/src/properties_window.c.i

CMakeFiles/gtar.dir/src/properties_window.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/gtar.dir/src/properties_window.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /home/taprosoft/gtar/build/src/properties_window.c -o CMakeFiles/gtar.dir/src/properties_window.c.s

CMakeFiles/gtar.dir/src/properties_window.c.o.requires:

.PHONY : CMakeFiles/gtar.dir/src/properties_window.c.o.requires

CMakeFiles/gtar.dir/src/properties_window.c.o.provides: CMakeFiles/gtar.dir/src/properties_window.c.o.requires
	$(MAKE) -f CMakeFiles/gtar.dir/build.make CMakeFiles/gtar.dir/src/properties_window.c.o.provides.build
.PHONY : CMakeFiles/gtar.dir/src/properties_window.c.o.provides

CMakeFiles/gtar.dir/src/properties_window.c.o.provides.build: CMakeFiles/gtar.dir/src/properties_window.c.o


CMakeFiles/gtar.dir/src/verify_window.c.o: CMakeFiles/gtar.dir/flags.make
CMakeFiles/gtar.dir/src/verify_window.c.o: src/verify_window.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/taprosoft/gtar/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building C object CMakeFiles/gtar.dir/src/verify_window.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/gtar.dir/src/verify_window.c.o   -c /home/taprosoft/gtar/build/src/verify_window.c

CMakeFiles/gtar.dir/src/verify_window.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/gtar.dir/src/verify_window.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /home/taprosoft/gtar/build/src/verify_window.c > CMakeFiles/gtar.dir/src/verify_window.c.i

CMakeFiles/gtar.dir/src/verify_window.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/gtar.dir/src/verify_window.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /home/taprosoft/gtar/build/src/verify_window.c -o CMakeFiles/gtar.dir/src/verify_window.c.s

CMakeFiles/gtar.dir/src/verify_window.c.o.requires:

.PHONY : CMakeFiles/gtar.dir/src/verify_window.c.o.requires

CMakeFiles/gtar.dir/src/verify_window.c.o.provides: CMakeFiles/gtar.dir/src/verify_window.c.o.requires
	$(MAKE) -f CMakeFiles/gtar.dir/build.make CMakeFiles/gtar.dir/src/verify_window.c.o.provides.build
.PHONY : CMakeFiles/gtar.dir/src/verify_window.c.o.provides

CMakeFiles/gtar.dir/src/verify_window.c.o.provides.build: CMakeFiles/gtar.dir/src/verify_window.c.o


# Object files for target gtar
gtar_OBJECTS = \
"CMakeFiles/gtar.dir/src/add_progress.c.o" \
"CMakeFiles/gtar.dir/src/extract-dialog.c.o" \
"CMakeFiles/gtar.dir/src/file_viewer.c.o" \
"CMakeFiles/gtar.dir/src/main.c.o" \
"CMakeFiles/gtar.dir/src/progress.c.o" \
"CMakeFiles/gtar.dir/src/properties_window.c.o" \
"CMakeFiles/gtar.dir/src/verify_window.c.o"

# External object files for target gtar
gtar_EXTERNAL_OBJECTS =

gtar: CMakeFiles/gtar.dir/src/add_progress.c.o
gtar: CMakeFiles/gtar.dir/src/extract-dialog.c.o
gtar: CMakeFiles/gtar.dir/src/file_viewer.c.o
gtar: CMakeFiles/gtar.dir/src/main.c.o
gtar: CMakeFiles/gtar.dir/src/progress.c.o
gtar: CMakeFiles/gtar.dir/src/properties_window.c.o
gtar: CMakeFiles/gtar.dir/src/verify_window.c.o
gtar: CMakeFiles/gtar.dir/build.make
gtar: CMakeFiles/gtar.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/taprosoft/gtar/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Linking C executable gtar"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/gtar.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/gtar.dir/build: gtar

.PHONY : CMakeFiles/gtar.dir/build

CMakeFiles/gtar.dir/requires: CMakeFiles/gtar.dir/src/add_progress.c.o.requires
CMakeFiles/gtar.dir/requires: CMakeFiles/gtar.dir/src/extract-dialog.c.o.requires
CMakeFiles/gtar.dir/requires: CMakeFiles/gtar.dir/src/file_viewer.c.o.requires
CMakeFiles/gtar.dir/requires: CMakeFiles/gtar.dir/src/main.c.o.requires
CMakeFiles/gtar.dir/requires: CMakeFiles/gtar.dir/src/progress.c.o.requires
CMakeFiles/gtar.dir/requires: CMakeFiles/gtar.dir/src/properties_window.c.o.requires
CMakeFiles/gtar.dir/requires: CMakeFiles/gtar.dir/src/verify_window.c.o.requires

.PHONY : CMakeFiles/gtar.dir/requires

CMakeFiles/gtar.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/gtar.dir/cmake_clean.cmake
.PHONY : CMakeFiles/gtar.dir/clean

CMakeFiles/gtar.dir/depend: src/add_progress.c
CMakeFiles/gtar.dir/depend: src/extract-dialog.c
CMakeFiles/gtar.dir/depend: src/file_viewer.c
CMakeFiles/gtar.dir/depend: src/main.c
CMakeFiles/gtar.dir/depend: src/progress.c
CMakeFiles/gtar.dir/depend: src/properties_window.c
CMakeFiles/gtar.dir/depend: src/verify_window.c
CMakeFiles/gtar.dir/depend: vala.stamp
	cd /home/taprosoft/gtar/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/taprosoft/gtar /home/taprosoft/gtar /home/taprosoft/gtar/build /home/taprosoft/gtar/build /home/taprosoft/gtar/build/CMakeFiles/gtar.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/gtar.dir/depend

