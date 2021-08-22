project "shaderc"

	-- Output Directories --
	location "%{wks.location}/Dependencies/shaderc"

	targetdir (target_dir)
	objdir    (object_dir)

	-- Compiler --
	kind "StaticLib"
	language "C++"

	-- Project Files ---
	files
	{
		-- source
		"libshaderc/src/shaderc.cc",
		"libshaderc_util/src/**.cc",
		
		-- headers
		"libshaderc/include/shaderc/**.h**",
		"libshaderc_util/include/libshaderc_util/**.h**",

		-- build.lua
		"%{prj.location}/build.lua",
	}

	excludes
	{
		"libshaderc_util/src/**test.cc",
	}
	
	-- Includes --
	includedirs
	{
		"%{prj.location}/",
		"%{prj.location}/libshaderc/include",
		"%{prj.location}/libshaderc_util/include",

		"%{include_dirs.vulkan_sdk}",
		"%{include_dirs.glslang}",
		"%{include_dirs.spirv}",
	}

	-- Libraries --
	libdirs
	{
		"%{lib_dirs.vulkan_sdk}",
	}

	-- Links --
	links
	{
		"glslang",
		"%{libs.spirv_tools}"
	}

	--- Filters ---
	-- windows
	filter "system:windows"
		systemversion "latest"
		staticruntime "On"

		defines 
		{ 
			"_CRT_SECURE_NO_WARNINGS",
			"ENABLE_HLSL"
		}

		flags { "MultiProcessorCompile" }

	-- debug
	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	-- release
	filter "configurations:Release"
		runtime "Release"
		optimize "on"

	-- distribution
	filter "configurations:Distribution"
		runtime "Release"
		optimize "full"