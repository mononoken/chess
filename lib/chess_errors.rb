# frozen_string_literal: true

module ChessErrors
  class EmptyOriginError < StandardError
    def message
      "Move sent to an empty origin."
    end
  end

  class InvalidOriginError < StandardError
    def message
      "Invalid origin selected."
    end
  end

  class InvalidDestinationError < StandardError
    def message
      "Invalid destination selected."
    end
  end

  class InvalidNotationError < StandardError
    def message
      "Invalid notation selected."
    end
  end
end
