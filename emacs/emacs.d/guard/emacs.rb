require 'rbconfig'

module Guard
  module Notifier

    # Send a notification to Emacs with emacsclient (http://www.emacswiki.org/emacs/EmacsClient).
    #
    # @example Add the `:emacs` notifier to your `Guardfile`
    #   notification :emacs
    #
    module Emacs
      extend self

      DEFAULTS = {
        :client  => 'emacsclient',
      }

      # Test if Emacs with running server is available.
      #
      # @param [Boolean] silent true if no error messages should be shown
      # @return [Boolean] the availability status
      #
      def available?(silent = false)
        result = `#{ DEFAULTS[:client] } --eval "(require 'guard)" 2> /dev/null || echo 'N/A'`

        if result.chomp! == 'N/A'
          false
        else
          true
        end
      end

      # Show a system notification.
      #
      # @param [String] type the notification type. Either 'success', 'pending', 'failed' or 'notify'
      # @param [String] title the notification title
      # @param [String] message the notification message body
      # @param [String] image the path to the notification image
      # @param [Hash] options additional notification library options
      # @option options [String] client the client to use for notification (default is 'emacsclient')
      # @option options [String, Integer] priority specify an int or named key (default is 0)
      #
      def notify(type, title, message, image, options = { })
        options = DEFAULTS.merge options
        message = message.gsub('"', "'");
        system(options[:client], "--eval", "(guard-notify \"#{ type }\" \"#{ title }\" \"#{ message }\")")
      end
    end
  end
end
