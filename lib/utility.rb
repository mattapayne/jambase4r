module JamBase4R
  module Utility
    
    def log_info(msg)
      JamBase4R.logger.info(msg) if JamBase4R.logger && JamBase4R.logger.respond_to?(:info)
    end
    
    def log_error(msg)
      JamBase4R.logger.error(msg) if JamBase4R.logger && JamBase4R.logger.respond_to?(:error)
    end
    
  end
end