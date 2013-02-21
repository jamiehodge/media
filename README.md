# Media

An `ffmpeg` or `avconv` wrapper

## Installation

Install ffmpeg:

    brew install ffmpeg --with-tools --with-libvpx --with-libvorbis --with-libtheora

Add this line to your application's Gemfile:

    gem 'media'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install media

## Usage

Convert:

    conversion = Media.convert do
      options y: true
  
      # this example is slow, due to heavy network usage
      input 'http://www.google.com/images/srpr/logo3w.png' do
        options loop: 1, f: 'image2'
      end
  
      output '/path/to/example.webm' do
        options vcodec: 'libvpx', acodec: 'libvorbis', t: 4
        maps label('video'), label('audio')
        graph do
          chain do
            filter 'negate'
            filter 'hflip' do |f| # optional
              f.outputs 'video'
            end
          end
          chain do
            filter 'aevalsrc' do
              arguments 'sin(440*2*PI*t)' => true
              outputs 'audio'
            end
          end
        end
      end
    end

    conversion.call {|progress| p progress}
    
Probe:

    probe = Media.probe('/path/to/example.mov') do
      options show_frames: true
    end
    
    probe.format
    probe.streams
    probe.streams('audio')
    probe.frames   # requires show_frames option
    probe.metadata # => Hash
    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
