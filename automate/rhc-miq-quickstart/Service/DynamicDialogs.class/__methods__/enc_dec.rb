#  list_flavors.rb
#
#  Author: Jeff Warnica <jwarnica@redhat.com>
#
#  Description: Method to build a drop down of the flavors configured in flavours.rb
#
# ------------------------------------------------------------------------------
#    Copyright 2018 Jeff Warnica <jwarnica@redhat.com>
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
# ------------------------------------------------------------------------------

module RhcMiqQuickstart
  module Automate
    module Service
      module DynamicDialogs
        class EncDec

          require 'manageiq-password'
          include RedHatConsulting_Utilities::StdLib::Core

          def initialize(handle = $evm)
            @handle = handle
            @DEBUG = true
            @tier = @handle.root['tier']
            dump_root() if @DEBUG

          end

          def main()
            log(:info, 'Start ' + self.class.to_s + '.' + __method__.to_s)


            if @handle.root['tier'] == 'enc'
              value =  MiqPassword::encrypt(@handle.root['dialog_dialog_0_cleartext'])
            elsif @handle.root['tier'] == 'dec'
              value = 'new decrypted value!'
            else
              error("I can't [#{@handle.root['tier']}]")
            end

            @handle.object['default_value'] =  @handle.object['value'] = value

            log(:info, 'Finishing ' + self.class.to_s + '.' + __method__.to_s)
          end

        end
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  RhcMiqQuickstart::Automate::Service::DynamicDialogs::EncDec.new.main()
end

