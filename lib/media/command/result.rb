module Media
  module Command
    class Result

      attr_reader :error, :out, :wait_thread

      def initialize(error, out, wait_thread)
        @error       = error
        @out         = out
        @wait_thread = wait_thread
      end

      def success?
        wait_thread.success?
      end
    end
  end
end
