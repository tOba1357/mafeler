class HealthPlanetInnerscanService
  class << self
    # 6021 : 体重 (kg)
    # 6022 : 体脂肪率 (%)
    # 6023 : 筋肉量 (kg)
    # 6024 : 筋肉スコア
    # 6025 : 内臓脂肪レベル2(小数点有り、手入力含まず)
    # 6026 : 内臓脂肪レベル(小数点無し、手入力含む)
    # 6027 : 基礎代謝量 (kcal)
    # 6028 : 体内年齢 (才)
    # 6029 : 推定骨量 (kg)
    TAG_COLUMNS = {
        '6021' => :weight,
        '6022' => :body_fat_percentage,
        '6023' => :muscle_mass,
        '6024' => :muscle_score,
        '6025' => :visceral_fat_level2,
        '6026' => :visceral_fat_level1,
        '6027' => :basal_metabolic_rate,
        '6028' => :body_age,
        '6029'=> :bone_mass,
    }

    def import(health_planet)
      access_token = HealthPlanetService.get_access_token health_planet
      innerscans = get(access_token)
      innerscans.each {|innerscan| innerscan.health_planet = health_planet}
      columns = HealthPlanetInnerscan.columns.map(&:name).select {|column| not %w(id created_at updated_at).include?(column)}
      HealthPlanetInnerscan.import innerscans, on_duplicate_key_update: {conflict_target: [:health_planet_id, :datetime], columns: columns}
    end

    def get(access_token)
      url = URI.parse("https://www.healthplanet.jp/status/innerscan.json?access_token=#{access_token}&date=0")
      req = Net::HTTP::Get.new(url.to_s)
      puts url.to_s
      res = Net::HTTP.start(url.host, use_ssl: true) {|http| http.request(req)}
      case res
      when Net::HTTPSuccess
        res_json = JSON.parse(res.body)
        res_json['data'].group_by {|row| row['date']}.map do |date, rows|
          model = HealthPlanetInnerscan.new
          model.datetime = Time.strptime(date, '%Y%m%d%H%M')
          attributes = rows.map do |row|
            value = row['keydata']
            column = TAG_COLUMNS[row['tag']]
            [column, value]
          end.to_h
          model.attributes = attributes
          model
        end
      else
        raise "failed: get HealthPlanetInnerscnas. #{res.body}"
      end
    end
  end
end