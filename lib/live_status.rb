require 'socket'
module LiveStatus
  module ClassMethods

    def get_hosts(options = {})
      results = query_socket("GET hosts\n#{options.map {|k,v| "#{k}:#{v}\n"}.join}OutputFormat: wrapped_json\n\n")

      if options.has_key? :Columns
        columns = options[:Columns].split(' ')
      else
        columns = results['columns'].flatten
      end

      results['data'].map {|d| Hash[d.each_with_index.map {|r, i| [columns[i], r]}]}
    end

    def get_host(id, options = {})
      results = query_socket("GET hosts\n#{options.map {|k,v| "#{k}:#{v}\n"}.join}Filter: id = #{id}\nOutputFormat: wrapped_json\n\n")

      if options.has_key? :Columns
        columns = options[:Columns].split(' ')
      else
        columns = results['columns'].flatten
      end

      results['data'].map {|d| Hash[d.each_with_index.map {|r, i| [columns[i], r]}]}.first
    end

    private
      def query_socket(query)
        socket = UNIXSocket.new('/var/cache/naemon/live')
        socket.puts(query)
        results = ''
        while(line = socket.gets) do
          results += line
        end
        return JSON.parse(results)
      end
  end
end
