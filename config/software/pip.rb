#
# Copyright:: Copyright (c) 2013-2014 Chef Software, Inc.
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

name "pip"
default_version "8.1.2"

dependency "setuptools"

source :url => "https://github.com/pypa/pip/archive/#{version}.tar.gz",
       :md5 => 'f65cbd43e06f4444ff66c25721a9ba02'

relative_path "pip-#{version}"

build do
  ship_license "https://raw.githubusercontent.com/pypa/pip/develop/LICENSE.txt"
  command "#{install_dir}/embedded/bin/python setup.py install --prefix=#{install_dir}/embedded"
end
