module HttpBaseline
  module Version
    MAJOR, MINOR, PATCH, PRE = 2, 0, 1
    STRING                   = [MAJOR, MINOR, PATCH, PRE].compact.join('.')
  end

  VERSION = Version::STRING
end
