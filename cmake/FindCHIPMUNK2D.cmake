#
# Try to find Chipmunk2D libraries and include paths.
# Once done this will define
#
# CHIPMUNK2D_FOUND
# CHIPMUNK2D_INCLUDE_DIR
# CHIPMUNK2D_LIBRARY
#

if(WIN32 AND MSVC_VERSION AND CHIPMUNK2D_MSVC)
	if(MSVC_VERSION EQUAL 1600)
		set (CHIPMUNK2D_VC_PATH ${CHIPMUNK2D_ROOT}/msvc/vc10/chipmunk)
	elseif(MSVC_VERSION EQUAL 1700)
		set (CHIPMUNK2D_VC_PATH ${CHIPMUNK2D_ROOT}/msvc/vc10/chipmunk)
	elseif(MSVC_VERSION EQUAL 1800)
		set (CHIPMUNK2D_VC_PATH ${CHIPMUNK2D_ROOT}/msvc/vc12/chipmunk)
	elseif(MSVC_VERSION EQUAL 1900)
		set (CHIPMUNK2D_VC_PATH ${CHIPMUNK2D_ROOT}/msvc/vc14/chipmunk)
	else()
		set (CHIPMUNK2D_VC_PATH ${CHIPMUNK2D_ROOT}/msvc/vc14/chipmunk)
	endif()

	if(CHIPMUNK2D_STATIC_LIBRARIES)
		set(CHIPMUNK2D_DEBUG_FOLDER /Debug/)
		set(CHIPMUNK2D_RELEASE_FOLDER /Release/)
	elseif(CHIPMUNK2D_SCRT_LIBRARIES)
		set(CHIPMUNK2D_DEBUG_FOLDER "/Debug SCRT/")
		set(CHIPMUNK2D_RELEASE_FOLDER "/Release SCRT/")
	else()
		set(CHIPMUNK2D_DEBUG_FOLDER "/Debug DLL/")
		set(CHIPMUNK2D_RELEASE_FOLDER "/Release DLL/")
	endif()
elseif(CHIPMUNK2D_LIBRARY_DIR)
	set (CHIPMUNK2D_VC_PATH ${CHIPMUNK2D_LIBRARY_DIR})
else()
	set (CHIPMUNK2D_VC_PATH ${CHIPMUNK2D_ROOT}/lib)
endif()

message(STATUS ${CHIPMUNK2D_VC_PATH})

find_path(CHIPMUNK2D_INCLUDE_DIR chipmunk/chipmunk.h
				PATHS ${CHIPMUNK2D_ROOT})
				
if (CHIPMUNK2D_INCLUDE_DIR AND EXISTS "${CHIPMUNK2D_VC_PATH}/")
	set(CHIPMUNK2D_LIBRARY_DEBUG ${CHIPMUNK2D_VC_PATH}${CHIPMUNK2D_DEBUG_FOLDER}chipmunk.lib)
	set(CHIPMUNK2D_LIBRARY_RELEASE ${CHIPMUNK2D_VC_PATH}${CHIPMUNK2D_RELEASE_FOLDER}chipmunk.lib)
	set(CHIPMUNK2D_FOUND TRUE)
	
	if (CHIPMUNK2D_LIBRARY_DEBUG AND CHIPMUNK2D_LIBRARY_RELEASE)
		set(CHIPMUNK2D_LIBRARY 	debug 		${CHIPMUNK2D_LIBRARY_DEBUG}
								optimized 	${CHIPMUNK2D_LIBRARY_RELEASE})
	elseif(CHIPMUNK2D_LIBRARY_DEBUG AND NOT CHIPMUNK2D_LIBRARY_RELEASE)
            # debug and not release
            set(CHIPMUNK2D_LIBRARY 	debug		${CHIPMUNK2D_LIBRARY_DEBUG}
									optimized 	${CHIPMUNK2D_LIBRARY_DEBUG})
    else(CHIPMUNK2D_LIBRARY_RELEASE AND NOT CHIPMUNK2D_LIBRARY_DEBUG)
        # release and not debug
            set(CHIPMUNK2D_LIBRARY 	debug		${CHIPMUNK2D_LIBRARY_RELEASE}
									optimized 	${CHIPMUNK2D_LIBRARY_RELEASE})
    endif()
	
	message(STATUS "Chipmunk2D found in ${CHIPMUNK2D_INCLUDE_DIR}.")
else()
	set(CHIPMUNK2D_FOUND FALSE)
	set(CHIPMUNK2D_LIBRARY "")
	message(STATUS "Chipmunk2D not found, physics code will be disabled.")
endif()

MARK_AS_ADVANCED(CHIPMUNK2D_LIBRARY
				 CHIPMUNK2D_LIBRARY_RELEASE
				 CHIPMUNK2D_LIBRARY_DEBUG)
