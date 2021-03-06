#
# Copyright:: Copyright (c) 2012-2014 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "libffi"
default_version "3.0.13"

dependency "libgcc"
dependency "libtool"

source :url => "http://pkgs.fedoraproject.org/repo/pkgs/libffi/libffi-3.0.13.tar.gz/45f3b6dbc9ee7c7dfbbbc5feba571529/libffi-3.0.13.tar.gz",
       :md5 => '45f3b6dbc9ee7c7dfbbbc5feba571529'

relative_path "libffi-3.0.13"

env = with_embedded_path()
env = with_standard_compiler_flags(env)

build do
  ship_license "https://raw.githubusercontent.com/atgreen/libffi/master/LICENSE"
  command "./configure --prefix=#{install_dir}/embedded", :env => env
  command "make -j #{workers}", :env => env
  command "make -j #{workers} install", :env => env
  # libffi's default install location of header files is awful...
  copy "#{install_dir}/embedded/lib/libffi-3.0.13/include/*", "#{install_dir}/embedded/include"

  # On 64-bit centos, libffi libraries are places under /embedded/lib64
  # move them over to lib
  if (rhel? || suse?) && _64_bit?
    move "#{install_dir}/embedded/lib64/*", "#{install_dir}/embedded/lib/"
    delete "#{install_dir}/embedded/lib64"
  end
end
