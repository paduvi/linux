#
    # CMakeLists.txt
    # Copyright (C) 2012, 2013, Valama development team
    #
    # Valama is free software: you can redistribute it and/or modify it
    # under the terms of the GNU General Public License as published by the
    # Free Software Foundation, either version 3 of the License, or
    # (at your option) any later version.
    #
    # Valama is distributed in the hope that it will be useful, but
    # WITHOUT ANY WARRANTY; without even the implied warranty of
    # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    # See the GNU General Public License for more details.
    #
    # You should have received a copy of the GNU General Public License along
    # with this program.  If not, see <http://www.gnu.org/licenses/>.
    #

    cmake_minimum_required(VERSION "2.8.4")

    include("${CMAKE_SOURCE_DIR}/cmake/project.cmake")
    include("${CMAKE_SOURCE_DIR}/cmake/Common.cmake")

    project("${project_name}" C)
    string(TOLOWER "${project_name}" project_name_lower)

    set(bindir "bin")
    set(datarootdir "share")
    set(libdir "lib")
    set(includedir "include")
    set(datadir "${datarootdir}/${project_name_lower}")
    set(uidir "${datadir}/ui")
    set(localedir "${datarootdir}/locale")
    set(appdir "${datarootdir}/applications")
    set(gsettingsdir "${datarootdir}/glib-2.0/schemas")
    set(pixrootdir "${datarootdir}/pixmaps")
    set(pixdir "${pixrootdir}/${project_name_lower}")
    set(docdir "${datadir}/doc")
    set(mandir "${datarootdir}/man")
    set(mimedir "${datarootdir}/mime/packages")
    if(CMAKE_INSTALL_PREFIX)
      set(install_prefix "${CMAKE_INSTALL_PREFIX}/")
    else()
      set(install_prefix)
    endif()

    list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/vala")
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

    find_package(Vala "0.20" REQUIRED)
    # Custom library version checks.
    set(definitions)
    set(vapidirs)
    find_package(PkgConfig)
    # config
    list(REMOVE_ITEM required_pkgs "config {nocheck,nolink}")
    # gobject-2.0
    pkg_check_modules(GOBJECT2.0 REQUIRED "gobject-2.0")

    set(default_vala_flags
      "--thread"
      "--target-glib" "${GOBJECT2.0_VERSION}"
    )

    include(ValaPkgs)
    vala_pkgs(VALA_C
      PACKAGES
        ${required_pkgs}
      DEFINITIONS
        ${definitions}
      OPTIONAL
        ${optional_pkgs}
      SRCFILES
        ${srcfiles}  VAPIS
        ${vapifiles}
      OPTIONS
        ${default_vala_flags}
        ${vapidirs}
    )
    # Set common C-macros.
    add_definitions(-DPACKAGE_NAME="${project_name}")
    add_definitions(-DPACKAGE_VERSION="${${project_name}_VERSION}")
    if(project_root)
      add_definitions(-DGETTEXT_PACKAGE="${project_root}")
    else()
      add_definitions(-DGETTEXT_PACKAGE="${project_name_lower}")
    endif()
    add_definitions(-DPACKAGE_DATA_DIR="${install_prefix}${datadir}")
    add_definitions(-DPACKAGE_UI_DIR="${install_prefix}${uidir}")
    add_definitions(-DLOCALE_DIR="${install_prefix}${localedir}")
    add_definitions(-DPIXMAP_DIR="${install_prefix}${pixdir}")
    add_definitions(-DVALA_VERSION="${VALA_SHORTVER}")
    add_executable("${project_name_lower}" ${VALA_C})
    target_link_libraries("${project_name_lower}"
      ${PROJECT_LDFLAGS}
      
    )
    add_definitions(
      ${PROJECT_C_FLAGS}
    )
    install(TARGETS ${project_name_lower} DESTINATION "${bindir}")# Install user interface files if used and copy them to build directory.
    set(uifiles_build)
    foreach(uifile ${uifiles})
      add_custom_command(
        OUTPUT
          "${CMAKE_CURRENT_BINARY_DIR}/${uifile}"
        COMMAND
          "${CMAKE_COMMAND}" -E copy_if_different "${CMAKE_CURRENT_SOURCE_DIR}/${uifile}" "${CMAKE_CURRENT_BINARY_DIR}/${uifile}"
        DEPENDS
          "${CMAKE_CURRENT_SOURCE_DIR}/${uifile}"
        COMMENT ""
      )
      list(APPEND uifiles_build "${CMAKE_CURRENT_BINARY_DIR}/${uifile}")
      install(FILES ${uifile} DESTINATION "${uidir}")
    endforeach()
    add_custom_target("ui_copy_${project_name_lower}" DEPENDS ${uifiles_build})
    add_dependencies("${project_name_lower}" "ui_copy_${project_name_lower}")