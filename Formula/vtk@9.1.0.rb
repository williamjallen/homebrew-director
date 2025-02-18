# Copyright (c) 2020, Massachusetts Institute of Technology.
# Copyright (c) 2020, Toyota Research Institute.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# * Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Copyright (c) 2009-2020, Homebrew contributors.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

class VtkAT910 < Formula
  desc "Toolkit for 3D computer graphics, image processing, and visualization"
  homepage "https://www.vtk.org/"
  url "https://www.vtk.org/files/release/9.1/VTK-9.1.0.tar.gz"
  sha256 "8fed42f4f8f1eb8083107b68eaa9ad71da07110161a3116ad807f43e5ca5ce96"
  license "BSD-3-Clause"
  revision 4

  bottle do
    root_url "https://drake-homebrew.csail.mit.edu/bottles"
    sha256 big_sur: "956b48fef0519400fbd973a1c3ed3b110614af99ede18d52b9e6c43c50cb8677"
    sha256 monterey: "4c4f04c7269ba002675c145bbd49c1d02f5ae264a2ad18f24fdd6dcd02bdfadb"
    sha256 arm64_monterey: "faf105956f0376ebc8c777c34ebdfe9e9c4c92a92faec7ce8e64888d94a40247"
  end

  keg_only :versioned_formula

  depends_on "cmake" => [:build, :test]
  depends_on "ninja" => :build
  depends_on "double-conversion"
  depends_on "eigen"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "glew"
  depends_on "hdf5"
  depends_on "jpeg"
  depends_on "jsoncpp"
  depends_on "libogg"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "libxml2"
  depends_on "lz4"
  depends_on "netcdf"
  depends_on "pugixml"
  depends_on "sqlite"
  depends_on "theora"
  depends_on "utf8cpp"
  depends_on "xz"
  uses_from_macos "expat"
  uses_from_macos "libxml2"
  uses_from_macos "zlib"

  def install
    # NOTE: these arguments should be the same as
    # drake/tools/workspace/vtk/image/vtk-args.  The exceptions:
    # 1) Request VTK uses macOS Cocoa graphics
    #    VTK_USE_COCOA:BOOL=ON
    #
    # 2) External dependencies added:
    #    VTK_MODULE_USE_EXTERNAL_VTK_pugixml:BOOL=ON
    #    VTK_MODULE_USE_EXTERNAL_VTK_utf8:BOOL=ON
    args = std_cmake_args + %W[
      -DBUILD_SHARED_LIBS:BOOL=ON
      -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON
      -DCMAKE_INSTALL_NAME_DIR:STRING=#{lib}
      -DCMAKE_INSTALL_RPATH:STRING=#{lib}
      -DVTK_USE_COCOA:BOOL=ON
      -DBUILD_TESTING:BOOL=OFF
      -DVTK_ENABLE_WRAPPING:BOOL=OFF
      -DVTK_WRAP_PYTHON:BOOL=OFF
      -DVTK_BUILD_ALL_MODULES:BOOL=OFF
      -DVTK_GROUP_ENABLE_Imaging:STRING=YES
      -DVTK_GROUP_ENABLE_MPI:STRING=DONT_WANT
      -DVTK_GROUP_ENABLE_Qt:STRING=NO
      -DVTK_GROUP_ENABLE_Rendering:STRING=YES
      -DVTK_GROUP_ENABLE_StandAlone:STRING=DONT_WANT
      -DVTK_GROUP_ENABLE_Views:STRING=DONT_WANT
      -DVTK_GROUP_ENABLE_Web:STRING=DONT_WANT
      -DVTK_LEGACY_REMOVE:BOOL=ON
      -DVTK_MODULE_ENABLE_VTK_AcceleratorsVTKmCore:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_AcceleratorsVTKmDataModel:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_AcceleratorsVTKmFilters:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_ChartsCore:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_CommonArchive:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_CommonColor:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_CommonComputationalGeometry:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_CommonCore:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_CommonDataModel:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_CommonExecutionModel:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_CommonMath:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_CommonMisc:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_CommonSystem:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_CommonTransforms:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_DICOMParser:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_DomainsChemistry:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_DomainsChemistryOpenGL2:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_DomainsMicroscopy:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_DomainsParallelChemistry:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersAMR:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersCore:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_FiltersExtraction:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersFlowPaths:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersGeneral:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_FiltersGeneric:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersGeometry:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersHybrid:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersHyperTree:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersImaging:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersModeling:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersOpenTURNS:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersParallel:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersParallelDIY2:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersParallelFlowPaths:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersParallelGeometry:STRING=WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersParallelImaging:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersParallelMPI:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersParallelStatistics:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersParallelVerdict:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersPoints:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersProgrammable:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersReebGraph:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersSMP:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersSelection:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersSources:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_FiltersStatistics:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersTexture:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersTopology:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_FiltersVerdict:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_GUISupportQt:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_GUISupportQtQuick:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_GUISupportQtSQL:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_GeovisCore:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_GeovisGDAL:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOADIOS2:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOAMR:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOAsynchronous:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOCGNSReader:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOCONVERGECFD:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOChemistry:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOCityGML:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOCore:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_IOEnSight:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOExodus:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOExport:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_IOExportGL2PS:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOExportPDF:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOFFMPEG:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOFides:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOGDAL:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOGeoJSON:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOGeometry:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_IOH5Rage:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOH5part:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOHDF:STRING=WANT
      -DVTK_MODULE_ENABLE_VTK_IOIOSS:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOImage:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_IOImport:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_IOInfovis:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOLAS:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOLSDyna:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOLegacy:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOMINC:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOMPIImage:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOMPIParallel:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOMotionFX:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOMovie:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOMySQL:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IONetCDF:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_IOODBC:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOOMF:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOOggTheora:STRING=WANT
      -DVTK_MODULE_ENABLE_VTK_IOOpenVDB:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOPDAL:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOPIO:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOPLY:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOParallel:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOParallelExodus:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOParallelLSDyna:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOParallelNetCDF:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOParallelXML:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOParallelXdmf3:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOPostgreSQL:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOSQL:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOSegY:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOTRUCHAS:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOTecplotTable:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOVPIC:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOVeraOut:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOVideo:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOXML:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOXMLParser:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOXdmf2:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_IOXdmf3:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_ImagingColor:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_ImagingCore:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_ImagingFourier:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_ImagingGeneral:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_ImagingHybrid:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_ImagingMath:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_ImagingMorphological:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_ImagingOpenGL2:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_ImagingSources:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_ImagingStatistics:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_ImagingStencil:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_InfovisBoost:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_InfovisBoostGraphAlgorithms:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_InfovisCore:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_InfovisLayout:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_InteractionImage:STRING=WANT
      -DVTK_MODULE_ENABLE_VTK_InteractionStyle:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_InteractionWidgets:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_ParallelCore:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_ParallelDIY:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_ParallelMPI:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_Python:STRING=NO
      -DVTK_MODULE_ENABLE_VTK_PythonInterpreter:STRING=NO
      -DVTK_MODULE_ENABLE_VTK_RenderingAnnotation:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingContext2D:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_RenderingContextOpenGL2:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingCore:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_RenderingExternal:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingFFMPEGOpenGL2:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingFreeType:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_RenderingFreeTypeFontConfig:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingGL2PSOpenGL2:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingImage:STRING=WANT
      -DVTK_MODULE_ENABLE_VTK_RenderingLICOpenGL2:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingLOD:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingLabel:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingMatplotlib:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_RenderingOpenGL2:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_RenderingOpenVR:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_RenderingParallel:STRING=WANT
      -DVTK_MODULE_ENABLE_VTK_RenderingParallelLIC:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingQt:STRING=NO
      -DVTK_MODULE_ENABLE_VTK_RenderingRayTracing:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingSceneGraph:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingUI:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_RenderingVR:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_RenderingVolume:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingVolumeAMR:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingVolumeOpenGL2:STRING=DEFAULT
      -DVTK_MODULE_ENABLE_VTK_RenderingVtkJS:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_TestingCore:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_TestingGenericBridge:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_TestingIOSQL:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_TestingRendering:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_UtilitiesBenchmarks:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_ViewsContext2D:STRING=WANT
      -DVTK_MODULE_ENABLE_VTK_ViewsCore:STRING=WANT
      -DVTK_MODULE_ENABLE_VTK_ViewsInfovis:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_ViewsQt:STRING=NO
      -DVTK_MODULE_ENABLE_VTK_WebCore:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_WebGLExporter:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_WrappingPythonCore:STRING=NO
      -DVTK_MODULE_ENABLE_VTK_WrappingTools:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_cgns:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_cli11:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_diy2:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_doubleconversion:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_eigen:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_exodusII:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_expat:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_exprtk:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_fides:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_fmt:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_freetype:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_gl2ps:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_glew:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_h5part:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_hdf5:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_ioss:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_jpeg:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_jsoncpp:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_kissfft:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_kwiml:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_libharu:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_libproj:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_libxml2:STRING=WANT
      -DVTK_MODULE_ENABLE_VTK_loguru:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_lz4:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_lzma:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_metaio:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_netcdf:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_octree:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_ogg:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_opengl:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_pegtl:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_png:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_pugixml:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_sqlite:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_theora:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_tiff:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_utf8:STRING=WANT
      -DVTK_MODULE_ENABLE_VTK_verdict:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_vpic:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_vtkm:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_vtksys:STRING=YES
      -DVTK_MODULE_ENABLE_VTK_xdmf2:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_xdmf3:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_zfp:STRING=DONT_WANT
      -DVTK_MODULE_ENABLE_VTK_zlib:STRING=YES
      -DVTK_MODULE_USE_EXTERNAL_VTK_doubleconversion:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_eigen:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_expat:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_exprtk:BOOL=OFF
      -DVTK_MODULE_USE_EXTERNAL_VTK_fmt:BOOL=OFF
      -DVTK_MODULE_USE_EXTERNAL_VTK_freetype:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_glew:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_hdf5:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_jpeg:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_jsoncpp:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_libharu:BOOL=OFF
      -DVTK_MODULE_USE_EXTERNAL_VTK_libxml2:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_lz4:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_lzma:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_netcdf:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_ogg:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_png:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_pugixml:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_sqlite:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_theora:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_tiff:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_utf8:BOOL=ON
      -DVTK_MODULE_USE_EXTERNAL_VTK_zlib:BOOL=ON
    ]

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      cmake_minimum_required(VERSION 3.3 FATAL_ERROR)
      project(Distance2BetweenPoints LANGUAGES CXX)
      find_package(VTK REQUIRED COMPONENTS CommonCore CONFIG)
      add_executable(Distance2BetweenPoints Distance2BetweenPoints.cxx)
      target_link_libraries(Distance2BetweenPoints PRIVATE ${VTK_LIBRARIES})
    EOS

    (testpath/"Distance2BetweenPoints.cxx").write <<~EOS
      #include <cassert>
      #include <vtkMath.h>
      int main() {
        double p0[3] = {0.0, 0.0, 0.0};
        double p1[3] = {1.0, 1.0, 1.0};
        assert(vtkMath::Distance2BetweenPoints(p0, p1) == 3.0);
        return 0;
      }
    EOS

    vtk_dir = Dir[opt_lib/"cmake/vtk-*"].first
    system "cmake", "-DCMAKE_BUILD_TYPE=Debug", "-DCMAKE_VERBOSE_MAKEFILE=ON",
      "-DVTK_DIR=#{vtk_dir}", "."
    system "make"
    system "./Distance2BetweenPoints"
  end
end
