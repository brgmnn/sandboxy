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
  def self.assert(id, &block)
    "if (#{yield}) { #{self.pass(id)} } else { #{self.fail(id)} }"
  end
end
