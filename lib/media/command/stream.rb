module Media
  module Command
    class Stream
      
      attr_reader :buffer, :io
      
      def initialize(io)
        @io     = io
        @buffer = '' 
      end
      
      alias to_io io
      alias to_s  buffer
      
      def handle_read(&block)
        buffer << io.read_nonblock(4096).tap do |data| 
          block.call(data.strip) if block
        end
      rescue IO::WaitReadable
      rescue EOFError, Errno::ECONNRESET
      end
    end
  end
end