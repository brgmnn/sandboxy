class Sandboxy::Language::Javascript
  extend Sandboxy::Language::Base

  self::CMD = 'nodejs'.freeze

  def self.pass(id)
    "console.log('#{id} test passed');"
  end

  def self.fail(id)
    "console.log('#{id} test failed');"
  end

  # hmm how will this work
  # def self.assert(id, &_)
  #   "if (#{yield}) { #{pass(id)} } else { #{fail(id)} }"
  # end
end
