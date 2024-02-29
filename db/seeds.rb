  # まず読み込みたいファイル名の配列を作成
table_names = %w(
  users
)

table_names.each do |table_name|
  # 配列をループしてファイルパスを作成
  path = Rails.root.join("db/seeds/#{Rails.env}/#{table_name}.rb")

  # ファイルが存在しない場合はdevelopmentディレクトリを読み込む。つまりファイルがない場合、「development」ディレクトリのseed.rbを参照するように設定
  path = path.sub(Rails.env, "development") unless File.exist?(path)

  # 現在の読み込みファイルをターミナルに出力
  puts "#{table_name}..."
  require path
end