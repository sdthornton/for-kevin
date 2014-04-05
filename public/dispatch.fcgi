#!/bin/bash

unset GEM_HOME
unset GEM_PATH
err_log_file="/home/cutthechi/azcutthechi.com/log/dispatch_err.log"
exec ~/.rvm/rubies/ruby-2.0.0-p247/bin/ruby "/home/cutthechi/azcutthechi.com/config/dispatch_fcgi.rb" "$@" 2>>"${err_log_file}"
