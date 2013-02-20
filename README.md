# Media

An `ffmpeg` or `avconv` wrapper

## Installation

Add this line to your application's Gemfile:

    gem 'media'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install media

## Usage

    conversion = Media.convert do
      options y: true
  
      input 'http://www.google.com/images/srpr/logo3w.png' do
        options loop: 1, f: 'image2'
      end
  
      output '/path/to/test2.webm' do
        options vcodec: 'libvpx', acodec: 'libvorbis', t: 4
        maps label('video'), label('audio')
        graph do
          chain do
            filter 'negate'
            filter 'hflip' do
              outputs 'video'
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

Outputs:    

    ffmpeg -v info -y -loop 1 -f image2 -i http://www.google.com/images/srpr/logo3w.png -vcodec libvpx -acodec libvorbis -t 4 -map [video] -map [audio] -filter_complex negate, hflip [video]; aevalsrc=sin(440*2*PI*t) [audio] /path/to/test2.webm
    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
