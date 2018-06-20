class WineQualityTest < Test::Unit::TestCase
  def setup
    @red_dataset = Datasets::WineQuality.new()
    @white_dataset = Datasets::WineQuality.new(:white)
  end

  def record(*args)
    Datasets::WineQuality::Record.new(*args)
  end

  test("RedWine#each") do
    wines = @red_dataset.each.to_a
    assert_equal([
                   1599,
                   record(7.4, 0.7, 0, 1.9, 0.076, 11, 34, 0.9978, 3.51, 0.56, 9.4, 5),
                   record(6, 0.31, 0.47, 3.6, 0.067, 18, 42, 0.99549, 3.39, 0.66, 11, 6),
                 ],
                 [
                   wines.size,
                   wines[0],
                   wines[-1],
                 ])
  end

  test("RedWine#each") do
    wines = @white_dataset.each.to_a
    assert_equal([
                   4898,
                   record(7,0.27, 0.36, 20.7, 0.045, 45, 170, 1.001, 3, 0.45, 8.8, 6),
                   record(6, 0.21, 0.38, 0.8, 0.02, 22, 98, 0.98941, 3.26, 0.32, 11.8, 6),
                 ],
                 [
                   wines.size,
                   wines[0],
                   wines[-1],
                 ])
  end

  sub_test_case("#metadata") do
    test("#description") do
      description = @red_dataset.metadata.description
      assert do
        description.start_with?("Citation Request:")
      end
      assert_equal(description, @white_dataset.metadata.description)
    end
  end
end
