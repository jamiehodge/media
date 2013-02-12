# Media

An `ffmpeg` or `avconv` wrapper

## Installation

Add this line to your application's Gemfile:

    gem 'media'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install foo

## Usage

    Media.convert do
      option 'v', 'warning'
  
      input 'in1.mov'
  
      input 'in2.mov' do
        option 'foo', 'bar'
      end
  
      output 'out.mov' do
        graph do
          chain do
            filter 'split' do
              input 'in'
              output 'T1'
            end
            filter 'fifo'
            filter 'overlay' do
              input 'T2'
              arg '0'
              arg 'H/2'
              output 'out'
            end
          end
          chain do
            filter 'fifo' do
              input 'T1'
            end
            filter 'crop' do
              arg 'iw'
              arg 'ih/2'
              arg '0'
              arg 'ih/2'
            end
            filter 'vflip' do
              output 'T2'
            end
          end
        end
    
        map 'out'
    
        option 'f', 'prores'
      end
    end
    
Outputs:    

    ffmpeg -v warning -i in1.mov -foo bar -i in2.mov -filter_complex "[in] split [T1], fifo, [T2] overlay=0:H/2 [out]; [T1] fifo, crop=iw:ih/2:0:ih/2, vflip [T2]" -map out -f prores out.mov

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
