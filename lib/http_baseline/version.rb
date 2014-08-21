module HttpBaseline
  module Version
    MAJOR, MINOR, PATCH, PRE = 2, 0, 2
    STRING                   = [MAJOR, MINOR, PATCH, PRE].compact.join('.')
  end

  VERSION = Version::STRING
end
