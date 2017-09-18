module Fastlane
  module Actions
    class GooglePlayTrackVersionCodesAction < Action
      # Supply::Options.available_options keys that apply to this action.
      OPTIONS = [
        :package_name,
        :track,
        :key,
        :issuer,
        :json_key,
        :json_key_data,
        :root_url
      ]

      def self.run(params)
        require 'supply'
        require 'supply/options'
        require 'supply/reader'

        Supply.config = params

        Supply::Reader.new.track_version_codes
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Retrieves version codes for a Google Play track"
      end

      def self.details
        "More information: https://github.com/fastlane/fastlane/tree/master/supply"
      end

      def self.available_options
        require 'supply'
        require 'supply/options'

        Supply::Options.available_options.select do |option|
          OPTIONS.include?(option.key)
        end
      end

      def self.output
      end

      def self.return_value
        "Array of integers representing the version codes for the given Google Play track"
      end

      def self.authors
        ["panthomakos"]
      end

      def self.is_supported?(platform)
        platform == :android
      end

      def self.example_code
        [
          'google_play_track_version_codes'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
