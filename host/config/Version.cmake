#
# Copyright 2010 Ettus Research LLC
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

########################################################################
# Setup Version Numbers
########################################################################
SET(UHD_VERSION_MAJOR 0)
SET(UHD_VERSION_MINOR 0)
SET(UHD_VERSION_PATCH 0)

########################################################################
# Find GIT to get repo information
########################################################################
MESSAGE(STATUS "Checking for git")
FIND_PROGRAM(GIT git)
IF(${GIT} STREQUAL "GIT-NOTFOUND")
    MESSAGE(STATUS "Checking for git - not found")
ELSE(${GIT} STREQUAL "GIT-NOTFOUND")
    MESSAGE(STATUS "Checking for git - found")

    #grab the git log entry for the current head
    EXECUTE_PROCESS(
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMAND ${GIT} log HEAD~..HEAD --date=raw
        OUTPUT_VARIABLE _git_log OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    #extract the timestamp from the git log entry
    EXECUTE_PROCESS(
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMAND ${PYTHON_EXECUTABLE} -c "import re; print re.match('^.*Date:\\s*(\\d*).*$', '''${_git_log}''', re.MULTILINE | re.DOTALL).groups()[0]"
        OUTPUT_VARIABLE _git_timestamp OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    #format the timestamp into YYYY-MM-DD
    EXECUTE_PROCESS(
        COMMAND ${PYTHON_EXECUTABLE} -c "import time; print time.strftime('%Y%m%d', time.gmtime(${_git_timestamp}))"
        OUTPUT_VARIABLE _git_date OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    SET(UHD_VERSION_MAJOR ${_git_date})

    #format the timestamp into HH-MM-SS
    EXECUTE_PROCESS(
        COMMAND ${PYTHON_EXECUTABLE} -c "import time; print time.strftime('%H%M%S', time.gmtime(${_git_timestamp}))"
        OUTPUT_VARIABLE _git_time OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    SET(UHD_VERSION_MINOR ${_git_time})

    #grab the git ref id for the current head
    EXECUTE_PROCESS(
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMAND ${GIT} rev-parse --short HEAD
        OUTPUT_VARIABLE _git_rev OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    SET(UHD_VERSION_PATCH ${_git_rev})

ENDIF(${GIT} STREQUAL "GIT-NOTFOUND")