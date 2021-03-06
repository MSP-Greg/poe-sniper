require_relative 'version'

module Poe
  module Sniper
    class AnalyticsData
      def self.app_start(input_hash)
        {
          version: Poe::Sniper::VERSION,
          search_provider: {
            'poetrade': {
              count: input_hash.size,
              items: input_hash.keys
            }
          }
        }
      end

      def self.exception(exception, description: nil, fatal: true)
        {
          version: Poe::Sniper::VERSION,
          type: exception.class,
          message: exception.message,
          origin: exception_origin(exception),
          description: description,
          fatal: fatal
        }
      end

      def self.socket_closed(live_ws_uri, event)
        {
          version: Poe::Sniper::VERSION,
          search_provider: 'poetrade',
          uri: live_ws_uri,
          reason: event.reason,
          code: event.code
        }
      end

      def self.socket_reopened(live_ws_uri)
        {
          version: Poe::Sniper::VERSION,
          search_provider: 'poetrade',
          uri: live_ws_uri
        }
      end

      private

      def self.exception_origin(exception)
        origin = [extract_info_starting_with_filename(exception.backtrace.first)]
        unless exception_coming_from_app(exception)
          app_origin_trace = exception.backtrace.detect{ |x| x.include?('poe/sniper') }
          origin.push(extract_info_starting_with_filename(app_origin_trace)) if app_origin_trace
        end
        origin
      end

      # Trace might contain user specific info (e.g. machine name, folder structure)
      # So we filter to only send the offending line starting with file name
      def self.extract_info_starting_with_filename(trace_line)
        trace_line.split('/').last
      end

      def self.exception_coming_from_app(exception)
        exception.backtrace.first.include?('poe/sniper')
      end
    end
  end
end
