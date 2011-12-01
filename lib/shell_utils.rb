require "shell_utils/version"

module ShellUtils
  extend self
  
  def sh(cmd, base = nil)
    out, code = sh_with_code(cmd)
    code == 0 ? out : raise(out.empty? ? "Running `#{cmd}' failed. Run this command directly for more detailed output." : out)
  end

  # Run in shell, return both status and output
  # @see #sh
  def sh_with_code(cmd, base = nil)
    cmd << " 2>&1"
    outbuf = ''
    outbuf = `#{base && "cd '#{base}' && "}#{cmd}`
    [outbuf, $?]
  end

  def escape(*command)
    command.flatten.map {|word| escape_word(word) }.join(' ')
  end

  def escape_word(str)
    if str.empty?
      "''"
    elsif %r{\A[0-9A-Za-z+,./:=@_-]+\z} =~ str
      str
    else
      result = ''
      str.scan(/('+)|[^']+/) {
        if $1
          result << %q{\'} * $1.length
        else
          result << "'#{$&}'"
        end
      }
      result
    end
  end
end
