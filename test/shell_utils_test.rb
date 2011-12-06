require File.expand_path('../test_helper', __FILE__)

describe "ShellTools" do
  it "should sh" do
    assert_equal Time.new.to_i.to_s, ShellTools.sh("date +%s").strip
  end

  it "should sh and raise" do
    assert_raises RuntimeError do
      ShellTools.sh("mymilkshakebringsvariousboystotheYARD")
    end
  end

  it "should sh_with_code" do
    out, status = ShellTools.sh_with_code("date +%s")
    assert_equal Time.new.to_i.to_s, out.strip
    assert_equal 0, status.to_i
  end

  it "should sh_with_code and fail" do
    out, status = ShellTools.sh_with_code("mymilkshakebringsvariousboystotheYARD")
    assert_equal "sh: mymilkshakebringsvariousboystotheYARD: command not found", out.strip
    refute_equal 0, status.to_i
  end
end