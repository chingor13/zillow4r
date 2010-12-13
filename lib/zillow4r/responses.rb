module Zillow4r
  module Responses
    class Base
      def self.message(message)
        @message = message
      end
      def self.resolution(message)
        @resolution = message
      end
      def message
        self.class.message
      end
      def resolution
        self.class.resolution
      end
    end
    class ServiceError < Base
      message "Service error-there was a server-side error while processing the request"
      resolution "Check to see if your url is properly formed: delimiters, character cases, etc"
    end
    class AccountError < Base
      message "Invalid ZWSID parameter specified-either the account does not exist or was disabled"
      resolution "Check if you have provided a ZWSID in your API call. If yes, check if the ZWSID is keyed in correctly. If it still doesn't work, contact API Network@zillow.com to get help on fixing your ZWSID."
    end
    class UnavailableError < Base
      message "Web services are currently unavailable"
      resolution "The Zillow Web Service is currently not available. Please come back later and try again."
    end
    class ApiUnavailableError < Base
      message "The API call is currently unavailable"
      resolution "The Zillow Web Service is currently not available. Please come back later and try again."
    end

    class DataError < Base; end

    class InvalidAddressError < DataError
      message "Invalid or missing address parameter"
      resolution "Check if the input address matches the format specified in the input parameters table. When inputting a city name, include the state too. A city name alone will not result in a valid address."
    end

    class NoResultsError < DataError
      message "Invalid or missing address parameter"
      resolution "Check if the input address matches the format specified in the input parameters table. When inputting a city name, include the state too. A city name alone will not result in a valid address."
    end

    class ResolveError < DataError
      message "Failed to resolve city, state or ZIP code"
      resolution "Please check to see if the city/state you entered is valid. If you provided a ZIP code, check to see if it is valid."
    end

    class CoverageError < DataError
      message "No coverage for specified area"
      resolution "The specified area is not covered by the Zillow property database. To see our property coverage tables, click here."
    end

    class TimeoutError < DataError
      message "Timeout"
      resolution "Your request timed out. The server could be busy or unavailable. Try again later."
    end

    class AddressTooLongError < DataError
      message "Address string too long"
      resolution "If address is valid, try using abbreviations."
    end

    class NoExactMatchError < DataError
      message "No exact match found."
      resolution "Verify that the given address is correct."
    end
  end
end
