# encoding: utf-8

#path_to_root = File.dirname(__FILE__)+'/../../'; $LOAD_PATH.unshift(File.expand_path(path_to_root)) unless $LOAD_PATH.include?(path_to_root) || $LOAD_PATH.include?(File.expand_path(path_to_root))
path_to_root = File.dirname(__FILE__)+'/../../'; $LOAD_PATH.unshift(File.expand_path(path_to_root))
#puts $LOAD_PATH
require "common/common"
require "common/init_test"
module Dummy
  $times=0
end
World(Dummy)



