class Jets::Commands::Runner
  def self.run(code)
    Jets.eager_load!

    if code =~ %r{^file://}
      path = code.sub('file://', '')
      full_path = "#{Jets.root}#{path}"
      if File.exist?(full_path)
        code = IO.read(full_path)
      else
        puts "ERROR: file not found at #{full_path}".colorize(:red)
        exit 1
      end
    end

    eval(code) # inline script
  end
end