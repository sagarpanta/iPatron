## www.pubnub.com - PubNub realtime push service in the cloud.
## http://www.pubnub.com/blog/ruby-push-api - Ruby Push API Blog

## PubNub Real Time Push APIs and Notifications Framework
## Copyright (c) 2010 Stephen Blum
## http://www.pubnub.com/

## -----------------------------------
## PubNub 3.0 Real-time Push Cloud API
## -----------------------------------


##including required libraries
require 'openssl'
require 'base64'
require 'open-uri'
require 'uri'
require 'net/http'
require 'json'
require 'pp'
require 'rubygems'
require 'securerandom'
require 'digest'
require 'PubnubCrypto.rb'

class Pubnub
    MAX_RETRIES = 3
retries=0
    
    #* Pubnub
    #*
    #* Init the Pubnub Client API
    #*
    #* @param string publish_key required key to send messages.
    #* @param string subscribe_key required key to receive messages.
    #* @param string secret_key required key to sign messages.
    #*@param string cipher_key required to encrypt messages.
    #* @param boolean ssl required for 2048 bit encrypted messages.
    #*
    def initialize( publish_key, subscribe_key, secret_key, cipher_key, ssl_on = false)
        @publish_key   = publish_key
        @subscribe_key = subscribe_key
        @secret_key    = secret_key
        @cipher_key    = cipher_key
        @ssl           = ssl_on
        @origin        = 'pubsub.pubnub.com'
        @limit         = 1800

        if @ssl
            @origin = 'https://' + @origin
        else
            @origin = 'http://'  + @origin
        end

        uri         = URI.parse(@origin)
        http        = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = ssl_on
        @connection = http.start()
        
        puts('Connection done')
        
    end

    
    #* UUID
    #*
    #* Unique identifier generation
    #* @Return Unique Identifier
    #*    
    def UUID()
        uuid=SecureRandom.base64(32).gsub("/","_").gsub(/=+$/,"")
    end

    
    #* Publish
    #*
    #* Send a message to a channel.
    #*
    #* @param array args with channel and message.
    #* @return array success information.
    
    def publish(args)
    
      ## Fail if bad input.
      if !(args['channel'] && args['message'])
          puts('Missing Channel or message')
          return false
      end

      ## Capture User Input
          channel = args['channel']
          message = args['message'].to_json
          puts message
        
        #encryption of message
       if @cipher_key.length > 0
            pubnubcrypto=PubnubCrypto.new('cipher_key')
            message=message.chop.reverse.chop.reverse()
            puts('message is->'+message)
            message=pubnubcrypto.encrypt(message)
            puts('Encrypted message->'+message)
            message = message.strip
            message = '"' +message+ '"'
       end   
       
        ## Sign message using HMAC
            String signature = '0'

         if @secret_key.length > 0
            signature = "{@publish_key,@subscribe_key,@secret_key,channel,message}" 
            digest = OpenSSL::Digest.new("sha256")
            key = [ @secret_key ]
            hmac = OpenSSL::HMAC.hexdigest(digest, key.pack("H*"), signature)
            signature = hmac
         end
            puts "signature >> "+signature
  
            
            ##If message length is greater than limit output fails              
          if message.length > @limit
            puts('message TOO LONG (' + @limit.to_s + ' LIMIT)')
          return [ 0, 'message Too Long.' ]
          end

          ## Send message
          return self._request([
            'publish',
            @publish_key,
            @subscribe_key,
            signature,
            channel,
            '0',
            message,])
   end
  
     
    #* Subscribe
    #*
    #* This is BLOCKING.
    #* Listen for a message on a channel.
    #*
    #* @param array args with channel and message.
    #* @return false on fail, array on success.
    #*
    def subscribe(args)
       ## Capture User Input
        channel   = args['channel']
        callback  = args['callback']
          
        ## Fail if missing channel
        if !channel
            puts "Missing Channel."
            return false
        end

        ## Fail if missing callback
        if !callback
            puts "Missing Callback."
            return false
        end
        
        ## Begin Subscribe
        loop do
            begin
                timetoken = args['timetoken'] ? args['timetoken'] : 0

                ## Wait for message
                response = self._request([
                    'subscribe',
                    @subscribe_key,
                    channel,
                    '0',
                    timetoken.to_s])
                    messages          = response[0]
                    args['timetoken'] = response[1]
   
                ## If it was a timeout
                next if !messages.length

                ## Run user Callback and Reconnect if user permits.
                ##Capture the message and encrypt it
                    messages.each do |message|
                    pc = PubnubCrypto.new('cipher_key')
                    message = pc.decrypt(message)
                    if !callback.call(message)
                        return 
                    end
                end
            rescue  Timeout::Error
            rescue
                    sleep(1)
                    end
        end
    end
    
    
    #* History
    #*
    #* Load history from a channel.
    #*
    #* @param array args with 'channel' and 'limit'.
    #* @return mixed false on fail, array on success.
    #*
    def history(args)
            ## Capture User Input
        limit   = +args['limit'] ? +args['limit'] : 15
        channel = args['channel']
         
          ## Fail if bad input.
        if (!channel)
            puts 'Missing Channel.'
            return false
        end

          ## Get History
          response = self._request([ 'history', @subscribe_key,channel,'0',limit.to_s])
          myarr=Array.new()
          response.each do |message|
          pc = PubnubCrypto.new('cipher_key')
          message = pc.decrypt(message)
          myarr.push(message)
        end
      return myarr
    end
   
    #* Time
    #*
    #* Timestamp from PubNub Cloud.
    #*
    #* @return int timestamp.
    #*
    def time()
        return self._request([
            'time',
            '0'
        ])[0]
    end

    #* Request URL
    #*
    #* @param array request of url directories.
    #* @return array from JSON response.
    #*
    def _request(request)
        ## Construct Request URL
        url = '/' + request.map{ |bit| bit.split('').map{ |ch|
            ' ~`!@#$%^&*()+=[]\\{}|;\':",./<>?'.index(ch) ?
            '%' + ch.unpack('H2')[0].to_s.upcase : URI.encode(ch)
        }.join('') }.join('/')
      
        puts(' URL==> '+url)
        
        response = send_with_retries(url,MAX_RETRIES )
        JSON.parse(response)
    end

    private
      def send_with_retries(url, retries)
      tries = 0

      begin
        @connection.get(url).body
        rescue

        tries += 1
        tries < retries ? retry : raise
      end

    end
end