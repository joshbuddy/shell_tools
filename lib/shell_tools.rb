require "shell_tools/version"

module ShellTools
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
    # An empty argument will be skipped, so return empty quotes.
    return "''" if str.empty?

    str = str.dup

    # Process as a single byte sequence because not all shell
    # implementations are multibyte aware.
    str.gsub!(/([^A-Za-z0-9_\-.,:\/@\n])/n, "\\\\\\1")

    # A LF cannot be escaped with a backslash because a backslash + LF
    # combo is regarded as line continuation and simply ignored.
    str.gsub!(/\n/, "'\n'")

    return str
  end

  def capture
    old_out, old_err = STDOUT.dup, STDERR.dup
    stdout_read, stdout_write = IO.pipe
    stderr_read, stderr_write = IO.pipe
    $stdout.reopen(stdout_write)
    $stderr.reopen(stderr_write)
    yield
    stdout_write.close
    stderr_write.close
    out = stdout_read.rewind && stdout_read.read rescue nil
    err = stderr_read.rewind && stderr_read.read rescue nil
    [out, err]
  ensure
    $stdout.reopen(old_out)
    $stderr.reopen(old_err)
  end

  def capture_stdout
    out, _ = capture { yield }
    out
  end

  def capture_all
    old_out, old_err = STDOUT.dup, STDERR.dup
    stdall_read, stdall_write = IO.pipe
    $stdout.reopen(stdall_write)
    $stderr.reopen(stdall_write)
    yield
    stdall_write.close
    stdall_write.rewind && stdall_write.read rescue ""
  ensure
    $stdout.reopen(old_out)
    $stderr.reopen(old_err)
  end
end
