module Quandl
  module ProjectRoot
    # Borrowed from https://github.com/rspec/rspec-core/blob/master/lib/rspec/core/ruby_project.rb

    def self.root
      @project_root ||= determine_root
    end

    def self.determine_root
      find_first_parent_containing('lib') || '.'
    end

    def self.find_first_parent_containing(dir)
      ascend_until { |path| File.exist?(File.join(path, dir)) }
    end

    def self.ascend_until
      fs = File::SEPARATOR
      escaped_slash = "\\#{fs}"
      special = "_ESCAPED_SLASH_"
      project_path = File.expand_path(".")
      parts = project_path.gsub(escaped_slash, special).squeeze(fs).split(fs).map do |x|
        x.gsub(special, escaped_slash)
      end

      until parts.empty?
        path = parts.join(fs)
        path = fs if path == ""
        return path if yield(path)
        parts.pop
      end
    end
  end
end
