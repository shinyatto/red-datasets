require "csv"

require_relative "dataset"

# http://archive.ics.uci.edu/ml/datasets/Wine+Quality
# http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv
# http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv
# http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality.names

module Datasets
  class WineQuality < Dataset
    Record = Struct.new(:fixed_acidity,
                      :volatile_acidity,
                      :citric_acid,
                      :residual_sugar,
                      :chlorides,
                      :free_sulfur_dioxide,
                      :total_sulfur_dioxide,
                      :density,
                      :ph,
                      :sulphates,
                      :alcohol,
                      :quality)

    def initialize(color=:red)
      super()
      @metadata.name = "Wine Quality"
      @metadata.url = "http://archive.ics.uci.edu/ml/datasets/Wine+Quality"
      @metadata.description = lambda do
        read_names
      end
      @color = color.to_s
    end

    def each
      return to_enum(__method__) unless block_given?

      open_data do |csv|
        csv.each do |row|
          next if row[0].nil?
          r = row.map{|r|r[1]}
          record = Record.new(*r)
          yield(record)
        end
      end
    end

    private
    def open_data
      data_path = cache_dir_path + "winequality-#{@color}.csv"
      unless data_path.exist?
        data_url = "http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-#{@color}.csv"
        download(data_path, data_url)
      end
      CSV.open(data_path, converters: [:numeric], col_sep: ";", headers: :first_row, return_headers: false) do |csv|
        yield(csv)
      end
    end

    def read_names
      names_path = cache_dir_path + "winequality.names"
      unless names_path.exist?
        names_url = "http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality.names"
        download(names_path, names_url)
      end
      names_path.read
    end

  end
end
